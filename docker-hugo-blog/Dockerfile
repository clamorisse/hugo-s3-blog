FROM ubuntu:14.04 

MAINTAINER Berenice Venegas Cotero <bvcotero@gmail.com>

RUN apt-get update && apt-get install -y curl tar

ENV HUGO_VERSION 0.30
ADD https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_${HUGO_VERSION}_Linux-64bit.tar.gz .
RUN tar -xf hugo_${HUGO_VERSION}_Linux-64bit.tar.gz -C /usr/local/bin \
    && rm -rf hugo_${HUGO_VERSION}_Linux-64bit.tar.gz 

ENV HOME /usr/src
VOLUME ${HOME}/blog/
WORKDIR ${HOME}/blog/

EXPOSE 1313 

#ENTRYPOINT ["./release.sh"]
#CMD ["hugo"]
