package dodfiles

import (
	"github.com/oclaussen/dodfiles/base/pkg:base"
)

actions:
	base.#BaseImage & {
		syft: {
			type: "eget"
			repo: "anchore/syft"
			asset: [".tar.gz"]
		}
	}
