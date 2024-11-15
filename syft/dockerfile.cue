package dodfiles

import (
	"github.com/oclaussen/dodfiles/base/pkg:base"
)

actions:
	base.#BaseImage & {
		syft: {
			type:        "fetch"
			source:      "https://github.com/anchore/syft/releases/download/v0.83.0/syft_0.83.0_linux_amd64.tar.gz"
			unpack:      "syft"
			destination: "/bin/syft"
		}
	}
