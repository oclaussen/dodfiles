package dodfiles

import (
	"github.com/oclaussen/dodfiles/base/pkg:base"
	"github.com/oclaussen/dodfiles/gpg/pkg:gpg"
)

#arch: "amd64"

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
			type: "eget"
			repo: "github/hub"
		}

		lab: {
			type: "eget"
			repo: "zaquestion/lab"
		}

		terraform: {
			type:        "fetch"
			source:      "https://releases.hashicorp.com/terraform/1.9.8/terraform_1.9.8_linux_\(#arch).zip"
			unpack:      "terraform"
			destination: "/bin/terraform"
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
	}
