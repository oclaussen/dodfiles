package dodfiles

import (
	"github.com/oclaussen/dodfiles/base/pkg:base"
	"github.com/oclaussen/dodfiles/gpg/pkg:gpg"
	"github.com/oclaussen/dodfiles/aws/pkg:aws"
	"github.com/oclaussen/dodfiles/kubernetes/pkg:kube"
	"github.com/oclaussen/dodfiles/docker/pkg:docker"
)

backdrops: {
	terraform11:
		base.#WithRepository &
		gpg.#WithPasswordStore &
		gpg.#WithSSHAgent &
		aws.#WithAWSCache &
		kube.#WithKubeconfig & {
			image: {
				name: "dodo/terraform11"
				requires: ["dodo/base", "dodo/languages/golang", "dodo/gpg", "dodo/pass", "dodo/aws", "dodo/kube"]
				context:    "{{ currentDir }}"
				dockerfile: "{{ currentDir }}/Dockerfile-0.11.yaml"
			}
			volumes: terraform: {source: "terraform", target: "/data/terraform"}
			environment: user: {name: "TF_VAR_username", value: "ole.claussen"}
			script: """
				  test -f terraform.log && rm -f terraform.log
				  if [ \"$1\" = \"fa\" ]; then
				    exec terraform init -get=true -upgrade=true
				  else
				    exec terraform \"$@\"
				  fi
				"""
		}

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
				requires: ["dodo/base", "dodo/languages/golang", "dodo/gpg", "dodo/pass", "dodo/aws", "dodo/kube", "dodo/google"]
			}
			volumes: {
				terraform: {source: "terraform", target: "/data/terraform"}
				gcloud: {source: "gcloud-data", target: "/home/dodo/.config/gcloud"}
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
				requires: ["dodo/base", "dodo/languages/golang", "dodo/gpg", "dodo/pass", "dodo/aws", "dodo/kube", "dodo/google"]
			}
			volumes: {
				terraform: {source: "terraform", target: "/data/terraform"}
				gcloud: {source: "gcloud-data", target: "/home/dodo/.config/gcloud"}
			}
		}

	tfsec:
		base.#WithDockerfile &
		base.#WithRepository & {
			image: {
				name: "dodo/terraform"
				requires: ["dodo/base", "dodo/languages/golang"]
			}
			script: "exec tfsec \"$@\""
		}
}
