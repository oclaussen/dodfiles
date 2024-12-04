package chirp

#InstallChirp: {
	chirp: {
		type: "eget"
		repo: "oclaussen/chirp"
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
