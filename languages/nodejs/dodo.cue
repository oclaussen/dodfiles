package dodfiles

import "github.com/oclaussen/dodfiles/base/pkg:base"

backdrops: nodejs:
	base.#WithLegacyDockerfile &
	base.#WithRepository & {
		aliases: ["node"]
		image: {
			name:     "dodo/languages/nodejs"
			requires: "dodo/base"
		}
		script: "exec node \"$@\""
	}
