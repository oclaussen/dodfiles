package dodfiles

import (
	"github.com/oclaussen/dodfiles/base/pkg:base"
)

actions:
	base.#BaseImage & {
		croc: {
			type:        "fetch"
			source:      "https://github.com/schollz/croc/releases/download/v8.3.2/croc_8.3.2_Linux-64bit.tar.gz"
			unpack:      "croc"
			destination: "/bin/croc"
		}
	}
