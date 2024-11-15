actions: {
	base: {
		type: "base"
		name: "dodo/base"
	}

	dodo: {
		type: "user"
		name: "dodo"
		uid:  501
	}

	render: {
		type:        "fetch"
		source:      "https://github.com/VirtusLab/render/releases/download/v0.1.3/render-linux-amd64"
		destination: "/bin/render"
	}
}
