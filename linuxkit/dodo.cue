package dodfiles

import "github.com/oclaussen/dodfiles/base/pkg:base"

backdrops: linuxkit:
	base.#WithDockerfile &
	base.#WithRepository & {
		image: {
			name: "dodo/linuxkit"
			requires: ["dodo/languages/buildbase", "dodo/languages/golang"]
		}
		script: "exec linuxkit \"$@\""
	}
