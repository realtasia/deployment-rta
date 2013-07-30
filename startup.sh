#!/bin/bash -ex

#get the deployment scripts
wget "https://s3-ap-southeast-1.amazonaws.com/cbrepo/deployRealtasia/deployRealtasia.tgz"
tar -zxvf deployRealtasia.tgz

USER="realtasiaWorker"
HME="/home/$USER"

# Create user.
apt-get install software-properties-common nano aptitude php5-cli git -y
adduser --force-badname --disabled-password --gecos "RealtAsia Worker" $USER
adduser $USER www-data

#add ssh access and change permissions.
mkdir "$HME/.ssh"
cd deployRealtasia
cp -r ssh/ "$HME/.ssh"
chmod 700 "$HME/.ssh"
chmod 644 "$HME/.ssh/$USER.pub"
chmod 600 "$HME/.ssh/$USER.pem"

#remote repositories

nginx=stable # use nginx=development for latest development version
add-apt-repository ppa:nginx/$nginx -y
apt-key adv --keyserver keyserver.ubuntu.com --recv 7F0CEB10 -y
echo 'deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen' | sudo tee /etc/apt/sources.list.d/10gen.list

apt-get update
DEBIAN_FRONTEND=noninteractive apt-get upgrade -y && apt-get install aptitude -y
DEBIAN_FRONTEND=noninteractive aptitude install -y mongodb-10gen libcurl4-openssl-dev nginx php5-dev php5-fpm php5-curl php5-gd php-pear php5-imagick php5-mcrypt php-apc git
DEBIAN_FRONTEND=noninteractive apt-get autoremove

printf "\n" | pecl install pecl_http
if ! grep -Fxq 'extension=http.so' '/etc/php5/fpm/php.ini'; then
    line=$(cat '/etc/php5/fpm/php.ini' | grep -n '; Module Settings ;' | grep -o '^[0-9]*')
    line=$((line - 2))
    sudo sed -i ${line}'i\extension=http.so' '/etc/php5/fpm/php.ini'
fi
printf "\n" | pecl install mongo
if ! grep -Fxq 'extension=mongo.so' '/etc/php5/fpm/php.ini'; then
    line=$(cat '/etc/php5/fpm/php.ini' | grep -n '; Module Settings ;' | grep -o '^[0-9]*')
    line=$((line - 2))
    sudo sed -i ${line}'i\extension=mongo.so' '/etc/php5/fpm/php.ini'
fi

