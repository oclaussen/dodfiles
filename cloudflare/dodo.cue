package dodfiles

import "github.com/oclaussen/dodfiles/base/pkg:base"

backdrops: wrangler:
	base.#WithDockerfile &
	base.#WithCWD & {
		image: {
			name: "dodo/cloudflare"
			requires: ["dodo/base", "dodo/languages/nodejs"]
		}
		script: "exec wrangler \"$@\""
	}
