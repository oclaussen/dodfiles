package base

#arch: "x86_64"

#InstallDormouse: {
	dormouse: {
		type:        "fetch"
		source:      "https://github.com/wabenet/dormouse/releases/download/v0.1.4/dormouse_0.1.4_Linux_\(#arch).tar.gz"
		unpack:      "dormouse"
		destination: "/bin/dormouse"
	}
	...
}

#WithDormouse: {
	interpreter: ["/bin/dormouse"]
	script: "{{ readFile `dormouse.yaml` }}"
	...
}
