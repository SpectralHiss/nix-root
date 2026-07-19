#!/usr/bin/env bash

set +o errexit
set -o xtrace

INSTALL_PATH=/etc/nixos 

sudo cp "${INSTALL_PATH}/configuration.nix" "${INSTALL_PATH}"/configuration.nix-$(date +%s)
sudo cp /home/houssem/Desktop/00SpectralHiss/nix-root/nix-vm/configuration.nix "${INSTALL_PATH}"/configuration.nix
