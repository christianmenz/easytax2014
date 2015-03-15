FROM ubuntu:14.04

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

# Run the app
CMD ./EasyTax2014AG/EasyTax2014_AG