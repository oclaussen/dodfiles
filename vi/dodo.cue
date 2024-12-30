package dodfiles

import (
	"github.com/oclaussen/dodfiles/base/pkg:base"
	"github.com/oclaussen/dodfiles/chirp/pkg:chirp"
)

backdrops: vim:
	base.#WithLegacyDockerfile &
	chirp.#WithClipboard &
	base.#WithCWD & {
		aliases: ["vi"]
		image: {
			name: "dodo/vim"
			requires: ["dodo/base", "dodo/languages/nodejs"]
		}
		volumes: vim: {source: "vim-data", target: "/data/vim"}
		script: "exec nvim \"$@\""
	}
