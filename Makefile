.PHONY: all
all: fmt cue

.PHONY: fmt
fmt: 
	cue fmt --strict --simplify --all-errors ./...

.PHONY: cue
cue: $(patsubst %.cue, %.yaml, $(wildcard **/dodo.cue))

%.yaml: %*.cue
	cue export --strict --simplify --force --outfile $@ $^
