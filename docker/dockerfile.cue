package dodfiles

import (
	"github.com/oclaussen/dodfiles/base/pkg:base"
	"github.com/oclaussen/dodfiles/gpg/pkg:gpg"
)

actions:
	base.#BaseImage &
	base.#WithDotfiles &
	base.#InstallDormouse &
	gpg.#InstallPass & {
		env: {
			type: "environment"
			variables: DOCKER_TLS_CERTDIR: "/certs"
		}

		packages: {
			type: "install"
			name: "btrfs-progs e2fsprogs iptables iproute2 openssl xfsprogs gnupg git"
		}

		docker: {
			type:        "fetch"
			source:      "https://download.docker.com/linux/static/stable/{{ archLike `x86_64` `aarch64` }}/docker-26.1.4.tgz"
			unpack:      "docker/docker"
			destination: "/bin/docker"
		}
		// TODO: same for ctr, runc, containerd-shim, docker-init, docker-proxy, dockerd, containerd

		ctop: {
			type: "eget"
			repo: "bcicen/ctop"
		}

		buildx: {
			type: "eget"
			repo: "docker/buildx"
			asset: ["^.sbom.json", "^.provenance.json"]
		}

		ecrhelper: {
			type:        "fetch"
			source:      "https://amazon-ecr-credential-helper-releases.s3.us-east-2.amazonaws.com/0.8.0/linux-{{ arch }}/docker-credential-ecr-login"
			destination: "/bin/docker-credential-ecr-login"
		}

		gpghome: {
			type:  "copy"
			path:  "/root/.gnupg"
			image: "dodo/gpg"
		}

		awsconfig: {
			type:  "copy"
			path:  "/root/.aws"
			image: "dodo/aws"
		}

		setup: {
			type: "script"
			script: """
				mkdir /certs /certs/client
				chmod 1777 /certs /certs/client
				mkdir /run/user
				chmod 1777 /run/user
				mkdir -p /root/.local/share/docker

				"""
		}
	}
