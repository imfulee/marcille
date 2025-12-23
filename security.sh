#!/bin/bash

sudo ufw enable

# kde connect ports
sudo ufw allow 1714:1764/udp
sudo ufw allow 1714:1764/tcp

sudo ufw reload
