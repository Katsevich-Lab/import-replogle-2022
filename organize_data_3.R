repl_offsite <- paste0(.get_config_path("LOCAL_REPLOGLE_2022_DATA_DIR"))
rd7_dir <- paste0(repl_offsite, "raw/rd7/rpe1_other/")
fs <- list.files(rd7_dir)

batch_no <- strsplit(x = fs, split = "_", fixed = TRUE) |> lapply(FUN = function(l) l[2]) |> unlist()
for (curr_batch_no in unique(batch_no)) {
  dir <- paste0(rd7_dir, "batch_", curr_batch_no)
  if (!dir.exists(dir)) dir.create(dir)
}

for (i in seq_along(fs)) {
  from <- fs[i]
  to <- paste0(rd7_dir, "batch_", batch_no[i], "/", from)
  file.rename(from = from, to = to)
}