package dodfiles

import (
	"github.com/oclaussen/dodfiles/base/pkg:base"
	"github.com/oclaussen/dodfiles/aws/pkg:aws"
	"github.com/oclaussen/dodfiles/gpg/pkg:gpg"
)

backdrops: {
	prowler:
		base.#WithDockerfile &
		base.#WithRepository &
		base.#WithDormouse &
		gpg.#WithPasswordStore &
		aws.#WithAWSCache & {
			image: {
				name: "dodo/prowler"
				requires: ["dodo/base", "dodo/languages/python", "dodo/gpg", "dodo/pass", "dodo/aws"]
			}
		}
}
