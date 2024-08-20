# Define variables
$dir = "$HOME/dotfiles"                          # Dotfiles directory
$olddir = "$HOME/dotfiles_old"                   # Old dotfiles backup directory
$files = "vimrc gitconfig"                       # List of files to symlink in home directory

# Create dotfiles_old directory in home directory
Write-Host "Creating $olddir for backup of any existing dotfiles in $HOME"
New-Item -ItemType Directory -Force -Path $olddir | Out-Null
Write-Host "...done"

# Change to the dotfiles directory
Write-Host "Changing to the $dir directory"
Set-Location -Path $dir
Write-Host "...done"

# Move existing dotfiles in home directory to dotfiles_old directory, then create symlinks
foreach ($file in $files.Split(' ')) {
    Write-Host "Moving any existing dotfiles from $HOME to $olddir"
    if (Test-Path "$HOME\.$file") {
        Move-Item -Force -Path "$HOME\.$file" -Destination $olddir
    }
    Write-Host "Creating symlink to $file in home directory."
    New-Item -ItemType SymbolicLink -Path "$HOME\.$file" -Target "$dir\$file"
}
