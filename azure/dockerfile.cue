package dodfiles

import (
	"github.com/oclaussen/dodfiles/base/pkg:base"
)

#arch: "amd64"

actions:
	base.#BaseImage & {
		packages: {
			type: "install"
			name: "azure-cli"
			repo: "deb [arch=\(#arch)] https://packages.microsoft.com/repos/azure-cli/ buster main"
			gpg:  "https://packages.microsoft.com/keys/microsoft.asc"
		}
	}
