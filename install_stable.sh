#!/usr/bin/env bash

conda create -n env_alphatools_stable -y -c conda-forge python=3.5.5 numpy=1.11.3 pandas=0.18.1 scipy=0.17.1 libgfortran=3.0 mkl-service pymc3=3.1 lightgbm=2.2.0 scikit-optimize=0.5.2 scikit-learn lapack catboost pip
source activate env_alphatools_stable
python -m pip install -r requirements_stable.txt --no-cache-dir
python -m pip install -r requirements_blaze_stable.txt --no-cache-dir
pip install cvxpy==0.4.10 --no-cache-dir --no-binary :all:
pip install zipline==1.3.0 --no-cache-dir
pip install ipykernel --no-cache-dir
pip install alphalens==0.3.2 --no-cache-dir
pip install pyfolio --no-cache-dir
pip install graphviz==0.9
cd ..
pip install -e alphatools --no-cache-dir
python -m ipykernel install --user --name env_alphatools_stable --display-name "Python 3.5 (env_alphatools_stable)"
conda install -y pytorch=0.4.1 torchvision -c pytorch

source ~/.bashrc
# must append to .bashrc
if [ "$MKL_THREADING_LAYER" = "" ]
then
    export MKL_THREADING_LAYER=GNU
    echo 'export MKL_THREADING_LAYER=GNU' >> ~/.bashrc
    echo 'Please source the .bashrc file to activate MKL_THREADING env variable.'
fi

if [ "$THEANO_FLAGS" = "" ]
then
    # Needed for Mac OS X
    export "THEANO_FLAGS='gcc.cxxflags=-Wno-c++11-narrowing'"
    echo "export \"THEANO_FLAGS='gcc.cxxflags=-Wno-c++11-narrowing'\"" >> ~/.bashrc
    echo 'Please source the .bashrc file to activate the THEANO_FLAGS env variable.'
fi
