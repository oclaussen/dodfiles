package dodfiles

import (
	"github.com/oclaussen/dodfiles/base/pkg:base"
	"github.com/oclaussen/dodfiles/docker/pkg:docker"
)

backdrops: {
	"syft":
		base.#WithDockerfile &
		base.#WithRepository &
		docker.#WithDockerDaemon & {
			image: {
				name: "dodo/syft"
				requires: ["dodo/base"]
			}
			script: "exec syft \"$@\""
		}
}
