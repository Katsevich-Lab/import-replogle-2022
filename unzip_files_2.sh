source ~/.research_config
echo $LOCAL_REPLOGLE_2022_DATA_DIR
rd7_dir=$LOCAL_REPLOGLE_2022_DATA_DIR"raw/rd7/"
tar -xvzf $rd7_dir"raw.mtx.tar.gz"
gzip -dv $rd7_dir/"rpe1_other" *
rm $rd7_dir"raw.mtx.tar.gz"
