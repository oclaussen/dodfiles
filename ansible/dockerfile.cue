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

		env: {
			type: "environment"
			variables: PATH: "/opt/python/bin"
		}

		sops: {
			type: "eget"
			repo: "mozilla/sops"
			asset: ["^.sbom.json"]
		}

		ansible: {
			type: "copy"
			path: "/opt/python"
			dockerfile: """
				FROM dodo/base
				COPY --from=dodo/languages/python /opt/python /opt/python
				COPY --from=dodo/languages/rust /opt/rust /opt/rust
				ENV RUSTUP_HOME=/opt/rust/rustup CARGO_HOME=/opt/rust/cargo
				ENV PATH /opt/python/bin:${CARGO_HOME}/bin:$PATH
				RUN apt-get update && apt-get install -y clang cmake libssl-dev make pkg-config
				RUN pip3 install ansible pywinrm

				"""
		}

		gpghome: {
			type:  "copy"
			path:  "/root/.gnupg"
			image: "dodo/gpg"
		}
	}
