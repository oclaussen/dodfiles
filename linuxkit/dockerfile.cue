package dodfiles

import (
	"github.com/oclaussen/dodfiles/base/pkg:base"
)

actions:
	base.#BaseImage & {
		linuxkit: {
			type: "golang"
			install: ["github.com/linuxkit/linuxkit/src/cmd/linuxkit@latest"]
		}
	}
