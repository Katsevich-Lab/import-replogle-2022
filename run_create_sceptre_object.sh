#$ -l m_mem_free=4G
#$ -j y

/usr/bin/time -v create_sceptre_object_5.R 2> profiling_output.txt
