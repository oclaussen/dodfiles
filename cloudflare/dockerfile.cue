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

	env: {
		type: "environment"
		variables: PATH: "/opt/nodejs/bin"
	}

	wrangler: {
		type: "copy"
		path: "/opt/nodejs"
		dockerfile: """
			FROM dodo/languages/nodejs
			ENV PATH /opt/nodejs/bin:$PATH
			RUN yarn config set global-folder /opt/nodejs
			RUN yarn global add wrangler --prefix /opt/nodejs

			"""
	}
}
