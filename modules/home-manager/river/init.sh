#!/bin/bash

CONFIG_PATH = "$HOME/os-config/"

# ============================================================================
# === Appearance and Environment Setup =======================================
# ============================================================================

# Set wallpaper
swaybg -i $HOME/os-config/wallpapers/wallpaper.jpg -m fill &

# Set the default cursor theme and size
riverctl xcursor-theme Bibata-Modern-Ice 16

# Mouse cursor behavior
riverctl focus-follows-cursor normal
riverctl border-width 2
riverctl hide-cursor when-typing enabled

# Set keyboard repeat rate
riverctl set-repeat 50 300

# Ensure Wayland environment variables are set
systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=river
systemctl --user restart xdg-desktop-portal

# ============================================================================
# === Application Launchers ==================================================
# ============================================================================

# Default applications
riverctl map normal Super+Shift Return spawn foot                # Terminal
riverctl map normal Super B spawn firefox                        # Browser
riverctl map normal Super E spawn pcmanfm                        # File manager
riverctl map normal Super D spawn "wofi --show drun --prompt ''" # App launcher
riverctl map normal Super S spawn "sh $HOME/os-config/modules/home-manager/scripts/emoji"
riverctl map normal Super A spawn "sh $HOME/os-config/modules/home-manager/scripts/wifi"

# ============================================================================
# === Window Management ======================================================
# ============================================================================

# Close and exit
riverctl map normal Super Q close      # Close focused view
riverctl map normal Super+Shift E exit # Exit River

# Focus navigation
riverctl map normal Super J focus-view next     # Focus next view
riverctl map normal Super K focus-view previous # Focus previous view

# Swap views
riverctl map normal Super+Shift J swap next     # Swap with next view
riverctl map normal Super+Shift K swap previous # Swap with previous view

# Output navigation
riverctl map normal Super Period focus-output next    # Focus next output
riverctl map normal Super Comma focus-output previous # Focus previous output

# Send views to outputs
riverctl map normal Super+Shift Period send-to-output next    # Send to next output
riverctl map normal Super+Shift Comma send-to-output previous # Send to previous output

# Zoom focused view to top of stack
riverctl map normal Super Return zoom

# Toggle floating and fullscreen
riverctl map normal Super Space toggle-float  # Toggle floating
riverctl map normal Super F toggle-fullscreen # Toggle fullscreen

# ============================================================================
# === Layout Control (Rivertile) =============================================
# ============================================================================

# Adjust main ratio
riverctl map normal Super H send-layout-cmd rivertile "main-ratio -0.05" # Decrease
riverctl map normal Super L send-layout-cmd rivertile "main-ratio +0.05" # Increase

# Adjust main count
riverctl map normal Super+Shift H send-layout-cmd rivertile "main-count +1" # Increment
riverctl map normal Super+Shift L send-layout-cmd rivertile "main-count -1" # Decrement

# Set layout modes
riverctl map normal Super M send-layout-cmd rivertile "main-location monocle"            # Monocle mode
riverctl map normal Super W send-layout-cmd rivertile "main-location-cycle left,monocle" # Cycle layouts

# Change layout orientation
riverctl map normal Super Up send-layout-cmd rivertile "main-location top"      # Top
riverctl map normal Super Right send-layout-cmd rivertile "main-location right" # Right
riverctl map normal Super Down send-layout-cmd rivertile "main-location bottom" # Bottom
riverctl map normal Super Left send-layout-cmd rivertile "main-location left"   # Left

# ============================================================================
# === Floating Window Movement and Resizing ==================================
# ============================================================================

# Move floating views
riverctl map normal Super+Alt H move left 100  # Left
riverctl map normal Super+Alt J move down 100  # Down
riverctl map normal Super+Alt K move up 100    # Up
riverctl map normal Super+Alt L move right 100 # Right

# Snap floating views to edges
riverctl map normal Super+Alt+Control H snap left  # Left edge
riverctl map normal Super+Alt+Control J snap down  # Bottom edge
riverctl map normal Super+Alt+Control K snap up    # Top edge
riverctl map normal Super+Alt+Control L snap right # Right edge

# Resize floating views
riverctl map normal Super+Alt+Shift H resize horizontal -100 # Shrink horizontally
riverctl map normal Super+Alt+Shift J resize vertical 100    # Expand vertically
riverctl map normal Super+Alt+Shift K resize vertical -100   # Shrink vertically
riverctl map normal Super+Alt+Shift L resize horizontal 100  # Expand horizontally

# ============================================================================
# === Mouse Bindings =========================================================
# ============================================================================

riverctl map-pointer normal Super BTN_LEFT move-view      # Move views with left click
riverctl map-pointer normal Super BTN_RIGHT resize-view   # Resize views with right click
riverctl map-pointer normal Super BTN_MIDDLE toggle-float # Toggle float with middle click

# ============================================================================
# === Tag Management =========================================================
# ============================================================================

# Scratchpad configuration (tag 20)
scratch_tag=$((1 << 20))
riverctl map normal Super P toggle-focused-tags ${scratch_tag} # Toggle visibility
riverctl map normal Super+Shift P set-view-tags ${scratch_tag} # Send to scratchpad
all_but_scratch_tag=$((((1 << 32) - 1) ^ $scratch_tag))
riverctl spawn-tagmask ${all_but_scratch_tag} # Exclude scratchpad from new windows

# Workspace tags (1-9, mapped to tags 0-8)
for i in $(seq 1 9); do
    tags=$((1 << ($i - 1)))
    riverctl map normal Super $i set-focused-tags $tags               # Focus tag
    riverctl map normal Super+Shift $i set-view-tags $tags            # Tag focused view
    riverctl map normal Super+Control $i toggle-focused-tags $tags    # Toggle focus
    riverctl map normal Super+Shift+Control $i toggle-view-tags $tags # Toggle view tag
done

# Focus or tag all tags
all_tags=$(((1 << 32) - 1))
riverctl map normal Super 0 set-focused-tags $all_tags    # Focus all tags
riverctl map normal Super+Shift 0 set-view-tags $all_tags # Tag view with all tags

# ============================================================================
# === System Utilities =======================================================
# ============================================================================

# Lock screen
riverctl map normal Super+Shift M spawn swaylock

# Screenshot
riverctl map normal Super Print spawn "$HOME/os-config/modules/home-manager/scripts/screenshot"

# ============================================================================
# === Passthrough Mode (Nested Compositors) ==================================
# ============================================================================

riverctl declare-mode passthrough
riverctl map normal Super F11 enter-mode passthrough # Enter passthrough mode
riverctl map passthrough Super F11 enter-mode normal # Exit passthrough mode

# ============================================================================
# === Media and Function Keys ================================================
# ============================================================================

for mode in normal locked; do
    # Eject
    riverctl map $mode None XF86Eject spawn 'eject -T'

    # Volume control
    riverctl map $mode None XF86AudioRaiseVolume spawn 'pamixer -i 5'   # Increase
    riverctl map $mode None XF86AudioLowerVolume spawn 'pamixer -d 5'   # Decrease
    riverctl map $mode None XF86AudioMute spawn 'pamixer --toggle-mute' # Mute toggle

    # Media playback
    riverctl map $mode None XF86AudioMedia spawn 'playerctl play-pause' # Play/pause
    riverctl map $mode None XF86AudioPlay spawn 'playerctl play-pause'  # Play/pause
    riverctl map $mode None XF86AudioPrev spawn 'playerctl previous'    # Previous track
    riverctl map $mode None XF86AudioNext spawn 'playerctl next'        # Next track

    # Brightness control
    riverctl map $mode None XF86MonBrightnessUp spawn 'brightnessctl set +5%'   # Increase
    riverctl map $mode None XF86MonBrightnessDown spawn 'brightnessctl set 5%-' # Decrease
done

# ============================================================================
# === Window Rules (Commented) ===============================================
# ============================================================================

# Example: Make views with app-id starting with "float" and title "foo" float
# riverctl rule-add -app使-id 'float*' -title 'foo' float
# riverctl rule-add -app-id 'htop' float

# Example: Use client-side decorations for app-id "bar"
# riverctl rule-add -app-id "bar" csd


# Set default layout generator
riverctl default-layout rivertile
rivertile -view-padding 3 -outer-padding 3 &

riverctl spawn "eww open bar"