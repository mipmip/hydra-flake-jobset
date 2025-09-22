{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-25.05";
  };

  outputs = { self, nixpkgs }:
    let
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
    in
    {

    packages.x86_64-linux.fortune = nixpkgs.legacyPackages.x86_64-linux.fortune;
    packages.x86_64-linux.cowsay = nixpkgs.legacyPackages.x86_64-linux.cowsay;
    packages.x86_64-linux.hello = nixpkgs.legacyPackages.x86_64-linux.hello;

    packages.x86_64-linux.default = self.packages.x86_64-linux.fortune;

    # Hydra jobset for building the fortune package
    hydraJobs = {
      fortune.x86_64-linux = self.packages.x86_64-linux.fortune;
      cowsay.x86_64-linux = self.packages.x86_64-linux.cowsay;
      #hello.x86_64-linux = self.packages.x86_64-linux.hello;


      sample.x86_64-linux = derivation {
        # A name for the derivation (whatever you choose)
        name = "hello-text";
        # The system realising the derivation
        system = "x86_64-linux";
        # The program realising the derivation
        builder = "bash";
        # Arguments passed to the builder program
        args = ["-c" "mkdir $out && echo Hello world3 > $out/hello.txt"];
      };

      tester-readme = pkgs.runCommand "readme" { } ''
        echo hello world
        #mkdir -p $out/nix-support
        echo "# A readme" > $out/readme.md
        echo "A readme" >> $out/readme.md
        echo "A readme" >> $out/readme.md
        #echo "doc readme $out/readme.md" >> $out/nix-support/hydra-build-products
        '';
    };

    hydraJobs2 = {
      fortune.x86_64-linux = self.packages.x86_64-linux.fortune;
      cowsay.x86_64-linux = self.packages.x86_64-linux.cowsay;
      hello.x86_64-linux = self.packages.x86_64-linux.hello;

    };

  };
}
