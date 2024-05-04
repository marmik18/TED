#!/usr/bin/env bash
PY_ARGS=${@:1}
CUDA_VISIBLE_DEVICES=0,1,2,3,4,5,6,7 nohup python3 -m torch.distributed.launch --nproc_per_node=8 train.py --launcher pytorch ${PY_ARGS} > log.txt&
