# 1) Stage, cost and survival by detection route. 2) Scenario: more cancers found through screening.
x <- readRDS("outputs/clean.rds"); d <- x$d; p <- x$p
by_route <- aggregate(cbind(early, cost_rp_m, alive_5y) ~ route, d, mean)
by_stage <- aggregate(cbind(cost_rp_m, alive_5y) ~ stage, d, mean)
# Stage mix by route, used to re-weight the cohort under a new screening share
mix <- prop.table(table(d$route, d$stage), 1)
cost_stage <- setNames(by_stage$cost_rp_m, by_stage$stage); surv_stage <- setNames(by_stage$alive_5y, by_stage$stage)
scenario <- function(share_screen) {
  m <- share_screen * mix["Screening", ] + (1 - share_screen) * mix["Symptoms", ]
  c(screen_share_pct = 100 * share_screen, early_pct = 100 * sum(m[1:2]),
    treat_cost_per_case_rp_m = sum(m * cost_stage), survival_5y_pct = 100 * sum(m * surv_stage))
}
sc <- as.data.frame(t(sapply(c(0.15, 0.30, 0.50), scenario)))
# Cost of screening per cancer found
screen_cost_per_case_rp_m <- p["screen_cost_rp_k"] / 1000 * 1000 / p["detect_per_1000_screened"]
saveRDS(list(by_route = by_route, by_stage = by_stage, scenarios = sc, screen_cost_per_case = screen_cost_per_case_rp_m), "outputs/results.rds")
