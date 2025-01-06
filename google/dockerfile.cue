package dodfiles

import (
	"github.com/oclaussen/dodfiles/base/pkg:base"
	"github.com/oclaussen/dodfiles/gpg/pkg:gpg"
	"github.com/oclaussen/dodfiles/google/pkg:google"
)

actions:
	base.#BaseImage &
	base.#WithDotfiles &
	gpg.#InstallPass &
	google.#InstallGoogleSDK & {
		packages: {
			type: "install"
			name: "git gnupg gzip libsqlite3-0 xz-utils"
		}

		gam: {
			type:        "fetch"
			source:      "https://github.com/GAM-team/GAM/releases/download/v6.58/gam-6.58-{{ os }}-{{ archLike `x86_64` `aarch64` }}-legacy.tar.xz"
			destination: "/tmp/gam.tar.xz"
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

		installgam: {
			type: "script"
			cwd:  "/root"
			script: """
				tar -xvf /tmp/gam.tar.xz -C .
				touch gam/noshorturls.txt

				"""
		}
	}
