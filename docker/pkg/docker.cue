package docker

#WithDockerDaemon: {
	volumes: {
		docker: {
			source: "/var/run/docker.sock"
			target: "/var/run/docker.sock"
		}
		...
	}

	user: "1000:113"
	...
}
