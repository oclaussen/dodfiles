package dodfiles

import "github.com/oclaussen/dodfiles/base/pkg:base"

backdrops: ruby:
	base.#WithRepository & {
		image: {
			name:       "dodo/languages/ruby"
			requires:   "dodo/base"
			context:    "{{ currentDir }}"
			dockerfile: "{{ currentDir }}/Dockerfile"
		}
		script: "exec ruby \"$@\""
	}
