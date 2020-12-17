#!/usr/bin/env bash

# set -x

. tools/env.sh

PARTITION=$1
JOB_NAME=dgs
CONFIG=$2
GPUS=8
GPUS_PER_NODE=8
CPUS_PER_TASK=3
SRUN_ARGS=${SRUN_ARGS:-""}
PY_ARGS=${@:3}

srun -p ${PARTITION} \
    --job-name=${JOB_NAME} \
    --gres=gpu:${GPUS_PER_NODE} \
    --ntasks=${GPUS} \
    --ntasks-per-node=${GPUS_PER_NODE} \
    --cpus-per-task=${CPUS_PER_TASK} \
    --kill-on-bad-exit=1 \
    ${SRUN_ARGS} \
    python -u tools/train.py ${CONFIG} --launcher="slurm" ${PY_ARGS}
