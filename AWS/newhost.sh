#!/bin/bash
ARGS=3        # name, pem, host
mkdir ~/.ssh
cp ~/Downloads/$2.pem ~/.ssh/
sudo chmod 400 ~/.ssh/$2.pem
sudo chmod 700 ~/.ssh
echo 'Host ' $1 '
HostName ' $3 '
User ubuntu 
IdentityFile "~/.ssh/'$2'.pem"' >> ~/.ssh/config



## in order for this to be executable,$:   chmod 777 newhost.sh
