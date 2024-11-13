package dodfiles

import "github.com/oclaussen/dodfiles/base/pkg:base"

backdrops: {
	java: {
		base.#WithLegacyDockerfile &
		base.#WithRepository & {
			image: {
				name:     "dodo/languages/java"
				requires: "dodo/base"
			}
			script: "exec java \"$@\""
		}
	}

	scala: {
		base.#WithLegacyDockerfile & {
			image: {
				name:     "dodo/languages/java"
				requires: "dodo/base"
			}
			interactive: true
		}
	}

	sbt:
		base.#WithLegacyDockerfile &
		base.#WithRepository & {
			image: {
				name:     "dodo/languages/java"
				requires: "dodo/base"
			}
			volumes: sbt: {source: "sbt-cache", target: "/root"}
			script: "exec sbt \"$@\""
		}
}
