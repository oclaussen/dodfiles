package chirp

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
