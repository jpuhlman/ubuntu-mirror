FROM ubuntu:19.10
ENV RELEASE_DISTRO ubuntu
ENV RELEASE_VERSION 19.10
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update
RUN apt-get install -y \
    lynx \
    build-essential \
    file \
    cpio \
    diffstat \
    gawk \
    koji-client \
    python-krbv \
    sudo \
    apt-transport-https \
    ca-certificates \    
    curl \
    software-properties-common \
    locales
# Make sure docker works in container
RUN apt install -y apt-transport-https ca-certificates curl software-properties-common
RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
RUN add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"
RUN apt update
RUN apt -y install docker-ce
# Fix locales
RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
    dpkg-reconfigure --frontend=noninteractive locales && \
    update-locale LANG=en_US.UTF-8
RUN apt -y install lib32stdc++6 mock 
COPY init.sh /
CMD  bash /init.sh
