package dodfiles

import (
	"github.com/oclaussen/dodfiles/base/pkg:base"
	"github.com/oclaussen/dodfiles/chirp/pkg:chirp"
	"github.com/oclaussen/dodfiles/gpg/pkg:gpg"
)

backdrops: {
	pass:
		base.#WithDockerfile &
		gpg.#WithPasswordStore &
		gpg.#WithSSHAgent &
		chirp.#WithClipboard & {
			image: {
				name: "dodo/pass"
				requires: ["dodo/base", "dodo/gpg"]
			}
			script: "exec gopass \"$@\""
		}

	pwgen: {
		image: {
			name: "dodo/pwgen"
			steps: """
				  # syntax = oclaussen/dodfile-syntax

				  base_image: dodo/base
				  user:
				    name: dodo
				  packages:
				    name: [pwgen]
				"""
		}
		script: "exec pwgen \"$@\""
	}
}
