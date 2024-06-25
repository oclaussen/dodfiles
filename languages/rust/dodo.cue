package dodfiles

import "github.com/oclaussen/dodfiles/base/pkg:base"

backdrops: rust:
	base.#WithRepository & {
		image: {
			name:       "dodo/languages/rust"
			requires:   "dodo/base"
			context:    "{{ currentDir }}"
			dockerfile: "{{ currentDir }}/Dockerfile"
		}
		interactive: true
	}
