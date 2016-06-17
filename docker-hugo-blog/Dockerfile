FROM ubuntu:14.04

MAINTAINER Berenice Cotero <bvcotero@gmail.com>

# Install wget
RUN apt-get update 
RUN apt-get install -y wget git
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Install go tarball
ENV GOLANG_VERSION 1.5.1
RUN wget -qO- http://golang.org/dl/go${GOLANG_VERSION}.linux-amd64.tar.gz | tar -C /usr/local -xzf -

# Set user
ENV HOME /root
ENV GOPATH ${HOME}/go
ENV PATH ${PATH}:${GOPATH}/bin:/usr/local/go/bin
RUN touch ${HOME}/.zshrc
WORKDIR ${HOME}

# Install Hugo
RUN go get -u -v github.com/spf13/hugo
EXPOSE 1313

VOLUME ${HOME}/hugo
WORKDIR ${HOME}/hugo
