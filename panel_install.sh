#!/bin/bash

curl -Lo panel.tar.gz https://github.com/pterodactyl/panel/releases/latest/download/panel.tar.gz
tar -xzvf panel.tar.gz
chmod -R 755 storage/* bootstrap/cache/
chmod -R 755 /var/www/pterodactyl/
cp .env.example .env
composer install --no-dev --optimize-autoloader

echo Only run the command below if you are installing this Panel for
echo the first time and do not have any Pterodactyl Panel data in the database.
sleep 1s
echo "*********************************************************************"
echo "---------            Completa los siguientes campos         ---------"
echo "*********************************************************************"
sleep 3s
php artisan key:generate --force
php artisan p:environment:setup

echo "*********************************************************************"
echo "----          Recuerda poner tu contraseña de mysql              ----"
echo "*********************************************************************"
sleep 5s
php artisan p:environment:database

echo "*********************************************************************"
echo "---------            Configura el Mail                       --------"
echo "*********************************************************************"
sleep 5s
php artisan p:environment:mail

echo "*********************************************************************"
echo "---------                 Migrando...                       ---------"
echo "*********************************************************************"
sleep 1s
php artisan migrate --seed --force

echo "*********************************************************************"
echo "---------            Crea tu usuario para el panel          ---------"
echo "*********************************************************************"
sleep 2s
php artisan p:user:make

echo "*********************************************************************"
echo "---------                If using NGINX or Apache            ---------"
echo "*********************************************************************"
chown -R www-data:www-data /var/www/pterodactyl/*

echo "*********************************************************************"
echo "---------               If using NGINX on CentOS            ---------"
echo "*********************************************************************"
chown -R nginx:nginx /var/www/pterodactyl/*

echo "*********************************************************************"
echo "---------               If using Apache on CentOS           ---------"
echo "*********************************************************************"
chown -R apache:apache /var/www/pterodactyl/*

echo "*********************************************************************"
echo "-------- pega esto en la ultima linea del siguiente comando  --------"
echo "*********************************************************************"
echo "***********************************************************************************************"
echo "---------  * * * * * php /var/www/pterodactyl/artisan schedule:run >> /dev/null 2>&1  ---------"
echo "***********************************************************************************************"
echo "*********************************************************************"
echo "--------- CTRL + O para guardar, CTRL + x para salir ---------"
echo "*********************************************************************"
sleep 10s 
crontab -e

echo "*********************************************************************"
echo "---------              Copiando pteroq.service               --------"
echo "*********************************************************************"
cp -R pteroq.service /etc/systemd/system

echo "*********************************************************************"
echo "---------    habilitando redis-server, pteroq.service       ---------"
echo "*********************************************************************"
systemctl enable --now redis-server
systemctl enable --now pteroq.service

echo "*********************************************************************"
echo "---------                Configurando Nginx                 ---------"
echo "*********************************************************************"
sleep 1s

echo "*********************************************************************"
echo "---------         Abriendo los siguientes puertos           ---------"
echo "---------               80, 2022, 8080                      ---------"
echo "*********************************************************************"
ufw allow 80/tcp
ufw allow 80/udp
ufw allow 2022/tcp
ufw allow 2022/udp
ufw allow 8080/tcp
ufw allow 8080/udp

echo "*********************************************************************"
echo "---------            Copiando pterodactyl.conf              ---------"
echo "*********************************************************************"
rm /etc/nginx/sites-enabled/default
cp -R pterodactyl.conf /etc/nginx/sites-available/

echo "*********************************************************************"
echo "---------           Activando pterodactyl.conf              ---------"
echo "*********************************************************************"
ln -s /etc/nginx/sites-available/pterodactyl.conf /etc/nginx/sites-enabled/pterodactyl.conf

echo "*********************************************************************"
echo "---------                Deteniendo Apache                  ---------"
echo "*********************************************************************"
systemctl stop apache2
sleep 1s

echo "*********************************************************************"
echo "---------                Reiniciando Nginx                  ---------"
echo "*********************************************************************"
systemctl restart nginx

echo "*********************************************************************"
echo "------- si todo salio bien deberia cargar la pagina del panel -------"
echo "*********************************************************************"
sleep 2

echo "*********************************************************************"
echo "   Eliminando my.cnf, mysql.sh, pterodactyl.conf, pteroq.service     "
echo "         pteroq.service, rm panel_install.sh, depends.sh             "
echo "*********************************************************************"
rm my.cnf
rm mysql.sh
rm pterodactyl.conf
rm pteroq.service
rm panel_install.sh
rm depends.sh 

exit 0
