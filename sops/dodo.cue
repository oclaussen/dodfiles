package dodfiles

import (
	"github.com/oclaussen/dodfiles/base/pkg:base"
	"github.com/oclaussen/dodfiles/gpg/pkg:gpg"
	"github.com/oclaussen/dodfiles/aws/pkg:aws"
)

backdrops: sops:
	base.#WithDockerfile &
	base.#WithRepository &
	gpg.#WithPasswordStore &
	aws.#WithAWSCache & {
		image: {
			name: "dodo/sops"
			requires: ["dodo/base", "dodo/gpg"]
		}
		script: "exec sops \"$@\""
	}
