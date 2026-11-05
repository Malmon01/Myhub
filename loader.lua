local source = game:HttpGet("https://raw.githubusercontent.com/Malmon01/Myhub/main/main.lua")
local run, err = loadstring(source)
assert(run, "MYHUB could not compile: " .. tostring(err))
run()
