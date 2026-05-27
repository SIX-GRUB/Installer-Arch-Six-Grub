#!/bin/bash

# Salir inmediatamente si ocurre un error
set -e

# Colores para la terminal
GREEN="\e[32m"
BLUE="\e[34m"
ENDCOLOR="\e[0m"

echo -e "${BLUE}==================================================${ENDCOLOR}"
echo -e "${BLUE}   INICIANDO INSTALACIÓN DE ARCH CONFIG (SIX)     ${ENDCOLOR}"
echo -e "${BLUE}==================================================${ENDCOLOR}"

# 1. ACTUALIZACIÓN E INSTALACIÓN DE DEPENDENCIAS CRÍTICAS
echo -e "\n${GREEN}[1/6] Actualizando sistema e instalando herramientas base...${ENDCOLOR}"
sudo pacman -Syu --noconfirm
sudo pacman -S --needed --noconfirm base-devel git wget curl

# 2. INSTALACIÓN DE PAQUETES OFICIALES (Pacman)
echo -e "\n${GREEN}[2/6] Instalando paquetes desde repositorios oficiales...${ENDCOLOR}"
for lista in paquetes/01-base.txt paquetes/02-drivers-audio.txt paquetes/03-entorno.txt paquetes/04-apps.txt; do
    if [ -f "$lista" ]; then
        echo -e "Instalando desde: $lista"
        sed 's/#.*//' "$lista" | xargs sudo pacman -S --needed --noconfirm
    fi
done

# 3. INSTALACIÓN DE YAY (AUR Helper)
if ! command -v yay &> /dev/null; then
    echo -e "\n${GREEN}[3/6] 'yay' no detectado. Instalando AUR helper...${ENDCOLOR}"
    mkdir -p /tmp/yay-build
    git clone https://aur.archlinux.org/yay.git /tmp/yay-build
    cd /tmp/yay-build
    makepkg -si --noconfirm
    cd -
    rm -rf /tmp/yay-build
else
    echo -e "\n${GREEN}[3/6] 'yay' ya está instalado.${ENDCOLOR}"
fi

# 4. INSTALACIÓN DE PAQUETES DESDE AUR
if [ -f "paquetes/05-aur.txt" ]; then
    echo -e "\n${GREEN}[4/6] Instalando paquetes de AUR...${ENDCOLOR}"
    sed 's/#.*//' paquetes/05-aur.txt | xargs yay -S --needed --noconfirm
fi

# 5. CONFIGURACIÓN DE SYSTEMD-BOOT (Bootloader)
echo -e "\n${GREEN}[5/6] Configurando systemd-boot...${ENDCOLOR}"
sudo bootctl update --path=/boot

if [ -f "system/loader.conf" ]; then
    sudo cp system/loader.conf /boot/loader/loader.conf
else
    sudo bash -c 'cat <<EOF > /boot/loader/loader.conf
default arch-zen.conf
timeout 4
console-mode max
editor no
EOF'
fi

# 6. COPIAR DOTFILES (Configuraciones Visuales)
echo -e "\n${GREEN}[6/6] Desplegando archivos de configuración (dotfiles)...${ENDCOLOR}"
mkdir -p ~/.config

if [ -d "dotfiles" ]; then
    cp -r dotfiles/* ~/.config/
    echo "¡Dotfiles copiados con éxito a ~/.config/!"
else
    echo "Advertencia: No se encontró la carpeta 'dotfiles'. Saltando paso."
fi

# HABILITAR SERVICIOS CRÍTICOS
echo -e "\n${GREEN}[+] Habilitando servicios del sistema...${ENDCOLOR}"
sudo systemctl enable NetworkManager
sudo systemctl enable ufw

echo -e "\n${BLUE}==================================================${ENDCOLOR}"
echo -e "${BLUE}  ¡INSTALACIÓN FINALIZADA! Por favor reinicia.   ${ENDCOLOR}"
echo -e "${BLUE}==================================================${ENDCOLOR}"