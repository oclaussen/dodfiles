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
			type:        "fetch"
			source:      "https://github.com/jreisinger/checkip/releases/download/v0.24.5/checkip_0.24.5_linux_\(#arch).tar.gz"
			unpack:      "checkip"
			destination: "/bin/checkip"
		}
	}
