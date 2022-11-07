package dodfiles

import "github.com/oclaussen/dodfiles/base/pkg:base"

backdrops: {
	vdirsyncer:
		base.#WithDockerfile & {
			image: {
				name: "dodo/khal"
				requires: ["dodo/base", "dodo/languages/python"]
			}
			volumes: vdir: {source: "vdir", target: "/data/vdir"}
			script: """
				  if [ $# != 0 ]; then
				    exec vdirsyncer \"$@\"
				  else
				    touch /data/vdir/vdirsyncer.log
				    cron && tail -f /data/vdir/vdirsyncer.log
				  fi
				"""
		}

	khal:
		base.#WithDockerfile & {
			image: {
				name: "dodo/khal"
				requires: ["dodo/base", "dodo/languages/python"]
			}
			volumes: vdir: {source: "vdir", target: "/data/vdir"}
			script:  "exec khal \"$@\""
			command: "interactive"
		}
}
