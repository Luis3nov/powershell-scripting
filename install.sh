sudo apt-get update
#Este comando sincroniza la base de datos local de paquetes con los servidores remotos. Y apt (Advanced Package Tool) descarga los índices actualizados de todos los repositorios configurados del sistema

sudo apt-get install -y wget apt-transport-https software-properties-common
#Este comando instala: (wget) un cliente HTTP para descargar archivos por línea de comandos. (apt-transport-https) un método de transporte que permite a APT descargar paquetes mediante protocolo HTTPS y (software-properties-common) que instala un conjunto de scripts y comandos que facilitan la gestión de repositorios

source /etc/os-release
#este comando lee el archivo del sistema que dice qué versión de Ubuntu tengo y guarda esa información en variables que se pueden usar posteriormente. (/etc/os-release) es un archivo de texto que contiene información sobre tu sistema operativo

wget -q https://packages.microsoft.com/config/ubuntu/$VERSION_ID/packages-microsoft-prod.deb
#(wget) sirve para descargar archivos desde servidores web. (-q) descarga silenciosamente, es decir, no muestra nada en la terminal. lo siquiente es la url. en resumen este codigo descarga el instalador del repositorio oficial de Microsoft a mi Ubuntu.

sudo dpkg -i packages-microsoft-prod.deb
#(dpkg) instala paquetes .deb manualmente. (-i) le dice a dpkg que voy a instalar a un archivo (packages-microsoft-prod.deb) es el archivo que descargue anteriormente con wget. en resumen este comando habilita a Ubuntu para descargar programas oficiales de Microsoft.

rm packages-microsoft-prod.deb
# 

sudo apt-get update

###################################
# Install PowerShell
sudo apt-get install -y powershell

# Start PowerShell
pwsh