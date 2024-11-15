.PHONY: all
all: fmt dodfiles

.PHONY: fmt
fmt: 
	cue fmt --strict --simplify --all-errors ./...

.PHONY: dodfiles
dodfiles: $(patsubst %.cue, %.yaml, $(shell find -type f -name dodo.cue))

%dodo.yaml: %dodo*.cue
	cue export --strict --simplify --force $^ > $@

.PHONY: dodfiles-diff
dodfiles-diff: $(patsubst %.cue, %.diff, $(shell find -type f -name dodo.cue))

.PHONY: %dodo.diff
%dodo.diff: %dodo*.cue
	-cue export --strict --simplify $^ | diff $(patsubst %.diff, %.yaml, $@) -

.PHONY: dockerfiles
dockerfiles: $(patsubst %.cue, %.yaml, $(shell find -type f -name dockerfile.cue))

%dockerfile.yaml: %dockerfile*.cue
	echo '# syntax = wabenet/dodfile-syntax' > $@
	cue export --strict --simplify --force $^ >> $@

.PHONY: dockerfiles-diff
dockerfiles-diff: $(patsubst %.cue, %.diff, $(shell find -type f -name dockerfile.cue))

.PHONY: %dockerfile.diff
%dockerfile.diff: %dockerfile*.cue
	-cue export --strict --simplify $^ | diff $(patsubst %.diff, %.yaml, $@) -

