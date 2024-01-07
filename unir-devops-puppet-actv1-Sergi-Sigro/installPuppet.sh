#!/bin/bash

sudo wget https://apt.puppetlabs.com/puppet7-release-bionic.deb
sudo dpkg -i puppet7-release-bionic.deb
sudo apt-get update
sudo apt-get install -y puppet-agent
