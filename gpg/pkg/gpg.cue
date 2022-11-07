package gpg

#WithGPGAgent: {
	volumes: {
		gpg: {
			source: "gpg-agent"
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
