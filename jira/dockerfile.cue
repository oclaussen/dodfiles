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

		jira: {
			type: "eget"
			repo: "go-jira/jira"
		}

		gpghome: {
			type:  "copy"
			path:  "/home/dodo/.gnupg"
			image: "dodo/gpg"
		}

		passconfig: {
			type:  "copy"
			path:  "/home/dodo/.config/gopass"
			image: "dodo/pass"
		}

		jiraui: {
			type: "copy"
			path: "/bin/jira-ui"
			dockerfile: """
				FROM dodo/languages/golang
				ENV PATH /opt/go/bin:$PATH
				RUN apt-get update && apt-get -y install git
				RUN git clone https://github.com/mikepea/go-jira-ui /jira-ui
				WORKDIR /jira-ui
				RUN go build -o bin/jira-ui ./jira-ui \\
				 && cp ./bin/* /bin/

				"""
		}
	}
