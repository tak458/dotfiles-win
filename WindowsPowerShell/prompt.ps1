$ui = (Get-Host).UI.RawUI 
$ui.WindowTitle = "$($ui.WindowTitle) $(Get-ExecutionPolicy)"

$pwsh_log = Join-Path $HOME ".pwsh_history.csv"

function Prompt {
    if ($?) {
        Write-Host "[$(Split-Path (Get-Location) -Leaf)]"  -NoNewLine -ForegroundColor "Green"
    }
    else {
        Write-Host "[$(Split-Path (Get-Location) -Leaf)]"  -NoNewLine -ForegroundColor "Red"
    }

    $latestHistory = Get-History -Count 1
    if ($script:lastHistory -ne $latestHistory) {
        Export-Csv -Path $pwsh_log -InputObject $latestHistory -Append
        $script:lastHistory = $latestHistory
    }

    return "> "
}

if (Test-Path $pwsh_log) {
    Import-Csv $pwsh_log | Add-History
}

# Log for Evidence
$logFileName = "C:\pwsh_log\" + (Split-Path (Get-Location) -Leaf) + "_" + (Get-date -Format "yyyyMMdd_HHmmss") + ".log"
Start-Transcript $logFileName -append
