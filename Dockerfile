FROM ubuntu:20.04
ENV RELEASE_DISTRO ubuntu
ENV RELEASE_VERSION 20.04
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update
RUN apt-get install -y \
    lynx \
    build-essential \
    file \
    cpio \
    diffstat \
    gawk \
    sudo \
    apt-transport-https \
    ca-certificates \    
    curl \
    software-properties-common \
    locales \
    wget \
    chrpath \ 
    python3-distutils \ 
    vim \
    screen \
    bzr \
    pbuilder \
    debootstrap \
    devscripts \
    libncursesw5 \
    ubuntu-dev-tools \ 
    apt-mirror    
RUN apt upgrade -y
# Make sure docker works in container
# Fix locales
RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
    dpkg-reconfigure --frontend=noninteractive locales && \
    update-locale LANG=en_US.UTF-8
COPY init.sh /
RUN sed -i -e "s,artful,focal,g" /etc/apt/mirror.list
CMD  bash /init.sh

