{ pkgs ? import <nixpkgs> { } }:

let
  localPkgs = import ./. { inherit pkgs; };
in
pkgs.mkShell {
  name = "mdoc-to-md-minimal-env";
  buildInputs = [ localPkgs.mdoc-to-md.bin ];
}

