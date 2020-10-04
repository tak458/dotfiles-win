cd $Args[0]
git branch --merged | Select-String -NotMatch -Pattern "(\*|develop|master)" | %{ git branch -d $_.ToString().Trim() }
git fetch --prune origin
