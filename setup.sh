#!/bin/bash
#Checks if you are root or not 
if test "`id -u`" -ne 0
	then 
	echo "You need to run this script as root!" 
	exit 
fi
nginx=stable # use nginx=development for latest development version
add-apt-repository ppa:nginx/$nginx -y
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv 7F0CEB10 -y
echo 'deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen' | sudo tee /etc/apt/sources.list.d/10gen.list
sudo apt-get update -y && sudo apt-get upgrade -y && sudo apt-get install aptitude -y
sudo aptitude install -y mongodb-10gen libcurl4-openssl-dev nginx php5-dev php5-fpm php5-curl php5-gd php-pear php5-imagick php5-mcrypt php-apc git
sudo apt-get autoremove

printf "\n" | pecl install pecl_http
if ! grep -Fxq 'extension="http.so"' '/etc/php5/fpm/php.ini'; then
    line=$(cat '/etc/php5/fpm/php.ini' | grep -n '; Module Settings ;' | grep -o '^[0-9]*')
    line=$((line - 2))
    sudo sed -i ${line}'i\extension="http.so"' '/etc/php5/fpm/php.ini'
fi
printf "\n" | pecl install mongo
if ! grep -Fxq 'extension="mongo.so"' '/etc/php5/fpm/php.ini'; then
    line=$(cat '/etc/php5/fpm/php.ini' | grep -n '; Module Settings ;' | grep -o '^[0-9]*')
    line=$((line - 2))
    sudo sed -i ${line}'i\extension="mongo.so"' '/etc/php5/fpm/php.ini'
fi
sudo pear -D auto_discover=1 install pear.amazonwebservices.com/sdk
sudo service php5-fpm restart
