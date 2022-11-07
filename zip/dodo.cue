package dodfiles

import "github.com/oclaussen/dodfiles/base/pkg:base"

backdrops: {
	zip:
		base.#WithDockerfile &
		base.#WithCWD & {
			image: name: "dodo/zip"
			script: "exec zip \"$@\""
		}

	unzip:
		base.#WithDockerfile &
		base.#WithCWD & {
			image: name: "dodo/zip"
			script: "exec unzip \"$@\""
		}
}
