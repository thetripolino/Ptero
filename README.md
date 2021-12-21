# Script Support
| Operating System |  Version  |Supported|
|------------------|-----------|---------|
|   Ubuntu         |    18.04  |   ✅    |
|				   |	20.04  |   ✅    |
|	CentOS		   |	7	   |   ❌	 |
|				   |	8      |   ❌   |
|	Debian  	   |    9      |   ❌    |
|				   |   10      |   ❌   |

Recuerda cambiar la contraseña de [Mysql](https://github.com/MizuThz/Pterodactyl-install-script/blob/main/mysql.sh)

# Panel

###### Ubuntu
*apt -y install git*

```bash
cd ; git clone https://github.com/MizuThz/Pterodactyl-install-script.git ; chmod -R 750 Pterodactyl-install-script ; cd Pterodactyl-install-script ; sh install.sh ; cd /var/www/pterodactyl ; sh depends.sh
```

# Wings

###### AMD64

```bash
cd /var/www/pterodactyl ; sh wings_AMD64.sh
```

###### ARM64 / AARCH64

```bash
cd /var/www/pterodactyl ; sh wings_ARM64_AARCH64.sh
```

## Borrar archivos
```bash
cd /var/www/pterodactyl ; sh remove_files.sh
```
