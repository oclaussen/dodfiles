package dodfiles

import (
	"github.com/oclaussen/dodfiles/base/pkg:base"
)

actions:
	base.#BaseImage & {
		wrangler: {
			type: "nodejs"
			modules: ["wrangler"]
		}
	}
