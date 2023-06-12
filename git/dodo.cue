package dodfiles

import (
	"github.com/oclaussen/dodfiles/base/pkg:base"
	"github.com/oclaussen/dodfiles/gpg/pkg:gpg"
)

backdrops: git:
	base.#WithDockerfile &
	base.#WithRepository &
	base.#WithDormouse &
	gpg.#WithPasswordStore &
	gpg.#WithSSHAgent & {
		image: {
			name: "dodo/git"
			requires: ["dodo/base", "dodo/languages/python", "dodo/gpg"]
		}
		volumes: cloudflare: {source: "cloudflare-cache", target: "/home/dodo/.cloudflared"}
	}
