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
			name: "git gnupg libsqlite3-0 xz-utils"
		}

		env: {
			type: "environment"
			variables: PATH: "/opt/google-cloud-sdk/bin:/opt/python/bin"
		}

		gam: {
			type:        "fetch"
			source:      "https://github.com/GAM-team/GAM/releases/download/v6.58/gam-6.58-linux-x86_64-legacy.tar.xz"
			destination: "/tmp/gam.tar.xz"
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

		python: {
			type:  "copy"
			path:  "/opt/python"
			image: "dodo/languages/python"
		}

		installgam: {
			type: "script"
			user: "dodo"
			cwd:  "/home/dodo"
			script: """
				tar -xvf /tmp/gam.tar.xz -C .
				touch gam/noshorturls.txt

				"""
		}
	}
