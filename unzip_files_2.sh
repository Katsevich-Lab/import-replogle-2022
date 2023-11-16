source ~/.research_config
echo $LOCAL_REPLOGLE_2022_DATA_DIR
rd7_dir=$LOCAL_REPLOGLE_2022_DATA_DIR"raw/rd7/"
cd $rd7_dir
tar -xvzf "raw.mtx.tar.gz"
# gzip -dv "rpe1_other" *
rm $rd7_dir"raw.mtx.tar.gz"
