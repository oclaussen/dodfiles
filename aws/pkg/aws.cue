package aws

#InstallAWSCLI: {
	awscli: {
		type:        "fetch"
		source:      "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip"
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
			target: "/home/dodo/.aws/sso"
		}
		...
	}
	...
}
