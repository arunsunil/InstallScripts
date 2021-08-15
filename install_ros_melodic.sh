#!/bin/bash

set -ex

# Elevate to superuser if not running as root
[ "$(id -u)" -eq 0 ] && SUDO="" || SUDO="sudo"

# To stop tzdata from prompting for time zone information and pausing the script
export DEBIAN_FRONTEND=noninteractive

$SUDO apt update
$SUDO apt install -y lsb-release curl gnupg

# Setup your sources.list
$SUDO sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'

# Set up your keys
curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | $SUDO apt-key add -

# Installation
# Change to ros-melodic-desktop-full or ros-melodic-ros-base as per requirements
$SUDO apt update
$SUDO apt install -y ros-melodic-desktop

# Environment setup
echo "source /opt/ros/melodic/setup.bash" >> ~/.bashrc
source ~/.bashrc

# Dependencies for building packages
$SUDO apt install -y python-rosdep python-rosinstall python-rosinstall-generator python-wstool build-essential

# Initialize rosdep
$SUDO apt install python-rosdep
$SUDO rosdep init
rosdep update

# Fix permissions
$SUDO rosdep fix-permissions
rosdep update
