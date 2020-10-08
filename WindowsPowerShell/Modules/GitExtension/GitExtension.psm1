function Remove-GitBranchMerged {
    Set-Location $Args[0]
    git branch --merged `
        | Select-String -NotMatch -Pattern "(\*|develop|master)" `
        | ForEach-Object{ git branch -d $_.ToString().Trim() }
    git fetch --prune origin
}
