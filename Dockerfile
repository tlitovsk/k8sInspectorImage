FROM ubuntu:latest

RUN apt-get update \
    && apt-get -y install telnet \
    && apt-get clean
