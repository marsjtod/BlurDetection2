#docker build =>
#docker build --tag blur-detect:0.1 ./
#docker run ==> 
#docker run -it -v "/mnt/e/workspace":/home/mars/workspace -w "/home/mars/workspace" -p 8891:8891 blur-detect:0.1
#run
# python process.py -i ~/workspace/test/deblur-test/ -s results.json

# 1. OS
FROM ubuntu:18.04

# 2. basic, gl
# Setup build environment for libpam
RUN apt-get update -y

## Updating Ubuntu packages
#RUN apt-get update && yes|apt-get upgrade
RUN apt-get install -y nano
RUN apt-get install -y wget bzip2

# GL for image view
RUN apt install libgl1-mesa-glx

# 3. pip
## python3, pip isntallation
ARG _PY_SUFFIX=3
ARG PYTHON=python${_PY_SUFFIX}
ARG PIP=pip${_PY_SUFFIX}

# See http://bugs.python.org/issue19846
ENV LANG C.UTF-8

RUN apt-get update && apt-get install -y \
    ${PYTHON} \
    ${PYTHON}-pip

RUN ${PIP} --no-cache-dir install --upgrade \
    pip \
    setuptools

# 4. env
# Some TF tools expect a "python" binary
RUN ln -s $(which ${PYTHON}) /usr/local/bin/python 

# # python
# RUN wget https://bootstrap.pypa.io/get-pip.py
# RUN apt-get -y install python
# RUN python get-pip.py 
# RUN apt-get install -y python-pip python-dev 

# 5. pip modules
RUN pip install numpy opencv-python