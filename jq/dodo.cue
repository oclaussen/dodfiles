package dodfiles

import "github.com/oclaussen/dodfiles/base/pkg:base"

backdrops: {
	jq:
		base.#WithDockerfile & {
			image: name: "dodo/jq"
			script: "exec jq \"$@\""
		}

	yq:
		base.#WithDockerfile & {
			image: name: "dodo/jq"
			script: "exec yq \"$@\""
		}
}
