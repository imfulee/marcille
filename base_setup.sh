#!/bin/bash

# create work and personal project directories
mkdir -p "$HOME"/{Documents,Downloads,work,personal,container}

# change shell to zsh
chsh -s "$(which zsh)"
