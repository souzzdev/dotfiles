#!/bin/bash

set -e

DOTFILES="$HOME/dotfiles"

echo "==================================="
echo " Instalando Dotfiles"
echo "==================================="

# Criar diretórios
mkdir -p "$HOME/.config"

echo "[1/6] Criando links simbólicos..."

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
    rm -rf "$HOME/.config/$dir"
    ln -s "$DOTFILES/.config/$dir" "$HOME/.config/$dir"
done

echo "[2/6] Configurando Zsh..."

rm -f "$HOME/.zshrc"
rm -f "$HOME/.p10k.zsh"
rm -rf "$HOME/.oh-my-zsh"

ln -s "$DOTFILES/.zshrc" "$HOME/.zshrc"
ln -s "$DOTFILES/.p10k.zsh" "$HOME/.p10k.zsh"
ln -s "$DOTFILES/.oh-my-zsh" "$HOME/.oh-my-zsh"

echo "[3/6] Instalando wallpapers..."

rm -rf "$HOME/Wallpaper"

ln -s "$DOTFILES/Wallpaper" "$HOME/Wallpaper"

echo "[4/6] Restaurando pacotes oficiais..."

if [ -f "$DOTFILES/pacotes.txt" ]; then
    sudo pacman -S --needed - < "$DOTFILES/pacotes.txt"
fi

echo "[5/6] Restaurando pacotes AUR..."

if command -v yay &> /dev/null; then
    if [ -f "$DOTFILES/aur.txt" ]; then
        yay -S --needed - < "$DOTFILES/aur.txt"
    fi
else
    echo "yay não encontrado."
    echo "Instale o yay manualmente e execute:"
    echo "yay -S --needed - < ~/dotfiles/aur.txt"
fi

echo "[6/6] Finalizado!"

echo
echo "Recomenda-se reiniciar a sessão do Hyprland."
echo "Tudo pronto!"
