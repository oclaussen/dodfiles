package dodfiles

import "github.com/oclaussen/dodfiles/base/pkg:base"

backdrops: golang:
	base.#WithRepository & {
		aliases: ["go"]
		image: {
			name:       "dodo/languages/golang"
			requires:   "dodo/base"
			context:    "{{ currentDir }}"
			dockerfile: "{{ currentDir }}/Dockerfile"
		}
		script: "exec go \"$@\""
	}
