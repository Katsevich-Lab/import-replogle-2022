repl_offsite <- paste0(.get_config_path("LOCAL_REPLOGLE_2022_DATA_DIR"))

# load R.utils; increase timeout to 5 hours
library(R.utils)
options(timeout = 10 * 60 * 60)

# create raw directory; also create subdirectories for the four datasets
raw_data_dir <- paste0(repl_offsite, "raw/")
raw_data_dir_rep <- paste0(raw_data_dir, c("kd8", "rd7", "kd6"))
for (dir in raw_data_dir_rep) {
  if (!dir.exists(dir)) dir.create(dir, recursive = TRUE)
}

# URL of data
data_urls <- c(rd7 = "https://plus.figshare.com/ndownloader/files/36000888",
               #kd8_ultima = "https://plus.figshare.com/ndownloader/files/36000884",
               kd6 = "https://plus.figshare.com/ndownloader/files/36000843",
               kd8 = "https://plus.figshare.com/ndownloader/files/36000572")

# download the data
for (i in seq_along(data_urls)) {
  to_save_dir <- names(data_urls[i])
  dest <- paste0(raw_data_dir, to_save_dir, "/raw.mtx.tar.gz")
  source <- data_urls[i]
  download.file(url = source, destfile = dest)
}

# the following file should be downloaded and placed into `raw_data_dir`: https://www.cell.com/cms/10.1016/j.cell.2022.05.013/attachment/5a940406-8883-4368-890e-e05f63eff4fd/mmc1.xlsx
