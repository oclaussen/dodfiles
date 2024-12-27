package dodfiles

import "github.com/oclaussen/dodfiles/base/pkg:base"

backdrops: python:
	base.#WithDockerfile &
	base.#WithRepository & {
		image: name: "dodo/languages/python"
		script: "exec python \"$@\""
	}
