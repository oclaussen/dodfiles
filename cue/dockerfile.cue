package dodfiles

import (
	"github.com/oclaussen/dodfiles/base/pkg:base"
)

actions:
	base.#BaseImage & {
		cue: {
			type: "eget"
			repo: "cuelang/cue"
		}
	}
