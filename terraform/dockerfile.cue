package dodfiles

import (
	"github.com/oclaussen/dodfiles/base/pkg:base"
	"github.com/oclaussen/dodfiles/gpg/pkg:gpg"
	"github.com/oclaussen/dodfiles/aws/pkg:aws"
	"github.com/oclaussen/dodfiles/google/pkg:google"
)

actions:
	base.#BaseImage &
	base.#WithDotfiles &
	base.#InstallDormouse &
	gpg.#InstallPass &
	aws.#InstallAWSCLI &
	google.#InstallGoogleSDK & {
		packages: {
			type: "install"
			name: "git gnupg gzip jq unzip less"
			repo: "deb [arch={{ arch }}] https://packages.microsoft.com/repos/azure-cli/ bullseye main"
			gpg:  "https://packages.microsoft.com/keys/microsoft.asc"
		}

		terraform: {
			type:        "fetch"
			source:      "https://releases.hashicorp.com/terraform/1.9.8/terraform_1.9.8_linux_{{ arch }}.zip"
			unpack:      "terraform"
			destination: "/bin/terraform"
		}

		terragrunt: {
			type: "eget"
			repo: "gruntwork-io/terragrunt"
		}

		tfsec: {
			type: "eget"
			repo: "aquasecurity/tfsec"
			asset: ["^.sig", "^.tar.gz", "^checkgen"]
		}

		docker: {
			type:        "fetch"
			source:      "https://download.docker.com/linux/static/stable/{{ archLike `x86_64` `aarch64` }}/docker-26.1.4.tgz"
			unpack:      "docker/docker"
			destination: "/bin/docker"
		}

		buildx: {
			type: "eget"
			repo: "docker/buildx"
			asset: ["^.sbom.json", "^.provenance.json"]
		}

		gpghome: {
			type:  "copy"
			path:  "/root/.gnupg"
			image: "dodo/gpg"
		}
	}
