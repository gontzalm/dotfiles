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
# $env.GEMINI_API_KEY = (pass google/gemini-api)
# $env.MISTRAL_API_KEY = (pass mistral/api)
# $env.CODESTRAL_API_KEY = (pass mistral/codestral-api)


# aliases
alias df = df -h
alias v = nvim
alias cat = bat
alias lazysync = nvim --headless '+Lazy! sync' +qa
alias dotfiles = git --git-dir=($env.home | path join .dotfiles) --work-tree=($env.home)

# List the filenames, sizes, and modification times of items in a directory.
def l [
    --long (-l),        # Get all available columns for each entry (slower; columns are platform-dependent)
    --short-names (-s), # Only print the file names, and not the path
    --full-paths (-f),  # display paths as absolute paths
    --du (-d),          # Display the apparent directory size ("disk usage") in place of the directory metadata size
    --directory (-D),   # List the specified directory itself instead of its contents
    --mime-type (-m),   # Show mime-type in type column instead of 'file' (based on filenames only; files' contents are not examined)
    --threads (-t),     # Use multiple threads to list contents. Output will be non-deterministic.
    ...pattern: glob,   # The glob pattern to use.
]: [ nothing -> table ] {
    let pattern = if ($pattern | is-empty) { [ '.' ] } else { $pattern }
    (ls
        -a
        --long=$long
        --short-names=$short_names
        --full-paths=$full_paths
        --du=$du
        --directory=$directory
        --mime-type=$mime_type
        --threads=$threads
        ...$pattern
    ) | sort-by type name -i
}
