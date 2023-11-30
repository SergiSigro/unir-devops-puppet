#!/bin/bash

sudo mkdir -p /my-first-blog
sudo /opt/puppetlabs/bin/puppet apply --modulepath=./modules ./manifests/default.pp