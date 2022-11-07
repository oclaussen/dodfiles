package dodfiles

import "github.com/oclaussen/dodfiles/base/pkg:base"

backdrops: buildbase:
	base.#WithDockerfile & {
		image: {
			name:     "dodo/languages/buildbase"
			requires: "dodo/base"
		}
		interactive: true
	}
