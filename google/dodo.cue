package dodfiles

import (
	"github.com/oclaussen/dodfiles/base/pkg:base"
	"github.com/oclaussen/dodfiles/gpg/pkg:gpg"
)

backdrops: {
	gcloud:
		base.#WithDockerfile &
		base.#WithRepository & {
			image: {
				name: "dodo/google"
				requires: ["dodo/base", "dodo/languages/python"]
			}
			volumes: gcloud: {source: "gcloud-data", target: "/home/dodo/.config/gcloud"}
			script: """
				  mkdir -p /home/dodo/.config/gcloud/configurations
				  cp /home/dodo/.gcloud/* /home/dodo/.config/gcloud/configurations/
				  exec gcloud \"$@\"
				"""
		}

	gam:
		base.#WithDockerfile &
		base.#WithRepository &
		gpg.#WithPasswordStore & {
			image: {
				name: "dodo/google"
				requires: ["dodo/base", "dodo/languages/python"]
			}
			volumes: gcloud: {source: "gcloud-data", target: "/data/google"}
			script: """
					cp /data/google/gam/client_secrets.json /home/dodo/gam/client_secrets.json
					cp /data/google/gam/oauth2service.json /home/dodo/gam/oauth2service.json
					cp /data/google/gam/oauth2.txt /home/dodo/gam/oauth2.txt
					/home/dodo/gam/gam \"$@\"
				"""
		}
}
