library(tidyverse)
library(sceptre)

conflicted::conflicts_prefer(dplyr::filter)
repl_offsite <- paste0(.get_config_path("LOCAL_REPLOGLE_2022_DATA_DIR"))

make_grna_target_df <- function(xl_fp, features_fp, nt_vectors_to_keep) {
  vector_info_table <- readxl::read_xlsx(path = paste0(repl_offsite, xl_fp), sheet = 3,
                                         col_names = c("vector_id", "gene_name", "transcript", "grna_target", "grna_a", "target_sequence_a",
                                                       "grna_b", "target_sequence_b", "duplicated", "either_duplicated"), skip = 1) |>
    select(vector_id, grna_target, grna_a, grna_b)
  vector_info_table$grna_a <- paste0(vector_info_table$grna_a, "_posA")
  vector_info_table$grna_b <- paste0(vector_info_table$grna_b, "_posB")
  feature_table <- data.table::fread(input = paste0(repl_offsite, features_fp),
                                     col.names = c("grna_id", "name", "modality"))
  grna_table <- feature_table |> filter(modality == "CRISPR Guide Capture") |> dplyr::select(grna_id)

  # reshape vector_info_table
  vector_info_table_reshape <- vector_info_table |>
    pivot_longer(cols = c("grna_a", "grna_b"), values_to = "grna_id", names_to = NULL)
  grna_table_updated <- left_join(x = grna_table, y = vector_info_table_reshape, by = "grna_id") |>
    dplyr::arrange(grna_id)
  na_grnas <- is.na(grna_table_updated$grna_target) | is.na(grna_table_updated$vector_id)
  grna_table_updated$grna_target[na_grnas] <- "unknown"
  grna_table_updated$vector_id[na_grnas] <- "unknown"
  grna_table_updated <- grna_table_updated |>
    dplyr::mutate(is_nt = (grna_target == "non-targeting"),
                  grna_target = ifelse(!is_nt | (vector_id %in% nt_vectors_to_keep), grna_target, "nt_off_target"),
                  is_nt = NULL)
  return(grna_table_updated)
}

return_nt_vectors_in_use_by_velten <- function(sceptre_object_fp) {
  readRDS(sceptre_object_fp)@grna_target_data_frame |>
    dplyr::filter(grna_target == "non-targeting") |>
    dplyr::pull(grna_id)
}

#############
# rd7 dataset
#############
xl_fp <- "raw/mmc1.xlsx"
features_fp <- "raw/rd7/rpe1_other/batch_1/RD7_1_features.tsv.gz"
nt_vectors_to_keep <- return_nt_vectors_in_use_by_velten(paste0(repl_offsite, "processed/velten/sceptre_object_RPE1.rds")) # we got this file from velten
grna_table_final_rd7 <- make_grna_target_df(xl_fp, features_fp, nt_vectors_to_keep)
# save result
saveRDS(object = grna_table_final_rd7,
        file = paste0(repl_offsite, "raw/rd7/grna_table.rds"))

#############
# kd6 dataset
#############
xl_fp <- "raw/mmc1.xlsx"
features_fp <- "raw/kd6/K562_essential_other/batch_1/KD6_1_essential_features.tsv.gz"
nt_vectors_to_keep <- return_nt_vectors_in_use_by_velten(paste0(repl_offsite, "processed/velten/sceptre_object_K562.rds")) # we got this file from velten
grna_table_final_kd6 <- make_grna_target_df(xl_fp, features_fp, nt_vectors_to_keep)
saveRDS(object = grna_table_final_kd6,
        file = paste0(repl_offsite, "raw/kd6/grna_table.rds"))
