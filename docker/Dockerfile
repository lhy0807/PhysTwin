FROM nvidia/cuda:12.1.0-devel-ubuntu22.04

ENV TZ=US/Pacific
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get update --fix-missing && \
    apt-get install -y libgtk2.0-dev libgl1-mesa-glx freeglut3-dev && \
    apt-get install -y wget bzip2 ca-certificates curl git vim tmux g++ gcc build-essential ninja-build cmake

SHELL ["/bin/bash", "--login", "-c"]

RUN cd / && wget --quiet https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O /miniconda.sh && \
    /bin/bash /miniconda.sh -b -p /opt/conda &&\
    ln -s /opt/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh &&\
    echo ". /opt/conda/etc/profile.d/conda.sh" >> ~/.bashrc &&\
    /bin/bash -c "source ~/.bashrc" && \
    /opt/conda/bin/conda update -n base -c defaults conda -y &&\
    /opt/conda/bin/conda create -y -n phystwin python=3.10


ENV PATH=$PATH:/opt/conda/envs/my/bin \
    CUDA_HOME=/usr/local/cuda \
    TORCH_CUDA_ARCH_LIST="8.0 8.6+PTX" \
    SETUPTOOLS_USE_DISTUTILS=stdlib \
    FORCE_CUDA=1

RUN git clone https://github.com/Jianghanxiao/PhysTwin.git

RUN conda init bash &&\
    echo "conda activate phystwin" >> ~/.bashrc &&\
    conda activate phystwin &&\
    cd PhysTwin && bash ./env_install/env_install.sh

RUN conda activate phystwin && pip install einops

ENV SHELL=/bin/bash
RUN ln -sf /bin/bash /bin/sh