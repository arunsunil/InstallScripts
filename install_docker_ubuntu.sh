#!/bin/bash

# This is just a compilation of the steps provided in https://docs.docker.com/engine/install/ubuntu/.

print_colour()
{
    # From https://stackoverflow.com/questions/5947742/how-to-change-the-output-color-of-echo-in-linux

    no_colour='\033[0m'

    case $2 in
        cyan)
            colour='\033[0;36m' # Cyan
            ;;
        lred)
            colour='\033[1;31m' # Light Red
            ;;
        lgrn)
            colour='\033[1;32m' # Light Green
            ;;
        *)
            colour=$no_colour # No Color
            ;;
    esac

    printf "${colour}$1${no_colour}\n"
}

print_colour "----------------------------- INSTALLING PREREQUISITES -----------------------------" "cyan"

sudo apt-get update

sudo apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common \
    lsb-release

print_colour "------------------------------- DOWNLOADING GPG KEY --------------------------------" "cyan"

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

print_colour "------------------------------ ADDING REPO TO SOURCES ------------------------------" "cyan"

sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

print_colour "----------------------------- INSTALLING DOCKER ENGINE -----------------------------" "cyan"

sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io

print_colour "---------------------- ADDING CURRENT USER TO 'docker' GROUP -----------------------" "cyan"

sudo groupadd docker
sudo usermod -aG docker $USER

print_colour "\nInstallation complete!\n" "lgrn"
print_colour "Please log out and log back in for the permission changes to take effect." "lred"
print_colour "You will only be able to use docker with root privileges (sudo) until then." "lred"
