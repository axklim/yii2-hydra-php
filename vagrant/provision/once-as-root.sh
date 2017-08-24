#!/usr/bin/env bash

#== Import script args ==

timezone=$(echo "$1")

#== Bash helpers ==

function info {
  echo " "
  echo "--> $1"
  echo " "
}

#== Provision script ==

info "Provision-script user: `whoami`"

info "Configure locales"
update-locale LC_ALL="C"
locale-gen ru_RU.UTF-8
dpkg-reconfigure locales

info "Configure timezone"
echo ${timezone} | tee /etc/timezone
dpkg-reconfigure --frontend noninteractive tzdata

info "Update OS software"
echo "deb http://ppa.launchpad.net/ondrej/php/ubuntu trusty main" | tee /etc/apt/sources.list.d/php.list
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 14AA40EC0831756756D7F66C4F4EA0AAE5267A6C
apt-get update
apt-get upgrade -y

info "Install additional software"
apt-get install -y php5.6 php5.6-curl php5.6-cli php5.6-intl php5.6-mysqlnd php5.6-gd php5.6-mbstring php5.6-xml
apt-get install -y zip git

info "Configure PHP-ORACLE"
apt-get install -y libaio1
cp /app/vagrant/php_oracle/oci8.ini /etc/php/5.6/mods-available/
cp /app/vagrant/php_oracle/pdo_oci.ini /etc/php/5.6/mods-available/
cp /app/vagrant/php_oracle/oci8.so /etc/php/5.6/mods-available/ /usr/lib/php/20131226/
cp /app/vagrant/php_oracle/pdo_oci.so /etc/php/5.6/mods-available/ /usr/lib/php/20131226/
phpenmod oci8
phpenmod pdo_oci
mkdir -p /opt/oracle/
cp -r /app/vagrant/php_oracle/instantclient_12_1 /opt/oracle/
# Github limit 100Mb
unzip -o /opt/oracle/instantclient_12_1/libclntsh.so.zip -d /opt/oracle/instantclient_12_1/
unzip -o /opt/oracle/instantclient_12_1/libociei.so.zip -d /opt/oracle/instantclient_12_1/
echo "PATH=\"/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games\"" > /etc/environment
# oracle environment
echo "NLS_LANG=\"AMERICAN_RUSSIA.AL32UTF8\"" | tee -a /etc/environment /etc/apache2/envvars
echo "ORACLE_HOME=/opt/oracle/instantclient_12_1/lib" | tee -a /etc/environment /etc/apache2/envvars
echo "LD_LIBRARY_PATH=/opt/oracle/instantclient_12_1/lib" | tee -a /etc/environment /etc/apache2/envvars
echo "Done!"
