package dodfiles

import (
	"github.com/oclaussen/dodfiles/base/pkg:base"
	"github.com/oclaussen/dodfiles/gpg/pkg:gpg"
)

actions:
	base.#BaseImage &
	base.#WithDotfiles &
	base.#InstallDormouse &
	gpg.#InstallPass & {
		env: {
			type: "environment"
			variables: PATH: "/opt/python/bin"
		}

		packages: {
			type: "install"
			name: "git git-lfs gnupg openssh-client less vim shellcheck"
		}

		precommit: {
			type: "copy"
			path: "/opt/python"
			dockerfile: """
				FROM dodo/languages/python
				ENV PATH /opt/python/bin:$PATH
				RUN pip3 install pre-commit checkov

				"""
		}

		cloudflared: {
			type: "install"
			name: "cloudflared"
			repo: "deb https://pkg.cloudflare.com/cloudflared bullseye main"
			gpg:  "https://pkg.cloudflare.com/cloudflare-main.gpg"
		}

		hub: {
			type:        "fetch"
			source:      "https://github.com/github/hub/releases/download/v2.14.2/hub-linux-amd64-2.14.2.tgz"
			unpack:      "hub-linux-amd64-2.14.2/bin/hub"
			destination: "/bin/hub"
		}

		lab: {
			type:        "fetch"
			source:      "https://github.com/zaquestion/lab/releases/download/v0.20.0/lab_0.20.0_linux_amd64.tar.gz"
			unpack:      "lab"
			destination: "/bin/lab"
		}

		terraform: {
			type:        "fetch"
			source:      "https://releases.hashicorp.com/terraform/1.9.8/terraform_1.9.8_linux_amd64.zip"
			unpack:      "terraform"
			destination: "/bin/terraform"
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
	}
