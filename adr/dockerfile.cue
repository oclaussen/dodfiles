package dodfiles

import (
	"github.com/oclaussen/dodfiles/base/pkg:base"
)

actions:
	base.#BaseImage & {
		packages: {
			type: "install"
			name: "git vim"
		}

		install: {
			type: "script"
			script: """
				  git clone https://github.com/npryce/adr-tools.git /tmp/adr-tools
				  cp /tmp/adr-tools/src/* /bin
				  rm -r /tmp/adr-tools
				"""
		}
	}
