package dodfiles

import (
	"github.com/oclaussen/dodfiles/base/pkg:base"
)

actions:
	base.#BaseImage &
	base.#WithDotfiles & {
		packages: {
			type: "install"
			name: "openssh-client"
		}

		gpghome: {
			type:  "copy"
			path:  "/home/dodo/.gnupg"
			image: "dodo/gpg"
		}
	}
