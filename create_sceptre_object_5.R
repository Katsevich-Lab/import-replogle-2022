library(sceptre)
repl_offsite <- paste0(.get_config_path("LOCAL_REPLOGLE_2022_DATA_DIR"))
# cellranger output directories
directories <- list.files(paste0(repl_offsite, "raw/rd7/rpe1_other"), full.names = TRUE)
# grna target data frame
grna_target_data_frame <- readRDS(paste0(repl_offsite, "raw/rd7/grna_table.rds"))
# directory to write
directory_to_write <- paste0(repl_offsite, "processed/rd7")
# import data into sceptre_object; write sceptre_object without setting analysis params
sceptre_object <- import_data_from_cellranger(directories = directories,
                                              moi = "low",
                                              grna_target_data_frame = grna_target_data_frame,
                                              use_ondisc = TRUE,
                                              directory_to_write = directory_to_write)
write_ondisc_backed_sceptre_object(sceptre_object, directory_to_write)
