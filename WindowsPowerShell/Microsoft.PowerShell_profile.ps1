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

# .env のロード
Get-ChildItem (Get-Location) |
    Where-Object {-not $_.PsIsContainer -and $_.Name -eq ".env"} |
    ForEach-Object { 
        Write-Host "Loading $_"
        Get-Content $_
    } |
    ForEach-Object {
        $key, $value = $_.split('=', 2);
        Invoke-Expression "`$env:$key='$value'"
        Write-Host "Loaded `$env:$key='$value' from $($_.Name)"
    }

# Log for Evidence
$logFileName = "C:\pwsh_log\" + (Split-Path (Get-Location) -Leaf) + "_" + (Get-date -Format "yyyyMMdd_HHmmss") + ".log"
Start-Transcript $logFileName -append
