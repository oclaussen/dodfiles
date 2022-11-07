package dodfiles

import "github.com/oclaussen/dodfiles/base/pkg:base"

backdrops: shellcheck:
	base.#WithDockerfile &
	base.#WithRepository & {
		image: {
			name:     "dodo/shellcheck"
			requires: "dodo/base"
		}
		script: "exec shellcheck \"$@\""
	}
