package dodfiles

import "github.com/oclaussen/dodfiles/base/pkg:base"

backdrops: python:
	base.#WithRepository & {
		image: {
			name:       "dodo/languages/python"
			requires:   "dodo/base"
			context:    "{{ currentDir }}"
			dockerfile: "{{ currentDir }}/Dockerfile"
		}
		script: "exec python \"$@\""
	}
