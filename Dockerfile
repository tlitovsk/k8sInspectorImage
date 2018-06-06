FROM ubuntu:latest

RUN apt-get update && apt-get install -y apt-transport-https curl gnupg
RUN curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
RUN echo 'deb http://apt.kubernetes.io/ kubernetes-xenial main' > EOF >/etc/apt/sources.list.d/kubernetes.list

RUN apt-get update \
    && apt-get -y install telnet cockpit kubectl \
    && apt-get clean
