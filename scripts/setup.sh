#!/bin/bash -eux

# Corda installation script

echo "Created by Jenrielle Gaon"

# Add vagrant user to sudoers.
echo "vagrant        ALL=(ALL)       NOPASSWD: ALL" >> /etc/sudoers
sed -i "s/^.*requiretty/#Defaults requiretty/" /etc/sudoers

# Disable daily apt unattended updates.
echo 'APT::Periodic::Enable "0";' >> /etc/apt/apt.conf.d/10periodic

# Update package lists
echo "# Updating package lists"
apt-get update

# This is for special distros that removed adding PPA by default
echo "Enabling support for adding PPA"
apt-get install software-properties-common -y