#!/bin/bash -eux

# JAVA 8

Install Java 8
echo 'deb http://ppa.launchpad.net/webupd8team/java/ubuntu bionic main' >/etc/apt/sources.list.d/webupd8team-ubuntu-java-disco.list

add-apt-repository -y ppa:webupd8team/java

apt-key adv --keyserver keyserver.ubuntu.com --recv-keys C2518248EEA14886

apt-get update

echo debconf shared/accepted-oracle-license-v1-1 select true | sudo debconf-set-selections
echo debconf shared/accepted-oracle-license-v1-1 seen true | sudo debconf-set-selections

echo "Installing Java 8"
apt install oracle-java8-installer -y