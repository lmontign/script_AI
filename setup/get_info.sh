#!/bin/bash
exec > system_info.txt
exec 2>&1

# Host
hostname && echo -en '\n'
uname -a && echo -en '\n'
sudo dmidecode -t bios -q && echo -en '\n'
lscpu && echo -en '\n'
lsblk && echo -en '\n'
cat /proc/meminfo && echo -en '\n'

# GPU
dpkg -l | grep cuda && echo -en '\n'
dpkg -l | grep rocm && echo -en '\n'
nvidia-smi && echo -en '\n'
rocm-smi && echo -en '\n'
cat /proc/driver/nvidia/version && echo -en '\n'


# AI
python --version
python -c "print('Pytorch=');import torch; print(torch.__version__)"
python3 -c "print('Tensorflow=');import tensorflow as tf; print(tf.__version__)"
