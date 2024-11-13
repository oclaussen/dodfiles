package dodfiles

import "github.com/oclaussen/dodfiles/base/pkg:base"

backdrops: python:
	base.#WithLegacyDockerfile &
	base.#WithRepository & {
		image: {
			name:     "dodo/languages/python"
			requires: "dodo/base"
		}
		script: "exec python \"$@\""
	}
