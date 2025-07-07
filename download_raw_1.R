repl_offsite <- paste0(.get_config_path("LOCAL_REPLOGLE_2022_DATA_DIR"))

# load R.utils; increase timeout to 5 hours
library(R.utils)
options(timeout = 10 * 60 * 60)

# create raw directory; also create subdirectories for the four datasets
raw_data_dir <- paste0(repl_offsite, "raw/")
processed_data_dir <- paste0(repl_offsite, "processed/velten")
raw_data_dir_rep <- paste0(raw_data_dir, c("kd8", "rd7", "kd6"))
for (dir in c(raw_data_dir_rep, processed_data_dir)) {
  if (!dir.exists(dir)) dir.create(dir, recursive = TRUE)
}

# URL of data
data_urls <- c(rd7 = "https://plus.figshare.com/ndownloader/files/36000888",
               #kd8_ultima = "https://plus.figshare.com/ndownloader/files/36000884",
               kd6 = "https://plus.figshare.com/ndownloader/files/36000843",
               kd8 = "https://plus.figshare.com/ndownloader/files/36000572")

# download the raw data
for (i in seq_along(data_urls)) {
  to_save_dir <- names(data_urls[i])
  dest <- paste0(raw_data_dir, to_save_dir, "/raw.mtx.tar.gz")
  source <- data_urls[i]
  download.file(url = source, destfile = dest)
}

# download the velten sceptre objects
download.file(url = "https:\u002f\u002fhu-my.sharepoint.com\u002fpersonal\u002ftbarry_hsph_harvard_edu\u002f_layouts\u002f15\u002fdownload.aspx?UniqueId=2fadfee7-7489-4581-9f0a-906aa75e8aff&Translate=false&tempauth=v1.eyJzaXRlaWQiOiJiNzdiZTdmZS1jNTY2LTRhYjctYTIxNC04MjAzMGVhMjlhNmQiLCJhdWQiOiIwMDAwMDAwMy0wMDAwLTBmZjEtY2UwMC0wMDAwMDAwMDAwMDAvaHUtbXkuc2hhcmVwb2ludC5jb21ANmZmYTIyZjQtNDU2OC00MTA1LWFkNDMtMmUzYWQ0NzI2OTU3IiwiZXhwIjoiMTc1MTkwNzc0NCJ9.CgkKBHNuaWQSATgSCwiQ04uW-dOePhAFGg4xOTQuOTQuMTM0LjI0OCIUbWljcm9zb2Z0LnNoYXJlcG9pbnQqLG96Qm4wbFhmQ0I4eHpoc1h1S2ZiQmVNaWVqWDhOeS80dGVBQzRSaStKZGM9MJUBOAFCEKGva5-vcACQW7Fky8L2CI1KEGhhc2hlZHByb29mdG9rZW5SCFsia21zaSJdYgR0cnVlaiQwMDVkOTEzOS05ZThiLTRkODAtMzkzZC0yYTAzNTNmMDdjMDRyKTBoLmZ8bWVtYmVyc2hpcHwxMDAzMjAwMzI2ZjI3YWFhQGxpdmUuY29tegEwwgEnMCMuZnxtZW1iZXJzaGlwfHRiYXJyeUBoc3BoLmhhcnZhcmQuZWR1yAEB4gEWbHZzR3RDVzBnMHV2UHBsakUtbUZBQQ.ZJWqhWS5e-y_NNfesWl-Z0ENz4uG5L1wpUqSZFq5tCE",
              destfile = paste0(processed_data_dir, "/sceptre_object_K562.rds"))
download.file(url = "https:\u002f\u002fhu-my.sharepoint.com\u002fpersonal\u002ftbarry_hsph_harvard_edu\u002f_layouts\u002f15\u002fdownload.aspx?UniqueId=ad2bbeb0-72f8-494e-abbf-9e8a1a8060f0&Translate=false&tempauth=v1.eyJzaXRlaWQiOiJiNzdiZTdmZS1jNTY2LTRhYjctYTIxNC04MjAzMGVhMjlhNmQiLCJhdWQiOiIwMDAwMDAwMy0wMDAwLTBmZjEtY2UwMC0wMDAwMDAwMDAwMDAvaHUtbXkuc2hhcmVwb2ludC5jb21ANmZmYTIyZjQtNDU2OC00MTA1LWFkNDMtMmUzYWQ0NzI2OTU3IiwiZXhwIjoiMTc1MTkwODI5OCJ9.CgkKBHNuaWQSATgSCwietKO8otSePhAFGg4xOTQuOTQuMTM0LjI0OCIUbWljcm9zb2Z0LnNoYXJlcG9pbnQqLHBPbDMxaVhSWHJqbFdiTTVwV3RFUkdWeXhCZVdlWm9yb08zc2E1Z0t3czA9MJUBOAFCEKGvbCGzkACQf60gYcbMX0dKEGhhc2hlZHByb29mdG9rZW5SCFsia21zaSJdYgR0cnVlaiQwMDVkOTEzOS05ZThiLTRkODAtMzkzZC0yYTAzNTNmMDdjMDRyKTBoLmZ8bWVtYmVyc2hpcHwxMDAzMjAwMzI2ZjI3YWFhQGxpdmUuY29tegEwwgEnMCMuZnxtZW1iZXJzaGlwfHRiYXJyeUBoc3BoLmhhcnZhcmQuZWR1yAEB4gEWbHZzR3RDVzBnMHV2UHBsakUtbUZBQQ.2SmtAj4AuMDllaVh4FVsXlNdR5dK8V6OoH_T5beGcgs",
              destfile = paste0(processed_data_dir, "/sceptre_object_RPE1.rds"))

# the following file should be downloaded and placed into `raw_data_dir`: https://www.cell.com/cms/10.1016/j.cell.2022.05.013/attachment/5a940406-8883-4368-890e-e05f63eff4fd/mmc1.xlsx