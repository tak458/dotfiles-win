function Set-DotFiles {
    param (
        [string]$dir,
        [string]$file
    )

    $dirFile = Join-Path $dir $file
    Write-Output $dirFile

    if ((Test-Path $dirFile) -and ((Get-Item $dirFile).LinkType -ne "SymbolicLink")) {
        # 対象ファイルが存在しシンボリックリンクでなければバックアップ
        New-Item ~\dotfiles_backup\$now -ItemType Directory -Force
        Move-Item $dirFile ~\dotfiles_backup\$now\$file
        Write-Output "backup saved as ~\dotfiles_backup\$now\$file"
    }
    elseif (Test-Path $dirFile) {
        # 対象ファイルが存在しシンボリックリンクならば削除
        Remove-Item $dirFile
    }
    New-Item -Path $dir -Name $file -ItemType SymbolicLink -Target "$(Get-Location)\$file"
}

$now = Get-Date -format "yyyy.MM.dd.hh.mm.ss"

$includeEntries = @("^\..*$")
$excludeEntries = @("\.editorconfig", "\.gitconfig", "PowerShell", "WindowsPowerShell")

Get-ChildItem | Where-Object {
    $file = $_.Name
    $matchIncludeEntries = @($includeEntries | Where-Object { $file -match $_ })
    $matchExcludeEntries = @($excludeEntries | Where-Object { $file -notmatch $_ })
    ($matchIncludeEntries.Count -gt 0) -and ($matchExcludeEntries.Count -eq $excludeEntries.Count)
} | ForEach-Object {
    Set-DotFiles "~" $_.Name
}

$MyDocuments = [Environment]::GetFolderPath("MyDocuments")

# PowerShell Core
Set-DotFiles "$MyDocuments" "PowerShell"

# Windows PowerShell
Set-DotFiles "$MyDocuments" "WindowsPowerShell"
