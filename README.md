# MYHUB

Zone 12 and Zone 13 egg farming, garden sorting and AFK Egg movement panel. Version 7.1.

```lua
loadstring(game:HttpGet("https://raw.githubusercontent.com/Malmon01/Myhub/main/main.lua"))()
```

Select Zone 12 or Zone 13, open Egg types to choose which eggs to farm, then enable Auto Farm. The list learns egg names from the selected zone as eggs load. Zone switching saves each zone's egg, rarity, Garden and AFK filters for the current session and stops active automation. A pending AFK pickup must finish or be cancelled first. Enter Zone 13 manually if its eggs or entry floor have not loaded.

Auto Gem is below Noclip in the Farm tab. It uses the shared Tween speed (300 studs/s by default) and selects loaded drops in the selected zone without a distance cutoff. Starting Auto Farm enables Auto Gem and checks for gems before choosing the next egg. An eligible AFK animal takes priority, and verified AFK delivery switches Auto Gem off.

Version 6.4 uses a compact draggable panel with Farm, AFK, Garden and Performance tabs. Movement, Auto Farm and AFK Egg use switches. Egg selection supports multiple checked options. Tween speed supports a slider and direct numeric entry (10–500 studs/s).

For the selected zone, enable Garden mode, select one or more egg types to keep, optionally enter minimum **Max HP** such as `300t`, then enable Auto Farm on the Farm tab. Wrong types and wanted types below the threshold are broken; matching eggs at or above the threshold are retained. Blank Max HP keeps selected types at any size. Normal farming remains unchanged when Garden mode is off. The garden filter uses MaxHealth, not remaining Health or weight. Unknown MaxHealth, invalid input or an empty keep list pauses selection safely. Monitoring covers loaded eggs in the selected zone; it does not claim that unloaded locations are complete. AFK Egg can remain armed independently.

Anti-idle remains active while the panel exists. No automatic leave, reconnect, rejoin or server-hop is added. Disconnects, client crashes, server shutdown and kicks cannot be prevented by this script.

Version 6.3 reduces script overhead with event-maintained egg/pickup/income-label indexes, cached raycast filters and character parts, and throttled target/Titanic checks. Egg death and pickup/return confirmation remain checked every frame or through attribute events.

`Reduce Hatch FX` defaults ON. It suppresses the observed particle-only HatchVFX emitters and hit/reveal highlights, and locally hides finished egg geometry, including client-predicted breaks before replication. Hidden egg rigs skip visual-only ModelScaler.Apply writes; live eggs and animal rigs continue normally. The toggle and panel unload restore the cosmetic changes. The script does not change rewards, health, hatch timing, animal attributes, carry prompts, collision or game remotes for this feature. Income labels remain readable. The title displays sampled FPS; performance still depends on the game and device.

For AFK Egg, leave income blank for manual pickup, or enter a minimum income per second such as `100b`, `1t`, or `10t`. Automatic selection waits briefly for hatch results and picks the highest eligible displayed income in the selected zone. It pauses farming and uses the original guardian-hit, pickup, and return sequence.

The MYHUB panel renders above the game HUD. The AFK tab offers Auto Shadowgale in Zone 12 and separate CastleCrab, CastleCroc, and Beholder switches in Zone 13. These targets require AFK Egg to be enabled. If a pickup meets the income threshold during selection, it takes priority. Otherwise the nearest enabled rare target in the selected zone can be collected at any size or weight. With blank income, manual pickup and optional rare targets are available. After any verified delivery, AFK Egg switches off and Infinite Jump and Noclip switch on.

AFK travel targets the guardian for the selected animal's zone and waits if that guardian is unloaded. Both zones use the same AFK return point. Return travel waits for a stable single-animal carry after pickup and checks the carry and destination again after ragdoll recovery. A denied return retries the same zone's guardian. Farming switches targets when an egg is no longer live.

The ragdoll return is stabilized for up to three seconds during ragdoll and checked again after recovery. Guardian travel samples floor heights and pauses when floor data is unavailable.

Automatic mode does not select an already-held animal for a new transaction. Only static Zone12 egg positions define the eligible pickup area, so a roaming guardian cannot cause a delivered animal to be selected outside the final stage.

Simulated checks cover stable carry handoff, guardian zone isolation, unloaded guardians, elevated and missing floors, return rollback, cancellation and reused pickup models. Live delivery verification is pending.

Anti-idle stays connected while the panel exists. Drag the title to move the panel. Re-running replaces the previous panel and disconnects its handlers.

`main.lua` is minified to shorten the distribution file. Minification does not prevent copying or reverse engineering.

This client script depends on the game's current controllers, attributes, loaded models, and the executor's supported APIs. Review game-specific runtime validation before treating a new release as fully tested.
