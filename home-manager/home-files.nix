{ pkgs, ... }:
{
    home.packages = [ pkgs.neofetch ];
    home.file.".config/neofetch/config.conf".text = ''
    print_info() {
    prin " \n \n ╭────┤ $(color 4) $(grep -Eo '^PRETTY_NAME="?[^"]*"?$' /etc/os-release | cut -d= -f2 | tr -d '"') $(color 15)├────╮"
    info "\x20  " kernel 
    info "\x20  " wm
    info " \x20  " shell
    info "\x20   " term
   # info "\x20 󰏖 " packages
    info "\x20 󰍛 " memory
    info "\x20 󰔛 " uptime
    prin " \n \n ╰────────────────────────────────╯"
    prin " \t \n \n \n \n $(color 1) \n $(color 2) \n $(color 3) \n $(color 4) \n $(color 5) \n $(color 6) \n $(color 7) \n $(color 0)"
    }

    kernel_shorthand="on"
    uptime_shorthand="on"
    memory_percent="on"
    memory_unit="gib"
    package_managers="on"
    shell_path="off"
    shell_version="off"
    cpu_brand="off"
    cpu_speed="off"
    cpu_cores="off"
    cpu_temp="off"
    gpu_brand="on"
    gpu_type="all"
    refresh_rate="off"
    colors=(distro)
    bold="off"
    separator=""

    image_backend="ascii" # ascii kitty iterm2
    image_source="/home/demeter/.config/neofetch/image.png" # auto /path/to/img /path/to/ascii
    image_size="200px" # auto 00px 00% none

    ascii_distro=$(grep -Eo '^ID="?[^"]*"?$' /etc/os-release | cut -d= -f2 | tr -d '"')_small
    ascii_colors=(distro)
    ascii_bold="on"

    image_loop="true"
    crop_mode="normal" # normal fit fill
    crop_offset="center" # northwest north northeast west center east southwest south southeast
    gap=0 # num -num
'';
}
