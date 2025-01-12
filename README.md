# Radial Menu

**A radial menu for redm, specially for VORP. It can be easily updated to be integrated to another framework by a developer.**

## Script Features
- Menu to select life styles.
- Section to add starter items and money.
- Uses state bags to efficiently store data.

## Getting Life Style
There are 2 ways of getting the life style of a player, using **export** or using the **state bag**. The export uses default civilian if lifestyle is nil whilst the state bag will return nil if lifestyle is nil.
### Server
```lua
Player(source).state.lifeStyle
```
or
```lua
exports["ez_lifestyle"]:GetLifeStyle(source)
```

### Client
```lua
LocalPlayer.state.lifeStyle
```
or
```lua
exports["ez_lifestyle"]:GetLifeStyle()
```

## Installation
### 1. Go to vorp_character/server/server.lua and search for the event "". Change/ modify it to add the following code.
```lua
-- Check if resourse ez_lifestyle is running
local function CheckLifeStyle()
	if GetResourceState("ez_lifestyle") == "started" then
		return true
	end
	return false
end

RegisterServerEvent("vorpcharacter:saveCharacter", function(data)
	local _source = source
	Core.getUser(_source).addCharacter(data)
	Wait(600)

	local iniPos, iniHead = iniSpawn()
	if CheckLifeStyle() then
		TriggerClientEvent("ez_lifeStyle:openStyles", _source, iniPos, iniHead)
	else
		TriggerClientEvent("vorp:initCharacter", _source, iniPos, iniHead, false)
	end
	SetTimeout(3000, function()
		TriggerEvent("vorp_NewCharacter", _source)
	end)
end)
```

*Just in case if you ever want to remove the script, you do not have to worry about removing the code, as we have made use of the function CheckLifeStyle() to check if the resource is running or not.*

*If you have renamed the script, make sure to change the name of the resource in the function CheckLifeStyle()*

### 2. [Optional] Make sure to remove default cash for new players from vorp_core/config.lua. Furthermore, make sure to remove any default items and weapons from the vorp_inventory/config.lua.
