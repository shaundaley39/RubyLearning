#!/bin/bash
# for setup extention, see this: http://blog.bottomlessinc.com/2010/12/installing-the-amazon-ec2-command-line-tools-to-launch-persistent-instances/
ARGS=3        # name, pem, host
mkdir ~/.ssh
cp ~/Downloads/$2.pem ~/.ssh/
sudo chmod 400 ~/.ssh/$2.pem
sudo chmod 700 ~/.ssh
echo 'Host ' $1 '
HostName ' $3 '
User ubuntu 
IdentityFile "~/.ssh/'$2'.pem"' >> ~/.ssh/config
ssh $1

## in order for this to be executable,$:   chmod 777 newhost.sh



