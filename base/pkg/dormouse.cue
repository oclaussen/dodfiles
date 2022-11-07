package base

#WithDormouse: {
	interpreter: ["/bin/dormouse"]
	script: "{{ readFile `dormouse.yaml` }}"
	...
}
