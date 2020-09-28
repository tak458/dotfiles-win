$ui = (Get-Host).UI.RawUI 
$ui.WindowTitle = "$($ui.WindowTitle) $(Get-ExecutionPolicy)"

function Prompt {
    $current = Split-Path (Get-Location) -Leaf
    if ($?) {
        Write-Host "[$current]"  -NoNewLine -ForegroundColor "Green"
        return "> "
    }
    else {
        Write-Host "[$current]"  -NoNewLine -ForegroundColor "Red"
        return "> "
    }
}

# Alias
Set-Alias dc docker-compose
Set-Alias d docker
Set-Alias ll ls

# Chocolatey profile
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
    Import-Module "$ChocolateyProfile"
}

# Log for Evidence
$logFileName = "C:\pwsh_log\" + (Split-Path (Get-Location) -Leaf) + "_" + (Get-date -Format "yyyyMMdd_HHmmss") + ".log"
Start-Transcript $logFileName -append
