.PHONY: all
all: fmt dodfiles

.PHONY: fmt
fmt: 
	cue fmt --strict --simplify --all-errors ./...

.PHONY: dodfiles
dodfiles: $(patsubst %.cue, %.yaml, $(shell find -type f -name dodo.cue))

%dodo.yaml: %dodo*.cue
	cue export --strict --simplify --force $^ > $@

.PHONY: dockerfiles
dockerfiles: $(patsubst %.cue, %.yaml, $(shell find -type f -name dockerfile.cue))

%dockerfile.yaml: %dockerfile*.cue
	echo '# syntax = wabenet/dodfile-syntax' > $@
	cue export --strict --simplify --force $^ >> $@
