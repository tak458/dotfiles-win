# load other scripts
Push-Location (Split-Path -parent $profile)
"aliases", "prompt" `
    | Where-Object { Test-Path "$_.ps1" } `
    | ForEach-Object -process { Invoke-Expression ". .\$_.ps1" }
Pop-Location

# Chocolatey profile
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
    Import-Module "$ChocolateyProfile"
}
