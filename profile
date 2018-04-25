
# Autostart systemd default session on tty
if [[ "$(tty)" == '/dev/tty1' ]]; then
	exec startx
fi;

export XDG_CONFIG_HOME="$HOME/.config"
