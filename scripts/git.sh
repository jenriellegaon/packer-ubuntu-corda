#!/bin/bash -eux

# Add git ppa
apt-add-repository -y ppa:git-core/ppa
apt-get update

# Install Git
echo "# Installing Git"
apt-get install -y git