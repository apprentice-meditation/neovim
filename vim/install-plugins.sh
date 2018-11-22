#!/bin/bash

# This script is simply for automating the downloading of the vim plugins
echo "Installing Plugins"
vim -i NONE -c VundleInstall -c quitall > /dev/null 2>&1
echo "Done Installling Plugins"
