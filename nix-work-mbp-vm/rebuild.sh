#!/usr/bin/env bash

HOSTNAME=utm-work
sudo nixos-rebuild --flake ".#${HOSTNAME}" switch

