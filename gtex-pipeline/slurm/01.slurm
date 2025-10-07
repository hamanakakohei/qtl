#!/bin/bash
#SBATCH --job-name=01_cromwell
#SBATCH --partition=epyc
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=6G
#SBATCH --output=logs/01.out
#SBATCH --error=logs/01.err

set -euo pipefail

eval "$(conda shell.bash hook)"
conda activate cromwell


CROMWELL_JAR=cromwell.jar
CONF=cromwell.conf
OPTION=cromwell-options.json
WDL=workflows/01_star_index.edit.wdl
INPUT=inputs/01/star_index.edit.20250829.json

JAVA_OPTS="-Xmx4G -XX:ParallelGCThreads=1"


java $JAVA_OPTS \
  -Dconfig.file=$CONF \
  -jar $CROMWELL_JAR run \
  -i $INPUT \
  $WDL
  #--options $OPTION \
