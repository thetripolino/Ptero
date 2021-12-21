rm -R /usr/local/bin/wings
echo "**********************************************"
echo "-------------- Instalando Docker --------------"
echo "**********************************************"
sleep 1s
curl -sSL https://get.docker.com/ | CHANNEL=stable bash
echo "**********************************************"
echo "------------- Start Docker on Boot ------------"
echo "**********************************************"
sleep 1s
systemctl enable --now docker
echo "**********************************************"
echo "-------------- Configurando grub -------------"
echo "**********************************************"
sleep 1s
cp -R grub /etc/default/
update-grub

echo "**********************************************"
echo "-------------- Instalando Wings --------------"
echo "**********************************************"
sleep 1s
mkdir -p /etc/pterodactyl
curl -L -o /usr/local/bin/wings https://github.com/pterodactyl/wings/releases/latest/download/wings_linux_arm64
chmod u+x /usr/local/bin/wings

echo "**********************************************"
echo "--------------    Daemonizing   --------------"
echo "**********************************************"
cp -R wings.service /etc/systemd/system

echo "**********************************************"
echo "--------------  Inciando Wings  --------------"
echo "**********************************************"
echo a hora necesitas el nodo "https://pterodactyl.io/community/config/nodes/add_node.html"
sleep 1s
echo "Presiona cualquier tecla para continuar"
read 1 -s -r -p ""

echo "**********************************************"
echo "------------- Reiniciando Wings  -------------"
echo "**********************************************"
systemctl enable --now wings
systemctl restart wings
echo "**********************************************"
echo "------------- Ignorar Error      -------------"
echo "**********************************************"
wings --debug
exit 0
