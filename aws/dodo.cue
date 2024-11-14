package dodfiles

import (
	"github.com/oclaussen/dodfiles/base/pkg:base"
	"github.com/oclaussen/dodfiles/aws/pkg:aws"
)

backdrops: "aws":
	base.#WithDockerfile &
	base.#WithRepository &
	base.#WithDormouse &
	aws.#WithAWSCache & {
		image: {
			name: "dodo/aws"
			requires: ["dodo/base", "dodo/languages/python"]
		}
	}
