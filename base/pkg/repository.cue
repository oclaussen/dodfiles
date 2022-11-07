package base

#WithRepository: {
	volumes: {
		repo: {
			source: "{{ projectRoot }}"
			target: "/project"
		}
		...
	}

	working_dir: "/project/{{ projectPath }}"
	...
}

#WithCWD: {
	volumes: {
		repo: {
			source: "{{ cwd }}"
			target: "/work"
		}
		...
	}

	working_dir: "/work"
	...
}
