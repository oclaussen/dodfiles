package dodfiles

import (
	"github.com/oclaussen/dodfiles/base/pkg:base"
	"github.com/oclaussen/dodfiles/docker/pkg:docker"
)

backdrops: zsh:
	base.#WithDockerfile &
	docker.#WithDockerDaemon & {
		image: {
			name: "dodo/zsh"
			requires: ["dodo/base", "dodo/languages/rust"]
		}
		volumes: {
			chirp: {source: "chirp", target: "/data/chirp"}
			zsh: {source: "zsh-data", target: "/data/zsh"}
		}
		interpreter: ["/usr/bin/zsh"]
		interactive: true
	}
