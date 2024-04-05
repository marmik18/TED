#!/bin/bash
# Install the requirements
python setup.py develop

# Run the script to create dataset infos
python -m pcdet.datasets.custom.custom_dataset create_custom_infos tools/cfgs/dataset_configs/custom_dataset.yaml

# Run the training
cd tools
python train.py --cfg_file cfgs/models/custom_models/TED-S.yaml