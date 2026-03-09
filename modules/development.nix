# Setup development environment

{ pkgs, nixpkgs, ... }: {
    config = {
        environment.systemPackages = [
            
            # development
            nixpkgs.for.rider.jetbrains.rider                       # jetbrains rider ide 
            nixpkgs.from.stable.vscode                              # visual studio code (development ide)
            nixpkgs.from.stable.direnv                              # shell extension for managing your environment 
            nixpkgs.from.stable.claude-code                         # agentic coding tool that lives in your terminal, understands your codebase, and helps you code faster
            nixpkgs.from.stable.devpod-desktop                      # Codespaces but open-source, client-only and unopinionated: Works with any IDE and lets you use any cloud, kubernetes or just localhost docker
            nixpkgs.from.stable.devpod                              # Codespaces but open-source, client-only and unopinionated: Works with any IDE and lets you use any cloud, kubernetes or just localhost docker
        ];
    };
}