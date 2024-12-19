package base

#BaseImage: {
	base: {
		type: "base"
		name: "dodo/base"
	}
	...
}

#WithDotfiles: {
	user: {
		type:      "copy"
		directory: "home"
		path:      "/root/"
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
