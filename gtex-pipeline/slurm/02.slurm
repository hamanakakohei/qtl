#!/bin/bash
#SBATCH --job-name=02_cromwell
#SBATCH --partition=epyc
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=6G
#SBATCH --output=logs/02.out
#SBATCH --error=logs/02.err

set -euo pipefail

eval "$(conda shell.bash hook)"
conda activate cromwell


CROMWELL_JAR=cromwell.jar
CONF=cromwell.conf
OPTION=cromwell-options.json
WDL=workflows/02_rsem_reference.edit.wdl
INPUT=inputs/02/rsem_reference.edit.20250829.json

JAVA_OPTS="-Xmx4G -XX:ParallelGCThreads=1"


java $JAVA_OPTS \
  -Dconfig.file=$CONF \
  -jar $CROMWELL_JAR run \
  -i $INPUT \
  $WDL
  #--options $OPTION \
