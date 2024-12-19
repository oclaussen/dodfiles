package dodfiles

import (
	"github.com/oclaussen/dodfiles/base/pkg:base"
	"github.com/oclaussen/dodfiles/gpg/pkg:gpg"
)

backdrops: jira:
	base.#WithDockerfile &
	base.#WithRepository &
	gpg.#WithPasswordStore & {
		image: {
			name: "dodo/jira"
			requires: ["dodo/base", "dodo/languages/golang"]
		}
		volumes: jira: {source: "jira-data", target: "/root/.jira.d"}
		script: """
			  cp /root/.jira.yml /root/.jira.d/config.yml
			  exec jira \"$@\"
			"""
	}
