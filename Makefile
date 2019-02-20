VERSION := 1.0.0
MANFLAGS += -I 'os=$(VERSION)'
.DEFAULT_GOAL = all

PREFIX ?= /usr/local
DESTDIR ?=

bindir := $(DESTDIR)$(PREFIX)/bin
mandir := $(DESTDIR)$(PREFIX)/share/man

X_MANFLAGS=$(foreach flag,$(MANFLAGS),-x $(flag))

ifndef NO_NIX_SHELL
README.md: README-preamble.md mdoc-to-md.1 mdoc-to-md default.nix mdoc-to-md.nix
	nix-shell --pure shell-minimal.nix \
	    --run 'mdoc-to-md $(X_MANFLAGS) mdoc-to-md.1' | \
	    cat README-preamble.md - > $@
else
README.md: README-preamble.md mdoc-to-md.1 mdoc-to-md default.nix mdoc-to-md.nix
	./mdoc-to-md $(X_MANFLAGS) mdoc-to-md.1 | \
	    cat README-preamble.md - > $@
endif

all: README.md mdoc-to-md mdoc-to-md.1

install: mdoc-to-md mdoc-to-md.1
	install -Dm755 -t $(bindir) mdoc-to-md
	install -Dm644 -t $(mandir)/man1 mdoc-to-md.1

view-man: mdoc-to-md.1
	@exec man -l mdoc-to-md.1

view-man-mdoc: mdoc-to-md.1
	@exec nix-shell --pure --run 'man -l mdoc-to-md.1'

nix-build:
	nix-build -A mdoc-to-md.all

clean:
	rm README.md result*

.PHONY: all install view-man view-man-mdoc nix-build clean
