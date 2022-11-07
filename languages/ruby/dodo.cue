package dodfiles

import "github.com/oclaussen/dodfiles/base/pkg:base"

backdrops: ruby:
	base.#WithDockerfile &
	base.#WithRepository & {
		image: {
			name:     "dodo/languages/ruby"
			requires: "dodo/base"
		}
		script: "exec ruby \"$@\""
	}
