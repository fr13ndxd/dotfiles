pkgs: let
  notify-send = "${pkgs.libnotify}/bin/notify-send";
  slurp = "${pkgs.slurp}/bin/slurp";
  # wayshot = "${pkgs.wayshot}/bin/wayshot";
  hyprshot = "${pkgs.hyprshot}/bin/hyprshot";
  swappy = "${pkgs.swappy}/bin/swappy";
  wl-copy = "${pkgs.wl-clipboard}/bin/wl-copy";
in
  pkgs.writeShellScript "screenshot" ''
    SCREENSHOTS="$HOME/Pictures/Screenshots"
    NOW=$(date +%Y-%m-%d_%H-%M-%S)
    TARGET="$SCREENSHOTS/$NOW.png"

    mkdir -p $SCREENSHOTS

    if [[ -n "$1" ]]; then
        RESULT="$(${hyprshot} -s -z -m active -m output -o $SCREENSHOTS -f $NOW.png 2>&1)"
        if [[ "$RESULT" == *"selection cancelled"* ]]; then
            exit 1
        fi
    else
        RESULT="$(${hyprshot} -s -z -m region -o $SCREENSHOTS -f $NOW.png 2>&1)"
        if [[ "$RESULT" == *"selection cancelled"* ]]; then
            exit 1
        fi
    fi

    RES=$(${notify-send} \
        -a "Screenshot" \
        -i "image-x-generic-symbolic" \
        -h string:image-path:$TARGET \
        -A "file=Show in Files" \
        -A "view=View" \
        -A "edit=Edit" \
        "Screenshot Taken" \
        $TARGET)

    case "$RES" in
        "file") xdg-open "$SCREENSHOTS" ;;
        "view") xdg-open $TARGET ;;
        "edit") ${swappy} -f $TARGET ;;
        *) ;;
    esac
  ''
