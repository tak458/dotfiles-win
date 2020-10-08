# dotfiles-win

Windows 用 dotfiles

## Windows (PowerShell)

```powershell
Set-Location ~
git clone https://github.com/tak458/dotfiles-win.git
Set-Location dotfiles-win

Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Force
.\dotfiles.ps1
```

## 開発

Windows sandbox で実行する

1. start > windows sandbox
2. powershell を開く

```powershell
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Force

cd ~\Documents\
iwr -useb https://github.com/tak458/dotfiles-win/archive/master.zip -outfile dotfiles-win.zip
expand-archive .\dotfiles-win.zip
cd .\dotfiles-win\
cd .\dotfiles-win-master\
mv .\* ..\
cd ..\
rm .\dotfiles-win-master\
.\dotfiles.ps1
```
