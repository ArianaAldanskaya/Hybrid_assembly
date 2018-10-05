FROM continuumio/miniconda
MAINTAINER Anastasia Illarionova <ariana.aldanskaya@gmail.com>
LABEL authors="ariana.aldanskaya@gmail.com" \
    description="Docker image containing all requirements for MeDuSa pipeline"


# Install MUMmer 3.0
RUN apt-get update && apt-get install -y g++ libboost-all-dev zlib1g-dev libbz2-dev make
RUN curl -fsSL https://sourceforge.net/projects/mummer/files/mummer/3.23/MUMmer3.23.tar.gz/download -o /opt/mummer.tar.gz
RUN cd /opt/; tar -xzvf mummer.tar.gz; cd MUMmer3.23; configure; make; make install
ENV PATH $PATH:/opt/mummer/bin


# Install MeDuSa 1.6
RUN apt-get update && apt-get install -y g++ libboost-all-dev zlib1g-dev libbz2-dev make
RUN curl -fsSL https://github.com/combogenomics/medusa/releases/download/medusa-1.6/medusa.tar.gz -o /opt/medusa.tar.gz
RUN cd /opt/; tar -xzvf medusa.tar.gz; cd medusa
ENV PATH $PATH:/opt/medusa


# Create medusa-env
COPY environment.yml /
RUN conda env create -f /environment.yml && conda clean -a
ENV PATH /opt/conda/envs/medusa-env/bin:$PATH


# Install PROCPS
RUN apt-get update && apt-get install -y procps