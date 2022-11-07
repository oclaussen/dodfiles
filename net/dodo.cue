package dodfiles

import "github.com/oclaussen/dodfiles/base/pkg:base"

backdrops: {
	curl:
		base.#WithDockerfile &
		base.#WithCWD & {
			image: name: "dodo/net"
			script: "exec curl \"$@\""
		}

	dig:
		base.#WithDockerfile & {
			image: name: "dodo/net"
			script: "exec dig \"$@\""
		}

	wget:
		base.#WithDockerfile &
		base.#WithCWD & {
			image: name: "dodo/net"
			script: "exec wget \"$@\""
		}

	traceroute:
		base.#WithDockerfile & {
			image: name: "dodo/net"
			script: "exec traceroute \"$@\""
		}

	iperf:
		base.#WithDockerfile & {
			image: name: "dodo/net"
			script: "exec iperf3 \"$@\""
		}

	checkip:
		base.#WithDockerfile & {
			image: name: "dodo/net"
			script: "exec checkip \"$@\""
		}
}
