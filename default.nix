{ pkgs ? import <nixpkgs> { } }:

let

  pkgsPinned = import (fetchTarball
    "https://api.github.com/repos/NixOS/nixpkgs/tarball/4477cf04b6779a537cdb5f0bd3dd30e75aeb4a3b"
  ) { };

  utf8all = { buildPerlPackage, stdenv, fetchurl
  , Carp, Encode, ImportInto, PerlIOutf8_strict, Parent
  , PathTools, IO, TestException, TestFatal, TestMore, TestWarn, autodie
  , constant, threads, threadsshared, version
  }:
  buildPerlPackage rec {
    name = "utf8-all-0.024";
    src = fetchurl {
      url = "mirror://cpan/authors/id/H/HA/HAYOBAAN/${name}.tar.gz";
      sha256 = "9233465d41174077ccdbc04f751ab7d68c8d19114e36cd02f2c5fdc2bc3937b7";
    };
    meta = with stdenv.lib; {
      description = "turn on Unicode - all of it";
      license = with licenses; [ artistic1 gpl1Plus ];
    };
    propagatedBuildInputs = [ Carp Encode ImportInto PerlIOutf8_strict Parent ];
    buildInputs = [ PathTools IO TestException TestFatal TestMore TestWarn autodie constant threads threadsshared version ];
  };

  perlPackages = pkgs.perlPackages.override {
    overrides = {
      utf8all = perlPackages.callPackage utf8all { };
    };
  };

in
rec { 
  inherit (pkgsPinned) mandoc;
  mdoc-to-md = pkgs.callPackage ./mdoc-to-md.nix {
    inherit (pkgsPinned) mandoc;
    inherit perlPackages;
  };
  inherit utf8all;
}
