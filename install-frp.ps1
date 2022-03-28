Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'
$ProgressPreference = 'SilentlyContinue'
trap {
    Write-Output "ERROR: $_"
    Write-Output (($_.ScriptStackTrace -split '\r?\n') -replace '^(.*)$','ERROR: $1')
    Exit 1
}

mkdir -Force frp | Out-Null
Push-Location frp

if (!(Test-Path frps.exe)) {
    Write-Output 'Downloading frp...'
    (New-Object System.Net.WebClient).DownloadFile(
        'https://github.com/fatedier/frp/releases/download/v0.34.2/frp_0.34.2_windows_amd64.zip',
        "$PWD/frp.zip")
    Write-Output 'Extracting frp...'
    tar xf frp.zip --strip-components=1
}


Write-Output 'Setting permissions for Scoop Installer...'
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser

Write-Output 'Installing Scoop...'
iwr -useb get.scoop.sh -outfile 'install.ps1'
.\install.ps1 -RunAsAdmin 
scoop bucket add extras
scoop update
scoop install aria2
scoop install irfanview
scoop install openoffice
scoop install brave
scoop install winscp
scoop install putty
scoop install teamviewer
scoop install anydesk
scoop install sumatrapdf
scoop install obs-studio
scoop install krita
scoop install audacity

Pop-Location
