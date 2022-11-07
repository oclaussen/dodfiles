package dodfiles

import "github.com/oclaussen/dodfiles/base/pkg:base"

backdrops: {
	mysql:
		base.#WithDockerfile &
		base.#WithCWD & {
			image: name: "dodo/databases"
			script: "exec mysql \"$@\""
		}

	psql:
		base.#WithDockerfile &
		base.#WithCWD & {
			image: name: "dodo/databases"
			script: "exec psql \"$@\""
		}

	pg_dump:
		base.#WithDockerfile &
		base.#WithCWD & {
			image: name: "dodo/databases"
			script: "exec pg_dump \"$@\""
		}

	pg_restore:
		base.#WithDockerfile &
		base.#WithCWD & {
			image: name: "dodo/databases"
			script: "exec pg_restore \"$@\""
		}
}
