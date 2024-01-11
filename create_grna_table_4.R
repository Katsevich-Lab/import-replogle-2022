library(tidyverse)
conflicted::conflicts_prefer(dplyr::filter)
repl_offsite <- paste0(.get_config_path("LOCAL_REPLOGLE_2022_DATA_DIR"))

#############
# rd7 dataset
#############
vector_info_table <- readxl::read_xlsx(path = paste0(repl_offsite, "raw/mmc1.xlsx"), sheet = 3,
                                       col_names = c("vector_id", "gene_name", "transcript", "grna_target", "grna_a", "target_sequence_a",
                                                     "grna_b", "target_sequence_b", "duplicated", "either_duplicated"), skip = 1) |>
  select(vector_id, grna_target, grna_a, grna_b)
vector_info_table$grna_a <- paste0(vector_info_table$grna_a, "_posA")
vector_info_table$grna_b <- paste0(vector_info_table$grna_b, "_posB")
feature_table <- data.table::fread(input = paste0(repl_offsite, "raw/rd7/rpe1_other/batch_1/RD7_1_features.tsv.gz"),
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

x <- grna_table_updated |>
  filter(grna_target != "unknown") |>
  mutate(non_targeting = (grna_target == "non-targeting")) |>
  group_by(non_targeting) |>
  mutate(vector_id_2 = factor(vector_id,
                              levels = unique(vector_id),
                              labels = paste0(ifelse(non_targeting[1], "non-targeting_", "targeting_"),
                                              "vector_", seq_along(unique(vector_id)))) |> as.character()) |>
  arrange(vector_id_2) |>
  ungroup() |>
  mutate(non_targeting = NULL, vector_id = NULL) |> 
  rename("vector_id" = "vector_id_2")
grna_table_final <- rbind(x, grna_table_updated |> filter(grna_target == "unknown"))

# save result
saveRDS(object = grna_table_final,
        file = paste0(repl_offsite, "raw/rd7/grna_table.rds"))

#############
# rd7 dataset
#############
kd6_dir <- paste0(repl_offsite, "raw/kd6/K562_essential_other")
vector_info_table <- readxl::read_xlsx(path = paste0(repl_offsite, "raw/mmc1.xlsx"), sheet = 1,
                                       col_names = c("vector_id", "gene_name", "transcript", "grna_target", "grna_a", "target_sequence_a",
                                                     "grna_b", "target_sequence_b", "duplicated", "either_duplicated"), skip = 1) |>
  select(vector_id, grna_target, grna_a, grna_b)
feature_table <- data.table::fread(input = paste0(kd6_dir, "/batch_1/KD6_1_essential_features.tsv.gz"),
                                   col.names = c("grna_id", "name", "modality"))  |>
  filter(modality == "CRISPR Guide Capture")
