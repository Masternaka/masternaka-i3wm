# 🪟 masternaka-i3wm

---

## 🚀 Installation

### Quick Install
```bash
git clone git@github.com:Masternaka/masternaka-i3wm.git
cd masternaka-i3wm
chmod +x install.sh
./install.sh
```

### Installation Options

The installer supports the following options:

```bash
./install.sh [OPTIONS]

Options:
  --only-config      Only copy config files (skip packages and external tools)
  --help             Show help message
```

**Features:**
- **Streamlined installation**: Simpler, more reliable installation process
- **Better error handling**: Installation fails fast on errors to prevent partial setups

**Package Installation:** Packages are installed in logical groups (core, UI, file manager, audio, utilities, terminal, fonts) for better organization.

# Copy configuration files
./install.sh --only-config
```

</details>

### Advanced Usage Examples

```bash
# Update only configuration files (useful for non-Debian systems)
./install.sh --only-config
```

**Note:** The script can be run from any location - it automatically detects its directory.

---

## 📦 What It Installs

| Component             | Purpose                          |
|------------------------|----------------------------------|
| `i3`                  | Tiling window manager            |
| `sxhkd`               | Hotkey daemon                    |
| `picom` `(yshui)`     | Compositor for transparency      |
| `polybar`             | Status bar                       |
| `rofi`                | Application launcher             |
| `dunst`               | Notifications                    |
| `kitty`               | Terminal emulator                |
| `firefox-esr`         | Default web browser              |
| `thunar` + plugins    | File manager                     |
| `nala`                | Better apt frontend              |
| `pipewire`            | Audio handling                   |
| `flameshot`,          | Screenshot tools                 |
| `qimgv`               | Lightweight image viewer         |
| `fzf`, etc.           | Utilities & enhancements         |


---

## 🎨 Appearance & Theming

- 12 built-in themes with matching wallpapers, swappable on the fly
- Polybar with optimized layout: system info (left), workspaces (center), controls (right)
- Enhanced polybar with multiple font support (Roboto Mono, FontAwesome, Hack Nerd Font)
- Dunst, rofi, and GTK themes preconfigured
- Wallpapers stored in `~/.config/i3/wallpaper`
- GTK Theme: [Orchis](https://github.com/vinceliuice/Orchis-theme)
- Icon Theme: [Colloid](https://github.com/vinceliuice/Colloid-icon-theme)

### Theme Switcher

Launch with `Super + Shift + T` (rofi menu) to swap the full desktop theme in one shot. The switcher updates i3 colors, polybar, wallpaper, dunst, rofi, kitty, and GTK theme + icons together.

Available themes: Catppuccin, Doom One, Dracula, Everforest, GitHub Dark, Gruvbox, Kanagawa, Monokai, Moonfly, Nord, Retro.

---

## 🔑 Keybindings Overview

| Key Combo              | Action                                |
|------------------------|----------------------------------------|
| `Super + Enter`        | Launch terminal (kitty)                |
| `Super + Shift + Enter`| Toggle scratchpad terminal             |
| `Super + Space`        | Launch rofi                            |
| `Super + B`            | Launch Firefox                         |
| `Super + Q`            | Close focused window                   |
| `Super + /`            | Help via keybind viewer                |
| `Super + Shift + T`    | Theme switcher                         |
| `Super + Alt + A`      | Audio mixer (pulsemixer) in scratchpad |
| `Super + X`            | Power menu (shutdown/reboot/logout)    |
| `Print` / `Super + s`  | Screenshot (fullscreen)                |
| `Super + Print` / `Super + Shift + s` | Screenshot (region select) |
| `Super + Shift + R`    | Reload i3 config                       |
| `Super + 1-0, -, =`    | Switch to workspace 1-12               |
| `Super + Shift + 1-0, -, =` | Move window to workspace 1-12     |
| `Super + W`            | Tabbed layout                          |
| `Super + T`            | Cycle layout (split → tabbed → stacking) |
| `Alt + Tab` / `Alt + Shift + Tab` | Cycle siblings / tabs        |

Keybindings are configured via:

- `~/.config/i3/sxhkd/sxhkdrc`
- `~/.config/i3/scripts/help` (run manually or with `Super + /`)

On first login, a welcome notification points to `~/QUICKSTART-i3.md` — a short cheat sheet you can delete when you're comfortable.

> **Note:** sxhkd only reliably binds keys in the `a-z` / standard ASCII range. If you use a non-US keyboard layout (German, French, Russian, Japanese, etc.), bindings that involve characters outside that range may not fire. You'll need to rework the relevant `sxhkdrc` entries to use keysyms that exist on your layout, or remove them.

---

## 📂 Configuration Files

```
~/.config/i3/
├── config                 # Main i3 config
├── workspaces.conf        # Workspace definitions
├── rules.conf             # Window rules and appearance
├── sxhkd/
│   └── sxhkdrc            # Keybinding configuration
├── polybar/
│   ├── config.ini
│   └── polybar-i3
├── dunst/
│   └── dunstrc
├── rofi/
│   ├── config.rasi
│   ├── keybinds.rasi
│   └── power.rasi
├── picom/
│   └── picom.conf
├── scripts/
│   ├── autostart.sh
│   ├── changevolume
│   ├── power
│   ├── scratchpad
│   └── help
├── wallpaper/
│   └── (wallpaper images)
```

### Terminal Configuration

Both roles use kitty:
- **Main terminal** (`Super + Enter`): kitty
- **Scratchpad terminal** (`Super + Shift + Enter`): a class-tagged kitty window toggled via i3's scratchpad

**Advanced scratchpad usage:**
```bash
# Launch custom applications in scratchpad mode
Super + Shift + Enter    # Default terminal scratchpad
Super + Alt + A          # Pulsemixer scratchpad
# Or via script: scratchpad app_name app_command
```

---

## 🔍 HiDPI / 4K Displays

Tiny type on a 4K screen? There's no single scaling knob — each toolkit (X fonts, GTK, Qt, the cursor) has to be told separately. `~/.config/i3/scripts/autostart.sh` ships a commented **HiDPI block** near the top; uncomment it and reload i3 (`Super + Shift + R`).

---

## 🎨 Modular Configuration

This i3 setup uses a modular configuration approach for better organization:
- **config**: Main i3 configuration with includes
- **workspaces.conf**: Workspace definitions (1-12)
- **rules.conf**: Window rules, borders, gaps, and scratchpad settings
- **sxhkd/sxhkdrc**: All keybindings managed by sxhkd for consistency

This modular approach makes it easy to:
- Understand and modify specific aspects of the configuration
- Share configurations between different window managers
- Keep the main config file clean and focused

---