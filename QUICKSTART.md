# Guide de Démarrage Rapide i3

Bienvenue dans la configuration **masternaka-i3wm**.

## Le raccourci indispensable à retenir

**`Super + /`** — Ouvre un menu interactif et recherchable contenant tous les raccourcis clavier. En cas de doute, appuyez sur cette combinaison !

## Raccourcis Essentiels

| Touche | Action |
|---|---|
| `Super + Entrée` | Terminal (`kitty`) |
| `Super + Maj + Entrée` | Terminal escamotable (*scratchpad*) |
| `Super + Espace` | Lanceur d'applications (`rofi`) |
| `Super + B` | Navigateur Web (`Firefox`) |
| `Super + F` | Gestionnaire de fichiers (`Thunar`) |
| `Super + E` | Éditeur de texte (`Geany`) |
| `Super + Q` | Fermer la fenêtre active |
| `Super + /` | Menu d'aide des raccourcis |
| `Super + Maj + T` | Sélecteur de thèmes (12 thèmes) |
| `Super + X` | Menu d'extinction / alimentation |
| `Super + 1-0, -, =` | Naviguer vers les espaces de travail 1 à 12 |
| `Super + Maj + 1-0, -, =` | Déplacer la fenêtre vers les espaces 1 à 12 |
| `Super + H/J/K/L` (ou Flèches) | Déplacer le focus (gauche / bas / haut / droite) |
| `Super + Maj + H/J/K/L` | Déplacer la fenêtre (gauche / bas / haut / droite) |
| `Super + Maj + Espace` | Basculer en mode flottant |
| `Super + Maj + F` | Mode plein écran |

## Organisation et Fichiers de Configuration

- **Configuration principale i3 :** `~/.config/i3/config`
- **Raccourcis clavier :** `~/.config/i3/sxhkd/sxhkdrc` (recharger avec `Super + Échap`)
- **Scripts utilitaires :** `~/.config/i3/scripts/`
- **Changement de thème :** `~/.config/i3/scripts/thememenu` (12 thèmes intégrés)
- **Fichiers de thèmes graphiques :** `rofi/`, `polybar/`, `dunst/`, `picom/`

## Obtenir de l'aide

- Appuyez sur `Super + /` pour consulter l'aide interactive des raccourcis.
- Dépôt GitHub du projet : <https://github.com/Masternaka/masternaka-i3wm>

Vous pouvez supprimer ce fichier (`rm ~/QUICKSTART-i3.md`) une fois familiarisé avec votre environnement.
