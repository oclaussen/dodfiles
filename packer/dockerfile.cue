package dodfiles

import (
	"github.com/oclaussen/dodfiles/base/pkg:base"
	"github.com/oclaussen/dodfiles/gpg/pkg:gpg"
)

#arch: "amd64"

actions:
	base.#BaseImage &
	gpg.#InstallPass & {
		packages: {
			type: "install"
			name: "gettext git gnupg libyaml-0-2 openssh-client sshpass zip"
		}

		packer: {
			type:        "fetch"
			source:      "https://releases.hashicorp.com/packer/1.7.2/packer_1.7.2_linux_\(#arch).zip"
			unpack:      "packer"
			destination: "/bin/packer"
		}

		ansible: {
			type: "python"
			build_dependencies: ["cargo", "clang", "cmake", "libssl-dev", "make", "pkg-config"]
			pip_packages: ["ansible", "pywinrm"]
		}

		kitchen: {
			type: "ruby"
                        build_dependencies: ["make", "gcc", "libffi-dev", "libyaml-dev"]
			gems : ["psych", "kitchen", "kitchen-ec2", "awspec", "kitchen-verifier-awspec", "inspec", "kitchen-inspec"]
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

		awsconfig: {
			type:  "copy"
			path:  "/root/.aws"
			image: "dodo/aws"
		}
	}
