package dodfiles

import (
	"github.com/oclaussen/dodfiles/base/pkg:base"
)

#arch: "amd64"

actions:
	base.#BaseImage & {
		syft: {
			type:        "fetch"
			source:      "https://github.com/anchore/syft/releases/download/v0.83.0/syft_0.83.0_linux_\(#arch).tar.gz"
			unpack:      "syft"
			destination: "/bin/syft"
		}
	}
