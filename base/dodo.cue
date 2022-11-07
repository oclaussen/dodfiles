package dodfiles

import "github.com/oclaussen/dodfiles/base/pkg:base"

backdrops: "base":
	base.#WithDockerfile & {
		image: name: "dodo/base"
		interactive: true
	}
