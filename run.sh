#!/bin/bash

helpFunction()
{
    echo ""
    echo "Usage: $0 -c [path-to-config-file]"
    echo "Options:"
    echo -e "\t-c: Path to the config file"
    exit 1
}


while getopts "c:" opt; do
    case $opt in
        c) CONFIG_PATH=$OPTARG;;
        *) helpFunction ;;
      esac
done

if [ -z "$CONFIG_PATH" ]; then
    echo "Please provide the path to the config file"
    helpFunction
fi
# Install the requirements
python setup.py develop

# Run the script to create dataset infos
python -m pcdet.datasets.custom.custom_dataset create_custom_infos tools/cfgs/dataset_configs/custom_dataset.yaml

# Run the training
cd tools
python train.py --cfg_file $CONFIG_PATH