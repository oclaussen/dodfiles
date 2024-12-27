package dodfiles

import (
	"github.com/oclaussen/dodfiles/base/pkg:base"
)

actions:
	base.#BaseImage & {
		packages: {
			type: "install"
			name: "gettext gnupg openssh-client sshpass zip"
		}

		sops: {
			type: "eget"
			repo: "mozilla/sops"
			asset: ["^.sbom.json"]
		}

		ansible: {
			type: "python"
			build_dependencies: ["cargo", "clang", "cmake", "libssl-dev", "make", "pkg-config"]
			pip_packages: ["ansible", "pywinrm"]
		}

		gpghome: {
			type:  "copy"
			path:  "/root/.gnupg"
			image: "dodo/gpg"
		}
	}
