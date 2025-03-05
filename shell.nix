{
  pkgs ? (let
    rev = "48913d8f9127ea6530a2a2f1bd4daa1b8685d8a3";
    sha = "sha256:0h3yzgn0mw74039xaqpvhvd2f924d923ax3kb8gh79f2m1jgla6i";
  in
    import (builtins.fetchTarball {
      name = "nixpkgs-${rev}";
      url = "https://github.com/NixOS/nixpkgs/archive/${rev}.tar.gz";
      sha256 = sha;
    }) {
      system = builtins.currentSystem;
    }),
}:
let
  flasher = import ./default.nix { inherit pkgs; };
in
(pkgs.buildFHSEnv {
  name = "calyxos-device-flashing";
  targetPkgs = pkgs: [
    pkgs.unzip
    pkgs.avbroot
    pkgs.android-tools
  ];
  # yes, device-flasher *has* to be in $PWD. no, that's not very pretty.
  runScript = "sh -c 'rm -f ./flasher && cp ${flasher}/bin/device-flasher ./flasher && exec bash'";
})
.env
