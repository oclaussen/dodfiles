package dodfiles

import (
	"github.com/oclaussen/dodfiles/base/pkg:base"
	"github.com/oclaussen/dodfiles/gpg/pkg:gpg"
	"github.com/oclaussen/dodfiles/aws/pkg:aws"
)

actions:
	base.#BaseImage &
	base.#WithDotfiles &
	gpg.#InstallPass &
	aws.#InstallAWSCLI & {
		packages: {
			type: "install"
			name: "git gnupg ncurses-bin vim unzip"
		}

		env: {
			type: "environment"
			variables: {
				PATH:       "/home/dodo/.krew/bin:/opt/python/bin:/usr/local/bin"
				KUBECONFIG: "/home/dodo/.kube/context.yaml:/home/dodo/.kubeconfig:/home/dodo/.kube/config"
			}
		}

		kubectl: {
			type:        "fetch"
			source:      "https://storage.googleapis.com/kubernetes-release/release/v1.30.0/bin/linux/amd64/kubectl"
			destination: "/bin/kubectl"
		}

		k9s: {
			type:        "fetch"
			source:      "https://github.com/derailed/k9s/releases/download/v0.32.4/k9s_Linux_amd64.tar.gz"
			unpack:      "k9s"
			destination: "/bin/k9s"
		}

		popeye: {
			type:        "fetch"
			source:      "https://github.com/derailed/popeye/releases/download/v0.21.3/popeye_Linux_amd64.tar.gz"
			unpack:      "popeye"
			destination: "/bin/popeye"
		}

		kind: {
			type:        "fetch"
			source:      "https://github.com/kubernetes-sigs/kind/releases/download/v0.23.0/kind-linux-amd64"
			destination: "/bin/kind"
		}

		helm: {
			type:        "fetch"
			source:      "https://get.helm.sh/helm-v3.15.1-linux-amd64.tar.gz"
			unpack:      "linux-amd64/helm"
			destination: "/bin/helm"
		}

		kustomize: {
			type:        "fetch"
			source:      "https://github.com/kubernetes-sigs/kustomize/releases/download/kustomize%2Fv5.4.2/kustomize_v5.4.2_linux_amd64.tar.gz"
			unpack:      "kustomize"
			destination: "/bin/kustomize"
		}

		flux: {
			type:        "fetch"
			source:      "https://github.com/fluxcd/flux2/releases/download/v2.3.0/flux_2.3.0_linux_amd64.tar.gz"
			unpack:      "flux"
			destination: "/bin/flux"
		}

		crictl: {
			type:        "fetch"
			source:      "https://github.com/kubernetes-sigs/cri-tools/releases/download/v1.30.0/crictl-v1.30.0-linux-amd64.tar.gz"
			unpack:      "crictl"
			destination: "/bin/crictl"
		}

		kubescape: {
			type:        "fetch"
			source:      "https://github.com/armosec/kubescape/releases/download/v3.0.11/kubescape-ubuntu-latest"
			destination: "/bin/kubescape"
		}

		linkerd: {
			type:        "fetch"
			source:      "https://github.com/linkerd/linkerd2/releases/download/stable-2.24.10/linkerd2-cli-stable-2.24.10-linux-amd64"
			destination: "/bin/linkerd"
		}

		kubeseal: {
			type:        "fetch"
			source:      "https://github.com/bitnami-labs/sealed-secrets/releases/download/v0.26.3/kubeseal-0.26.3-linux-amd64.tar.gz"
			unpack:      "kubeseal"
			destination: "/bin/kubeseal"
		}

		docker: {
			type:        "fetch"
			source:      "https://download.docker.com/linux/static/stable/x86_64/docker-26.1.4.tgz"
			unpack:      "docker/docker"
			destination: "/bin/docker"
		}

		krew: {
			type: "copy"
			path: "/home/dodo/.krew"
			dockerfile: """
				FROM dodo/base

				RUN apt-get update && apt-get -y install curl git

				RUN curl -L -o /bin/kubectl \\
				    https://storage.googleapis.com/kubernetes-release/release/v1.14.0/bin/linux/amd64/kubectl \\
				 && chmod +x /bin/kubectl

				RUN curl -L -o /tmp/krew.tar.gz \\
				    https://github.com/kubernetes-sigs/krew/releases/download/v0.4.4/krew-linux_amd64.tar.gz \\
				 && tar -xzf /tmp/krew.tar.gz -C /tmp \\
				 && curl -L -o /tmp/krew.yaml \\
				    https://github.com/kubernetes-sigs/krew/releases/download/v0.4.4/krew.yaml

				RUN addgroup \\
				      --gid 1000 \\
				      dodo \\
				 && adduser \\
				      --uid 501 \\
				      --gid 1000 \\
				      --gecos '' \\
				      --home /home/dodo \\
				      --shell /bin/bash \\
				      --disabled-password \\
				      dodo \\
				 && adduser dodo users

				USER dodo
				RUN /tmp/krew-linux_amd64 install --archive /tmp/krew.tar.gz --manifest /tmp/krew.yaml
				ENV PATH /home/dodo/.krew/bin:${PATH}

				RUN kubectl krew update \\
				 && kubectl krew install tree \\
				 && kubectl krew install ctx \\
				 && kubectl krew install ns \\
				 && kubectl krew install neat \\
				 && kubectl krew install view-secret \\
				 && kubectl krew install cert-manager

				"""
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
	}
