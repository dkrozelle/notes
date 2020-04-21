### setup a conda env with jupyter 
conda create -n bids python=3.7 ipykernel jupyter
source activate bids
conda install -c conda-forge pandas
python -m ipykernel install --user --name=bids
jupyter notebook


### installing packages from inside jupyter
import sys
!conda install --yes --prefix {sys.prefix} pandas

### import src modules and forced re-import
import importlib
from src.util import *
importlib.reload(src.util)

### Organize notebooks under the notebooks/ directory but retain project root as working directory
import os
os.chdir("..")
os.getcwd()


# connect to jupyter server and run locally
# on cygwin, forward post 8889 from server 43
ssh -L localhost:8889:localhost:8889 drozelle@10.113.29.43

# launch the notebook
jupyter notebook --no-browser --port=8889
