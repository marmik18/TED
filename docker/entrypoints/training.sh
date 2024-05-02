#!/bin/bash
# Install the requirements
python setup.py develop

# Run the script to create dataset infos
python -m pcdet.datasets.custom.custom_dataset create_custom_infos tools/cfgs/dataset_configs/custom_dataset.yaml

# Run the training
cd tools
python train.py --cfg_file cfgs/models/custom_models/TED-S.yaml

# Run the evaluation
python test.py --cfg_file cfgs/models/custom_models/TED-S.yaml

# Run the visualization
python demo.py --cfg_file cfgs/models/custom_models/TED-S.yaml --ckpt ../output/models/custom_models/TED-S/default/ckpt/checkpoint_epoch_80.pth --data_path ../data/custom/points/ --ext .npy