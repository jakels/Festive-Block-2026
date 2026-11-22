# Syncs mods with the pack, then starts the server.
$ErrorActionPreference = "Stop"
Set-Location $PSScriptRoot
& "$PSScriptRoot\update-mods.ps1"
if (-not (Test-Path eula.txt)) { throw "eula.txt missing - see install-server.ps1 output" }
.\run.bat --nogui
