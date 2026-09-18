{
  lib,
  stdenv,
  writeShellScriptBin,
  whisper-cpp,
  xdotool,
  libnotify,
  pipewire,
  procps,
  busybox,
}: let
  script = writeShellScriptBin "stt-ptt" ''
    #!/usr/bin/env bash
    # stt-ptt - Push to Talk Speech to Text (X11 variant, uses xdotool)

    CACHE_DIR="''${XDG_CACHE_HOME:-$HOME/.cache}/stt-ptt"
    MODEL_DIR="''${XDG_DATA_HOME:-$HOME/.local/share}/stt-ptt/models"
    AUDIO="$CACHE_DIR/stt.wav"

    # Configurable via environment
    STT_MODEL="''${STT_MODEL:-$MODEL_DIR/ggml-large-v3-turbo.bin}"
    STT_LANGUAGE="''${STT_LANGUAGE:-auto}"
    STT_NOTIFY_TIMEOUT="''${STT_NOTIFY_TIMEOUT:-3000}"

    NOTIFY="${libnotify}/bin/notify-send"
    PW_RECORD="${pipewire}/bin/pw-record"
    WHISPER="${whisper-cpp}/bin/whisper-cli"
    XDOTOOL="${xdotool}/bin/xdotool"
    PKILL="${procps}/bin/pkill"
    MKDIR="${busybox}/bin/mkdir"
    RM="${busybox}/bin/rm"
    TR="${busybox}/bin/tr"
    SED="${busybox}/bin/sed"
    SLEEP="${busybox}/bin/sleep"

    # Ensure cache directory exists
    "$MKDIR" -p "$CACHE_DIR"

    # Kill any existing pw-record for this audio file (prevents orphan nodes)
    kill_existing() {
        "$PKILL" -f "pw-record.*$AUDIO" 2>/dev/null
        "$SLEEP" 0.1
    }

    case "''${1:-}" in
        start)
            kill_existing
            "$RM" -f "$AUDIO"
            "$NOTIFY" -t "$STT_NOTIFY_TIMEOUT" -a "stt-ptt" "Recording..."
            "$PW_RECORD" --rate=16000 --channels=1 "$AUDIO" &
            ;;
        stop)
            kill_existing

            if [[ -f "$AUDIO" ]]; then
                if [[ ! -f "$STT_MODEL" ]]; then
                    "$NOTIFY" -t "$STT_NOTIFY_TIMEOUT" -a "stt-ptt" "Error: Model not found at $STT_MODEL"
                    "$RM" -f "$AUDIO"
                    exit 1
                fi
                text=$("$WHISPER" -m "$STT_MODEL" -f "$AUDIO" -l "$STT_LANGUAGE" -np -nt 2>/dev/null | "$TR" -d '\n' | "$SED" 's/^[[:space:]]*//;s/[[:space:]]*$//')
                "$RM" -f "$AUDIO"
                [[ -n "$text" ]] && "$XDOTOOL" type --clearmodifiers -- "$text"
            fi
            ;;
        *)
            echo "Usage: stt-ptt {start|stop}"
            echo ""
            echo "Environment variables:"
            echo "  STT_MODEL          - Path to whisper model (default: \$XDG_DATA_HOME/stt-ptt/models/ggml-large-v3-turbo.bin)"
            echo "  STT_LANGUAGE       - Language code or 'auto' for auto-detection (default: auto)"
            echo "  STT_NOTIFY_TIMEOUT - Notification timeout in ms (default: 3000)"
            exit 1
            ;;
    esac
  '';
in
  stdenv.mkDerivation {
    pname = "stt-ptt";
    version = "0.1.0";

    dontUnpack = true;

    # No buildInputs needed - all runtime deps are hardcoded with full nix store paths in the script

    installPhase = ''
      mkdir -p "$out/bin"
      ln -s ${script}/bin/stt-ptt "$out/bin/stt-ptt"
    '';

    meta = with lib; {
      description = "Push to Talk Speech to Text using Whisper (X11 variant)";
      homepage = "https://code.m3ta.dev/m3tam3re/nixpkgs";
      license = licenses.mit;
      platforms = platforms.linux;
      mainProgram = "stt-ptt";
    };
  }
