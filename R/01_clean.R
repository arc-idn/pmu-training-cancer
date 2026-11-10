# Read and check the patient file. DATA_DIR points to real data; by default the dummy data is used.
DATA_DIR <- Sys.getenv("DATA_DIR", "data/dummy")
d <- read.csv(file.path(DATA_DIR, "cancer_dummy_patients.csv"))
p <- read.csv(file.path(DATA_DIR, "screening_dummy_parameters.csv")); p <- setNames(p$value, p$parameter)
stopifnot(all(d$stage %in% 1:4), !anyNA(d))
d$early <- d$stage <= 2
saveRDS(list(d = d, p = p), "outputs/clean.rds")
