#!/bin/bash
set -euo pipefail


# まず全サンプルのinput.jsonをつくる
SAMPLE_LIST=inputs/samples.txt
TEMPLATE=inputs/03/rnaseq_pipeline_fastq.edit.to_add_sample.json

while read SAMPLE; do
  NEW_JSON=inputs/03/rnaseq_pipeline_fastq.edit.${SAMPLE}.json
  sed "s/<SAMPLE>/$SAMPLE/g" $TEMPLATE > $NEW_JSON
done < $SAMPLE_LIST


# で、その各サンプルのinput.jsonを、
# TASK_IDに基づいて内部で使うジョブを全サンプル動かす
sbatch --array=1-430%20 slurm/03.slurm
