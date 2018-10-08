FROM continuumio/miniconda
MAINTAINER Ariana Aldanskaya <ariana.aldanskaya@gmail.com>
LABEL authors="ariana.aldanskaya@gmail.com" \
    description="Docker image containing all requirements for MeDuSa pipeline"
    
    
# Install java
RUN apt-get update && apt-get install -y g++ libboost-all-dev zlib1g-dev libbz2-dev make
RUN curl -fsSL http://javadl.oracle.com/webapps/download/AutoDL?BundleId=234464_96a7b8442fe848ef90c96a2fad6ed6d1 -o /java.tar.gz
RUN cd /opt/; tar -xzvf java.tar.gz; rm java.tar.gz
ENV PATH $PATH:/jre1.8.0_181/bin

# Install MUMmer 3.23
RUN apt-get update && apt-get install -y g++ libboost-all-dev zlib1g-dev libbz2-dev make
RUN curl -fsSL https://sourceforge.net/projects/mummer/files/mummer/3.23/MUMmer3.23.tar.gz/download -o /mummer.tar.gz
RUN cd /opt/; tar -xzvf mummer.tar.gz; cd MUMmer3.23; make install; rm mummer.tar.gz
ENV PATH $PATH:/MUMmer3.23


# Install MeDuSa 1.6
RUN apt-get update && apt-get install -y g++ libboost-all-dev zlib1g-dev libbz2-dev make
RUN curl -fsSL https://github.com/combogenomics/medusa/releases/download/medusa-1.6/medusa.tar.gz -o /opt/medusa.tar.gz
RUN cd /opt/; tar -xzvf medusa.tar.gz; cd medusa
ENV PATH $PATH:/medusa


# Create medusa-env
COPY environment.yml /
RUN conda env create -f /environment.yml && conda clean -a
ENV PATH /conda/envs/medusa-env/bin:$PATH


# Install PROCPS
RUN apt-get update && apt-get install -y procps
