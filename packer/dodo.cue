package dodfiles

import (
	"github.com/oclaussen/dodfiles/base/pkg:base"
	"github.com/oclaussen/dodfiles/gpg/pkg:gpg"
)

backdrops: {
	packer:
		base.#WithDockerfile &
		base.#WithRepository &
		gpg.#WithPasswordStore & {
			image: {
				name: "dodo/packer"
				requires: ["dodo/base", "dodo/languages/python", "dodo/languages/ruby", "dodo/gpg", "dodo/pass"]
			}
			script: "exec packer \"$@\""
		}

	kitchen:
		base.#WithDockerfile &
		base.#WithRepository &
		gpg.#WithPasswordStore & {
			image: {
				name: "dodo/packer"
				requires: ["dodo/base", "dodo/languages/python", "dodo/languages/ruby", "dodo/gpg", "dodo/pass"]
			}
			script: "exec kitchen \"$@\""
		}
}
