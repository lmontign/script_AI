#!/bin/bash
# TensorFlow installation on AMD GPU with ROCm
# AMD - All Right Reserved
# 2022/03

# Install conda
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
bash Miniconda3-latest-Linux-x86_64.sh -b -p $HOME/miniconda
source $HOME/miniconda/bin/activate
conda init

# Create new environment
conda create -n pytorch-rocm-nightly -y
conda activate pytorch-rocm-nightly
conda install pip -y

export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/opt/rocm/hip/lib
export LD_LIBRARY_PATH="/usr/lib/aomp/lib:/usr/lib/aomp/lib64:/opt/rocm/lib:/opt/rocm/lib64:/opt/rocm/opencl/lib/x86_64:$LD_LIBRARY_PATH"

# Install Pytorch
pip3 install --pre torch torchvision -f https://download.pytorch.org/whl/nightly/rocm4.3.1/torch_nightly.html

# Check installation
python3 -c "import torch; print(torch.cuda.is_available())"
pip3 list

# Training example
git clone https://github.com/pytorch/examples.git
cd examples/mnist
python3 main.py --epochs 2
