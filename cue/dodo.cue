package dodfiles

import "github.com/oclaussen/dodfiles/base/pkg:base"

backdrops: cue:
	base.#WithDockerfile &
	base.#WithCWD & {
		image: name: "dodo/cue"
		script: "exec cue \"$@\""
	}
