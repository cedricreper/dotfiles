# config.nu
#
# Installed by:
# version = "0.111.0"
#
# This file is used to override default Nushell settings, define
# (or import) custom commands, or run any other startup tasks.
# See https://www.nushell.sh/book/configuration.html
#
# Nushell sets "sensible defaults" for most configuration settings, 
# so your `config.nu` only needs to override these defaults if desired.
#
# You can open this file in your default editor using:
#     config nu
#
# You can also pretty-print and page through the documentation for configuration
# options using:
#     config nu --doc | nu-highlight | less -R
#
# Updated ghostty config with env = XDG_CONFIG_HOME=/Users/cedric/.config
# so that nushell points to this file instead of Application folder
$env.config.show_banner = false
$env.config.buffer_editor = "nvim"
$env.config.edit_mode = "vi"
def --wrapped dot [...args: string] {
  run-external "git" $"--git-dir=($env.HOME)/.dotfiles" $"--work-tree=($env.HOME)" ...$args
}
alias e = exit
alias c = clear
alias vim = nvim
alias zbr = zig build run
# Aliases - git
alias gap = git add -p
alias gco = git checkout
alias gcm = git commit -m
alias gpo = git push origin HEAD
def gfd [] { git fetch origin develop; git merge origin/develop }
def gfm [] { git fetch origin main; git merge origin/main }
def gcp [msg: string] { gap; gcm $msg; gpo }

# Aliases - docker/project
alias dclaude = claude --dangerously-skip-permissions
alias damp = amp --dangerously-allow-all
alias prettier = docker exec -it hats-gunicorn npx prettier . --write
alias trans = docker exec -it hats-gunicorn invoke prepare-l10n
alias fullbuild = docker exec -it hats-gunicorn invoke full-build
alias codegen = docker exec -it hats-gunicorn invoke codegen
alias dbash = docker exec -t -i hats-dramatiq /bin/bash
alias up = ./start_hats_local.sh up

def uifix [] {npm run ttag:update; npm run lint:fix}
def uiurls [] {npm run build:hats-codegen}

def dtest [test_path: string] {
    docker exec hats-gunicorn /bin/bash -c $"pytest ($test_path)"
}

def ruff [] {
    docker exec -it hats-gunicorn invoke ruff-format
    docker exec -it hats-gunicorn ruff check --fix
}

def gcomp [branch: string] {
    git fetch origin
    git checkout -b $"review/($branch)" $"origin/($branch)"
    let base = (git merge-base origin/main HEAD | str trim)
    git reset $base
}

def gdiff [] {
    git diff --name-only --relative --diff-filter=d -z | xargs -0 bat --diff
}

# tmux
alias ta = tmux attach-session -t
alias tls = tmux list-sessions
def th [] {
    tmux new-session -s h -c /Users/cedric/dev/hats
    #tmux new-window -c /Users/cedric/dev/hats
    #tmux split-window -h -c /Users/cedric/dev/hats
}

def tui [] {
    tmux new-session -s ui -c /Users/cedric/dev/ui
    #tmux new-window -c /Users/cedric/dev/ui
    #tmux split-window -h -c /Users/cedric/dev/ui

}
def tz [] {
    tmux new-session -s z -c /Users/cedric/dev/zig/zlox/
}

alias cat = bat

# fzf/zoxide scripts
source ~/scripts/fzf_listoldfiles.nu
source ~/scripts/zoxide_openfiles_nvim.nu

# open man page via fzf
def fman [] {
    let cmd = (bash -c "compgen -c" | fzf | str trim)
    if ($cmd | is-not-empty) { man $cmd }
}

# Init tools (these generate and cache their init scripts)
zoxide init nushell | save -f ~/.config/nushell/zoxide.nu
source ~/.config/nushell/zoxide.nu
source ~/.config/nushell/starship.nu


# keybindings
$env.config = {
  keybindings: [
    {
      name: disable_ctrl_space
      modifier: control
      keycode: "char_ " 
      mode: [emacs, vi_insert, vi_normal]
      event: { send: none }
    },
    # {
    #     name: take_history_hint
    #     modifier: none
    #     keycode: tab
    #     mode: [emacs, vi_normal]
    #     event: {
    #         until: [
    #             { send: historyhintwordcomplete }
    #         ]
    #     }
    # }
  ]
}
