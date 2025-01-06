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
				PATH:       "/root/.krew/bin:/opt/python/bin:/usr/local/bin"
				KUBECONFIG: "/root/.kube/context.yaml:/root/.kubeconfig:/root/.kube/config"
			}
		}

		kubectl: {
			type:        "fetch"
			source:      "https://storage.googleapis.com/kubernetes-release/release/v1.30.0/bin/linux/{{ arch }}/kubectl"
			destination: "/bin/kubectl"
		}

		k9s: {
			type: "eget"
			repo: "derailed/k9s"
			asset: [".tar.gz", "^.sbom.json"]
		}

		popeye: {
			type: "eget"
			repo: "derailed/popeye"
			asset: [".tar.gz", "^.sbom.json"]
		}

		kind: {
			type: "eget"
			repo: "kubernetes-sigs/kind"
		}

		helm: {
			type:        "fetch"
			source:      "https://get.helm.sh/helm-v3.15.1-linux-{{ arch }}.tar.gz"
			unpack:      "linux-{{ arch }}/helm"
			destination: "/bin/helm"
		}

		kustomize: {
			type: "eget"
			repo: "kubernetes-sigs/kustomize"
		}

		flux: {
			type: "eget"
			repo: "fluxcd/flux2"
		}

		crictl: {
			type: "eget"
			repo: "kubernetes-sigs/cri-tools"
			asset: ["crictl", "^sha512"]
		}

		kubescape: {
			type: "eget"
			repo: "armosec/kubescape"
			asset: ["^sbom", "^tar.gz"]
		}

		linkerd: {
			type: "eget"
			repo: "linkerd/linkerd2"
		}

		kubeseal: {
			type: "eget"
			repo: "bitnami-labs/sealed-secrets"
			asset: ["^.sig"]
			file: "kubeseal"
		}

		docker: {
			type:        "fetch"
			source:      "https://download.docker.com/linux/static/stable/{{ archLike `x86_64` `aarch64` }}/docker-26.1.4.tgz"
			unpack:      "docker/docker"
			destination: "/bin/docker"
		}

		krew: {
			type:       "copy"
			path:       "/root/.krew"
			dockerfile: """
				FROM debian:buster-slim

				RUN apt-get update && apt-get -y install curl git

				RUN curl -L -o /bin/kubectl \\
				    https://storage.googleapis.com/kubernetes-release/release/v1.14.0/bin/linux/{{ arch }}/kubectl \\
				 && chmod +x /bin/kubectl

				RUN curl -L -o /tmp/krew.tar.gz \\
				    https://github.com/kubernetes-sigs/krew/releases/download/v0.4.4/krew-linux_{{ arch }}.tar.gz \\
				 && tar -xzf /tmp/krew.tar.gz -C /tmp \\
				 && curl -L -o /tmp/krew.yaml \\
				    https://github.com/kubernetes-sigs/krew/releases/download/v0.4.4/krew.yaml

				RUN /tmp/krew-linux_{{ arch }} install --archive /tmp/krew.tar.gz --manifest /tmp/krew.yaml
				ENV PATH /root/.krew/bin:${PATH}

				RUN kubectl krew update \\
				 && kubectl krew install ctx \\
				 && kubectl krew install ns \\
				 && kubectl krew install neat \\
				 && kubectl krew install view-secret \\
				 && kubectl krew install cert-manager

				"""
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
	}
