package base

#BaseImage: {
	base: {
		type: "base"
		name: "dodo/base"
	}
	user: {
		type: "user"
		name: "dodo"
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
