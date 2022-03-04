#!/bin/bash
# TensorFlow installation on AMD GPU with ROCm
# AMD - All Right Reserved
# 2022/03

# Install conda
#wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
#bash Miniconda3-latest-Linux-x86_64.sh -b -p $HOME/miniconda
#source $HOME/miniconda/bin/activate
#conda init

# Create new environment
#conda create -n tensorflow-rocm -y
#conda activate tensorflow-rocm
#conda install pip -y

# Install requirements
sudo yum update -y
sudo yum install cmake cmake3 -y
sudo yum install rocm-libs rccl -y
sudo yum install rocrand hipfft rocblas -y

export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/opt/rocm/hip/lib
export LD_LIBRARY_PATH="/usr/lib/aomp/lib:/usr/lib/aomp/lib64:/opt/rocm/lib:/opt/rocm/lib64:/opt/rocm/opencl/lib/x86_64:$LD_LIBRARY_PATH"

# Install TensorFlow package (TF 2.6.2=OK, higher need ROCM 5.x libs)
pip3 install --user --upgrade pip
pip3 install --user tensorflow-rocm
pip3 install keras==2.6.0

# Check installation
python3 -c "import tensorflow as tf; print(tf.config.list_physical_devices('GPU'))"
python3 -c "import tensorflow as tf;print(tf.reduce_sum(tf.random.normal([1000, 1000])))"
python3 -c 'import keras; print(keras.__version__)'

# Training example
git clone https://github.com/tensorflow/benchmarks.git
cd benchmarks/scripts/tf_cnn_benchmarks/
python3 tf_cnn_benchmarks.py --num_gpus=1 --batch_size=32 --model=resnet50 --variable_update=parameter_server
