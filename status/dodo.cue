package dodfiles

import "github.com/oclaussen/dodfiles/base/pkg:base"

backdrops: status:
	base.#WithDockerfile & {
		image: {
			name: "dodo/status"
			requires: ["dodo/base", "dodo/languages/python", "dodo/khal"]
		}
		volumes: vdir: {source: "vdir", target: "/data/vdir"}
		script: "exec watch -n 60 --color --no-title status"
	}
