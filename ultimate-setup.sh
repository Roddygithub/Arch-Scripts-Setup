#!/bin/bash
set -e

echo "=== Ultimate Developer Environment Interactive ==="

SUMMARY="Résumé de l'installation:\n"

ask_yes_no() {
    while true; do
        read -p "$1 [y/n]: " yn
        case $yn in
            [Yy]* ) return 0;;
            [Nn]* ) return 1;;
            * ) echo "Répondez par y ou n.";; 
        esac
    done
}

# -------------------------
# 1️⃣ Mise à jour
# -------------------------
if ask_yes_no "Voulez-vous mettre à jour le système ?"; then
    echo "Mise à jour du système..."
    sudo pacman -Syu --noconfirm
    SUMMARY+="- Système mis à jour\n"
fi

# -------------------------
# 2️⃣ Outils dev
# -------------------------
if ask_yes_no "Installer les outils de développement (Python, Node, Rust, Docker, git…) ?"; then
    declare -A DEV_PACKAGES=(
        [git]=git
        [python]=python
        [python-pip]=python-pip
        [nodejs]=nodejs
        [npm]=npm
        [rust]=rust
        [docker]=docker
        [docker-compose]=docker-compose
        [go]=go
    )
    for pkg in "${!DEV_PACKAGES[@]}"; do
        if ! command -v $pkg >/dev/null 2>&1; then
            echo "Installation de ${DEV_PACKAGES[$pkg]}..."
            sudo pacman -S --noconfirm ${DEV_PACKAGES[$pkg]}
            SUMMARY+="- ${DEV_PACKAGES[$pkg]} installé\n"
        else
            SUMMARY+="- ${DEV_PACKAGES[$pkg]} déjà présent\n"
        fi
    done
fi

# -------------------------
# 3️⃣ Windsurf
# -------------------------
if ask_yes_no "Installer Windsurf ?"; then
    if ! command -v windsurf >/dev/null 2>&1; then
        yay -S --noconfirm windsurf
        SUMMARY+="- Windsurf installé\n"
    else
        SUMMARY+="- Windsurf déjà présent\n"
    fi
fi

# -------------------------
# 4️⃣ Shell (Oh My Zsh + Starship)
# -------------------------
if ask_yes_no "Configurer le shell (Oh My Zsh + Starship + plugins) ?"; then
    ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
    mkdir -p $ZSH_CUSTOM/plugins

    # Oh My Zsh
    if [ ! -d "$HOME/.oh-my-zsh" ]; then
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
        SUMMARY+="- Oh My Zsh installé\n"
    else
        SUMMARY+="- Oh My Zsh déjà présent\n"
    fi

    # Starship
    if ! command -v starship >/dev/null 2>&1; then
        curl -sS https://starship.rs/install.sh | sh
        SUMMARY+="- Starship installé\n"
    else
        SUMMARY+="- Starship déjà présent\n"
    fi

    # Starship config
    rm -f /home/roddy/.config/starship.toml
    rm -rf /home/roddy/.config/starship_cache
    mkdir -p /home/roddy/.config

    cat > /home/roddy/.config/starship.toml <<'EOF'
add_newline = true

[directory]
truncation_length = 3
read_only = "🔒"

[git_branch]
symbol = "🌿 "
format = "[$symbol$branch]($style) "

[git_status]
format = '[[$all_status]]($style) '
conflicted = "💥 "
ahead = "⬆️ "
behind = "⬇️ "
staged = "✔️ "
modified = "✏️ "
untracked = "❌ "
stashed = "📦 "

[python]
symbol = "🐍 "
format = "[$symbol$version]($style) "

[nodejs]
symbol = "⬢ "
format = "[$symbol$version]($style) "

[rust]
symbol = "🦀 "
format = "[$symbol$version]($style) "

[time]
disabled = false
format = "🕒 $time"
time_format = "%H:%M:%S"
EOF
    SUMMARY+="- Starship configuré\n"

    # Plugins
    for plugin in zsh-autosuggestions zsh-syntax-highlighting; do
        if [ ! -d "$ZSH_CUSTOM/plugins/$plugin" ]; then
            git clone https://github.com/zsh-users/$plugin $ZSH_CUSTOM/plugins/$plugin
            SUMMARY+="- Plugin $plugin installé\n"
        else
            SUMMARY+="- Plugin $plugin déjà présent\n"
        fi
    done

    # Autojump
    if ! command -v autojump >/dev/null 2>&1; then
        if pacman -Si autojump >/dev/null 2>&1; then
            sudo pacman -S --noconfirm autojump
            SUMMARY+="- Autojump installé depuis les dépôts\n"
        else
            if command -v yay >/dev/null 2>&1; then
                yay -S --noconfirm autojump
                SUMMARY+="- Autojump installé depuis l'AUR via yay\n"
            else
                SUMMARY+="- Autojump non disponible, installez yay pour l'AUR\n"
            fi
        fi
    else
        SUMMARY+="- Autojump déjà présent\n"
    fi

    # .zshrc
    if ! grep -q "starship init zsh" "$HOME/.zshrc"; then
        echo 'eval "$(starship init zsh)"' >> "$HOME/.zshrc"
    fi
    sed -i 's/^plugins=(.*)/plugins=(git zsh-autosuggestions zsh-syntax-highlighting autojump docker)/' "$HOME/.zshrc" || true
fi

# -------------------------
# 5️⃣ Post-setup
# -------------------------
if ask_yes_no "Appliquer post-setup (Git global, ~/Projects…) ?"; then
    mkdir -p ~/Projects
    git config --global user.name "Roland Salardon"
    git config --global user.email "ton.email@example.com"
    SUMMARY+="- Post-setup appliqué (~/Projects et Git global)\n"
fi

# -------------------------
# Fin
# -------------------------
echo -e "\n=== Installation Interactive Ultimate terminée ==="
echo -e "$SUMMARY"

exec zsh
