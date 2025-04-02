# --- Default apps --- #
riverctl map normal Super+Shift Return spawn foot
riverctl map normal Super B spawn firefox
riverctl map normal Super E spawn thunar
riverctl map normal Super D spawn fuzzel

# Super+Q to close the focused view
riverctl map normal Super Q close

# Super+Shift+E to exit river
riverctl map normal Super+Shift E exit

# Super+J and Super+K to focus the next/previous view in the layout stack
riverctl map normal Super J focus-view next
riverctl map normal Super K focus-view previous

# Super+Shift+J and Super+Shift+K to swap the focused view with the next/previous
# view in the layout stack
riverctl map normal Super+Shift J swap next
riverctl map normal Super+Shift K swap previous

# Super+Period and Super+Comma to focus the next/previous output
riverctl map normal Super Period focus-output next
riverctl map normal Super Comma focus-output previous

# Super+Shift+{Period,Comma} to send the focused view to the next/previous output
riverctl map normal Super+Shift Period send-to-output next
riverctl map normal Super+Shift Comma send-to-output previous

# Super+Return to bump the focused view to the top of the layout stack
riverctl map normal Super Return zoom

# Super+H and Super+L to decrease/increase the main ratio of rivercarro(1)
riverctl map normal Super H send-layout-cmd rivercarro "main-ratio -0.05"
riverctl map normal Super L send-layout-cmd rivercarro "main-ratio +0.05"

# Super+Shift+H and Super+Shift+L to increment/decrement the main count of rivercarro(1)
riverctl map normal Super+Shift H send-layout-cmd rivercarro "main-count +1"
riverctl map normal Super+Shift L send-layout-cmd rivercarro "main-count -1"

riverctl map normal Super M send-layout-cmd rivercarro "main-location monocle"
# Cycle through layout
riverctl map normal Super W send-layout-cmd rivercarro "main-location-cycle left,monocle"

# Super+Alt+{H,J,K,L} to move views
riverctl map normal Super+Alt H move left 100
riverctl map normal Super+Alt J move down 100
riverctl map normal Super+Alt K move up 100
riverctl map normal Super+Alt L move right 100

# Super+Alt+Control+{H,J,K,L} to snap views to screen edges
riverctl map normal Super+Alt+Control H snap left
riverctl map normal Super+Alt+Control J snap down
riverctl map normal Super+Alt+Control K snap up
riverctl map normal Super+Alt+Control L snap right

riverctl map normal Super+Alt+Shift H resize horizontal -100
riverctl map normal Super+Alt+Shift J resize vertical 100
riverctl map normal Super+Alt+Shift K resize vertical -100
riverctl map normal Super+Alt+Shift L resize horizontal 100

# Super + Left Mouse Button to move views
riverctl map-pointer normal Super BTN_LEFT move-view

# Super + Right Mouse Button to resize views
riverctl map-pointer normal Super BTN_RIGHT resize-view

# Super + Middle Mouse Button to toggle float
riverctl map-pointer normal Super BTN_MIDDLE toggle-float

for i in $(seq 1 9); do
    tags=$((1 << ($i - 1)))

    # Super+[1-9] to focus tag [0-8]
    riverctl map normal Super $i set-focused-tags $tags

    # Super+Shift+[1-9] to tag focused view with tag [0-8]
    riverctl map normal Super+Shift $i set-view-tags $tags

    # Super+Control+[1-9] to toggle focus of tag [0-8]
    riverctl map normal Super+Control $i toggle-focused-tags $tags

    # Super+Shift+Control+[1-9] to toggle tag [0-8] of focused view
    riverctl map normal Super+Shift+Control $i toggle-view-tags $tags
done

# Super+0 to focus all tags
# Super+Shift+0 to tag focused view with all tags
all_tags=$(((1 << 32) - 1))
riverctl map normal Super 0 set-focused-tags $all_tags
riverctl map normal Super+Shift 0 set-view-tags $all_tags
riverctl xcursor-theme Bibata-Modern-Ice 16

# Super+Space to toggle float
riverctl map normal Super Space toggle-float

# Super+F to toggle fullscreen
riverctl map normal Super F toggle-fullscreen

# screenshot on print key press
riverctl map normal Super Print spawn $HOME/bin/screenshot.sh

# Super+{Up,Right,Down,Left} to change layout orientation
riverctl map normal Super Up send-layout-cmd rivercarro "main-location top"
riverctl map normal Super Right send-layout-cmd rivercarro "main-location right"
riverctl map normal Super Down send-layout-cmd rivercarro "main-location bottom"
riverctl map normal Super Left send-layout-cmd rivercarro "main-location left"

# Declare a passthrough mode. This mode has only a single mapping to return to
# normal mode. This makes it useful for testing a nested wayland compositor
riverctl declare-mode passthrough
# toggle passthrough mode
riverctl map normal Super F11 enter-mode passthrough
riverctl map passthrough Super F11 enter-mode normal
riverctl focus-follows-cursor always 

# --- Function keys --- #
for mode in normal locked; do
    riverctl map $mode None XF86Eject spawn 'eject -T'

    # volume control
    riverctl map $mode None XF86AudioRaiseVolume spawn 'pamixer -i 5'
    riverctl map $mode None XF86AudioLowerVolume spawn 'pamixer -d 5'
    riverctl map $mode None XF86AudioMute spawn 'pamixer --toggle-mute'

    # play pause etc
    riverctl map $mode None XF86AudioMedia spawn 'playerctl play-pause'
    riverctl map $mode None XF86AudioPlay spawn 'playerctl play-pause'
    riverctl map $mode None XF86AudioPrev spawn 'playerctl previous'
    riverctl map $mode None XF86AudioNext spawn 'playerctl next'

    # Brightness
    riverctl map $mode None XF86MonBrightnessUp spawn 'brightnessctl set +5%'
    riverctl map $mode None XF86MonBrightnessDown spawn 'brightnessctl set 5%-'
done

# Set keyboard repeat rate
riverctl set-repeat 50 300

# Make all views with an app-id that starts with "float" and title "foo" start floating.
# riverctl rule-add -app-id 'float*' -title 'foo' float
riverctl rule-add -app-id 'htop' float

# Make all views with app-id "bar" and any title use client-side decorations
riverctl rule-add -app-id "bar" csd

# set wallpaper

# Set the default layout generator to be rivercarro and start it.
# River will send the process group of the init executable SIGTERM on exit.
riverctl default-layout rivercarro
rivercarro -outer-gaps 6 -per-tag &
swaybg -i $HOME/os-config/wallpapers/wallpaper.jpg -m fill &
waybar &
