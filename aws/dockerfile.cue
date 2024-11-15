actions: {
	base: {
		type: "base"
		name: "dodo/base"
	}

	dodo: {
		type:     "user"
		name:     "dodo"
		uid:      501
		dotfiles: "home"
	}

	packages: {
		type: "install"
		name: "curl groff jq less unzip"
	}

	sessionmanager: {
		type:        "fetch"
		source:      "https://s3.amazonaws.com/session-manager-downloads/plugin/latest/ubuntu_64bit/session-manager-plugin.deb"
		destination: "/tmp/session-manager-plugin.deb"
	}

	awscli: {
		type:        "fetch"
		source:      "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip"
		destination: "/tmp/awscliv2.zip"
	}

	dormouse: {
		type:        "fetch"
		source:      "https://github.com/wabenet/dormouse/releases/download/v0.1.4/dormouse_0.1.4_Linux_x86_64.tar.gz"
		unpack:      "dormouse"
		destination: "/bin/dormouse"
	}

	file: {
		type:      "copy"
		path:      "/"
		directory: "root"
	}

	installcli: {
		type: "script"
		script: """
			unzip /tmp/awscliv2.zip -d /tmp
			/tmp/aws/install

			"""
	}

	installsessionmanager: {
		type:   "script"
		script: "dpkg -i /tmp/session-manager-plugin.deb"
	}
}
