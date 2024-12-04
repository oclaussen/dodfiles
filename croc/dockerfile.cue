package dodfiles

import (
	"github.com/oclaussen/dodfiles/base/pkg:base"
)

actions:
	base.#BaseImage & {
		croc: {
			type: "eget"
			repo: "schollz/croc"
		}
	}
