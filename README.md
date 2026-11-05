# MYHUB

Zone 12 egg farming and AFK Egg movement panel. Version 6.1.

```lua
loadstring(game:HttpGet("https://raw.githubusercontent.com/Malmon01/Myhub/main/main.lua"))()
```

Select Void, Omega, or Spectral eggs, choose whether Titanic eggs take priority, then enable Auto Farm. Default tween speed is 300 studs/s.

For AFK Egg, leave income blank for manual pickup, or enter a minimum income per second such as `100b`, `1t`, or `10t`. Automatic selection waits briefly for hatch results and picks the highest eligible displayed income in Zone 12. It pauses farming and uses the original guardian-hit, pickup, and return sequence.

Version 6.1 uses the configured tween speed for guardian travel, retries unconfirmed pickups, and verifies both the carried animal and destination after ragdoll recovery. A denied return retries the guardian sequence. Automatic income mode stays armed after delivery until switched off; manual mode finishes after a verified return. Farming switches targets immediately when an egg is no longer live, without waiting for hatch labels.

Validation: source and distribution parse checks and simulated pickup, rollback, recovery, cancellation and reused-model scenarios passed. These changes have not yet completed a live game regression. Server denial, missing targets and respawns can still prevent delivery.

Anti-idle stays connected while the panel exists. Drag the title to move the panel. Re-running replaces the previous panel and disconnects its handlers.

`main.lua` is minified to shorten the distribution file. Minification does not prevent copying or reverse engineering.

This client script depends on the game's current controllers, attributes, loaded models, and the executor's supported APIs. Review game-specific runtime validation before treating a new release as fully tested.
