package base

#WithDockerfile: {
	image: {
		context:    "{{ currentDir }}"
		dockerfile: "{{ currentDir }}/dockerfile.yaml"
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
