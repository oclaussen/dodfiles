package dodfiles

import (
	"github.com/oclaussen/dodfiles/base/pkg:base"
	"github.com/oclaussen/dodfiles/gpg/pkg:gpg"
)

backdrops: {
	pass:
		base.#WithDockerfile &
		gpg.#WithPasswordStore &
		gpg.#WithSSHAgent & {
			image: {
				name: "dodo/pass"
				requires: ["dodo/languages/buildbase", "dodo/base", "dodo/gpg"]
			}
			volumes: chirp: {source: "chirp", target: "/data/chirp"}
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
