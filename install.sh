echo "*********************************************************************"
echo "---------                 Copiando Archivos                 ---------"
echo "*********************************************************************"

mkdir -p /var/www/pterodactyl
cp -R panel_install.sh /var/www/pterodactyl
cp -R my.cnf /var/www/pterodactyl
cp -R pterodactyl.conf /var/www/pterodactyl
cp -R pteroq.service /var/www/pterodactyl
cp -R mysql.sh /var/www/pterodactyl
cp -R depends.sh /var/www/pterodactyl
cp -R grub /var/www/pterodactyl
cp -R wings.service /var/www/pterodactyl
cp -R wings_AMD64.sh /var/www/pterodactyl
cp -R wings_ARM64_AARCH64.sh /var/www/pterodactyl

exit 0
