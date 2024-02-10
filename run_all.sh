#$ -l m_mem_free=4G

Rscript download_raw_1.R # download raw data
./unzip_files_2.sh # unzip the files 
Rscript organize_data_3.R # organize the data into directories
Rscript create_grna_table_4.R # create the grna data table
Rscript create_sceptre_object_5.R # create the ondisc-backed sceptre_object