# env.nu
#
# Installed by:
# version = "0.111.0"
#
# Previously, environment variables were typically configured in `env.nu`.
# In general, most configuration can and should be performed in `config.nu`
# or one of the autoload directories.
#
# This file is generated for backwards compatibility for now.
# It is loaded before config.nu and login.nu
#
# See https://www.nushell.sh/book/configuration.html
#
# Also see `help config env` for more options.
#
# You can remove these comments if you want or leave
# them for future reference.

$env.PATH = (
    $env.PATH | split row (char esep)
    | prepend [
        ".local/bin"
        "/usr/local/bin"
        "/usr/bin"
        "/bin"
        ($env.HOME | path join ".cargo/bin")
        ($env.HOME | path join ".local/bin")
 ($env.HOME | path join "dev/zig-x86_64-linux-0.16.0")
    ]
    | uniq
)

$env.EDITOR = "nvim"
$env.VISUAL = "nvim"

$env.BAT_PAGER = ""   # disables the pager entirely
$env.BAT_THEME = "gruvbox-dark"

# todo install carapace
# $env.CARAPACE_BRIDGES = 'zsh,fish,bash,inshellisense' # optional
# mkdir $"($nu.cache-dir)"
# carapace _carapace nushell | save --force $"($nu.cache-dir)/carapace.nu"

# ${UserConfigDir}/nushell/config.nu
# source $"($nu.cache-dir)/carapace.nu"
