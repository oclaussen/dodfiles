package dodfiles

import (
	"github.com/oclaussen/dodfiles/base/pkg:base"
	"github.com/oclaussen/dodfiles/gpg/pkg:gpg"
)

backdrops: {
	ssh:
		base.#WithDockerfile &
		base.#WithCWD &
		gpg.#WithSSHAgent & {
			image: {
				name:     "dodo/ssh"
				requires: "dodo/base"
			}
			script: "exec ssh \"$@\""
		}

	scp:
		base.#WithDockerfile &
		base.#WithCWD &
		gpg.#WithSSHAgent & {
			image: {
				name:     "dodo/ssh"
				requires: "dodo/base"
			}
			script: "exec scp \"$@\""
		}

	sftp:
		base.#WithDockerfile &
		base.#WithCWD &
		gpg.#WithSSHAgent & {
			image: {
				name:     "dodo/ssh"
				requires: "dodo/base"
			}
			script: "exec sftp \"$@\""
		}
}
