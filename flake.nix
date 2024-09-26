{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    systems.url = "github:nix-systems/default";
    # Dev tools
    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      systems = import inputs.systems;
      imports = [ inputs.treefmt-nix.flakeModule ];
      perSystem =
        {
          config,
          self',
          pkgs,
          lib,
          system,
          ...
        }:
        {
          devShells.default = pkgs.mkShell {
            inputsFrom = [ config.treefmt.build.devShell ];
            nativeBuildInputs = with pkgs; [
              dotnetCorePackages.dotnet_8.sdk
              dotnetCorePackages.dotnet_8.runtime
              nixfmt-rfc-style
              omnisharp-roslyn
              mono
              libxslt.bin
              nodePackages.npm
            ];

            DOTNET_ROOT = "${pkgs.dotnet-sdk_8}";
          };

          # Add your auto-formatters here.
          # cf. https://numtide.github.io/treefmt/
          treefmt.config = {
            projectRootFile = "flake.nix";
            programs = {
              csharpier.enable = true;
              nixfmt.enable = true;
              shfmt.enable = true;
              prettier = {
                enable = true;
                includes = [
                  "*.xml"
                  "*.xslt"
                  "*.json"
                  "*.csproj"
                  ".github/workflows/*"
                ];
                settings = {
                  plugins = [ "@prettier/plugin-xml" ];
                  bracketSameLine = true;
                  printWidth = 1000;
                  overrides = [
                    {
                      files = "*.xml";
                      options = {
                        xmlQuoteAttributes = "double";
                        xmlSortAttributesByKey = true;
                        xmlWhitespaceSensitivity = "preserve";
                      };
                    }
                  ];
                };
              };
            };
            settings.global.excludes = [
              "node_modules/"
              "*.ase"
              "*.dll"
              "*.png"
              "*.ogg"
            ];
          };
        };
    };
}
