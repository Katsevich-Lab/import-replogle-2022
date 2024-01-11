repl_offsite <- paste0(.get_config_path("LOCAL_REPLOGLE_2022_DATA_DIR"))
rd7_dir <- paste0(repl_offsite, "raw/rd7/rpe1_other/")
kd6_dir <- paste0(repl_offsite, "raw/kd6/K562_essential_other/")

organize_files_for_dir <- function(curr_dir) {
  fs <- list.files(curr_dir)
  batch_no <- strsplit(x = fs, split = "_", fixed = TRUE) |> lapply(FUN = function(l) l[2]) |> unlist()
  for (curr_batch_no in unique(batch_no)) {
    dir <- paste0(curr_dir, "batch_", curr_batch_no)
    if (!dir.exists(dir)) dir.create(dir)
  }
  for (i in seq_along(fs)) {
    from <- paste0(curr_dir, fs[i])
    to <- paste0(curr_dir, "batch_", batch_no[i], "/", fs[i])
    file.rename(from = from, to = to)
  }
}

organize_files_for_dir(rd7_dir)
organize_files_for_dir(kd6_dir)

