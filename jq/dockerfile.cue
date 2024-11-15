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

	packages: {
		type: "install"
		name: "jq"
	}

	yq: {
		type:        "fetch"
		source:      "https://github.com/mikefarah/yq/releases/download/v4.22.1/yq_linux_amd64"
		destination: "/bin/yq"
	}
}
