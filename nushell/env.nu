# create cache-dir
mkdir $nu.cache-dir

# carapace
carapace _carapace nushell | save -f ($nu.cache-dir | path join carapace.nu)

# zoxide
zoxide init nushell | save -f ($nu.cache-dir | path join zoxide.nu)
