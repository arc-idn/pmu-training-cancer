# Generate DUMMY data (invented values, for training only). Real analyses use JKN claims and registry data.
set.seed(2026)
n <- 5000
sites <- c("Breast", "Cervical", "Colorectal")
d <- data.frame(id = seq_len(n), site = sample(sites, n, TRUE, c(0.45, 0.3, 0.25)),
                route = sample(c("Screening", "Symptoms"), n, TRUE, c(0.15, 0.85)))
# Screening finds cancers earlier: stage probabilities differ by route
p_stage <- list(Screening = c(0.45, 0.35, 0.15, 0.05), Symptoms = c(0.10, 0.25, 0.35, 0.30))
d$stage <- vapply(d$route, function(r) sample(1:4, 1, prob = p_stage[[r]]), integer(1))
# Treatment cost in the first two years (Rp million), rising with stage
base_cost <- c(45, 80, 140, 190)
d$cost_rp_m <- round(base_cost[d$stage] * runif(n, 0.8, 1.25), 1)
# Five-year survival falls with stage
p_surv <- c(0.90, 0.75, 0.45, 0.15)
d$alive_5y <- rbinom(n, 1, p_surv[d$stage])
write.csv(d, "data/dummy/cancer_dummy_patients.csv", row.names = FALSE)
# Programme inputs for the scenario (also dummy)
write.csv(data.frame(parameter = c("women_target_m", "screen_cost_rp_k", "detect_per_1000_screened"),
                     value = c(20, 150, 2.5)), "data/dummy/screening_dummy_parameters.csv", row.names = FALSE)
cat("Dummy data written to data/dummy/\n")
