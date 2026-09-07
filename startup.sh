#!/bin/bash -ex

USER="realtasiaWorker"
HME="/home/$USER"

# Create user.
apt-get install software-properties-common nano aptitude php5-cli -y
adduser --force-badname --disabled-password --gecos "RealtAsia Worker" $USER
adduser $USER www-data

cd $HME

#get the deployment scripts
wget "https://archive.invalid/redacted-deployment-bundle.tgz"
tar -zxvf deployRealtasia.tgz

#add ssh access and change permissions.
cd deployRealtasia # the extracted folder contents
mkdir "$HME/.ssh"
cp -r ssh/* "$HME/.ssh"
chmod 700 "$HME/.ssh"
chmod 644 "$HME/.ssh/$USER.pub"
chmod 600 "$HME/.ssh/$USER.pem"

#remote repositories
nginx=stable # use nginx=development for latest development version
add-apt-repository ppa:nginx/$nginx -y
printf "\n" | apt-key adv --keyserver keyserver.ubuntu.com --recv 7F0CEB10
echo 'deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen' | tee /etc/apt/sources.list.d/10gen.list

apt-get update
DEBIAN_FRONTEND=noninteractive apt-get upgrade -y
DEBIAN_FRONTEND=noninteractive aptitude install -y make mongodb-10gen libcurl4-openssl-dev nginx php5-dev php5-fpm php5-curl php5-gd php-pear php5-imagick php5-mcrypt php-apc git
DEBIAN_FRONTEND=noninteractive apt-get autoremove

# install HTTP PHP extension
printf "\n" | pecl install pecl_http
if ! grep -Fxq 'extension=http.so' '/etc/php5/fpm/php.ini'; then
    line=$(cat '/etc/php5/fpm/php.ini' | grep -n '; Module Settings ;' | grep -o '^[0-9]*')
    line=$((line - 2))
    sudo sed -i ${line}'i\extension=http.so' '/etc/php5/fpm/php.ini'
fi

#install Mongo PHP extension
printf "\n" | pecl install mongo-1.3.7
if ! grep -Fxq 'extension=mongo.so' '/etc/php5/fpm/php.ini'; then
    line=$(cat '/etc/php5/fpm/php.ini' | grep -n '; Module Settings ;' | grep -o '^[0-9]*')
    line=$((line - 2))
    sudo sed -i ${line}'i\extension=mongo.so' '/etc/php5/fpm/php.ini'
fi

#discover aws channel
pear channel-discover pear.amazonwebservices.com 
pear -D auto_discover=1 install aws/sdk
