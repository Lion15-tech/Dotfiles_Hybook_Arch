# Dotfiles Hybook Arch Linux — Estética Cyberpunk

Configuración completa de entorno **i3wm** en Arch Linux (Hyundai Hybook / Intel Core i5-8279U):

- **Gestor de ventanas y bloqueo:** i3 + i3lock-color (`~/.config/i3/lock.sh`)
- **Barra de estado:** Polybar (`~/.config/polybar/`)
- **Terminal y Prompt:** Kitty + Bash con detección de rama y estado Git (`~/.bashrc`)
- **Lanzador:** Rofi (`~/.config/rofi/`)
- **Inicio de sesión:** LightDM + web-greeter con tema personalizado `cyberpunk` (`/usr/share/web-greeter/themes/cyberpunk/`)

## Restauración rápida en una instalación limpia de Arch

    sudo pacman -S --needed - < pkglist_oficial.txt
    yay -S --needed - < pkglist_aur.txt
    cp -r .config/* ~/.config/
    cp home/.bashrc ~/
    sudo cp etc/lightdm/* /etc/lightdm/
    sudo cp -r usr/share/web-greeter/themes/cyberpunk /usr/share/web-greeter/themes/
