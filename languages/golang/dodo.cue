package dodfiles

import "github.com/oclaussen/dodfiles/base/pkg:base"

backdrops: golang:
	base.#WithDockerfile &
	base.#WithRepository & {
		aliases: ["go"]
		image: name: "dodo/languages/golang"
		script: "exec go \"$@\""
	}
