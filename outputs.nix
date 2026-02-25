# outputs.nix -- this is the contents of your `outputs` function from the original flake.nix file.
inputs: inputs.flake-parts.lib.mkFlake { inherit inputs; } {
  systems = [ "x86_64-linux" ];
  imports = [(inputs.import-tree ./modules)];
}

