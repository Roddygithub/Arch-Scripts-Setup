# Arch-Scripts-Setup

**Ultimate Interactive Dev Setup pour Arch Linux**

Ce dépôt contient un script interactif pour configurer un environnement de développement complet sur Arch Linux, incluant :

- **Oh My Zsh** : shell avec plugins et thèmes
- **Starship prompt** : prompt moderne et personnalisable
- Plugins Oh My Zsh :
  - `zsh-autosuggestions`
  - `zsh-syntax-highlighting`
- Outils dev optionnels :
  - **autojump**
  - **Docker**
  - **Node.js & npm**
  - **Python & pip**
  - **Rust & cargo**

---

## 🔹 Installation

1. Cloner le dépôt :

```bash
git clone git@github.com:Roddygithub/Arch-Scripts-Setup.git
cd Arch-Scripts-Setup
```

2. Rendre le script exécutable :

```bash
chmod +x ultimate-setup.sh
```

3. Lancer le script interactif :

```bash
./ultimate-setup.sh
```

---

## 🔹 Utilisation

Le script propose un menu interactif pour choisir les composants à installer :

1. Oh My Zsh
2. Starship prompt
3. Plugins Oh My Zsh
4. Autojump
5. Docker
6. Node.js & npm
7. Python & pip
8. Rust & cargo
9. Tout installer
0. Quitter

> Le script détecte automatiquement si certains outils sont déjà installés.

---

## 🔹 Configuration Starship

Le fichier de configuration est généré automatiquement dans :

```text
~/.config/starship.toml
```

Inclut :

- Prompt pour **Python, Node.js, Rust, Docker**
- **Horloge**
- Statut Git corrigé pour éviter les warnings `[WARN] - (starship::config)`

---

## 🔹 Plugins Oh My Zsh

- **zsh-autosuggestions** : suggestions automatiques basées sur l’historique
- **zsh-syntax-highlighting** : coloration syntaxique des commandes

---

## 🔹 Notes

- **autojump** : si non disponible dans les dépôts, il faut l’installer manuellement.
- Le script est conçu pour **Arch Linux** avec Zsh.
- Redémarrage du shell nécessaire après exécution (`exec zsh`).

---

## 🔹 Contribuer

1. Forker le dépôt
2. Créer une branche : `git checkout -b feature/ma-feature`
3. Commit tes changements : `git commit -am 'Ajout d'une feature'`
4. Push : `git push origin feature/ma-feature`
5. Ouvrir une Pull Request

---

## 🔹 License

MIT License © Roddy Salardon

