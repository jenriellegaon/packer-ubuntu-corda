#!/bin/bash -eux

# Install IntelliJ IDEA
echo "Installing IntelliJ-IDEA"
wget "https://download-cf.jetbrains.com/idea/ideaIC-2018.3.3.tar.gz"

tar xfz ideaIC-2018.3.3.tar.gz -C /opt/

# echo "Run idea.sh inside /opt/<IntelliJ>/bin"