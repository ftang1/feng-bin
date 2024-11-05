#!/bin/sh
sudo cp /usr/bin/ccache /usr/local/bin/
sudo ln -s /usr/local/bin/ccache /usr/local/bin/gcc
sudo ln -s /usr/local/bin/ccache /usr/local/bin/g++
sudo ln -s /usr/local/bin/ccache /usr/local/bin/cc

