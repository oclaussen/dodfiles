package dodfiles

import (
	"github.com/oclaussen/dodfiles/base/pkg:base"
	"github.com/oclaussen/dodfiles/gpg/pkg:gpg"
	"github.com/oclaussen/dodfiles/chirp/pkg:chirp"
)

actions:
	base.#BaseImage &
	base.#WithDotfiles &
	base.#WithLocalFiles &
	gpg.#InstallPass &
	chirp.#InstallChirp & {
		packages: {
			type: "install"
			name: "git git-lfs gnupg less openssh-client vim"
		}

		env: {
			type: "environment"
			variables: PATH: "/home/dodo/bin"
		}

		gpghome: {
			type:  "copy"
			path:  "/home/dodo/.gnupg"
			image: "dodo/gpg"
		}
	}
