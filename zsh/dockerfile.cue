package dodfiles

import (
	"github.com/oclaussen/dodfiles/base/pkg:base"
	"github.com/oclaussen/dodfiles/chirp/pkg:chirp"
)

actions:
	base.#BaseImage &
	base.#WithDotfiles &
	base.#WithLocalFiles &
	chirp.#InstallChirp & {
		packages: {
			type: "install"
			name: "less man procps zsh"
		}

		fzf: {
			type: "eget"
			repo: "junegunn/fzf"
		}

		tools: {
			type: "rust"
			build_dependencies: ["clang", "cmake", "libssl-dev", "make", "pkg-config"]
			crates: [
				"bat",
				"exa",
				"fd-find",
				"procs",
				"ripgrep",
				"sd",
				"starship",
				"tokei",
				"xsv",
			]
		}
	}
