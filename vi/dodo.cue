package dodfiles

import "github.com/oclaussen/dodfiles/base/pkg:base"

backdrops: vim:
	base.#WithDockerfile &
	base.#WithCWD & {
		aliases: ["vi"]
		image: {
			name: "dodo/vim"
			requires: ["dodo/base", "dodo/languages/golang", "dodo/languages/nodejs"]
		}
		volumes: {
			chirp: {source: "chirp", target: "/data/chirp"}
			vim: {source: "vim-data", target: "/data/vim"}
		}
		script: "exec nvim \"$@\""
	}
