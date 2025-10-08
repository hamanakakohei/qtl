#!/bin/bash
#SBATCH --job-name=01_cromwell
#SBATCH --partition=epyc
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=6G
#SBATCH --output=logs/%a.out
#SBATCH --error=logs/%a.err
#SBATCH --array=1-4%2

set -euo pipefail

eval "$(conda shell.bash hook)"
conda activate cromwell


# 共通の変数
SAMPLE_LIST=inputs/samples.txt

CROMWELL_JAR=cromwell.jar
CONF=cromwell.examples.conf
OPTION=cromwell-options.json
WDL=workflows/participant_vcfs.edit.wdl

JAVA_OPTS="-Xmx4G -XX:ParallelGCThreads=1"


# このサンプルを解析します
SAMPLE=$(sed -n "${SLURM_ARRAY_TASK_ID}p" $SAMPLE_LIST)
INPUT=inputs/participant_vcfs.edit.${SAMPLE}.json

java $JAVA_OPTS \
  -Dconfig.file=$CONF \
  -jar $CROMWELL_JAR run \
  -i $INPUT \
  $WDL
  #--options $OPTION \
