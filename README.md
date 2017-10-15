# dotfiles
my dotfiles

# Windows で Powershell の設定を配置する
``` Powershell
cd $profile/..
New-Item -ItemType SymbolicLink -Name Microsoft.PowerShell_profile.ps1 -Target ./dotfiles/.profi
le.ps1
```

# Windows で Powershell から Emacs を立ち上げる
```Powershell
emacs -nw
```
