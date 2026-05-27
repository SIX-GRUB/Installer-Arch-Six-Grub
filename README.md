

```markdown
# 🚀 MANUAL COMPLETÍSIMO DESDE CERO: INSTALACIÓN ABSOLUTA DE ARCH LINUX (SIX)

Este documento contiene toda la información necesaria para instalar el sistema operativo base y desplegar el entorno gráfico personalizado. No requiere conocimientos previos; está diseñado para ser leído desde el celular y seguir los pasos de principio a fin de manera estrictamente secuencial.

---

## 📱 PARTE 1: PREPARACIÓN DE LA ISO Y ARRANQUE INICIAL

1. Descarga la imagen `.iso` oficial desde la página web de Arch Linux.
2. Grábala en un pendrive USB utilizando una herramienta como Rufus (en modo DD) o BalenaEtcher.
3. Apaga la computadora, conecta el pendrive USB y enciéndela presionando la tecla de arranque de tu placa madre (F12, F11, F8 o F9 según la marca) para seleccionar el inicio desde el USB.
4. En la primera pantalla que aparece (Menú de Arch Linux), presiona **Enter** en la primera opción.
5. Espera a que carguen todas las letras en la pantalla hasta que quede fija la línea de comandos con el texto `root@archiso ~ #`.

---

## 💾 PARTE 2: EL ASISTENTE AUTOMATIZADO DE INSTALACIÓN BASE

En la consola de la pantalla, escribe exactamente el siguiente comando y presiona **Enter**:

```bash
archinstall

```

Se desplegará un menú interactivo con fondo azul o negro. Utiliza las flechas de dirección (`Arriba` y `Abajo`) para navegar y la tecla **Enter** para ingresar a modificar cada apartado. Configura el menú exactamente de la siguiente manera:

1. **Language:** Selecciona tu idioma de preferencia para el instalador.
2. **Keyboard layout:** Busca y selecciona `es` (si tu teclado tiene la letra Ñ física) o `us` (si no la tiene).
3. **Mirror region:** Selecciona tu país o el país más cercano a tu ubicación geográfica para asegurar descargas rápidas.
4. **Disk configuration:**
* Selecciona "Drive(s)".
* Marca con la barra espaciadora tu disco rígido mecánico (HDD). Sabrás cuál es por su tamaño en GB. Presiona Enter.
* Selecciona la opción **"Erase all block devices and use a best-effort default partition layout"**.
* Selecciona el sistema de archivos **`ext4`**.


5. **Disk encryption:** Selecciona "No encryption" para evitar ralentizaciones innecesarias en el disco mecánico.
6. **Bootloader:** Cambia esta opción presionando Enter hasta que quede seleccionado únicamente **`systemd-boot`**.
7. **Unified Kernel Images (UKI):** Selecciona "False" o déjalo desactivado.
8. **Swap:** Déjalo activado en "True" (esto ayuda al rendimiento de la memoria).
9. **Hostname:** Escribe un nombre para identificar a la computadora en red (por ejemplo: `arch-six`).
10. **Root password:** Define una contraseña maestra de administrador. Escríbela, confírmala y anótala en un papel.
11. **User account:**
* Selecciona "Add a user".
* Escribe tu nombre de usuario en minúsculas (por ejemplo: `six`).
* Asignale una contraseña segura a este usuario.
* Cuando te pregunte **"Should this user be a sudoer (admin)?"**, selecciona estrictamente que **YES**.
* Selecciona "Confirm and exit" para volver al menú principal.


12. **Profiles:** Selecciona "Type" y déjalo estrictamente en **`Minimal`**. No instales ningún escritorio desde aquí.
13. **Audio:** Selecciona **`Pipewire`** (es el motor de audio moderno necesario para el control de volumen por teclado).
14. **Kernels:** Muévete con las flechas y presiona la barra espaciadora para dejar marcados con un asterisco únicamente los paquetes **`linux-zen`** y **`linux-lts`**. Luego presiona Enter para confirmar.
15. **Additional packages:** Presiona Enter, escribe exactamente `git` y presiona Enter. Luego deja la casilla en blanco y presiona Enter para regresar.
16. **Network configuration:** Selecciona estrictamente la opción **`NetworkManager`**.
17. **Timezone:** Busca y selecciona tu zona horaria local (por ejemplo: `America/Argentina/Buenos_Aires`).
18. **Automatic Time Sync (NTP):** Déjalo activado en "True".
19. **Optional repositories:** No selecciones ninguno, déjalos vacíos.

### Ejecución de la instalación base:

* Baja hasta el final del menú donde dice **Install** y presiona **Enter**.
* Presiona **Enter** una vez más cuando te pida confirmar el inicio del formateo.
* El asistente comenzará a descargar e instalar la estructura base. Esto tardará varios minutos dependiendo de tu velocidad de internet.
* Al finalizar el proceso, aparecerá un mensaje preguntando: *"Would you like to chroot into the newly created installation?"*. Selecciona estrictamente que **NO**.

Escribe el siguiente comando para reiniciar la computadora:

```bash
reboot

```

*Retira inmediatamente el pendrive USB de la computadora en cuanto la pantalla se apague.*

---

## 🖥️ PARTE 3: CONFIGURACIÓN AUTOMÁTICA DEL ENTORNO VISUAL

Cuando la computadora encienda por primera vez, verás el menú de arranque limpio de `systemd-boot`. De manera automática tras 4 segundos iniciará la opción con el Kernel Zen.

1. La pantalla se quedará fija pidiendo credenciales. En donde dice `login:` escribe el nombre de tu usuario personal creado previamente (por ejemplo: `six`) y presiona **Enter**.
2. En donde dice `Password:` escribe la contraseña asignada a ese usuario y presiona **Enter**. *(Nota: No verás caracteres en pantalla ni asteriscos mientras escribes la contraseña por motivos de seguridad del sistema).*

Una vez que tengas acceso a la línea de comandos limpia, copia y pega los siguientes comandos exactamente en el mismo orden estructural, esperando que cada uno termine por completo:

```bash
sudo pacman -S --needed git --noconfirm

```

*(Escribe tu contraseña de usuario si te la vuelve a solicitar y presiona Enter)*

```bash
git clone [https://github.com/TU_USUARIO/Installer-Arch-Six-Grub.git](https://github.com/TU_USUARIO/Installer-Arch-Six-Grub.git)

```

*(¡ATENCIÓN! Reemplaza la palabra `TU_USUARIO` en la dirección URL por el nombre exacto de tu perfil o cuenta de GitHub donde guardaste este repositorio).*

```bash
cd Installer-Arch-Six-Grub

```

```bash
chmod +x install.sh

```

```bash
./install.sh

```

### ¿Qué hará este script de forma automática en tu PC?

* Actualizará las bases de datos de los repositorios oficiales.
* Instalará todos los paquetes de sistema listados en tus archivos `01-base.txt`, `02-drivers.txt`, `03-fonts.txt` y `04-apps.txt` de manera silenciosa y sin pedir confirmaciones.
* Descargará el código fuente del gestor de paquetes AUR (`yay`), resolverá sus dependencias, lo compilará e instalará de forma nativa.
* Usará `yay` para instalar el driver específico de tu antena WiFi USB (`rtl8188fu-dkms-git`), la versión binaria de Microsoft Edge, Visual Studio Code y el agente de políticas de Hyprland guardados en tu archivo `05-aur.txt`.
* Creará los directorios de configuración del usuario en tu directorio raíz (`~/.config/`).
* Copiará de forma exacta tus configuraciones personalizadas de `hyprland.conf`, `hyprpaper.conf`, `hyprlock.conf`, el dock flotante de `waybar`, los estilos de `fuzzel`, el sistema de notificaciones `mako`, tu terminal `ghostty` y el formateo de `fastfetch`.
* Reemplazará los parámetros de arranque en tu disco configurando el archivo `system/loader.conf` para optimizar resoluciones y tiempos de espera de carga.

Espera pacientemente a que el instalador procese todos los datos. El final del script se indicará con un mensaje claro de instalación completada con éxito en la consola.

---

## 🎨 PARTE 4: CONFIGURACIÓN OBLIGATORIA DEL FONDO DE PANTALLA

Para asegurar que los servicios de renderizado de fondo de pantalla (`hyprpaper`) y la interfaz de bloqueo del sistema (`hyprlock`) se ejecuten de forma correcta sin generar fallos visuales ni pantallas totalmente oscuras, se requiere un archivo de imagen en la ruta configurada. Ejecuta los siguientes dos comandos en tu consola antes del reinicio final:

```bash
mkdir -p ~/.config/hypr

```

```bash
curl -o ~/.config/hypr/wallpaper.png [https://raw.githubusercontent.com/catppuccin/wallpapers/main/landscapes/clouds.png](https://raw.githubusercontent.com/catppuccin/wallpapers/main/landscapes/clouds.png)

```

*(Este comando descarga de forma directa un archivo de imagen optimizado estéticamente con el esquema de colores oscuros Mocha y lo ubica con el nombre y extensión exacta que tus archivos de configuración necesitan).*

Una vez descargada la imagen, ejecuta el reinicio definitivo del sistema operativo escribiendo:

```bash
sudo reboot

```

La computadora se reiniciará e iniciará sesión de forma directa dentro de tu nuevo entorno gráfico Hyprland optimizado, cargando la barra en forma de dock flotante en la parte inferior de la pantalla.

---

## ⌨️ PARTE 5: MAPA DE CONTROL Y ATAJOS DE TECLADO

Al carecer de barras de herramientas tradicionales o botones superiores en las ventanas para minimizar, maximizar o cerrar procesos, debes gobernar todo el entorno mediante combinaciones de teclas. Utiliza la siguiente lista detallada:

### 🚀 Apertura de Aplicaciones y Menús del Sistema

* **Teclas `Control` + `Super` (Tecla Windows):** Despliega el lanzador de aplicaciones Fuzzel en el centro de tu monitor. Comienza a escribir el nombre del programa que deseas usar y presiona Enter para abrirlo.
* **Teclas `Super` (Tecla Windows) + `P`:** Despliega el menú del historial de tu portapapeles. Te permite ver todo lo que has copiado previamente (textos, códigos o enlaces). Selecciona el elemento deseado con las flechas y presiona Enter para tenerlo listo para pegar.
* **Teclas `Super` (Tecla Windows) + `Enter`:** Abre una instancia limpia de la terminal Ghostty configurada con la fuente JetBrainsMono.
* **Teclas `Super` (Tecla Windows) + `T`:** Abre una instancia secundaria alternativa de la terminal Ghostty.
* **Teclas `Super` (Tecla Windows) + `F`:** Ejecuta el administrador de archivos Thunar para explorar tus discos y carpetas.
* **Teclas `Super` (Tecla Windows) + `Shift` + `M`:** Abre el navegador web Microsoft Edge Stable.
* **Teclas `Super` (Tecla Windows) + `Shift` + `O`:** Ejecuta tu aplicación de notas y gestión Obsidian.
* **Teclas `Super` (Tecla Windows) + `Shift` + `X`:** Abre el entorno de desarrollo Visual Studio Code.

### 🖼️ Manejo de Ventanas y Distribución de Espacio

* **Teclas `Super` (Tecla Windows) + `Q`:** Mata o cierra inmediatamente el proceso de la ventana activa en la que te encuentres posicionado.
* **Teclas `Super` (Tecla Windows) + `F11`:** Alterna la ventana actual a pantalla completa completa ocultando los márgenes del entorno, o la devuelve a su mosaico regular.
* **Teclas `Super` (Tecla Windows) + `Espacio`:** Fuerza a una ventana a salir del modo mosaico rígido y convertirse en una ventana flotante independiente.
* **Teclas `Super` (Tecla Windows) + `Flecha Izquierda / Derecha / Arriba / Abajo`:** Cambia el foco del cursor para controlar otra ventana que se encuentre abierta en esa dirección espacial.
* **Teclas `Super` (Tecla Windows) + Números del `1` al `5`:** Te desplaza instantáneamente entre tus 5 escritorios de trabajo independientes disponibles.
* **Teclas `Super` (Tecla Windows) + `Shift` + Números del `1` al `5`:** Envía la ventana seleccionada actualmente hacia el escritorio de trabajo correspondiente al número presionado.

### 🖱️ Control Analógico con Ratón (Para Ventanas Flotantes)

* **Combinación `Super` (Tecla Windows) + Mantener Click Izquierdo del Mouse:** Te permite arrastrar y reposicionar libremente cualquier ventana flotante (como interfaces de configuración de volumen o apariencia) en el espacio de la pantalla.
* **Combinación `Super` (Tecla Windows) + Mantener Click Derecho del Mouse:** Te permite estirar, redimensionar y alterar las proporciones de tamaño de las ventanas flotantes arrastrando desde cualquier dirección.

### 🔊 Teclas de Función de Hardware (Multimedia)

* **Tecla Física `AudioRaiseVolume` (Subir Volumen):** Sube el nivel general de audio del sistema en pasos de 5% interactuando directamente con Pamixer.
* **Tecla Física `AudioLowerVolume` (Bajar Volumen):** Baja el nivel general de audio del sistema en pasos de 5% interactuando directamente con Pamixer.
* **Tecla Física `AudioMute` (Silenciar):** Muta o reactiva el canal maestro de audio con un solo toque.
* **Tecla Física `MonBrightnessUp` (Subir Brillo):** Incrementa la iluminación de retroiluminación de la pantalla de forma gradual mediante Brightnessctl.
* **Tecla Física `MonBrightnessDown` (Bajar Brillo):** Reduce la iluminación de retroiluminación de la pantalla de forma gradual mediante Brightnessctl.

```

```