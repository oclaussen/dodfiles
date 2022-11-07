package aws

#WithAWSCache: {
	volumes: {
		aws: {
			source: "aws-cache"
			target: "/home/dodo/.aws/cli/cache"
		}
		...
	}
	...
}
