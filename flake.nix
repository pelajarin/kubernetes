{
  description = "An flexible empty flake template";

  inputs.nixpkgs.url = "https://flakehub.com/f/NixOS/nixpkgs/0.2505.802491";

  outputs = inputs: let
    supportedSystems = [
      "x86_64-linux" # 64-bit Intel/AMD Linux
      "aarch64-linux" # 64-bit ARM Linux
      "x86_64-darwin" # 64-bit Intel macOS
      "aarch64-darwin" # 64-bit ARM macOS
    ];
    forEachSupportedSystem = f:
      inputs.nixpkgs.lib.genAttrs supportedSystems (system:
        f {
          pkgs = import inputs.nixpkgs {inherit system;};
        });
  in {
    devShells = forEachSupportedSystem ({pkgs}: {
      default = pkgs.mkShell {
        packages = [
          pkgs.act
          pkgs.civo
          pkgs.envsubst
          pkgs.gh
          pkgs.go-task
          pkgs.go
          pkgs.gum
          pkgs.k9s
          pkgs.kluctl
          pkgs.ko
          pkgs.kubectx
          pkgs.kubent
          pkgs.kustomize
          pkgs.nodejs_20
          pkgs.oras
          (pkgs.google-cloud-sdk.withExtraComponents [pkgs.google-cloud-sdk.components.gke-gcloud-auth-plugin])
          pkgs.poetry
          pkgs.procps
          pkgs.python312
          pkgs.tilt
          pkgs.yq-go
          pkgs.cloud-provider-kind
        ];

        shellHook = ''
          export GOBIN=$(git rev-parse --show-toplevel)/bin
          export PATH=$GOBIN:$PATH
        '';
      };
    });
  };
}
