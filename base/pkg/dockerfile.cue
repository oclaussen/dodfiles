package base

#WithDockerfile: {
	image: {
		context:    "{{ currentDir }}"
		dockerfile: "{{ currentDir }}/Dockerfile.yaml"
		...
	}
	...
}
