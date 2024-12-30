package dodfiles

import (
	"github.com/oclaussen/dodfiles/base/pkg:base"
	"github.com/oclaussen/dodfiles/gpg/pkg:gpg"
)

actions:
	base.#BaseImage &
	base.#WithDotfiles &
	gpg.#InstallPass & {
		packages: {
			type: "install"
			name: "gnupg"
		}

		gpghome: {
			type:  "copy"
			path:  "/root/.gnupg"
			image: "dodo/gpg"
		}

		passconfig: {
			type:  "copy"
			path:  "/root/.config/gopass"
			image: "dodo/pass"
		}

		jiraui: {
			type: "golang"
			install: [
				"github.com/go-jira/jira/cmd/jira@latest",
				"github.com/mikepea/go-jira-ui/jira-ui@latest",
			]
		}
	}
