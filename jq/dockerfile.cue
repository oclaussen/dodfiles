package dodfiles

import (
	"github.com/oclaussen/dodfiles/base/pkg:base"
)

actions:
	base.#BaseImage & {
		packages: {
			type: "install"
			name: "jq"
		}

		yq: {
			type:        "fetch"
			source:      "https://github.com/mikefarah/yq/releases/download/v4.22.1/yq_linux_amd64"
			destination: "/bin/yq"
		}
	}
