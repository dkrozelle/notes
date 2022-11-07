# setup a conda env with jupyter 
conda create -n myenv python=3.7 pandas 
conda activate myenv
conda install -c conda-forge pandas

conda env remove -n myenv

conda env export >environment.yaml
conda env create -f environment.yaml

# using conda in dockerfile
USER ubuntu
RUN conda create -n myenv python=3.9
SHELL ["conda", "run", "-n", "myenv", "/bin/bash", "-c"]
RUN conda install -c conda-forge -c anaconda pigz pyyaml

RUN conda init bash

# running a script from a conda env
conda run -n myenv script.sh


conda config --add channels bioconda
