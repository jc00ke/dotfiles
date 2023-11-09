#!/bin/env bash

curl https://cli-assets.heroku.com/install-ubuntu.sh | sh
sudo apt-key export E80F6A35 | sudo gpg --dearmor -o /etc/apt/trusted.gpg.d/heroku.gpg
