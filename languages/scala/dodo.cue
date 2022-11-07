package dodfiles

import "github.com/oclaussen/dodfiles/base/pkg:base"

backdrops: {
	scala:
		base.#WithDockerfile & {
			image: {
				name: "dodo/languages/scala"
				requires: ["dodo/base"]
			}
			interactive: true
		}

	sbt:
		base.#WithDockerfile &
		base.#WithRepository & {
			image: {
				name: "dodo/languages/scala"
				requires: ["dodo/base"]
			}
			volumes: sbt: {source: "sbt-cache", target: "/root"}
			script: "exec sbt \"$@\""
		}
}
