package dodfiles

import (
	"github.com/oclaussen/dodfiles/base/pkg:base"
)

#arch: "amd64"

actions:
	base.#BaseImage & {
		packages: {
			type: "install"
			name: "curl dnsutils iperf3 traceroute wget"
		}

		checkip: {
			type: "eget"
			repo: "jreisinger/checkip"
		}
	}
