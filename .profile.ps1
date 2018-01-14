# Disable beep on backspace
Set-PSReadlineOption -BellStyle None

# Set key-binding like Bash
Set-PSReadlineKeyHandler -Key 'Ctrl+u' -Function BackwardDeleteLine
Set-PSReadlineKeyHandler -Key 'Ctrl+b' -Function BackwardChar
Set-PSReadlineKeyHandler -Key 'Ctrl+f' -Function ForwardChar
Set-PSReadlineKeyHandler -Key 'Ctrl+d' -Function DeleteChar
Set-PSReadlineKeyHandler -Key 'Ctrl+h' -Function BackwardDeleteChar
Set-PSReadlineKeyHandler -Key 'Ctrl+p' -Function HistorySearchBackward
Set-PSReadlineKeyHandler -Key 'Ctrl+n' -Function HistorySearchForward
Set-PSReadlineKeyHandler -Key 'Ctrl+a' -Function BeginningOfLine
Set-PSReadlineKeyHandler -Key 'Ctrl+e' -Function EndOfLine

# Re-Define Pause command using any keys
function Pause
{
    if ($psISE) {
        $null = Read-Host 'Press Enter Key...'
    }
    else {
        Write-Host "Press Any Key..."
        (Get-Host).UI.RawUI.ReadKey("NoEcho,IncludeKeyDown") | Out-Null
    }
}

# Define sudo and su command
function Invoke-CommandRunAs
{
    $cd = (Get-Location).Path
    $commands = "Set-Location $cd; Write-Host `"[Administrator] $cd> $args`"; $args; Pause; exit"
    $bytes = [System.Text.Encoding]::Unicode.GetBytes($commands)
    $encodedCommand = [Convert]::ToBase64String($bytes)
    Start-Process powershell.exe -Verb RunAs -ArgumentList "-NoExit","-encodedCommand",$encodedCommand
}

Set-Alias sudo Invoke-CommandRunAs

function Start-RunAs
{
    $cd = (Get-Location).Path
    $commands = "Set-Location $cd; (Get-Host).UI.RawUI.WindowTitle += `" [Administrator]`""
    $bytes = [System.Text.Encoding]::Unicode.GetBytes($commands)
    $encodedCommand = [Convert]::ToBase64String($bytes)
    Start-Process powershell.exe -Verb RunAs -ArgumentList "-NoExit","-encodedCommand",$encodedCommand
}

Set-Alias su Start-RunAs

