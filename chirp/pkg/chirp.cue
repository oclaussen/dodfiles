package chirp

#InstallChirp: {
	chirp: {
		type:        "fetch"
		source:      "https://github.com/oclaussen/chirp/releases/download/v2.0.1/chirp_linux_amd64"
		destination: "/bin/chirp"
	}
	...
}

#WithClipboard: {
	volumes: {
		chirp: {
			source: "chirp"
			target: "/data/chirp"
		}
		chirps: {
			source: "/run/user/501/chirp.sock"
			target: "/data/chirp.sock"
		}
		...
	}
	...
}
