#!/bin/sh
# This script installs homer on this computer
# PREREQUISITE: configurehomer.pl is in same dir as this script
# instructions found here http://homer.salk.edu/homer/introduction/install.html

# Make new folder for homer and install it
mkdir homer_install
mv configureHomer.pl homer_install/configureHomer.pl
cd homer_install
perl configureHomer.pl -install

# modify .bash_profile so we can execute homer programs from
# any working directory
to_add='PATH=$PATH:'$(pwd)'/bin'
echo $to_add >> ~/.bash_profile
source ~/.bash_profile