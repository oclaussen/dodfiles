package dodfiles

import "github.com/oclaussen/dodfiles/base/pkg:base"

backdrops: "base":
	base.#WithLegacyDockerfile & {
		image: name: "dodo/base"
		interactive: true
	}
