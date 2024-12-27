package dodfiles

import (
	"github.com/oclaussen/dodfiles/base/pkg:base"
)

actions:
	base.#BaseImage &
	base.#WithDotfiles & {
		packages: {
			type: "install"
			name: "git"
		}

		copier: {
			type: "python"
			pip_packages: ["copier", "copier-templates-extensions", "jinja2-time"]
		}
	}
