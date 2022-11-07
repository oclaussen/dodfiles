package dodfiles

import (
	"github.com/oclaussen/dodfiles/base/pkg:base"
	"github.com/oclaussen/dodfiles/gpg/pkg:gpg"
	"github.com/oclaussen/dodfiles/docker/pkg:docker"
)

backdrops: {
	"docker":
		base.#WithDockerfile &
		base.#WithRepository &
		base.#WithDormouse &
		gpg.#WithPasswordStore &
		docker.#WithDockerDaemon & {
			image: {
				name: "dodo/docker"
				requires: ["dodo/base"]
			}
		}

	ctop:
		base.#WithDockerfile &
		docker.#WithDockerDaemon & {
			image: {
				name: "dodo/docker"
				requires: ["dodo/base"]
			}
			script: "exec ctop \"$@\""
		}
}
