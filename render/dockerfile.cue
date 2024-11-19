package dodfiles

import (
	"github.com/oclaussen/dodfiles/base/pkg:base"
)

#arch: "amd64"

actions:
	base.#BaseImage & {
		render: {
			type:        "fetch"
			source:      "https://github.com/VirtusLab/render/releases/download/v0.1.3/render-linux-\(#arch)"
			destination: "/bin/render"
		}
	}
