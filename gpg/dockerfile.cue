package dodfiles

import (
	"github.com/oclaussen/dodfiles/base/pkg:base"
)

actions:
	base.#BaseImage &
	base.#WithDotfiles & {
		packages: {
			type: "install"
			name: "libccid scdaemon gnupg libncurses6 libpcsclite1 pinentry-tty procps usbutils"
		}

		env: {
			type: "environment"
			variables: PATH: "/opt/pcsc/bin:/opt/pcsc/sbin:/opt/python/bin:/home/dodo/bin"
		}

		pcsc: {
			type: "copy"
			path: "/opt/pcsc"
			dockerfile: """
				FROM dodo/base AS build

				RUN apt-get update \\
				 && apt-get -y install \\
				    build-essential \\
				    autoconf-archive \\
				    automake \\
				    flex \\
				    git \\
				    libtool \\
				    pkg-config \\
				    libpcsclite-dev \\
				    libusb-1.0.0-dev \\
				    zlib1g-dev

				RUN git clone https://salsa.debian.org/rousseau/pcsc.git /pcsc
				WORKDIR /pcsc
				RUN ./bootstrap \\
				 && ./configure \\
				        --prefix=/opt/pcsc \\
				        --enable-libusb \\
				        --disable-libsystemd \\
				        --disable-libudev \\
				        --disable-polkit \\
				 && make \\
				 && make install

				RUN git clone --recursive https://salsa.debian.org/rousseau/ccid.git /ccid
				WORKDIR /ccid
				RUN ./bootstrap \\
				 && ./configure \\
				        --enable-usbdropdir=/opt/pcsc/lib/pcsc/drivers \\
				 && make \\
				 && make install

				"""
		}
	}
