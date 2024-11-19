package dodfiles

import (
	"github.com/oclaussen/dodfiles/base/pkg:base"
	"github.com/oclaussen/dodfiles/aws/pkg:aws"
)

#arch: "amd64"

actions:
	base.#BaseImage &
	base.#WithDotfiles &
	base.#WithLocalFiles &
	base.#InstallDormouse &
	aws.#InstallAWSCLI & {
		packages: {
			type: "install"
			name: "curl groff jq less unzip"
		}

		env: {
			type: "environment"
			variables: {
				PATH: "/opt/python/bin"
			}
		}

		sessionmanager: {
			type:        "fetch"
			source:      "https://s3.amazonaws.com/session-manager-downloads/plugin/latest/ubuntu_64bit/session-manager-plugin.deb"
			destination: "/tmp/session-manager-plugin.deb"
		}

		installsessionmanager: {
			type:   "script"
			script: "dpkg -i /tmp/session-manager-plugin.deb"
		}

		boto: {
			type: "copy"
			path: "/opt/python"
			dockerfile: """
				FROM dodo/languages/python
				ENV PATH /opt/python/bin:$PATH
				RUN pip3 install boto3

				"""
		}

	}
