package dodfiles

backdrops: pulseaudio: {
	aliases: ["pa"]
	image: {
		name:       "dodo/pulseaudio"
		context:    "{{ currentDir }}"
		dockerfile: "{{ currentDir }}/Dockerfile"
	}
	volumes: [
		"dbus:/var/run/dbus",
		"pulseaudio:/data/pulseaudio",
	]
	devices: [
		"/dev/snd:/dev/snd",
	]
	environment: [
		"DISPLAY=:1",
	]
	script: """
		  alsactl init
		  Xvfb $DISPLAY -screen 0 1x1x8 &
		  rm -f /var/run/dbus/pid
		  dbus-uuidgen > /var/lib/dbus/machine-id
		  dbus-daemon --config-file=/usr/share/dbus-1/system.conf --print-address
		  USER=dodo HOME=/home/dodo setpriv --reuid dodo --regid dodo --init-groups pulseaudio
		"""
}
