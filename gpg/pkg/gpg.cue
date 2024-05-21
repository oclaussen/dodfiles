package gpg

#InstallPass: {
	pass: {
		type:        "fetch"
		source:      "https://github.com/gopasspw/gopass/releases/download/v1.14.3/gopass-1.14.3-linux-amd64.tar.gz"
		unpack:      "gopass"
		destination: "/bin/gopass"
	}
	...
}

#WithGPGAgent: {
	volumes: {
		gpg: {
                        source: "/run/user/1000/gnupg"
			target: "/data/gpg-agent"
		}
		...
	}
	...
}

#WithPasswordStore: #WithGPGAgent & {
	volumes: {
		passwords: {
			source: "passwords"
			target: "/data/passwords"
		}
		...
	}
	...
}

#WithSSHAgent: #WithGPGAgent & {
	environment: {
		gpg: {
			name:  "SSH_AUTH_SOCK"
			value: "/data/gpg-agent/S.gpg-agent.ssh"
		}
		...
	}
	...
}

#WithSCD: {
	volumes: {
		scd: {
			source: "scd"
			target: "/var/run/pcscd"
		}
		usb: {
			source: "/dev/bus/usb"
			target: "/dev/bus/usb"
		}
		...
	}

	devices: [{cgroup_rule: "c *:* rmw"}]
	...
}
