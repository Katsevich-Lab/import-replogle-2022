source ~/.research_config
echo $LOCAL_REPLOGLE_2022_DATA_DIR

rd7_dir=$LOCAL_REPLOGLE_2022_DATA_DIR"raw/rd7/"
cd $rd7_dir
tar -xvzf "raw.mtx.tar.gz"
rm "raw.mtx.tar.gz"

kd6_dir=$LOCAL_REPLOGLE_2022_DATA_DIR"raw/kd6"
cd $kd6_dir
tar -xvzf "raw.mtx.tar.gz"
rm "raw.mtx.tar.gz"

