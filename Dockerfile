# React Native for android 
#  Build with
#    $ docker build -t react-native . 
#  Run with:
#    $ docker run -v /tmp/.X11-unix:/tmp/.X11-unix \
#      -e DISPLAY=unix$DISPLAY \
#      -it react-native:latest


# node:7-slim = debian:jessie + buildpack-deps:jessie-curl
FROM node:7-slim
LABEL maintainer "arpat <arunsmtp@gmail.com"

RUN npm install -g react-native-cli

#   install JDK8
RUN bash -xc \
   'echo "# jessie-backports, previously on backports.debian.org" >> /etc/apt/sources.list ; \
    echo "deb http://ftp.uk.debian.org/debian/ jessie-backports main contrib non-free" >> /etc/apt/sources.list' \
 && DEBIAN_FRONTEND=noninteractive apt-get update \
 && DEBIAN_FRONTEND=noninteractive apt-get install -y -t jessie-backports --no-install-recommends \
    openjdk-8-jdk openjdk-8-jre-headless && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

#   Install Android Studio
#   vendor requires agreement action, rename download as android-studio-ide-latest.zip
#   Needs i386 compatability, we assume this system is amd64
RUN dpkg --add-architecture i386 \
 && DEBIAN_FRONTEND=noninteractive apt-get update \
 && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    zip unzip \
    libc6:i386 libncurses5:i386 libstdc++6:i386 lib32z1 libbz2-1.0:i386 \
    && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

COPY ./android-studio-ide-latest.zip /tmp/studio.zip
RUN  unzip -q /tmp/studio.zip -d /opt && rm -v /tmp/studio.zip

#    default user is android
RUN  useradd -ms /bin/bash android
USER android
WORKDIR /home/android

ENTRYPOINT ["/bin/bash"]
