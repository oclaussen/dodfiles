package base

#WithDockerfile: {
	image: {
		context:    "{{ currentDir }}"
		dockerfile: "{{ currentDir }}/Dockerfile.yaml"
		...
	}
	...
}

#WithLegacyDockerfile: {
	image: {
		context:    "{{ currentDir }}"
		dockerfile: "{{ currentDir }}/Dockerfile"
		...
	}
	...
}
