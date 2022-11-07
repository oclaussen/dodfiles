package dodfiles

import "github.com/oclaussen/dodfiles/base/pkg:base"

backdrops: croc:
	base.#WithDockerfile &
	base.#WithCWD & {
		image: name: "dodo/croc"
		script: "exec croc \"$@\""
	}
