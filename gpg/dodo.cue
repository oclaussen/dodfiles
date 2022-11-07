package dodfiles

import (
	"github.com/oclaussen/dodfiles/base/pkg:base"
	"github.com/oclaussen/dodfiles/gpg/pkg:gpg"
)

backdrops: {
	"gpg":
		base.#WithDockerfile &
		base.#WithRepository &
		gpg.#WithGPGAgent & {
			image: {
				name: "dodo/gpg"
				requires: ["dodo/languages/buildbase", "dodo/languages/python", "dodo/base"]
			}
			script: """
				  if [ \"$1\" = \"status\" ]; then
				    . /home/dodo/.lib/gpg_cards.sh
				    if ! is_agent_running; then echo \"locked\"; exit 0; fi
				    card=\"$(current_card)\"
				    if [ -n \"${card}\" ]; then basename \"${card}\" .txt; else echo \"locked\"; fi
				  else
				    exec gpg \"$@\"
				  fi
				"""
		}

	unlock:
		base.#WithDockerfile &
		gpg.#WithGPGAgent &
		gpg.#WithSCD & {
			container_name: "gpg-agent"
			image: {
				name: "dodo/gpg"
				requires: ["dodo/languages/buildbase", "dodo/languages/python", "dodo/base"]
			}
			script: """
				  export GPG_TTY=$(tty)
				  . /home/dodo/.lib/gpg_cards.sh
				  init_agent
				  unlock_any_card
				  while check_usb; do sleep 1; done
				"""
		}

	ykman:
		base.#WithDockerfile &
		gpg.#WithSCD & {
			image: {
				name: "dodo/gpg"
				requires: ["dodo/languages/buildbase", "dodo/languages/python", "dodo/base"]
			}
			script: """
				  set -eux
				  rm -f /var/run/pcscd/*
				  pcscd
				  exec ykman \"$@\"
				"""
		}
}
