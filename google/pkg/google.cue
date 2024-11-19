package google

#arch_alt: "x86_64"

#InstallGoogleSDK: {
	googlesdk: {
		type:        "fetch"
		source:      "https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-471.0.0-linux-\(#arch_alt).tar.gz"
		destination: "/tmp/google-cloud-sdk.tar.gz"
	}

	googlesdk_install: {
		type:   "script"
		script: "tar -xvzf /tmp/google-cloud-sdk.tar.gz -C /opt"
	}
	...
}
