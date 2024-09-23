##################################################
# Arena インストール先の「Logs」フォルダのパスを書く。
# Write the path of the “Logs” folder where Arena is installed.

$path = "C:\Battlestate Games\Escape from Tarkov Arena\Logs"

##################################################

Write-Host "EFT:Arena Matching Notifier`r`n    © 2024 ergofriend" -ForegroundColor Cyan

if(-not(Test-Path $path)) {
    Write-Host "------------- ERROR -------------" -ForegroundColor White -BackgroundColor Red
    Write-Host "    $`path Path Does not Exist.    " -ForegroundColor White -BackgroundColor Red
    Write-Host "Check and Edit `$path in .ps1 file." -ForegroundColor White -BackgroundColor Red
    pause
    exit
}

## Add Notification Icon in Toolbar
[reflection.assembly]::loadwithpartialname('System.Windows.Forms') > $null
[reflection.assembly]::loadwithpartialname('System.Drawing') > $null
$notify = new-object system.windows.forms.notifyicon
$notify.icon = [System.Drawing.SystemIcons]::Information
$notify.visible = $true

## Define Target Log File (Latest "web_socket.log")
$latest = (Get-ChildItem $path | Sort-Object LastWriteTime -Descending)[0].FullName
$target = (Get-ChildItem $latest\*web_socket*.log | Sort-Object LastWriteTime -Descending)[0].FullName

## Reading Tail line for Monitoring
Write-Host "----------- Activated -----------" -ForegroundColor White -BackgroundColor DarkCyan
Get-Content -Wait -Tail 10 -Path $target | ForEach-Object {
    $now = Get-Date -format "yyyy/MM/dd HH:mm:ss"
    # Write-Host "logging: $_"
    If($_ -like "*activity = ArenaMatchMakingScreen, activity_state = Show*") {
        Write-Host "$now`t Matching started."
    } elseif($_ -like "*activity = ArenaMatchReadyPopup, activity_state = Show*") {
        Write-Host "$now`t Please Accept!"
        $notify.showballoontip(10,'EFT:Arena Matching Notifier','Please Accept!',[system.windows.forms.tooltipicon]::None)
    } elseif($_ -like "*all-players-confirmed*") {
        Write-Host "$now`t All players confirmed."
    } elseif($_ -like "*re-create-match-notification*") {
        Write-Host "$now`t Matching skipped."
    } elseif($_ -like "*activity = ArenaPresetsSelectionScreen, activity_state = Show*") {
        Write-Host "$now`t Game Start!"
        $notify.showballoontip(10,'EFT:Arena Matching Notifier','Game Start!',[system.windows.forms.tooltipicon]::None)
    }
}
