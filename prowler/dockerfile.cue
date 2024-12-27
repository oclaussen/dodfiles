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
			name: "git gnupg"
		}

		prowler: {
			type: "python"
			build_dependencies: ["cargo", "clang", "cmake", "libssl-dev", "make", "pkg-config"]
			pip_packages: ["prowler"]
		}

		awsconfig: {
			type:  "copy"
			path:  "/root/.aws"
			image: "dodo/aws"
		}
	}
