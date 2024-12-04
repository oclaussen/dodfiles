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
			type: "eget"
			repo: "mozilla/sops"
			asset: ["^.sbom.json"]
		}

		gpghome: {
			type:  "copy"
			path:  "/home/dodo/.gnupg"
			image: "dodo/gpg"
		}
	}
