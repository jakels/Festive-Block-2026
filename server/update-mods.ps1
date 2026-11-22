# Syncs server mods + configs with ..\modpack (server-side mods only). Safe to re-run.
$ErrorActionPreference = "Stop"
Set-Location $PSScriptRoot
$boot = "packwiz-installer-bootstrap.jar"
if (-not (Test-Path $boot)) {
    Invoke-WebRequest "https://github.com/packwiz/packwiz-installer-bootstrap/releases/latest/download/$boot" -OutFile $boot
}
java -jar $boot -g -s server "..\modpack\pack.toml"
if ($LASTEXITCODE -ne 0) { throw "packwiz-installer failed" }
