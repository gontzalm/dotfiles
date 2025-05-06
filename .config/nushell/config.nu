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
$env.hatch_config = ($env.home | path join .config/hatch/config.toml)
$env.jsii_silence_warning_untested_node_version = 1
$env.gemini_api_key = (pass google/gemini-api)
$env.mistral_api_key = (pass mistral/api)
$env.codestral_api_key = (pass mistral/codestral-api)


# aliases
alias df = df -h
alias vim = nvim
alias cat = bat
alias lazysync = nvim --headless '+Lazy! sync' +qa
alias dotfiles = git --git-dir=($env.home | path join .dotfiles) --work-tree=($env.home)

def update [] { brew update; brew upgrade }
