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

# Log for Evidence
$logFileName = "C:\pwsh_log\" + (Split-Path (Get-Location) -Leaf) + "_" + (Get-date -Format "yyyyMMdd_HHmmss") + ".log"
Start-Transcript $logFileName -append
