# Description: Creates a continer running EasyTax2014AG 
#
# Usage: 
# docker run -it --rm  -v /tmp/.X11-unix:/tmp/.X11-unix -v /home/<yourusername>/EasyTax2014/:/root/TaxData -e DISPLAY=unix$DISPLAY christianmenz/easytax2014ag
#
# Note: the important thing for you to change is the location where you will actually want to store your data.
# When using the application please make sure you save the data in the mounted directory (/root/TaxData). If you miss that point you could end up having lost all your changes.

FROM ubuntu:14.04
MAINTAINER Christian Menz <christianmenz@gmail.com>

RUN apt-get update
RUN apt-get -y install python-software-properties
RUN apt-get -y install software-properties-common
RUN apt-get -y install unzip

#
# Install Oracle JDK
#
RUN add-apt-repository -y ppa:webupd8team/java
RUN apt-get update
RUN echo debconf shared/accepted-oracle-license-v1-1 select true | debconf-set-selections
RUN echo debconf shared/accepted-oracle-license-v1-1 seen true | debconf-set-selections
RUN apt-get -y install oracle-java7-installer
RUN apt-get -y install oracle-java7-set-default
RUN apt-get clean

# Install some X libs & stuff (not sure what is actually needed)
RUN apt-get -y install libxtst6 libgtk2.0-0 libgdk-pixbuf2.0-0 libfontconfig1 libxrender1 libx11-6 libglib2.0-0  libxft2 libfreetype6 libc6 zlib1g libpng12-0 libstdc++6-4.8-dbg-arm64-cross libgcc1

# Download and extract EasyTax2014
RUN mkdir /EasyTax
WORKDIR /EasyTax
RUN wget http://www.hwis.ch/Downloads/EasyTax2014AG_unix_1_1.tar.gz
RUN tar -zxvf EasyTax2014AG_unix_1_1.tar.gz

RUN mkdir /root/TaxData

# Run the app
CMD ./EasyTax2014AG/EasyTax2014_AG
