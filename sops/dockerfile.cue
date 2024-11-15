package dodfiles

import (
	"github.com/oclaussen/dodfiles/base/pkg:base"
)

actions:
	base.#BaseImage & {
		packages: {
			type: "install"
			name: "gnupg vim"
		}

		env: {
			type: "environment"
			variables: EDITOR: "vim"
		}

		sops: {
			type:        "fetch"
			source:      "https://github.com/mozilla/sops/releases/download/v3.6.1/sops-v3.6.1.linux"
			destination: "/bin/sops"
		}

		gpghome: {
			type:  "copy"
			path:  "/home/dodo/.gnupg"
			image: "dodo/gpg"
		}
	}
