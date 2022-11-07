package dodfiles

import (
	"github.com/oclaussen/dodfiles/base/pkg:base"
	"github.com/oclaussen/dodfiles/gpg/pkg:gpg"
)

backdrops: ansible:
	base.#WithDockerfile &
	base.#WithRepository &
	gpg.#WithSSHAgent & {
		image: {
			name: "dodo/ansible"
			requires: ["dodo/base", "dodo/languages/python", "dodo/gpg"]
		}
		environment: ansible: {name: "ANSIBLE_HOST_KEY_CHECKING", value: "False"}
		script: "exec ansible-playbook \"$@\""
	}
