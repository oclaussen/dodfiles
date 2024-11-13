package dodfiles

import "github.com/oclaussen/dodfiles/base/pkg:base"

backdrops: ruby:
	base.#WithLegacyDockerfile &
	base.#WithRepository & {
		image: {
			name:     "dodo/languages/ruby"
			requires: "dodo/base"
		}
		script: "exec ruby \"$@\""
	}
