package dodfiles

import (
	"github.com/oclaussen/dodfiles/base/pkg:base"
)

actions:
	base.#BaseImage & {
		packages: {
			type: "install"
			name: "curl dnsutils iperf3 traceroute wget"
		}

		checkip: {
			type:        "fetch"
			source:      "https://github.com/jreisinger/checkip/releases/download/v0.24.5/checkip_0.24.5_linux_amd64.tar.gz"
			unpack:      "checkip"
			destination: "/bin/checkip"
		}
	}
