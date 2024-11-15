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

		env: {
			type: "environment"
			variables: PATH: "/opt/python/bin"
		}

		khal: {
			type: "copy"
			path: "/opt/python"
			dockerfile: """
				FROM dodo/languages/python
				ENV PATH /opt/python/bin:$PATH
				RUN pip3 install khal vdirsyncer requests-oauthlib

				"""
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
