package dodfiles

import (
	"github.com/oclaussen/dodfiles/base/pkg:base"
	"github.com/oclaussen/dodfiles/gpg/pkg:gpg"
)

backdrops: {
	gcloud:
		base.#WithDockerfile &
		base.#WithRepository & {
			image: name: "dodo/google"
			volumes: gcloud: {source: "gcloud-data", target: "/root/.config/gcloud"}
			script: """
				  mkdir -p /root/.config/gcloud/configurations
				  cp /root/.gcloud/* /root/.config/gcloud/configurations/
				  exec gcloud \"$@\"
				"""
		}

	gam:
		base.#WithDockerfile &
		base.#WithRepository &
		gpg.#WithPasswordStore & {
			image: name: "dodo/google"
			volumes: gcloud: {source: "gcloud-data", target: "/data/google"}
			script: """
					cp /data/google/gam/client_secrets.json /root/gam/client_secrets.json
					cp /data/google/gam/oauth2service.json /root/gam/oauth2service.json
					cp /data/google/gam/oauth2.txt /root/gam/oauth2.txt
					/root/gam/gam \"$@\"
				"""
		}
}
