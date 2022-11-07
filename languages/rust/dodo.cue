package dodfiles

import "github.com/oclaussen/dodfiles/base/pkg:base"

backdrops: rust:
	base.#WithDockerfile &
	base.#WithRepository & {
		image: {
			name: "dodo/languages/rust"
			requires: ["dodo/base"]
		}
		interactive: true
	}
