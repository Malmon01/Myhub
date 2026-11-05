# MYHUB

Zone 12 egg farming and AFK Egg movement panel.

```lua
loadstring(game:HttpGet("https://raw.githubusercontent.com/Malmon01/Myhub/main/main.lua"))()
```

Select Void, Omega, or Spectral eggs, choose whether Titanic eggs take priority, then enable Auto Farm. Default tween speed is 300 studs/s.

For AFK Egg, leave income blank for manual pickup, or enter a minimum income per second such as `100b`, `1t`, or `10t`. Automatic selection waits briefly for hatch results and picks the highest eligible displayed income in Zone 12. It pauses farming and uses the original guardian-hit, pickup, and return sequence.

Anti-idle stays connected while the panel exists. Drag the title to move the panel. Re-running replaces the previous panel and disconnects its handlers.

`main.lua` is minified to shorten the distribution file. Minification does not prevent copying or reverse engineering.

This client script depends on the game's current controllers, attributes, loaded models, and the executor's supported APIs. Review game-specific runtime validation before treating a new release as fully tested.
