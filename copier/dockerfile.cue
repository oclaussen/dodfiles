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

	env: {
		type: "environment"
		variables: PATH: "/opt/python/bin"
	}

	packages: {
		type: "install"
		name: "git"
	}

	copier: {
		type: "copy"
		path: "/opt/python"
		dockerfile: """
			FROM dodo/languages/python
			ENV PATH /opt/python/bin:$PATH
			RUN pip3 install copier

			"""
	}
}
