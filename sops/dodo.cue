package dodfiles

import (
	"github.com/oclaussen/dodfiles/base/pkg:base"
	"github.com/oclaussen/dodfiles/gpg/pkg:gpg"
)

backdrops: sops:
	base.#WithDockerfile &
	base.#WithRepository &
	gpg.#WithPasswordStore & {
		image: {
			name: "dodo/sops"
			requires: ["dodo/base", "dodo/gpg"]
		}
		script: "exec sops \"$@\""
	}
