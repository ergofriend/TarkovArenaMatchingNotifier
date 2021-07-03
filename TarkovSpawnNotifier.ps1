﻿##################################################
# EFTインストール先の「eft」フォルダのパスを書く。
# Edit your EFT Installed path, and Save.

$eft = "D:\Battlestate Games\eft\Logs"

##################################################

Write-Host "Escape From Tarkov Spawn Notifier`r`n      © 2021 advanced_bear" -ForegroundColor Cyan

if(-not(Test-Path $eft)) {
    Write-Host "------------- ERROR -------------" -ForegroundColor White -BackgroundColor Red
    Write-Host "    $`eft Path Does not Exist.    " -ForegroundColor White -BackgroundColor Red
    Write-Host "Check and Edit `$eft in .ps1 file." -ForegroundColor White -BackgroundColor Red
    pause
    exit
}

## Add Notification Icon in Toolbar
[reflection.assembly]::loadwithpartialname('System.Windows.Forms') > $null
[reflection.assembly]::loadwithpartialname('System.Drawing') > $null
$notify = new-object system.windows.forms.notifyicon
$notify.icon = [System.Drawing.SystemIcons]::Information
$notify.visible = $true

## Define Target Log File (Latest "trace.log")
$latest = (Get-ChildItem $eft | Sort-Object LastWriteTime -Descending)[0].FullName
$target = (Get-ChildItem $latest\*traces*.log | Sort-Object LastWriteTime -Descending)[0].FullName
## Reading Tail line for Monitoring
Write-Host "----------- Activated -----------" -ForegroundColor White -BackgroundColor DarkCyan
Get-Content -Wait -Tail 10 -Path $target | ForEach-Object {
    $now = Get-Date -format "yyyy/MM/dd HH:mm:ss"
    If($_ -like "*MatchingCompleted*") {
        Write-Host "$now`tMatching Completed!"
        $notify.showballoontip(10,'Tarkov Spawn Notifier','Matching Completed!',[system.windows.forms.tooltipicon]::None)
    } elseif ($_ -like "*GameStarting*") {
        Write-Host "$now`tGame Starting!"
        $notify.showballoontip(10,'Tarkov Spawn Notifier','Game Starting!',[system.windows.forms.tooltipicon]::None)
    } elseif ($_ -like "*profileStatus*") {
        $_ -match "(Location: .*?)," > $null
        $Location = $Matches[1]
        Write-Host "$now`t$Location"
    } elseif ($_ -like "*ClientMetricsEvents*") {
        Write-Host "$now`tStart Match Making!"
    } elseif ($_ -like "*PlayerSpawnEvent*") {
        $_ -match "PlayerSpawnEvent:(\d+)" > $null
        $passedTime = [TimeSpan]::fromseconds($Matches[1])
        Write-Host "$now`tPlayer was Spawned! ->"($passedTime).ToString("hh\:mm\:ss") -ForegroundColor Green
    } elseif ($_ -like "*cancelled*") {
        Write-Host "$now`tMatching Cancelled!" -ForegroundColor Yellow
        $startTime = $null
    }
}
