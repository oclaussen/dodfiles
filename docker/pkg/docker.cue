package docker

#WithDockerDaemon: {
	volumes: {
		docker: {
			source: "/run/user/501/docker.sock"
			target: "/var/run/docker.sock"
		}
		...
	}

	user: "1000:113"
	...
}
