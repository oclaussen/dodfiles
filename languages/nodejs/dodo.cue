package dodfiles

import "github.com/oclaussen/dodfiles/base/pkg:base"

backdrops: nodejs:
	base.#WithRepository & {
		aliases: ["node"]
		image: {
			name:       "dodo/languages/nodejs"
			requires:   "dodo/base"
			context:    "{{ currentDir }}"
			dockerfile: "{{ currentDir }}/Dockerfile"
		}
		script: "exec node \"$@\""
	}
