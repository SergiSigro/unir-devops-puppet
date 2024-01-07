#!/bin/bash

# Script principal que llama a los otros dos scripts

# Ejecutar script para instalar Puppet
./installPuppet.sh

# Ejecutar script para aplicar manifestos Puppet
./apply-manifest.sh