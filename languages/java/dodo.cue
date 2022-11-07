package dodfiles

import "github.com/oclaussen/dodfiles/base/pkg:base"

backdrops: {
	java8:
		base.#WithRepository & {
			image: {
				name: "dodo/languages/java8"
				requires: ["dodo/base", "dodo/languages/buildbase"]
				context:    "{{ currentDir }}"
				dockerfile: "{{ currentDir }}/Dockerfile.8"
			}
			script: "exec java \"$@\""
		}

	java11:
		base.#WithRepository & {
			aliases: ["java"]
			image: {
				name: "dodo/languages/java11"
				requires: ["dodo/base", "dodo/languages/buildbase"]
				context:    "{{ currentDir }}"
				dockerfile: "{{ currentDir }}/Dockerfile.11"
			}
			script: "exec java \"$@\""
		}
}
