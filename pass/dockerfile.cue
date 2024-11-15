actions: {
	base: {
		type: "base"
		name: "dodo/base"
	}

	dodo: {
		type:     "user"
		name:     "dodo"
		uid:      501
		dotfiles: "home"
	}

	packages: {
		type: "install"
		name: "git git-lfs gnupg less openssh-client vim"
	}

	env: {
		type: "environment"
		variables: PATH: "/home/dodo/bin"
	}

	pass: {
		type:        "fetch"
		source:      "https://github.com/gopasspw/gopass/releases/download/v1.8.6/gopass-1.8.6-linux-amd64.tar.gz"
		unpack:      "gopass-1.8.6-linux-amd64/gopass"
		destination: "/bin/gopass"
	}

	chirp: {
		type:        "fetch"
		source:      "https://github.com/oclaussen/chirp/releases/download/v2.0.1/chirp_linux_amd64"
		destination: "/bin/chirp"
	}

	gpghome: {
		type:  "copy"
		path:  "/home/dodo/.gnupg"
		image: "dodo/gpg"
	}

	files: {
		type:      "copy"
		path:      "/"
		directory: "root"
	}
}
