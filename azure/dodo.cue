package dodfiles

import (
	"github.com/oclaussen/dodfiles/base/pkg:base"
)

backdrops: az:
	base.#WithDockerfile &
	base.#WithRepository & {
		image: {
			name: "dodo/azure"
			requires: ["dodo/base"]
		}
		volumes: azure: {source: "azure-data", target: "/root/.azure"}
		script: "exec az \"$@\""
	}
