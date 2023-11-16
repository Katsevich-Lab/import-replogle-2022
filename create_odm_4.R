library(ondiscLite)
repl_offsite <- paste0(.get_config_path("LOCAL_REPLOGLE_2022_DATA_DIR"))
rd7_dir <- paste0(repl_offsite, "raw/rd7/rpe1_other")
directories <- list.files(rd7_dir, full.names = TRUE)
dir_to_write <- paste0(repl_offsite, "processed/rd7/")
create_odm_from_cellranger(directories_to_load = directories,
                           directory_to_write = dir_to_write)
# gene_odm <- initialize_odm_from_backing_file(paste0(dir_to_write, "gene.odm"))
# grna_odm <- initialize_odm_from_backing_file(paste0(dir_to_write, "grna.odm"))
