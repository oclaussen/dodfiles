package dodfiles

import "github.com/oclaussen/dodfiles/base/pkg:base"

backdrops: timg:
	base.#WithDockerfile &
	base.#WithRepository & {
		image: {
			name: "dodo/timg"
			requires: ["dodo/base"]
		}
		script: "exec timg \"$@\""
	}
