FROM ubuntu:14.04 

MAINTAINER Berenice Venegas Cotero <bvcotero@gmail.com>

RUN apt-get update && apt-get install -y curl tar

ENV HUGO_VERSION 0.19
ADD https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_${HUGO_VERSION}_Linux-64bit.tar.gz .
RUN tar -xf hugo_${HUGO_VERSION}_Linux-64bit.tar.gz -C /usr/local/bin \
	&& mv /usr/local/bin/hugo_${HUGO_VERSION}_linux_amd64/hugo_${HUGO_VERSION}_linux_amd64 /usr/local/bin/hugo

ENV HOME /usr/src
VOLUME ${HOME}/blog/
WORKDIR ${HOME}/blog/

EXPOSE 1313 

#ENTRYPOINT ["./release.sh"]
#CMD ["hugo"]
