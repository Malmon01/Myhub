# MYHUB

Zone 12 egg farming, garden sorting and AFK Egg movement panel. Version 6.5.

```lua
loadstring(game:HttpGet("https://raw.githubusercontent.com/Malmon01/Myhub/main/main.lua"))()
```

Select Void, Omega, or Spectral eggs, choose whether Titanic eggs take priority, then enable Auto Farm. Default tween speed is 300 studs/s.

Version 6.4 uses a compact draggable panel with Farm, AFK, Garden and Performance tabs. Movement, Auto Farm and AFK Egg use switches. Egg selection supports multiple checked options. Tween speed supports a slider and direct numeric entry (10–500 studs/s).

Garden: enable Garden mode, select one or more egg types to keep, optionally enter minimum **Max HP** such as `300t`, then enable Auto Farm on the Farm tab. Wrong types and wanted types below the threshold are broken; matching eggs at or above the threshold are retained. Blank Max HP keeps selected types at any size. Normal farming remains unchanged when Garden mode is off. The garden filter uses MaxHealth, not remaining Health or weight. Unknown MaxHealth, invalid input or an empty keep list pauses selection safely. Monitoring covers loaded Zone12 eggs; it does not claim that unloaded locations are complete. AFK Egg can remain armed independently.

Anti-idle remains active while the panel exists. No automatic leave, reconnect, rejoin or server-hop is added. Disconnects, client crashes, server shutdown and kicks cannot be prevented by this script.

Version 6.3 reduces script overhead with event-maintained egg/pickup/income-label indexes, cached raycast filters and character parts, and throttled target/Titanic checks. Egg death and pickup/return confirmation remain checked every frame or through attribute events.

`Reduce Hatch FX` defaults ON. It suppresses the observed particle-only HatchVFX emitters and hit/reveal highlights, and locally hides finished egg geometry, including client-predicted breaks before replication. Hidden egg rigs skip visual-only ModelScaler.Apply writes; live eggs and animal rigs continue normally. The toggle and panel unload restore the cosmetic changes. The script does not change rewards, health, hatch timing, animal attributes, carry prompts, collision or game remotes for this feature. Income labels remain readable. The title displays sampled FPS; performance still depends on the game and device.

For AFK Egg, leave income blank for manual pickup, or enter a minimum income per second such as `100b`, `1t`, or `10t`. Automatic selection waits briefly for hatch results and picks the highest eligible displayed income in Zone 12. It pauses farming and uses the original guardian-hit, pickup, and return sequence.

Auto Shadowgale is available in the AFK tab and requires AFK Egg to be enabled. If a pickup meets the income threshold during selection, it takes priority. Otherwise the nearest eligible Zone 12 Shadowgale can be collected at any size or weight. With blank income, manual pickup and the optional Shadowgale fallback are available. After any verified delivery, AFK Egg switches off and Infinite Jump and Noclip switch on.

AFK travel uses the configured tween speed, retries unconfirmed pickups, and verifies both the carried animal and destination after ragdoll recovery. A denied return retries the guardian sequence. Farming switches targets immediately when an egg is no longer live, without waiting for hatch labels.

Version 6.2 starts the return from the carry-attribute replication callback, including when the prompt helper yields. The ragdoll return is briefly stabilized for at most three seconds while ragdolled, then checked after recovery. Guardian travel samples floor heights and rises before elevated terrain; a retry uses the nearest loaded guardian rather than chasing one across the map. Missing floor data pauses travel. Cancellation is checked before retry status/actions.

Automatic mode does not select an already-held animal for a new transaction. Only static Zone12 egg positions define the eligible pickup area, so a roaming guardian cannot cause a delivered animal to be selected outside the final stage.

Validation: source and distribution parse checks and simulated immediate carry handoff, elevated floor, nearest guardian, unloaded floor, pickup, rollback, recovery, cancellation and reused-model scenarios passed. These changes have not yet completed a live game regression. Server denial, missing targets and respawns can still prevent delivery.

Anti-idle stays connected while the panel exists. Drag the title to move the panel. Re-running replaces the previous panel and disconnects its handlers.

`main.lua` is minified to shorten the distribution file. Minification does not prevent copying or reverse engineering.

This client script depends on the game's current controllers, attributes, loaded models, and the executor's supported APIs. Review game-specific runtime validation before treating a new release as fully tested.
