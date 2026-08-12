# 🪟 masternaka-i3wm

Une configuration i3wm complète, moderne et modulaire pour les systèmes basés sur Debian/Ubuntu. Elle inclut tous les paquets essentiels, une gestion dynamique de thèmes et des raccourcis clavier optimisés, prêts à l'emploi dès l'installation.

---

## 🚀 Installation

### Installation rapide

```bash
git clone https://github.com/Masternaka/masternaka-i3wm.git
cd masternaka-i3wm
chmod +x install.sh
./install.sh
```

### Options d'installation

Le script d'installation prend en charge plusieurs options :

```bash
./install.sh [OPTIONS]

Options :
  --only-config      Copie uniquement les fichiers de configuration (ignore l'installation des paquets et outils externes)
  --help             Affiche le message d'aide
```

**Exemples d'utilisation :**

```bash
# Appliquer ou mettre à jour uniquement la configuration i3 (utile si les paquets sont déjà installés)
./install.sh --only-config
```

**Caractéristiques de l'installateur :**
- **Installation structurée** : Installation propre et fiable avec vérification automatique à chaque étape.
- **Organisation par paquets** : Les paquets requis sont regroupés logiquement (noyau, interface, gestionnaire de fichiers, audio, utilitaires, terminal, polices, outils de compilation).
- **Gestion des configurations existantes** : Détecte une configuration `~/.config/i3` existante et propose une sauvegarde automatique avant remplacement.
- **Aide au premier démarrage** : Copie automatique du guide de démarrage rapide dans `~/QUICKSTART-i3.md`.

---

## 📦 Composants installés

| Composant | Description / Rôle |
|---|---|
| `i3` | Gestionnaire de fenêtres en pavage (Tiling Window Manager) |
| `sxhkd` | Démon de gestion des raccourcis clavier |
| `picom` | Compositeur de fenêtres (effets visuels, transparence, ombres) |
| `polybar` | Barre d'état hautement personnalisée et dynamique |
| `rofi` | Lanceur d'applications, menu de thèmes et menu d'extinction |
| `dunst` | Démon de gestion des notifications système |
| `kitty` | Émulateur de terminal principal et terminal escamotable (scratchpad) |
| `firefox` / `firefox-esr` | Navigateur Web par défaut |
| `thunar` (+ plugins `gvfs`) | Gestionnaire de fichiers graphique complet |
| `pipewire` / `pamixer` / `pulsemixer` | Gestion globale et mixage du flux audio |
| `flameshot` | Outil de capture d'écran interactif |
| `qimgv` | Visionneuse d'images rapide et légère |
| `autotiling` | Basculement automatique du pavage (horizontal / vertical) |
| `variety` / `feh` | Gestion et affichage des fonds d'écran |
| `lxpolkit` / `xsettingsd` / `nwg-look` | Agent d'authentification PolicyKit et gestion du thème GTK |

---

## 🎨 Apparence & Thèmes

- **12 thèmes intégrés** avec fonds d'écran assortis, interchangeables à la volée.
- **Polybar optimisée** : affichage modulaire comprenant les informations système à gauche, les espaces de travail au centre et les raccourcis/date/heure à droite.
- **Prise en charge multi-polices** : intégration de JetBrains Mono Nerd Font, FontAwesome et Roboto.
- **Thèmes GTK et icônes** : configurés automatiquement pour une cohérence visuelle complète.
- **Fonds d'écran** : stockés directement dans `~/.config/i3/wallpaper`.

### Sélecteur de thèmes dynamique

Lancez le sélecteur avec **`Super + Maj + T`** (menu Rofi) pour changer l'intégralité du thème en un clic. Le script met à jour instantanément les couleurs d'i3, Polybar, Rofi, Dunst, Kitty, le thème GTK, les icônes et le fond d'écran.

**Thèmes disponibles (12) :**
- Catppuccin
- Doom One
- Dracula
- Everforest
- GitHub Dark
- Gruvbox
- Kanagawa
- Monokai
- Moonfly
- Nord
- Retro
- Rose Pine

---

## 🔑 Raccourcis clavier principaux

| Combinaison | Action |
|---|---|
| `Super + Entrée` | Lancer le terminal (`kitty`) |
| `Super + Maj + Entrée` | Masquer / Afficher le terminal escamotable (*scratchpad*) |
| `Super + Espace` | Lancer le menu d'applications (`rofi`) |
| `Super + B` | Lancer le navigateur Web (`Firefox`) |
| `Super + Maj + B` | Lancer Firefox en mode privé |
| `Super + F` | Lancer le gestionnaire de fichiers (`Thunar`) |
| `Super + E` | Lancer l'éditeur de texte (`Geany`) |
| `Super + Q` | Fermer la fenêtre active |
| `Super + /` | Afficher l'aide interactive des raccourcis |
| `Super + Maj + T` | Ouvrir le sélecteur de thèmes |
| `Super + Alt + A` | Ouvrir le mélangeur audio (`pulsemixer` en scratchpad) |
| `Super + X` | Menu d'extinction (éteindre / redémarrer / déconnexion) |
| `Impr écran` / `Super + S` | Capture d'écran (plein écran) |
| `Super + Maj + S` | Capture d'écran (sélection de zone avec Flameshot) |
| `Super + Maj + R` | Recharger la configuration i3 |
| `Super + Échap` | Recharger la configuration sxhkd |
| `Super + 1-0, -, =` | Basculer vers l'espace de travail 1 à 12 |
| `Super + Maj + 1-0, -, =` | Déplacer la fenêtre vers l'espace de travail 1 à 12 |
| `Super + H / J / K / L` | Déplacer le focus (gauche / bas / haut / droite) |
| `Super + Maj + H / J / K / L` | Déplacer la fenêtre (gauche / bas / haut / droite) |
| `Super + Ctrl + H / J / K / L` | Redimensionner la fenêtre |
| `Super + Maj + Espace` | Basculer la fenêtre en mode flottant |
| `Super + Maj + F` | Basculer la fenêtre en plein écran |
| `Super + W` | Disposition en onglets (*tabbed*) |
| `Super + T` | Alterner la disposition (split → tabbed → stacking) |
| `Alt + Tab` / `Alt + Maj + Tab` | Naviguer entre les fenêtres / onglets |

Les raccourcis clavier sont gérés et configurés via :
- `~/.config/i3/sxhkd/sxhkdrc`
- `~/.config/i3/scripts/help` (exécutable via `Super + /`)

> **Remarque pour les claviers non-US (AZERTY, etc.) :** `sxhkd` associe les touches selon la disposition ASCII standard. Si vous utilisez une disposition de clavier francophone, utilisez `Super + /` pour vérifier l'attribution ou adaptez les entrées dans `~/.config/i3/sxhkd/sxhkdrc`.

---

## 📂 Structure des fichiers de configuration

```
~/.config/i3/
├── config                 # Fichier de configuration principal d'i3
├── workspaces.conf        # Configuration des 12 espaces de travail
├── rules.conf             # Règles des fenêtres, bordures, marges (gaps) et scratchpads
├── colors.conf            # Fichier de couleurs du thème actif
├── sxhkd/
│   └── sxhkdrc            # Configuration centralisée des raccourcis clavier
├── polybar/
│   ├── config.ini         # Configuration de la barre Polybar
│   ├── colors.ini         # Thème de couleurs Polybar
│   └── polybar-i3         # Script de lancement de Polybar
├── dunst/
│   └── dunstrc            # Configuration du démon de notifications
├── rofi/
│   ├── config.rasi        # Configuration du lanceur Rofi
│   ├── keybinds.rasi     # Interface d'aide des raccourcis
│   ├── power.rasi        # Menu d'extinction
│   └── colors.rasi       # Thème de couleurs Rofi
├── picom/
│   └── picom.conf         # Configuration du compositeur visuel
├── scripts/
│   ├── autostart.sh       # Script de démarrage automatique des démons
│   ├── changevolume       # Script de gestion du volume sonore
│   ├── help               # Visualiseur interactif des raccourcis clavier
│   ├── power              # Script du menu de gestion d'énergie
│   ├── scratchpad         # Gestionnaire de fenêtres escamotables
│   └── thememenu          # Script de changement de thème en direct
└── themes/                # Définitions des 12 thèmes préconfigurés
```

---

## 🔍 Écrans HiDPI / 4K

Si le texte et les icônes paraissent trop petits sur un écran 4K ou à haute résolution, un bloc de configuration **HiDPI** est préparé dans `~/.config/i3/scripts/autostart.sh`.

Pour l'activer :
1. Ouvrez `~/.config/i3/scripts/autostart.sh`.
2. Décommentez les lignes de la section HiDPI.
3. Rechargez i3 avec **`Super + Maj + R`**.
4. Ajustez la hauteur et la taille de police dans `~/.config/i3/polybar/config.ini` si nécessaire.

---

## 🎨 Architecture modulaire

Cette configuration i3 adopte une structure modulaire via des directives d'inclusion (`include`) pour maintenir un code propre et maintenable :
- **`config`** : Configuration principale i3 (charge les sous-fichiers).
- **`workspaces.conf`** : Définition des espaces de travail (1 à 12).
- **`rules.conf`** : Définition des règles de fenêtres, bordures, espaces inter-fenêtres (gaps) et scratchpads.
- **`sxhkd/sxhkdrc`** : Gestion centralisée et fluide de tous les raccourcis clavier.

Cette séparation simplifie la personnalisation, facilite le partage de modules et garantit une grande lisibilité du projet.