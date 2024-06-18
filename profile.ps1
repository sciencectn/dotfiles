Import-Module ZLocation
New-Alias -Name "j" Invoke-ZLocation
New-Alias -Name "subl" "C:\Program Files\Sublime Text\subl.exe"
Set-PSReadLineOption -PredictionViewStyle ListView
Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete
Import-Module git-aliases -DisableNameChecking
