# One-time server install: NeoForge + mods/configs from ..\modpack. Needs Java 21.
#   powershell -ExecutionPolicy Bypass -File server\install-server.ps1
$ErrorActionPreference = "Stop"
Set-Location $PSScriptRoot
$pack = Get-Content "..\modpack\pack.toml" -Raw
$neo = [regex]::Match($pack, 'neoforge\s*=\s*"([^"]+)"').Groups[1].Value
$installer = "neoforge-$neo-installer.jar"

Write-Host "Downloading NeoForge $neo installer..."
Invoke-WebRequest "https://maven.neoforged.net/releases/net/neoforged/neoforge/$neo/$installer" -OutFile $installer

# Keep our JVM args in case the installer rewrites them
Copy-Item user_jvm_args.txt user_jvm_args.txt.bak -Force
java -jar $installer --installServer
if ($LASTEXITCODE -ne 0) { throw "NeoForge installer failed" }
Move-Item user_jvm_args.txt.bak user_jvm_args.txt -Force
Remove-Item $installer, "$installer.log" -ErrorAction SilentlyContinue

& "$PSScriptRoot\update-mods.ps1"
Write-Host ""
Write-Host "Done. Read the Minecraft EULA (https://aka.ms/MinecraftEULA), then create eula.txt containing eula=true."
Write-Host "Start the server with server\start-server.ps1"
