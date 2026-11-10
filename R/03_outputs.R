# Tables and one chart.
r <- readRDS("outputs/results.rds")
write.csv(r$scenarios, "outputs/scenarios.csv", row.names = FALSE)
png("outputs/stage_cost.png", width = 1600, height = 900, res = 160)
par(mfrow = c(1, 2), mar = c(4.5, 5, 3, 1))
barplot(r$by_stage$cost_rp_m, names.arg = paste("Stage", r$by_stage$stage), col = "#1E3A5F",
        ylab = "Treatment cost per case (Rp million)", main = "Cost rises with stage (DUMMY)")
plot(r$scenarios$screen_share_pct, r$scenarios$treat_cost_per_case_rp_m, type = "b", pch = 19, col = "#C8811A", lwd = 2,
     xlab = "Cancers found through screening (%)", ylab = "Treatment cost per case (Rp million)", main = "Earlier detection (DUMMY)")
dev.off()
print(r$by_route); print(round(r$scenarios, 1)); cat("Screening cost per cancer found (Rp million):", round(r$screen_cost_per_case, 1), "\n")
