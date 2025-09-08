#!/bin/bash
# ultimate-setup.sh (Interactive)
# Script interactif pour configurer un environnement de dev complet sur Arch Linux

set -e

echo "=== Ultimate Interactive Dev Setup ==="

# --- Fonctions utiles ---
pause() {
    read -rp "Appuyez sur Entrée pour continuer..."
}

install_if_missing() {
    local cmd="$1"
    local pkg="$2"
    if ! command -v "$cmd" &> /dev/null; then
        echo "Installation de $pkg..."
        sudo pacman -S --noconfirm "$pkg"
    else
        echo "$pkg déjà installé."
    fi
}

# --- Choix interactifs ---
echo
echo "Choisissez les composants à installer :"
echo "1) Oh My Zsh"
echo "2) Starship prompt"
echo "3) Plugins Oh My Zsh (autosuggestions, syntax-highlighting)"
echo "4) Autojump"
echo "5) Docker"
echo "6) Node.js & npm"
echo "7) Python & pip"
echo "8) Rust & cargo"
echo "9) Tout installer"
echo "0) Quitter"
echo

read -rp "Votre choix (ex: 1 2 3 ou 9) : " choices

if [[ "$choices" =~ 0 ]]; then
    echo "Abandon."
    exit 0
fi

# --- Installation et configuration ---

# 1) Oh My Zsh
if [[ "$choices" =~ 1 ]] || [[ "$choices" =~ 9 ]]; then
    if [ ! -d "$HOME/.oh-my-zsh" ]; then
        echo "Installation de Oh My Zsh..."
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    else
        echo "Oh My Zsh déjà installé."
    fi
fi

# 2) Starship
if [[ "$choices" =~ 2 ]] || [[ "$choices" =~ 9 ]]; then
    if ! command -v starship &> /dev/null; then
        echo "Installation de Starship..."
        curl -fsSL https://starship.rs/install.sh | bash -s -- -y
    else
        echo "Starship déjà installé."
    fi

    echo "⚡ Configuration Starship..."
    mkdir -p ~/.config
    cat > ~/.config/starship.toml <<'EOF'
add_newline = true

[python]
symbol = "🐍 "
format = "[$symbol$version]($style) "

[nodejs]
symbol = "⬢ "
format = "[$symbol$version]($style) "

[rust]
symbol = "🦀 "
format = "[$symbol$version]($style) "

[docker]
symbol = "🐳 "
format = "[$context]($style) "

[time]
disabled = false
format = "🕒 [%H:%M:%S]($style)"

[git_status]
disabled = false
format = "([$all_status])($style) "
conflicted = "⚔️ "
ahead = "⬆️${count} "
behind = "⬇️${count} "
staged = "●${count} "
untracked = "…"
modified = "✚${count} "
renamed = "➜${count} "
deleted = "✖${count} "
EOF
fi

# 3) Plugins Oh My Zsh
if [[ "$choices" =~ 3 ]] || [[ "$choices" =~ 9 ]]; then
    ZSH_CUSTOM="${HOME}/.oh-my-zsh/custom"
    if [ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]; then
        git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
    fi
    if [ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]; then
        git clone https://github.com/zsh-users/zsh-syntax-highlighting $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
    fi
fi

# 4) Autojump
if [[ "$choices" =~ 4 ]] || [[ "$choices" =~ 9 ]]; then
    if ! command -v autojump &> /dev/null; then
        if pacman -Si autojump &> /dev/null; then
            sudo pacman -S --noconfirm autojump
        else
            echo "[oh-my-zsh] autojump non disponible dans les dépôts. Installer manuellement si nécessaire."
        fi
    else
        echo "Autojump déjà installé."
    fi
fi

# 5) Docker
if [[ "$choices" =~ 5 ]] || [[ "$choices" =~ 9 ]]; then
    install_if_missing docker docker
fi

# 6) Node.js & npm
if [[ "$choices" =~ 6 ]] || [[ "$choices" =~ 9 ]]; then
    install_if_missing node nodejs
    install_if_missing npm npm
fi

# 7) Python & pip
if [[ "$choices" =~ 7 ]] || [[ "$choices" =~ 9 ]]; then
    install_if_missing python python
    install_if_missing pip python-pip
fi

# 8) Rust & cargo
if [[ "$choices" =~ 8 ]] || [[ "$choices" =~ 9 ]]; then
    install_if_missing rustc rust
    install_if_missing cargo rust
fi

echo
echo "=== Configuration terminée ! ==="
echo "Redémarrage du shell pour appliquer les changements..."
exec zsh
