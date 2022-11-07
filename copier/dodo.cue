package dodfiles

import "github.com/oclaussen/dodfiles/base/pkg:base"

backdrops: copier:
	base.#WithDockerfile &
	base.#WithRepository & {
		image: {
			name: "dodo/copier"
			requires: ["dodo/base", "dodo/languages/python"]
		}
		script: "exec copier \"$@\""
	}
