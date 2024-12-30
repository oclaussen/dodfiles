package dodfiles

import (
	"github.com/oclaussen/dodfiles/base/pkg:base"
	"github.com/oclaussen/dodfiles/gpg/pkg:gpg"
	"github.com/oclaussen/dodfiles/aws/pkg:aws"
	"github.com/oclaussen/dodfiles/kubernetes/pkg:kube"
	"github.com/oclaussen/dodfiles/docker/pkg:docker"
)

backdrops: {
	terraform:
		base.#WithDockerfile &
		base.#WithRepository &
		base.#WithDormouse &
		gpg.#WithSSHAgent &
		aws.#WithAWSCache &
		kube.#WithKubeconfig &
		kube.#WithHelmCache &
		docker.#WithDockerDaemon & {
			image: {
				name: "dodo/terraform"
				requires: ["dodo/base", "dodo/gpg", "dodo/pass", "dodo/aws", "dodo/kube", "dodo/google"]
			}
			volumes: {
				terraform: {source: "terraform", target: "/data/terraform"}
				gcloud: {source: "gcloud-data", target: "/root/.config/gcloud"}
				azure: {source: "azure-data", target: "/root/.azure"}
			}
		}

	terragrunt:
		base.#WithDockerfile &
		base.#WithRepository &
		base.#WithDormouse &
		gpg.#WithSSHAgent &
		aws.#WithAWSCache &
		kube.#WithKubeconfig &
		kube.#WithHelmCache &
		docker.#WithDockerDaemon & {
			image: {
				name: "dodo/terraform"
				requires: ["dodo/base", "dodo/gpg", "dodo/pass", "dodo/aws", "dodo/kube", "dodo/google"]
			}
			environment: cache: {name: "TERRAGRUNT_DOWNLOAD", value: "/data/terraform/terragrunt-cache"}
			volumes: {
				terraform: {source: "terraform", target: "/data/terraform"}
				gcloud: {source: "gcloud-data", target: "/root/.config/gcloud"}
				azure: {source: "azure-data", target: "/root/.azure"}
			}
		}

	tfsec:
		base.#WithDockerfile &
		base.#WithRepository & {
			image: name: "dodo/terraform"
			script: "exec tfsec \"$@\""
		}
}
