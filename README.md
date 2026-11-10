# PMU training: cancer early detection and JKN costs

Training repository for the BKPK Policy Modelling Unit (PMU). It teaches how to link the route by which a cancer is
found, its stage at diagnosis, treatment cost and survival, and how to model the effect of finding more cancers through
screening. **The data here is DUMMY data, invented for practice.** No real JKN or registry data is included.

## The policy question

If more breast, cervical and colorectal cancers were found through screening rather than after symptoms, how would the
stage at diagnosis, the treatment cost per case and five-year survival change, and what does screening cost per cancer
found? This follows PMU research plan study A (cancer early detection and JKN costs).

## The method in four steps

1. **Patients by route and stage.** Each patient has a cancer site, a detection route (screening or symptoms), a stage
   (I to IV), a two-year treatment cost and five-year survival.
2. **Describe.** Share of early-stage (I-II) cancers, mean cost and survival, by route and by stage.
3. **Scenario.** Re-weight the stage mix to a higher share found through screening (15%, 30%, 50%) and recompute cost
   per case and survival. This assumes each route keeps its own stage mix.
4. **Cost of finding.** Screening cost per cancer found = cost per woman screened / cancers found per woman screened.

## How to run

In RStudio, open this folder as a project and run `source("run_all.R")`, or in a terminal `Rscript run_all.R`.
Only base R is used.

| File | What it does |
|---|---|
| `R/00_make_dummy_data.R` | Writes the dummy patients and programme parameters to `data/dummy/` |
| `R/01_clean.R` | Reads and checks the inputs, marks early-stage cancers |
| `R/02_analysis.R` | Tables by route and stage, the screening scenarios and screening cost per cancer found |
| `R/03_outputs.R` | Writes `outputs/scenarios.csv` and `outputs/stage_cost.png` |

## Using real data

Set `DATA_DIR` to the folder with your files, for example `Sys.setenv(DATA_DIR = "D:/pmu/data")`. The patient file needs
`id, site, route, stage, cost_rp_m, alive_5y`; the parameter file needs `parameter, value` rows for
`women_target_m, screen_cost_rp_k, detect_per_1000_screened`. Never commit real data.

## Exercises

1. Repeat the scenario for each cancer site separately. Where does screening change cost most?
2. Add the screening cost to the treatment cost: at what screening share does total cost per case stop falling?
3. Stage at diagnosis from claims is often missing. How would you check how much this changes the results?
4. The scenario assumes stage mix by route stays fixed. Name one reason this could be wrong.

ARC Institute for the BKPK Policy Modelling Unit. Dummy data only.
