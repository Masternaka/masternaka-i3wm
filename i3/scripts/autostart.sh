
# ─── HiDPI / 4K displays ──────────────────────────────────────────────
# There's no single scaling knob — i3 doesn't scale, so each toolkit has
# to be told separately. If type is tiny on a 4K screen, uncomment this
# whole block and reload (Super + Shift + R).
#
# The values give ~200% (good for a 4K laptop or 27"). For ~150%, use
# Xft.dpi 144, drop GDK_SCALE, and set the cursor sizes to 36. Exports live
# up here so apps launched from sxhkd inherit them.
#
# printf 'Xft.dpi: 192\nXcursor.size: 48\n' | xrdb -merge   # X apps, fonts + cursor
# export GDK_SCALE=2          # GTK app widgets (thunar, geany)
# export GDK_DPI_SCALE=0.5    # cancel GTK's double font scaling on top of GDK_SCALE
# export QT_AUTO_SCREEN_SCALE_FACTOR=1   # Qt apps follow Xft.dpi
# export XCURSOR_SIZE=48
# ──────────────────────────────────────────────────────────────────────

# Scripts pour démarrer les applications et services nécessaires au démarrage d'i3

# Screen configuration (replace with your screen configuration) (install arandr to manage screen configuration)
exec --no-startup-id sh -c '[ -f "$HOME/.screenlayout/$(whoami).sh" ] && sh "$HOME/.screenlayout/$(whoami).sh"'

# Attendre 1 secondes pour que le système ait le temps de configurer les écrans
sleep 1

# Active le picom (compositor)
killall picom
while pgrep -u $UID -x picom >/dev/null; do sleep 1; done
picom --config ~/.config/i3/picom/picom.conf -b &

# Active Polybar (barre de statut)
~/.config/i3/polybar/polybar-i3 &

# Active le polkit (gestionnaire de permissions)
lxpolkit &

# Active ce qui est nécessaire pour changer les thèmes (gestionnaire de thèmes)
xsettingsd &

# Active le dunst (gestionnaire de notifications)
dunst -config ~/.config/i3/dunst/dunstrc &

# Active le fond d'écran (remplacer par le fond d'écran de votre choix)
feh --bg-fill ~/.config/wallpapers/wallhaven-e8w2jk.png &

# Active le tiling automatique (gestion du tiling)
pkill -x autotiling
autotiling &

# sxhkd
pkill -x sxhkd
sxhkd -c ~/.config/i3/sxhkd/sxhkdrc &

# First-login welcome (shown once, dismissable)
if [ ! -f "$HOME/.cache/i3/welcomed" ]; then
	mkdir -p "$HOME/.cache/i3"
	touch "$HOME/.cache/i3/welcomed"
	(sleep 3; notify-send -u normal -t 15000 \
		"Welcome to i3" \
		"Press Super + / anytime to see all keybindings.&#10;See ~/QUICKSTART-i3.md for a cheat sheet.") &
fi
