package base

#BaseImage: {
	base: {
		type: "base"
		name: "dodo/base"
	}
	user: {
		type: "user"
		name: "dodo"
		uid:  501 // TODO: 501 is the main user on MacOS - this shouldn't be hardcoded here
		...
	}
	...
}

#WithDotfiles: {
	user: {
		type:     "user"
		dotfiles: "home"
		...
	}
	...
}

#WithLocalFiles: {
	root: {
		type:      "copy"
		directory: "root"
		path:      "/"
	}
	...
}
