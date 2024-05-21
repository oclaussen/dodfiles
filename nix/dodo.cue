package dodfiles

import (
	"github.com/oclaussen/dodfiles/base/pkg:base"
	"github.com/oclaussen/dodfiles/gpg/pkg:gpg"
)

backdrops: {
	nix:
		base.#WithDockerfile &
		base.#WithRepository &
		gpg.#WithSSHAgent & {
			image: {
				name:     "dodo/nix"
				requires: "dodo/base"
			}
			script: "exec nix \"$@\""
		}
}
