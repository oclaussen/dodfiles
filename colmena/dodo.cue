package dodfiles

import (
	"github.com/oclaussen/dodfiles/base/pkg:base"
	"github.com/oclaussen/dodfiles/gpg/pkg:gpg"
)

backdrops: "colmena":
	base.#WithRepository &
	gpg.#WithSSHAgent & {
		image: {
			name: "dodo/colmena"
			context:    "{{ currentDir }}"
			dockerfile: "{{ currentDir }}/Dockerfile"
		}
                script: "exec /result/bin/colmena \"$@\""
	}
