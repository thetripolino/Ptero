# Solo cambia los numeros por tu contraseña, no toques nada mas...
PASS='3205829086'
echo "*********************************************************************"
echo "--------- Configurando Mysql... esta es tu contraseña "$PASS" ----------"
echo "*********************************************************************"
sleep 5s

mysql -u root -p"1" <<EOF
CREATE USER 'pterodactyl'@'127.0.0.1' IDENTIFIED BY '$PASS';
CREATE DATABASE panel;
GRANT ALL PRIVILEGES ON panel.* TO 'pterodactyl'@'127.0.0.1' WITH GRANT OPTION;
CREATE USER 'pterodactyluser'@'127.0.0.1' IDENTIFIED BY '$PASS';
GRANT ALL PRIVILEGES ON *.* TO 'pterodactyluser'@'127.0.0.1' WITH GRANT OPTION;
EOF

echo "*********************************************************************"
echo "---------                Mysql configurado...               ---------"
echo "*********************************************************************"
sleep 1s

echo "*********************************************************************"
echo "---------                Acceso remoto activado             ---------"
echo "*********************************************************************"
cp -R my.cnf /etc/alternatives/

sh panel_install.sh
