FROM ubuntu:16.04

RUN apt-get update && \
                    # for Anaconda
    apt-get install -y wget bzip2 \
                    # for OpenCV
                       libgtk2.0-0

# Anaconda3-4.2.0 install
RUN wget https://repo.continuum.io/archive/Anaconda3-4.2.0-Linux-x86_64.sh && \
    bash Anaconda3-4.2.0-Linux-x86_64.sh -b && \
    rm -f Anaconda3-4.2.0-Linux-x86_64.sh

ENV PATH $PATH:/root/anaconda3/bin

# OpenCV install
RUN conda install -c https://conda.anaconda.org/menpo opencv3

# chainer install
RUN pip install chainer

# make jupyter directory
RUN mkdir /opt/jupyter/ && \
    jupyter notebook --generate-config && \
    sed -i -e "s/#c.NotebookApp.ip = 'localhost'/c.NotebookApp.ip = '*'/" /root/.jupyter/jupyter_notebook_config.py

CMD cd /opt/jupyter/ && \
    jupyter notebook
