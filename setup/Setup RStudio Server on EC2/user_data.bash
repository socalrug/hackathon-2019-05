#!/bin/bash
#install R
sudo yum update -y
sudo amazon-linux-extras install -y R3.4

wget https://download2.rstudio.org/server/centos6/x86_64/rstudio-server-rhel-1.2.1335-x86_64.rpm
sudo yum install -y rstudio-server-rhel-1.2.1335-x86_64.rpm
rm rstudio-server-rhel-1.2.1335-x86_64.rpm

# needed for RCurl
sudo yum install -y libcurl-devel.x86_64

# add user(s)
useradd shiny-user
echo shiny-user:shinypass | sudo chpasswd

sudo /usr/sbin/rstudio-server start
