package dodfiles

import "github.com/oclaussen/dodfiles/base/pkg:base"

backdrops: {
	ldapsearch:
		base.#WithDockerfile &
		base.#WithCWD & {
			image: name: "dodo/ldap"
			script: "exec ldapsearch \"$@\""
		}
                }
