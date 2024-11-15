package dodfiles

import (
	"github.com/oclaussen/dodfiles/base/pkg:base"
)

actions:
	base.#BaseImage & {
		render: {
			type:        "fetch"
			source:      "https://github.com/VirtusLab/render/releases/download/v0.1.3/render-linux-amd64"
			destination: "/bin/render"
		}
	}
