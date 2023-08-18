# setup a conda env with jupyter 
conda create -n ENV_NAME python=3.7 pandas 
conda activate ENV_NAME
conda install -c conda-forge pandas

# uninstall conda
rm -r ~/miniconda/

# work with an environment yaml file
conda env export >environment.yaml
conda env create -f environment.yaml

# remove a named environment
conda remove -n ENV_NAME --all

# using conda in dockerfile
USER ubuntu
RUN conda create -n ENV_NAME python=3.9
SHELL ["conda", "run", "-n", "ENV_NAME", "/bin/bash", "-c"]
RUN conda install -c conda-forge -c anaconda pigz pyyaml

RUN conda init bash

# running a script from a conda env
conda run -n ENV_NAME script.sh


conda config --add channels bioconda
