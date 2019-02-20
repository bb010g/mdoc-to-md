{ pkgs ? import <nixpkgs> { } }:

let

  localPkgs = import ./. { inherit pkgs; };

in
pkgs.mkShell rec {
  name = "mdoc-to-md-env";
  buildInputs = [
    pkgs.bash
    pkgs.less
    localPkgs.mdoc-to-md
    localPkgs.mandoc
  ] ++ localPkgs.mdoc-to-md.buildInputs;

  MANPATH = let
    inherit (pkgs.stdenv) lib;
    pathPkgs = lib.misc.closePropagation buildInputs;
    getUniqueOutputs = outputs: pkg: lib.unique (map (lib.flip lib.getOutput pkg) outputs);
    paths = lib.concatMap (getUniqueOutputs [ "man" "devman" ]) pathPkgs;
  in lib.concatStringsSep ":" (map (lib.flip lib.makeSearchPath paths) [ "share/man" "man" ]);
}
