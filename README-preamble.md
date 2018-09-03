# mdoc-to-md

mdoc-to-md converts manual pages written in mdoc to GitHub Flavored Markdown so
you can drop them into your READMEs.

As mandoc isn't commonly installed outside of BSDs, this project uses the
[Nix package manager](https://nixos.org/nix/) to ensure a compatible version of
mandoc is available easily, without the fear of collision with your current man.
Nix is also used to install some CPAN packages nicely. To install Nix, either
use the [upstream installer](https://nixos.org/nix/download.html) or install a
package on [Arch (AUR)](https://aur.archlinux.org/packages/nix/),
[Fedora (COPR, currently out of date)](https://copr.fedorainfracloud.org/coprs/petersen/nix/),
[Gentoo](https://packages.gentoo.org/packages/sys-apps/nix), or
[Void Linux](https://github.com/void-linux/void-packages/tree/master/srcpkgs/nix).
The Makefile here uses Nix to build this README, so feel free to use it as an
example for your own projects.

mdoc-to-md is dual licensed under the Apache License 2.0 and MIT Licenses, at
your discretion.

# MDOC-TO-MD(1)

