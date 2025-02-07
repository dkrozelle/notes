## setup

```python setup.py
from setuptools import setup, find_packages

# Call setup function
setup(
    author="Dan",
    description="A package for converting imperial lengths and weights.",
    name="impyrial",
    packages=find_packages(include=['impyrial','impyrial.*']),
    version="0.1.0",
    install_requires=['pandas>=1.0'],
    # only python >2.7 and not 3
    python_requires=['>=2.7, !=3.0*, !=3.1.*']
)
```

## installation

```bash
# install an editable version
pip install -e .
```
