package dodfiles

import (
	"github.com/oclaussen/dodfiles/base/pkg:base"
)

actions:
	base.#BaseImage &
	base.#WithDotfiles &
	base.#WithLocalFiles & {
		packages: {
			type: "install"
			name: "cron libsqlite3-0 vim"
		}

		khal: {
			type: "python"
			pip_packages: ["khal", "vdirsyncer", "requests-oauthlib"]
		}

		setup: {
			type: "script"
			script: """
				  chmod u+s /usr/sbin/cron
				  cp /usr/share/zoneinfo/Europe/Berlin /etc/localtime
				  echo Europe/Berlin > /etc/timezone
				"""
		}
	}
