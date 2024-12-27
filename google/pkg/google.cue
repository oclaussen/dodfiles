package google

#arch_alt: "x86_64"

#InstallGoogleSDK: {
	googlesdk_env: {
		type: "environment"
		variables: PATH: "/opt/google-cloud-sdk/bin"
	}

	googlsdk_python: type: "python"

	googlesdk: {
		type:        "fetch"
		source:      "https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-504.0.1-linux-\(#arch_alt).tar.gz"
		destination: "/tmp/google-cloud-sdk.tar.gz"
	}

	googlesdk_install: {
		type:   "script"
		script: "tar -xvzf /tmp/google-cloud-sdk.tar.gz -C /opt"
	}
	...
}
