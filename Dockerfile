FROM ubuntu:rolling

RUN DEBIAN_FRONTEND=noninteractive \
    apt-get update && \
    apt-get install -y locales locales-all && \
    apt-get install -y tzdata && \
    apt-get install -y keyboard-configuration

    

# --- Custom Code here:

# Add additional apt-packages and dependencies here:
RUN apt-get install -y wget pulseaudio dbus-x11 procps psmisc cups wget xfonts-100dpi-transcoded xfonts-75dpi xfonts-75dpi-transcoded

# Custom Script(s) here:
RUN DLLINK=$(wget --save-headers --output-document - https://downloads.nomachine.com/de/download/?id=5 | grep download.nomachine.com | cut -d '"' -f6 | head -1) && wget -O /nomachine.deb $DLLINK && \
    apt-get install -y /nomachine.deb

# Install latest Chrome
RUN wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -O /tmp/google-chrome-stable_current_amd64.deb && \
    apt-get install -y /tmp/google-chrome-stable_current_amd64.deb


#  --- End Custom Code

RUN rm -rf /var/lib/apt/lists/*

# Set Timezone
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Set System Language
RUN echo $LANG > /etc/locale.gen && \
    env DEBIAN_FRONTEND=noninteractive apt-get install -y \
     locales && \
     locale-gen $LANG || update-locale --reset LANG=$LANG

ENV LANG=de_AT.UTF-8
ENV TZ=Europe/Vienna

ENV QT_GRAPHICSSYSTEM="native"
COPY entrypoint.sh /
RUN chmod +x entrypoint.sh

CMD ["/bin/sh", "/entrypoint.sh"]
