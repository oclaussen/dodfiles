package dodfiles

import "github.com/oclaussen/dodfiles/base/pkg:base"

backdrops: rust:
	base.#WithLegacyDockerfile &
	base.#WithRepository & {
		image: {
			name:     "dodo/languages/rust"
			requires: "dodo/base"
		}
		interactive: true
	}
