AMD GPU MI250x, Pytorch Compilation
01/2022

# Get source code
git clone --recursive https://github.com/ROCmSoftwarePlatform/pytorch.git
cd pytorch

# Create env
conda create -y -n pytorch-rocm python=3.7
conda activate pytorch-rocm
conda install pyyaml

# Convert to HIP
python3 tools/amd_build/build_amd.py 

# Compile
 PYTORCH_ROCM_ARCH=gfx90a hip_DIR=/opt/rocm/hip/cmake/ USE_NVCC=OFF BUILD_CAFFE2_OPS=0 PATH=/usr/lib/ccache/:$PATH USE_CUDA=OFF python3 setup.py bdist_wheel 
 
# Install whl
pip install dist/*.whl
 
# Test
python -c "import torch;print('Torch gpu is available: ', torch.cuda.is_available())"
