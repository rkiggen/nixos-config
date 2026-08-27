# local ai installation

{ inputs, pkgs, nixpkgs, userName, ... }: {
            
    config = {

        # --- llama-cpp overlay ---
        # built for CPU with BLAS + native CPU optimizations
        # Trade-off: because this enables -march=native, Nix cannot serve it
        # from the shared binary cache. The FIRST rebuild after adding this
        # will compile llama.cpp from source locally - budget 15-30 minutes.
        # https://www.nijho.lt/post/llama-nixos/#my-nixos-setup
        # https://github.com/basnijholt/dotfiles
        nixpkgs.overlays = [
            (final: prev: {
                llama-cpp = (prev.llama-cpp.override {
                    cudaSupport = false;
                    rocmSupport = false;            # flip to true only if you get 780M ROCm working later
                    blasSupport = true;
                }).overrideAttrs (old: {
                    cmakeFlags = (old.cmakeFlags or []) ++ [ "-DGGML_NATIVE=ON" ];
                    preConfigure = ''
                        export NIX_ENFORCE_NO_NATIVE=0
                        ${old.preConfigure or ""}
                    '';
                });
            })
        ];     



        # --- llama-swap config ---
        # Two models only, sized for a 32GB CPU-only laptop (no discrete GPU).
        # Start here; don't copy Bas's full multi-GPU model list.
        environment.etc."llama-swap/config.yaml".text = ''
            models:
              # Fast, no reasoning trace - good default for everyday questions
              "qwen3:8b":
                cmd: |
                  ${pkgs.llama-cpp}/bin/llama-server
                  --hf-repo unsloth/Qwen3-8B-128K-GGUF
                  --port ''${PORT}
                  --ctx-size 32768
                  --threads 8
                  --jinja
                  --chat-template-kwargs '{"enable_thinking": false}'
                  
              # Same model, thinking enabled - use for genuinely hard problems
              "qwen3-thinking:8b":
                cmd: |
                  ${pkgs.llama-cpp}/bin/llama-server
                  --hf-repo unsloth/Qwen3-8B-128K-GGUF
                  --port ''${PORT}
                  --ctx-size 32768
                  --threads 8
                  --jinja

              # Heavier MoE model for ingest/synthesis work, not for quick chat
              # MoE (only ~3.3B active params despite "30B" name), 
              # so  noticeably faster than a dense 30B on CPU. Use for
              # ingest/synthesis jobs where you don't need instant response.
              "qwen3-coder:30b":
                cmd: |
                  ${pkgs.llama-cpp}/bin/llama-server
                  --hf-repo unsloth/Qwen3-Coder-30B-A3B-Instruct-GGUF:Q4_K_M
                  --port ''${PORT}
                  --ctx-size 32768
                  --threads 8
                  --jinja

            healthCheckTimeout: 600
            ttl: 3600
        '';

        # --- llama-swap --- (systemd service)
        systemd.services.llama-swap = {
            description = "llama-swap - OpenAI compatible proxy with automatic model swapping";
            after = [ "network.target" ];
            wantedBy = [ "multi-user.target" ];
  
            serviceConfig = {
                Type = "simple";
                User = userName;
                Group = "users";
                Environment = [ "HOME=/home/${userName}" ];
                # Point to your declarative config file
                ExecStart = "${pkgs.llama-swap}/bin/llama-swap --config /etc/llama-swap/config.yaml --listen 0.0.0.0:9292 --watch-config";
                Restart = "always";
                RestartSec = 10;
            };
        };        

        # --- ai packages ---
        environment.systemPackages = [
            nixpkgs.from.stable.opencode            # open source ai coding agent supporting multiple models and providers
            nixpkgs.from.stable.claude-code         # agentic coding tool that lives in your terminal, understands your codebase, and helps you code faster
            pkgs.llama-cpp                          # add llama-cpp via overlay, natively-optimized build
        ];
    };
}