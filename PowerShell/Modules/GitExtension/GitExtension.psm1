function Remove-GitBranchMerged {

    $dir = $args.count -eq 0 ? (Get-Location) : $args[0]

    Write-Host ("target directory:" + $dir)

    Push-Location $dir

    git fetch --prune origin
    git branch --merged `
        | Select-String -NotMatch -Pattern "(\*|develop|master)" `
        | ForEach-Object { git branch -d $_.ToString().Trim() }

    Pop-Location
}
