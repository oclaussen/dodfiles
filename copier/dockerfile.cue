package dodfiles

import (
	"github.com/oclaussen/dodfiles/base/pkg:base"
)

actions:
	base.#BaseImage &
	base.#WithDotfiles & {
		env: {
			type: "environment"
			variables: PATH: "/opt/python/bin"
		}

		packages: {
			type: "install"
			name: "git"
		}

		copier: {
			type: "copy"
			path: "/opt/python"
			dockerfile: """
				FROM dodo/languages/python
				ENV PATH /opt/python/bin:$PATH
				RUN pip3 install copier

				"""
		}
	}
