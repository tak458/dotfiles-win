$ui = (Get-Host).UI.RawUI 
$ui.WindowTitle = "$($ui.WindowTitle) $(Get-ExecutionPolicy)"

$pwsh_log = Join-Path $HOME ".pwsh_history.csv"

function Prompt {
    # カレントディレクトリの表示
    if ($?) {
        Write-Host "[$(Split-Path (Get-Location) -Leaf)]"  -NoNewLine -ForegroundColor "Green"
    }
    else {
        Write-Host "[$(Split-Path (Get-Location) -Leaf)]"  -NoNewLine -ForegroundColor "Red"
    }

    # 履歴のCSV保存
    $latestHistory = Get-History -Count 1
    if ($script:lastHistory -ne $latestHistory) {
        Export-Csv -Path $pwsh_log -InputObject $latestHistory -Append
        $script:lastHistory = $latestHistory
    }

    return "> "
}

# 履歴のロード
if (Test-Path $pwsh_log) {
    Import-Csv $pwsh_log | Add-History
}
