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
		packages: {
			type: "install"
			name: "git git-lfs gnupg openssh-client less vim shellcheck"
		}

		precommit: {
			type: "python"
			pip_packages: ["pre-commit", "checkov"]
			build_dependencies: ["ca-certificates", "cargo"]
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
			source:      "https://releases.hashicorp.com/terraform/1.9.8/terraform_1.9.8_linux_{{ arch }}.zip"
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
