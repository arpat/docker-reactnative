## React Native in docker

#### Requirements

Docker, a running xorg session.

#### The Dockerfile Installs Dependencies 
- Node
- React Native command line interface
- JDK
- Android Studio

#### Android Studio requires a user agreement, so download first.

The Dockerfile expects ./android-studio-ide-latest.zip

Build with `$ docker build -t react-native .`

#### Running the IDE

Assuming you are running from an xterm like console run with

```
#!/bin/bash

Studio="AndroidStudio2.3"
MyFiles=developer

WORKDIR=${PWD}

docker run -v /tmp/.X11-unix:/tmp/.X11-unix \
           -e DISPLAY=unix$DISPLAY \
           -v ${WORKDIR}/android/.${Studio}:/home/android/.${Studio} \
           -v ${WORKDIR}/android/.java:/home/android/.java \
           -v ${WORKDIR}/android/.android:/home/android/.android \
           -v ${WORKDIR}/android/${MyFiles}:/home/android/${MyFiles} \
      --entrypoint=/opt/android-studio/bin/studio.sh \
           -it react-native:latest
```
