#!/bin/bash

set -e

DOTFILES="$HOME/dotfiles"

echo "==================================="
echo " Instalando Dotfiles"
echo "==================================="

backup_and_link() {
    local source="$1"
    local target="$2"

    if [ -L "$target" ]; then
        echo "Removendo link existente: $target"
        rm "$target"

    elif [ -e "$target" ]; then
        echo "Criando backup: $target.backup"
        mv "$target" "$target.backup"
    fi

    ln -s "$source" "$target"

    echo "✓ $target"
}

echo
echo "[1/5] Configurações"

mkdir -p "$HOME/.config"

CONFIGS=(
hypr
waybar
rofi
kitty
fastfetch
cava
swaync
nwg-look
Kvantum
gtk-3.0
gtk-4.0
qt5ct
xsettingsd
)

for dir in "${CONFIGS[@]}"; do

    if [ -d "$DOTFILES/.config/$dir" ]; then

        backup_and_link \
        "$DOTFILES/.config/$dir" \
        "$HOME/.config/$dir"

    fi

done


echo
echo "[2/5] Zsh"

[ -f "$DOTFILES/.zshrc" ] && \
backup_and_link "$DOTFILES/.zshrc" "$HOME/.zshrc"

[ -f "$DOTFILES/.p10k.zsh" ] && \
backup_and_link "$DOTFILES/.p10k.zsh" "$HOME/.p10k.zsh"


echo
echo "[3/5] Wallpapers"

if [ -d "$DOTFILES/Wallpaper" ]; then

    if [ -d "$HOME/Wallpaper" ]; then

        mv "$HOME/Wallpaper" "$HOME/Wallpaper.backup"

    fi

    ln -s "$DOTFILES/Wallpaper" "$HOME/Wallpaper"

    echo "✓ Wallpapers"

fi


echo
echo "[4/5] Pacotes oficiais"

if [ -f "$DOTFILES/pacotes.txt" ]; then

    sudo pacman -S --needed - < "$DOTFILES/pacotes.txt"

fi


echo
echo "[5/5] Pacotes AUR"

if command -v yay &> /dev/null; then

    if [ -f "$DOTFILES/aur.txt" ]; then

        yay -S --needed - < "$DOTFILES/aur.txt"

    fi

else

    echo "yay não encontrado."
    echo "Instale o yay e execute:"
    echo "yay -S --needed - < ~/dotfiles/aur.txt"

fi


echo
echo "==================================="
echo " Instalação concluída!"
echo "==================================="

echo
echo "Se algo der errado, procure por:"
echo

echo "~/.config/*.backup"
echo "~/Wallpaper.backup"
echo "~/.zshrc.backup"
echo "~/.p10k.zsh.backup"
