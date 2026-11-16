#!/usr/bin/env bash
set -e
REPO_DIR="$HOME/Dotfiles_Hybook_Arch"

rm -rf "$REPO_DIR/.config" "$REPO_DIR/etc" "$REPO_DIR/usr" "$REPO_DIR/home"
mkdir -p "$REPO_DIR/.config" "$REPO_DIR/etc/lightdm" "$REPO_DIR/usr/share/web-greeter/themes" "$REPO_DIR/home/Documentos" "$REPO_DIR/home/Wallpapers"

for dir in i3 polybar kitty rofi mpv xfce4 picom; do
  [ -d "$HOME/.config/$dir" ] && cp -r "$HOME/.config/$dir" "$REPO_DIR/.config/"
done

cp "$HOME/.bashrc" "$REPO_DIR/home/.bashrc"
[ -f "$HOME/reproducir_bad_apple.sh" ] && cp "$HOME/reproducir_bad_apple.sh" "$REPO_DIR/home/"
[ -f "$HOME/Documentos/configuracion_linux.txt" ] && cp "$HOME/Documentos/configuracion_linux.txt" "$REPO_DIR/home/Documentos/"
[ -f "$HOME/Imagenes/Wallpapers/cyberpunk_rosa(2560x1440).jpg" ] && cp "$HOME/Imagenes/Wallpapers/cyberpunk_rosa(2560x1440).jpg" "$REPO_DIR/home/Wallpapers/"

[ -f /etc/lightdm/lightdm.conf ] && cp /etc/lightdm/lightdm.conf "$REPO_DIR/etc/lightdm/"
[ -f /etc/lightdm/web-greeter.toml ] && cp /etc/lightdm/web-greeter.toml "$REPO_DIR/etc/lightdm/"
[ -d /usr/share/web-greeter/themes/cyberpunk ] && cp -r /usr/share/web-greeter/themes/cyberpunk "$REPO_DIR/usr/share/web-greeter/themes/"

pacman -Qqen > "$REPO_DIR/pkglist_oficial.txt"
pacman -Qqem > "$REPO_DIR/pkglist_aur.txt"

echo "Archivos sincronizados en $REPO_DIR"
