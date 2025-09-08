# Arch Scripts Setup

Dépôt contenant un script interactif unique pour configurer un environnement de développement complet sur Arch Linux.

## Script principal

- `ultimate-setup.sh` : script interactif permettant de choisir quoi installer/configurer
    - Mise à jour du système
    - Installation des outils de développement (Python, Node, Rust, Docker, git…)
    - Windsurf
    - Shell (Oh My Zsh, Starship, plugins)
    - Post-setup (Git global, ~/Projects…)

## Instructions

1. Cloner le dépôt :
```bash
git clone https://github.com/ton-utilisateur/Arch-Scripts-Setup.git
cd Arch-Scripts-Setup
```

2. Rendre le script exécutable :
```bash
chmod +x ultimate-setup.sh
```

3. Lancer le script :
```bash
./ultimate-setup.sh
```

- Le script posera des questions pour chaque étape.
- Répondre `y` pour installer, `n` pour ignorer.

## Conseils

- Avoir `yay` installé pour gérer les paquets AUR automatiquement.
- Vérifier que `sudo` est configuré pour ton utilisateur.
