# 管理者権限チェック
if (-not(([Security.Principal.WindowsPrincipal] `
                [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(`
                [Security.Principal.WindowsBuiltInRole] "Administrator"`
        ))) {
    Write-Output "please execute as Administrator."
    exit
}

# install chocolatey
Set-ExecutionPolicy Bypass -Scope Process -Force; Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
cinst -y choco.package.config

$now = Get-Date -format "yyyy.MM.dd.hh.mm.ss"

$includeEntries = @("^\..*$")
$excludeEntries = @("\.editorconfig", "\.gitconfig", "PowerShell")

Get-ChildItem | Where-Object {
    $file = $_.Name; (@($includeEntries | Where-Object { $file -match $_ }).Count -gt 0) -and (@($excludeEntries | Where-Object { $file -notmatch $_ }).Count -eq $excludeEntries.Count)
} | ForEach-Object {
    $file = $_.Name
    if ((Test-Path "~/$file") -and ((Get-Item ~/$file).LinkType -ne "SymbolicLink")) {
        New-Item ~/dotfiles_backup/$now -ItemType Directory -Force
        Move-Item ~/$file ~/dotfiles_backup/$now/$file
        Write-Output "backup saved as ~/dotfiles_backup/$now/$file"
    }
    elseif (Test-Path "~/$file") {
        Remove-Item ~/$file
    }
    New-Item -Path ~/$file -ItemType SymbolicLink -Target "$(Get-Location)/$file"
}

# PowerShell
$MyDocuments = [Environment]::GetFolderPath("MyDocuments")
$file = "PowerShell"
if ((Test-Path "$MyDocuments/$file") -and ((Get-Item "$MyDocuments/$file").LinkType -ne "SymbolicLink")) {
    New-Item ~/dotfiles_backup/$now -ItemType Directory -Force
    Move-Item "$MyDocuments/$file" ~/dotfiles_backup/$now/$file
    Write-Output "backup saved as ~/dotfiles_backup/$now/$file"
}
elseif (Test-Path "~/$file") {
    Remove-Item ~/$file
}
New-Item -Path $MyDocuments -Name $file -ItemType SymbolicLink -Target "$(Get-Location)/$file"
