repl_offsite <- paste0(.get_config_path("LOCAL_REPLOGLE_2022_DATA_DIR"))

# load R.utils; increase timeout to 5 hours
library(R.utils)
options(timeout = 5 * 60 * 60)

# create raw directory; also create subdirectories for the four datasets
raw_data_dir <- paste0(repl_offsite, "raw/")
raw_data_dir_rep <- paste0(raw_data_dir, c("kd8", "rd7", "kd6", "kd8_ultima"))
for (dir in raw_data_dir_rep) {
  dir.create(dir, recursive = TRUE)
}

# URL of data
data_urls <- c(rd7 = "https://plus.figshare.com/ndownloader/files/36000888",
               kd8_ultima = "https://plus.figshare.com/ndownloader/files/36000884",
               kd6 = "https://plus.figshare.com/ndownloader/files/36000843",
               kd8 = "https://plus.figshare.com/ndownloader/files/36000572")[1]

# download the rd7 dataset only for now
for (i in seq_along(data_urls)) {
  to_save_dir <- names(data_urls[i])
  dest <- paste0(raw_data_dir, to_save_dir, "/raw.mtx.tar.gz")
  source <- data_urls[i]
  download.file(url = source, destfile = dest)
}
