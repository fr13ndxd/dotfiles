pkgs:
let
  nu = "${pkgs.nushell}/bin/nu";
  notify-send = "${pkgs.libnotify}/bin/notify-send";
  slurp = "${pkgs.slurp}/bin/slurp";
  wayshot = "${pkgs.wayshot}/bin/wayshot";
  hyprpicker = "${pkgs.hyprpicker}/bin/hyprpicker";
  swappy = "${pkgs.swappy}/bin/swappy";
  wl-copy = "${pkgs.wl-clipboard}/bin/wl-copy";
in pkgs.writers.writeNu "screenshot" # nu
''
  use std

  let SCREENSHOTS = $"($env.HOME)/Pictures/Screenshots"
  let NOW = $"(date now | format date "%Y-%m-%d_%H-%M-%S")"
  let target = $"($SCREENSHOTS)/($NOW).png"

  mkdir $SCREENSHOTS

  def --wrapped main [fullscreen: string = "uwu", ...rest] {
    if $fullscreen == "-f" {
      ${wayshot} -f $target
    } else {
      bash -c  "${hyprpicker} -rz &"
      sleep 200ms    
      let RESULT = $"(${slurp} -w 0)"
      pkill hyprpicker
      ${wayshot} -s $"($RESULT)" -c -f $target
    }

    if ($target | path exists) {
     open $target | ${wl-copy}

      let res = (
          ${notify-send} -a "Screenshot" -i "image-x-generic-symbolic" 
                      -h $"string:image-path:($target)" 
                      -A "file=Show in files" 
                      -A "view=View" 
                      -A "edit=Edit" 
                      "Screenshot Taken" 
                      $"($target)"
      )  
      match $res {
        "file" => (xdg-open $SCREENSHOTS),
        "view" => (xdg-open $target),
        "edit" => (${swappy} -f $target)
      }
    }
  }
''
