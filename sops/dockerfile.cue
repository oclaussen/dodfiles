package dodfiles

import (
	"github.com/oclaussen/dodfiles/base/pkg:base"
)

actions:
	base.#BaseImage &
	base.#WithDotfiles & {
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
			path:  "/root/.gnupg"
			image: "dodo/gpg"
		}
	}
