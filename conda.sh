# install mamba miniforge
curl -L -O "https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-$(uname)-$(uname -m).sh"
bash Miniforge3-$(uname)-$(uname -m).sh


# setup a conda env with jupyter 
conda create -n ENV_NAME python=3.7 pandas 
or
conda env create -f environment.yaml
conda activate ENV_NAME
conda install -c conda-forge pandas

# use mamba resolver and add channels
conda install conda-libmamba-solver
conda config --set solver libmamba

conda config --add channels bioconda 
conda config --add channels conda-forge 
conda config --add channels biocore
conda config --show channels

# work with an environment yaml file
conda env export >environment.yaml


# remove a named environment
conda remove -n ENV_NAME --all

# uninstall conda
rm -r ~/miniconda/

# using conda in dockerfile
USER ubuntu
RUN conda create -n ENV_NAME python=3.9
SHELL ["conda", "run", "-n", "ENV_NAME", "/bin/bash", "-c"]
RUN conda install -c conda-forge -c anaconda pigz pyyaml

RUN conda init bash

# running a script from a conda env
conda run -n ENV_NAME script.sh


