package dodfiles

import (
	"github.com/oclaussen/dodfiles/base/pkg:base"
	"github.com/oclaussen/dodfiles/chirp/pkg:chirp"
)

actions:
	base.#BaseImage &
	base.#WithDotfiles &
	chirp.#InstallChirp & {
		packages: {
			type: "install"
			name: "less man procps zsh"
		}

		env: {
			type: "environment"
			variables: {
				RUSTUP_HOME: "/opt/rust/rustup"
				CARGO_HOME:  "/opt/rust/cargo"
				PATH:        "/opt/rust/cargo/bin:$PATH"
			}
		}

		fzf: {
			type: "eget"
			repo: "junegunn/fzf"
		}

		tools: {
			type: "copy"
			path: "/opt/rust"
			dockerfile: """
				FROM dodo/languages/rust
				ENV RUSTUP_HOME=/opt/rust/rustup CARGO_HOME=/opt/rust/cargo
				ENV PATH ${CARGO_HOME}/bin:$PATH

				RUN apt-get update && apt-get install -y clang cmake libssl-dev make pkg-config

				RUN cargo install \\
				    bat \\
				    exa \\
				    fd-find \\
				    procs \\
				    ripgrep \\
				    sd \\
				    starship \\
				    tokei \\
				    xsv

				"""
		}

		installdodo: {
			type: "copy"
			path: "/bin/dodo"
			dockerfile: """
				FROM dodo/languages/golang
				ENV PATH /opt/go/bin:$PATH
				WORKDIR /dodo

				RUN apt-get update && apt-get install -y git

				RUN git init \\
				 && git remote add origin https://github.com/wabenet/dodo \\
				 && git fetch origin main \\
				 && git reset --hard 83b6cba

				ADD generate.yaml .
				RUN go generate . && go build . && mv dodo /bin/dodo

				"""
		}
	}
