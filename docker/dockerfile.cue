package dodfiles

import (
	"github.com/oclaussen/dodfiles/base/pkg:base"
)

actions:
	base.#BaseImage &
	base.#WithDotfiles &
	base.#InstallDormouse & {
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
			source:      "https://download.docker.com/linux/static/stable/x86_64/docker-26.1.4.tgz"
			unpack:      "docker/docker"
			destination: "/bin/docker"
		}
		// TODO: same for ctr, runc, containerd-shim, docker-init, docker-proxy, dockerd, containerd

		ctop: {
			type:        "fetch"
			source:      "https://github.com/bcicen/ctop/releases/download/v0.7.7/ctop-0.7.7-linux-amd64"
			destination: "/bin/ctop"
		}

		buildx: {
			type:        "fetch"
			source:      "https://github.com/docker/buildx/releases/download/v0.14.1/buildx-v0.14.1.linux-amd64"
			destination: "/usr/lib/docker/cli-plugins/docker-buildx"
		}

		pass: {
			type:        "fetch"
			source:      "https://github.com/gopasspw/gopass/releases/download/v1.14.3/gopass-1.14.3-linux-amd64.tar.gz"
			unpack:      "gopass"
			destination: "/bin/gopass"
		}

		awsvault: {
			type:        "fetch"
			source:      "https://github.com/99designs/aws-vault/releases/download/v6.6.0/aws-vault-linux-amd64"
			destination: "/bin/aws-vault"
		}

		ecrhelper: {
			type:        "fetch"
			source:      "https://amazon-ecr-credential-helper-releases.s3.us-east-2.amazonaws.com/0.8.0/linux-amd64/docker-credential-ecr-login"
			destination: "/bin/docker-credential-ecr-login"
		}

		gpghome: {
			type:  "copy"
			path:  "/home/dodo/.gnupg"
			image: "dodo/gpg"
		}

		awsconfig: {
			type:  "copy"
			path:  "/home/dodo/.aws"
			image: "dodo/aws"
		}

		setup: {
			type: "script"
			script: """
				mkdir /certs /certs/client
				chmod 1777 /certs /certs/client
				mkdir /run/user
				chmod 1777 /run/user
				mkdir -p /home/dodo/.local/share/docker
				chown -R dodo:dodo /home/dodo/.local/share/docker

				"""
		}
	}
