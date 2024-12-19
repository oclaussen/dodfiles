package dodfiles

import (
	"github.com/oclaussen/dodfiles/base/pkg:base"
	"github.com/oclaussen/dodfiles/gpg/pkg:gpg"
)

#arch: "amd64"

actions:
	base.#BaseImage &
	gpg.#InstallPass & {
		packages: {
			type: "install"
			name: "gettext git gnupg libyaml-0-2 openssh-client sshpass zip"
		}

		env: {
			type: "environment"
			variables: {
				GEM_HOME: "/opt/ruby/bundle"
				PATH:     "/opt/python/bin:/opt/ruby/bundle/bin:/opt/ruby/bin"
			}
		}

		packer: {
			type:        "fetch"
			source:      "https://releases.hashicorp.com/packer/1.7.2/packer_1.7.2_linux_\(#arch).zip"
			unpack:      "packer"
			destination: "/bin/packer"
		}

		ansible: {
			type: "copy"
			path: "/opt/python"
			dockerfile: """
				FROM dodo/languages/python
				ENV PATH /opt/python/bin:$PATH
				RUN apt-get update && apt-get install -y libyaml-dev
				RUN pip3 install ansible pywinrm

				"""
		}

		kitchen: {
			type: "copy"
			path: "/opt/ruby"
			dockerfile: """
				FROM dodo/languages/ruby
				ENV GEM_HOME /opt/ruby/bundle
				ENV PATH $GEM_HOME/bin:/opt/ruby/bin:$PATH
				RUN apt-get update && apt-get install -y make gcc libffi-dev libyaml-dev
				RUN gem install psych \\
				        kitchen kitchen-ec2 \\
				        awspec kitchen-verifier-awspec \\
				        inspec kitchen-inspec

				"""
		}

		gpghome: {
			type:  "copy"
			path:  "/root/.gnupg"
			image: "dodo/gpg"
		}

		passconfig: {
			type:  "copy"
			path:  "/root/.config/gopass"
			image: "dodo/pass"
		}

		awsconfig: {
			type:  "copy"
			path:  "/root/.aws"
			image: "dodo/aws"
		}
	}
