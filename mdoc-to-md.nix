{ stdenv, makeWrapper, perlPackages
, mandoc
}:

let
  # nixpkgs-unstable compatability
  makeFullPerlPath = perlPackages.makeFullPerlPath or stdenv.lib.makeFullPerlPath;

  perlDeps = with perlPackages; [
    GetoptLongDescriptive
    HTMLTree
    IPCRun3
    utf8all
  ];
in
stdenv.mkDerivation rec {
  name = "mdoc-to-md-${version}";
  version = "1.0.0";

  src = builtins.filterSource (path: type: let
    relPath = stdenv.lib.removePrefix ((toString ./.) + "/") path;
  in !(
    (type == "directory" || type == "symlink") && stdenv.lib.hasPrefix "result" relPath ||
    baseNameOf path == ".git" ||
    relPath == "README.md" ||
    relPath == "shell.nix" || relPath == "shell-minimal.nix"
  )) ./.;
  # src = fetchFromGitHub {
  #   owner = "bb010g";
  #   repo = "mdoc-to-md";
  #   rev = "v${version}";
  #   sha256 = "";
  # };

  outputs = [ "bin" "man" "out" ];

  nativeBuildInputs = [ makeWrapper ];
  buildInputs = [ perlPackages.perl ] ++ perlDeps;

  postPatch = ''
    substituteInPlace mdoc-to-md \
      --replace "// 'mandoc'" "// '${mandoc}/bin/mandoc'"
    patchShebangs mdoc-to-md
  '';

  makeFlags = [ "PREFIX=$(out)" "NO_NIX_SHELL=1" ];

  postInstall = ''
    mkdir -p $bin/bin
    mv -t $bin/bin $out/bin/mdoc-to-md
    rmdir $out/bin

    wrapProgram $bin/bin/mdoc-to-md \
      --prefix PERL5LIB : ${makeFullPerlPath perlDeps}
  '';

  meta = with stdenv.lib; {
    description = "mdoc to GitHub Flavored Markdown converter";
    longDescription = ''
      mdoc-to-md converts manual pages written in mdoc to GitHub Flavored
      Markdown so you can drop them into your READMEs.
    '';
    homepage = https://github.com/bb010g/mdoc-to-md;
    license = with licenses; [ asl20 mit ];
    maintainers = with maintainers; [ bb010g ];
    platforms = platforms.unix;
  };
}
