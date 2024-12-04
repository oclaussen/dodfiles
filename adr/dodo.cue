package dodfiles

import (
	"github.com/oclaussen/dodfiles/base/pkg:base"
)

backdrops: adr:
	base.#WithDockerfile &
	base.#WithRepository & {
		image: name: "dodo/adr"
	}
