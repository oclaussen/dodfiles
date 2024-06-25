package dodfiles

import "github.com/oclaussen/dodfiles/base/pkg:base"

backdrops: {
	java: {
		base.#WithRepository & {
			image: {
				name:       "dodo/languages/java"
				requires:   "dodo/base"
				context:    "{{ currentDir }}"
				dockerfile: "{{ currentDir }}/Dockerfile"
			}
			script: "exec java \"$@\""
		}
	}

	scala: {
		image: {
			name:       "dodo/languages/java"
			requires:   "dodo/base"
			context:    "{{ currentDir }}"
			dockerfile: "{{ currentDir }}/Dockerfile"
		}
		interactive: true
	}

	sbt:
		base.#WithRepository & {
			image: {
				name:       "dodo/languages/java"
				requires:   "dodo/base"
				context:    "{{ currentDir }}"
				dockerfile: "{{ currentDir }}/Dockerfile"
			}
			volumes: sbt: {source: "sbt-cache", target: "/root"}
			script: "exec sbt \"$@\""
		}
}
