package dodfiles

import "github.com/oclaussen/dodfiles/base/pkg:base"

backdrops: render:
	base.#WithDockerfile &
	base.#WithRepository & {
		image: name: "dodo/render"
		script: "exec render \"$@\""
	}
