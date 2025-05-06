use std/util "path add"

# path
path add "~/.local/bin"
path add "/usr/local/bin"
path add "~/management/scripts"

# nu config
$env.config.show_banner = false
$env.config.edit_mode = "vi"
$env.config.buffer_editor = "nvim"
$env.config.cursor_shape.vi_insert = "line"
$env.config.cursor_shape.vi_normal = "block"

# prompt
$env.starship_shell = "nu"

def create_left_prompt [] {
    starship prompt --cmd-duration $env.CMD_DURATION_MS $'--status=($env.LAST_EXIT_CODE)'
}

$env.prompt_command = { || create_left_prompt }
$env.prompt_command_right = ""

$env.prompt_indicator = ""
$env.prompt_indicator_vi_insert = ""
$env.prompt_indicator_vi_normal = ""
$env.prompt_multiline_indicator = "::: "

# env variables
$env.JSII_SILENCE_WARNING_UNTESTED_NODE_VERSION = 1
$env.GEMINI_API_KEY = (pass google/gemini-api)
$env.MISTRAL_API_KEY = (pass mistral/api)
$env.CODESTRAL_API_KEY = (pass mistral/codestral-api)


# aliases
alias df = df -h
alias vim = nvim
alias cat = bat
alias lazysync = nvim --headless '+Lazy! sync' +qa
alias dotfiles = git --git-dir=($env.home | path join .dotfiles) --work-tree=($env.home)

def update [] { brew update; brew upgrade }
