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
		packages: {
			type: "install"
			name: "git gnupg"
		}

		env: {
			type: "environment"
			variables: PATH: "/opt/python/bin"
		}

		prowler: {
			type: "copy"
			path: "/opt/python"
			dockerfile: """
				FROM dodo/languages/buildbase
				COPY --from=dodo/languages/python /opt/python /opt/python
				COPY --from=dodo/languages/rust /opt/rust /opt/rust
				ENV RUSTUP_HOME=/opt/rust/rustup CARGO_HOME=/opt/rust/cargo
				ENV PATH /opt/python/bin:${CARGO_HOME}/bin:$PATH
				RUN apt-get update && apt-get install -y clang cmake libssl-dev make pkg-config
				RUN pip3 install prowler

				"""
		}

		awsvault: {
			type:        "fetch"
			source:      "https://github.com/99designs/aws-vault/releases/download/v6.6.0/aws-vault-linux-\(#arch)"
			destination: "/bin/aws-vault"
		}

		gpghome: {
			type:  "copy"
			path:  "/home/dodo/.gnupg"
			image: "dodo/gpg"
		}

		awsconfig: {
			type:  "copy"
			path:  "/home/dodo/.aws"
			image: "dodo/aws"
		}
	}
