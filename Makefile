VERSION:=1.0.0
MANFLAGS+=-I 'os=$(VERSION)'
.DEFAULT_GOAL=all

X_MANFLAGS=$(foreach flag,$(MANFLAGS),-x $(flag))

mdoc-to-md.1: mdoc-to-md.1.mdoc
	nix-shell --pure --run 'mandoc $(MANFLAGS) -T man $<' > $@

README.md: README-preamble.md mdoc-to-md.1.mdoc mdoc-to-md
	nix-shell --pure --run './mdoc-to-md $(X_MANFLAGS) mdoc-to-md.1.mdoc' | \
	    cat README-preamble.md - > $@

all: mdoc-to-md.1 README.md

view-man: mdoc-to-md.1
	@exec man -l $<

view-man-mdoc: mdoc-to-md.1.mdoc
	@exec nix-shell --pure --run 'man -l $<'

clean:
	rm mdoc-to-md.1 README.md

.PHONY: all view-man view-man-mdoc clean
