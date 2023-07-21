#https://nix-tutorial.gitlabpages.inria.fr/nix-tutorial/first-package.html
#https://dev.to/deciduously/workstation-management-with-nix-flakes-build-a-cmake-c-package-21lp
{
  description = "libicepic";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs";

  outputs = { self, nixpkgs }: {

    # after apps

    devShells.x86_64-linux.default =  with import nixpkgs { system = "x86_64-linux"; };
      mkShell {
        buildInputs =  [ stdenv.cc.cc.lib cmake ];
        packages = with pkgs; [cmake libusb1];
      };
    
    
    packages.x86_64-linux.default =
      # Notice the reference to nixpkgs here.
      with import nixpkgs { system = "x86_64-linux"; };
      
      stdenv.mkDerivation rec {
        pname = "libicepic";
        version = "0.1.0";
        src = ./.;
        # for build dependencies only, stuff you need to build the package but not to run it.
        nativeBuildInputs = [ dpkg ];
        #for build and runtime dependencies, stuff you need to build the package and to run it.
        buildInputs = [ stdenv.cc.cc.lib cmake];
        #sourceRoot = ".";
        #configurePhase = "cmake .";
        #buildPhase = "make -j $NIX_BUILD_CORES";
     
        #installPhase = ''cmake --install .'';

        meta = with lib; {
          homepage = "http://icepic.de";
          description = "nix test library";
          platforms = platforms.linux;
          
        };
      };
  };
}

