#!/bin/bash
#Checks if you are root or not 
if test "`id -u`" -ne 0
	then 
	echo "You need to run this script as root!" 
	exit 
fi
sudo apt-get install software-properties-common
sudo apt-get update -y && sudo apt-get upgrade -y && sudo apt-get install aptitude -y
sudo aptitude install -y mongodb libcurl4-openssl-dev nginx php5-dev php5-fpm php5-curl php5-gd php-pear php5-imagick php5-mcrypt php-apc php5-tidy gearman-job-server libgearman-dev git

sudo pecl install pecl_http
if ! grep -Fxq 'extension=http.so' '/etc/php5/fpm/php.ini'; then
    line=$(cat '/etc/php5/fpm/php.ini' | grep -n '; Module Settings ;' | grep -o '^[0-9]*')
    line=$((line - 2))
    sudo sed -i ${line}'i\extension=http.so' '/etc/php5/fpm/php.ini'
fi
sudo pecl install mongo
if ! grep -Fxq 'extension=mongo.so' '/etc/php5/fpm/php.ini'; then
    line=$(cat '/etc/php5/fpm/php.ini' | grep -n '; Module Settings ;' | grep -o '^[0-9]*')
    line=$((line - 2))
    sudo sed -i ${line}'i\extension=mongo.so' '/etc/php5/fpm/php.ini'
fi
sudo pecl install gearman
if ! grep -Fxq 'extension=gearman.so' '/etc/php5/fpm/php.ini'; then
    line=$(cat '/etc/php5/fpm/php.ini' | grep -n '; Module Settings ;' | grep -o '^[0-9]*')
    line=$((line - 2))
    sudo sed -i ${line}'i\extension=gearman.so' '/etc/php5/fpm/php.ini'
fi
sudo pear -D auto_discover=1 install pear.amazonwebservices.com/sdk
sudo service php5-fpm restart
