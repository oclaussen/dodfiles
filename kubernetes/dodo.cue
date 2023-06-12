package dodfiles

import (
	"github.com/oclaussen/dodfiles/base/pkg:base"
	"github.com/oclaussen/dodfiles/kubernetes/pkg:kube"
)

backdrops: {
	kubectl:
		base.#WithDockerfile &
		base.#WithRepository &
		kube.#WithKubeconfig & {
			image: {
				name: "dodo/kube"
				requires: ["dodo/base", "dodo/gpg", "dodo/aws"]
			}
			script: """
				  test -f /home/dodo/.kube/context.yaml || cp /home/dodo/context.yaml /home/dodo/.kube/context.yaml
				  if [ \"$1\" = \"debug\" ]; then
				    shift
				    exec kubectl run -i --rm --tty debug --image=alpine:latest --restart=Never \"$@\" -- sh
				  else
				    exec /bin/kubectl \"$@\"
				  fi
				"""
		}

	helm:
		base.#WithDockerfile &
		base.#WithRepository &
		kube.#WithKubeconfig &
		kube.#WithHelmCache & {
			image: {
				name: "dodo/kube"
				requires: ["dodo/base", "dodo/gpg", "dodo/aws"]
			}
			script: "exec /bin/helm \"$@\""
		}

	kustomize:
		base.#WithDockerfile &
		base.#WithRepository &
		kube.#WithKubeconfig & {
			image: {
				name: "dodo/kube"
				requires: ["dodo/base", "dodo/gpg", "dodo/aws"]
			}
			script: """
				  test -f /home/dodo/.kube/context.yaml || cp /home/dodo/context.yaml /home/dodo/.kube/context.yaml
				  exec kustomize \"$@\"
				"""
		}

	k9s:
		base.#WithDockerfile &
		kube.#WithKubeconfig & {
			container_name: "k9s"
			image: {
				name: "dodo/kube"
				requires: ["dodo/base", "dodo/gpg", "dodo/aws"]
			}
			ports: ["8080:8080"]
			script: "exec /bin/k9s \"$@\""
		}

	crictl:
		base.#WithDockerfile & {
			image: {
				name: "dodo/kube"
				requires: ["dodo/base", "dodo/gpg", "dodo/aws"]
			}
			volumes: containerd: {source: "/run/containerd/containerd.sock", target: "/run/containerd/containerd.sock"}
			script: "exec /bin/crictl \"$@\""
		}

	flux:
		base.#WithDockerfile &
		kube.#WithKubeconfig & {
			image: {
				name: "dodo/kube"
				requires: ["dodo/base", "dodo/gpg", "dodo/aws"]
			}
			script: "exec /bin/flux \"$@\""
		}

	linkerd:
		base.#WithDockerfile &
		kube.#WithKubeconfig & {
			image: {
				name: "dodo/kube"
				requires: ["dodo/base", "dodo/gpg", "dodo/aws"]
			}
			script: "exec /bin/linkerd \"$@\""
		}

	kubeseal:
		base.#WithDockerfile &
		kube.#WithKubeconfig & {
			image: {
				name: "dodo/kube"
				requires: ["dodo/base", "dodo/gpg", "dodo/aws"]
			}
			script: "exec /bin/kubeseal \"$@\""
		}

	popeye:
		base.#WithDockerfile &
		kube.#WithKubeconfig & {
			image: {
				name: "dodo/kube"
				requires: ["dodo/base", "dodo/gpg", "dodo/aws"]
			}
			script: "exec /bin/popeye \"$@\""
		}

	kubescape:
		base.#WithDockerfile &
		kube.#WithKubeconfig & {
			image: {
				name: "dodo/kube"
				requires: ["dodo/base", "dodo/gpg", "dodo/aws"]
			}
			script: "exec /bin/kubescape \"$@\""
		}
}
