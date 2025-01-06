package aws

#InstallAWSCLI: {
	awscli: {
		type:        "fetch"
		source:      "https://awscli.amazonaws.com/awscli-exe-linux-{{ archLike `x86_64` `aarch64` }}.zip"
		destination: "/tmp/awscliv2.zip"
	}

	awscli_install: {
		type: "script"
		script: """
			unzip /tmp/awscliv2.zip -d /tmp
			/tmp/aws/install

			"""
	}
	...
}

#WithAWSCache: {
	volumes: {
		aws: {
			source: "aws-cache"
			target: "/root/.aws/sso"
		}
		...
	}
	...
}
