package kube

import (
	"github.com/oclaussen/dodfiles/gpg/pkg:gpg"
	"github.com/oclaussen/dodfiles/aws/pkg:aws"
)

#WithKubeconfig: gpg.#WithPasswordStore & aws.#WithAWSCache & {
	volumes: {
		kube: {
			source: "kubeconfig"
			target: "/root/.kube"
		}
		...
	}
	...
}

#WithHelmCache: {
	volumes: {
		helm: {
			source: "helm"
			target: "/root/.cache/helm"
		}
		...
	}
	...
}
