
{ mkDerivation, base, pure-txt, haskell-src-meta, template-haskell, stdenv
}:
mkDerivation {
  pname = "pure-txt-interpolate";
  version = "0.7.0.0";
  src = ./.;
  libraryHaskellDepends = [
    base pure-txt haskell-src-meta template-haskell
    ];
  homepage = "github.com/grumply/pure-txt-interpolate";
  license = stdenv.lib.licenses.bsd3;
}