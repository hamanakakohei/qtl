#!/bin/bash
set -euo pipefail


# make each individual vcf for WASP
# see https://github.com/broadinstitute/gtex-pipeline/tree/master/rnaseq
# see https://github.com/broadinstitute/gtex-pipeline/tree/master/genotype


# まず全サンプルのinput.jsonをつくる
SAMPLE_LIST=inputs/samples.txt
TEMPLATE=inputs/participant_vcfs.edit.to_add_sample.json

while read SAMPLE; do
  NEW_JSON=inputs/participant_vcfs.edit.${SAMPLE}.json
  sed "s/<SAMPLE>/$SAMPLE/g" $TEMPLATE > $NEW_JSON
done < $SAMPLE_LIST


# で、その各サンプルのinput.jsonを、
# TASK_IDに基づいて内部で使うジョブを全サンプル動かす
sbatch --array=1-4%2 slurm/01.slurm
