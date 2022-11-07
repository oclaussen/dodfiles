package dodfiles

import (
	"github.com/oclaussen/dodfiles/base/pkg:base"
	"github.com/oclaussen/dodfiles/gpg/pkg:gpg"
)

backdrops: isync:
	base.#WithDockerfile &
	gpg.#WithPasswordStore &
	gpg.#WithSSHAgent & {
		aliases: ["mbsync"]
		image: {
			name: "dodo/isync"
			requires: ["dodo/base"]
		}
		volumes: mail: {source: "mail", target: "/data/mail"}
		script: """
			  mkdir -p /data/mail/gmail/Inbox
			  exec mbsync \"$@\"
			"""
	}
