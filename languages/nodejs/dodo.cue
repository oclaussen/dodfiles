package dodfiles

import "github.com/oclaussen/dodfiles/base/pkg:base"

backdrops: nodejs:
	base.#WithDockerfile &
	base.#WithRepository & {
		aliases: ["node"]
		image: {
			name: "dodo/languages/nodejs"
			requires: ["dodo/base", "dodo/languages/buildbase"]
		}
		script: "exec node \"$@\""
	}
