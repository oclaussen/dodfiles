package dodfiles

import (
	"github.com/oclaussen/dodfiles/base/pkg:base"
	"github.com/oclaussen/dodfiles/aws/pkg:aws"
)

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

		sessionmanager: {
			type:        "fetch"
			source:      "https://s3.amazonaws.com/session-manager-downloads/plugin/latest/ubuntu_{{ arch }}/session-manager-plugin.deb"
			destination: "/tmp/session-manager-plugin.deb"
		}

		installsessionmanager: {
			type:   "script"
			script: "dpkg -i /tmp/session-manager-plugin.deb"
		}

		boto: {
			type: "python"
			pip_packages: ["boto3"]
		}
	}
