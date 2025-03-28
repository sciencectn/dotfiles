FROM ubuntu:22.04

RUN DEBIAN_FRONTEND=noninteractive apt update
RUN DEBIAN_FRONTEND=noninteractive apt-get install --yes --reinstall ca-certificates
RUN DEBIAN_FRONTEND=noninteractive apt-get --yes --no-install-recommends install \
    sudo \
    git \
    curl \
    wget \
    zsh

COPY . /root/dotfiles/

RUN /root/dotfiles/setup.bash

ENTRYPOINT [ "/bin/zsh" ]
