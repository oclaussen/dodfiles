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
			type: "eget"
			repo: "mikefarah/yq"
			asset: ["^.tar.gz"]
		}
	}
