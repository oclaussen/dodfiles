package base

#InstallDormouse: {
	dormouse: {
		type: "eget"
		repo: "wabenet/dormouse"
	}
	...
}

#WithDormouse: {
	interpreter: ["/bin/dormouse"]
	script: "{{ readFile `dormouse.yaml` }}"
	...
}
