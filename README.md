# FestiveBlock26

Repo for the Festive Block 26 mod pack, resource pack and server.
Minecraft **1.21.1**, **NeoForge 21.1.267**, managed with [packwiz](https://packwiz.infra.link/).

## What's in the pack

| Mod | Why |
| --- | --- |
| Snow! Real Magic! | Snow layers pile up, fall and melt |
| Snow Under Trees | No bare patches under trees |
| Cold Sweat | Body temperature: dress warm or freeze |
| Biomes O' Plenty | Extra snowy biomes (all non-snowy BOP biomes are switched off) |
| Biome Replacer | Swaps every non-snowy vanilla overworld biome for a snowy one |
| Musket Mod | Craftable flintlock muskets and pistols |
| Enhanced Celestials | Blood moons and harvest moons |
| Simple Voice Chat | Proximity voice chat (default key: hold `Caps Lock` to talk) |
| Sound Physics Remastered | Realistic echo and muffling (client only) |
| Distant Thunders | Thunder arrives later the further away the strike is (client only) |
| Pretty Rain | Particle rain and snow (client only) |

Dependencies (Kiwi, TerraBlender, GlitchCore, etc.) are added automatically.

### Snow-only world generation

- `modpack/config/biomesoplenty/biome_toggles.json`: only BOP's snowy biomes are on
  (Auroral Garden, Muskeg, Snowblossom Grove, Snowy Coniferous Forest, Snowy Fir Clearing,
  Snowy Maple Woods, Wintry Origin Valley), plus BOP's cave, Nether and End biomes.
- `modpack/config/biome_replacer.properties`: e.g. plains → snowy plains, forests → snowy taiga,
  badlands → ice spikes, oceans → frozen ocean. Terrain shape is unchanged.
- Vanilla cave biomes (lush caves, dripstone, deep dark) are kept so caves and ancient cities still work.

Both are worldgen settings: get them right **before** generating the world.

## Layout

```
modpack/        packwiz pack (pack.toml, index.toml, mods/*.pw.toml, config/)
resourcepack/   source for the custom resource pack (only files we change)
server/         server settings + install/start scripts
scripts/        helper scripts for building the pack
```

## Tools you need (once)

- **Java 21**: e.g. [Adoptium Temurin 21](https://adoptium.net/)
- **packwiz**: download the Windows build from
  [nightly.link](https://nightly.link/packwiz/packwiz/workflows/go/main), extract `packwiz.exe`
  and put its folder on your PATH (or install Go and run `go install github.com/packwiz/packwiz@latest`)
- **Prism Launcher**: <https://prismlauncher.org/> (what everyone plays with)

## First-time setup

```powershell
powershell -ExecutionPolicy Bypass -File scripts\setup-mods.ps1
```

This adds all the mods to `modpack/mods/` as small `.pw.toml` files. Commit those.

## Day-to-day

| Task | Command (from repo root) |
| --- | --- |
| Add a mod | `cd modpack; packwiz modrinth add <slug>` |
| Update all mods | `cd modpack; packwiz update --all` |
| After editing anything in `modpack/` by hand | `cd modpack; packwiz refresh` |
| Build the resource pack into the modpack | `scripts\build-resourcepack.ps1` |
| Build the file for friends | `scripts\export-mrpack.ps1` → `dist\FestiveBlock26.mrpack` |

## Playing (friends)

1. Install Prism Launcher and Java 21.
2. In Prism: **Add Instance → Import** → choose `FestiveBlock26.mrpack`.
3. Launch and join the server. When the pack changes, import the new `.mrpack`.

## Running the server

```powershell
powershell -ExecutionPolicy Bypass -File server\install-server.ps1   # once
# read https://aka.ms/MinecraftEULA, then create server\eula.txt containing: eula=true
powershell -ExecutionPolicy Bypass -File server\start-server.ps1     # every time
```

`start-server.ps1` re-syncs mods and configs from `modpack/` before every start, so the
server always matches the pack. The whitelist is on: add friends with `/whitelist add <name>`.
RAM is set in `server/user_jvm_args.txt`.

**Voice chat:** Simple Voice Chat uses **UDP port 24454** on the server, separate from the
game's TCP port 25565. If you port-forward, forward 24454/UDP too, or voice won't connect.

## Resource pack

Only put files you actually change in `resourcepack/`. Minecraft uses vanilla for everything else.
To get originals to edit, open `%APPDATA%\.minecraft\versions\1.21.1\1.21.1.jar` with 7-Zip and
extract `assets/minecraft` into `vanilla-ref/` (git-ignored; Mojang's assets must not be committed).
Copy a file into the **same path** under `resourcepack/assets/minecraft/` and edit it there.
