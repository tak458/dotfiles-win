# dotfiles-win

Windows 用 dotfiles

### Windows (PowerShell)

```powershell
Set-Location ~
git clone https://github.com/tak458/dotfiles-win.git
Set-Location dotfiles-win

Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Force
iwr -useb get.scoop.sh | iex
```
