{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = { self, nixpkgs }: {

    packages.x86_64-linux.fortune = nixpkgs.legacyPackages.x86_64-linux.fortune;
    packages.x86_64-linux.cowsay = nixpkgs.legacyPackages.x86_64-linux.cowsay;

    packages.x86_64-linux.default = self.packages.x86_64-linux.fortune;

    # Hydra jobset for building the fortune package
    hydraJobs = {
      fortune.x86_64-linux = self.packages.x86_64-linux.fortune;
      cowsay.x86_64-linux = self.packages.x86_64-linux.cowsay;
    };

  };
}
