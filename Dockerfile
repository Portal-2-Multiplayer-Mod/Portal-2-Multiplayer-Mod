FROM ubuntu
ENV DEBIAN_FRONTEND=noninteractive


RUN apt-get update && \
    apt-get -yq install software-properties-common curl && \
    apt-get -yq autoclean


RUN add-apt-repository universe
RUN add-apt-repository ppa:deadsnakes/ppa
RUN apt-get -yq install python3.10 python3-pip python3-venv libfuse2

ADD . /app
WORKDIR "/app"

RUN chmod +x tools/build-appimage.sh
# RUN tools/build-appimage.sh