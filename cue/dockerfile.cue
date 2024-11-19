package dodfiles

import (
	"github.com/oclaussen/dodfiles/base/pkg:base"
)

#arch: "amd64"

actions:
	base.#BaseImage & {
		cue: {
			type:        "fetch"
			source:      "https://github.com/cuelang/cue/releases/download/v0.4.0-rc.1/cue_v0.4.0-rc.1_linux_\(#arch).tar.gz"
			unpack:      "cue"
			destination: "/bin/cue"
		}
	}
