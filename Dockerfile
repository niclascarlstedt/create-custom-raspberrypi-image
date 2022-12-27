FROM ubuntu:20.04

RUN echo "APT::Get::Assume-Yes \"true\";" > /etc/apt/apt.conf.d/90assumeyes

RUN apt-get update \
    && apt-get install \
        ca-certificates \
        jq \
        git \
        curl\
        wget \
        xz-utils \
        gpg

# RUN echo 'deb http://download.opensuse.org/repositories/home:/pragmalin/xUbuntu_20.04/ /' | tee /etc/apt/sources.list.d/home:pragmalin.list \
#     && curl -fsSL https://download.opensuse.org/repositories/home:pragmalin/xUbuntu_20.04/Release.key | gpg --dearmor | tee /etc/apt/trusted.gpg.d/home_pragmalin.gpg > /dev/null \
#     && apt-get update \
#     && apt-get install rpi-imager
 
RUN mkdir -p /scripts
COPY scripts/download-latest-raspberrypi-image.sh /scripts

WORKDIR /

RUN chmod +x scripts/download-latest-raspberrypi-image.sh

ENTRYPOINT ["bash"]