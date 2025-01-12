AddEventHandler("vorp:SelectedCharacter",function(source,character)
    if character.getUsedCharacter then
		MySQL.Async.fetchAll("SELECT lifestyle FROM characters WHERE charidentifier = @identifier", {
			['@identifier'] = character.getUsedCharacter
		}, function(result)
			if result[1] then
				Player(source).state.lifeStyle = result[1].lifestyle
			end
		end)
	end
end)

RegisterServerEvent('ez_lifeStyle:chooseStyle', function(id, spawnLocation, spawnHeading)
	local spawnLocation = spawnLocation or vector3(1,1,1)
	local spawnHeading = spawnHeading or 0
	local src = source
	local uniqueId = Config.GetUniqueIdentifierForCharacter(src)
	if Config.ChooseLifeStyleOnce or Config.StarterItemsOnlyFirstTime then
		MySQL.Async.fetchAll("SELECT lifestyle FROM characters WHERE charidentifier = @identifier", {
			['@identifier'] = uniqueId
		}, function(result)
			if result[1] then
				local upt = false
				if result[1].lifestyle == nil then
					TriggerClientEvent("vorp:initCharacter", src, Config.LifeSyles[id].spawnLocation or spawnLocation, Config.LifeSyles[id].spawnHeading or spawnHeading, false)
					Player(src).state.lifeStyle =  id
					upt = true
					MySQL.Async.execute("UPDATE characters SET lifestyle = @lifeStyle WHERE charidentifier = @identifier", {
						['@identifier'] = uniqueId,
						['@lifeStyle'] = id
					})
					SetTimeout(5000, function()
						Config.GiveStarterItems(src, id)
					end)
				end
				if not upt and not Config.ChooseLifeStyleOnce then
					TriggerClientEvent("vorp:initCharacter", src, Config.LifeSyles[id].spawnLocation or spawnLocation, Config.LifeSyles[id].spawnHeading or spawnHeading, false)
					Player(src).state.lifeStyle =  id
					MySQL.Async.execute("UPDATE characters SET lifestyle = @lifeStyle WHERE charidentifier = @identifier", {
						['@identifier'] = uniqueId,
						['@lifeStyle'] = id
					})
				end
			end
		end)
	else
		TriggerClientEvent("vorp:initCharacter", src, Config.LifeSyles[id].spawnLocation or spawnLocation, Config.LifeSyles[id].spawnHeading or spawnHeading, false)
		Player(src).state.lifeStyle =  id
		MySQL.Async.execute("UPDATE characters SET lifestyle = @lifeStyle WHERE charidentifier = @identifier", {
			['@identifier'] = uniqueId,
			['@lifeStyle'] = id
		})
		SetTimeout(5000, function()
			Config.GiveStarterItems(src, id)
		end)
	end
end)

GetLifeStyle = function(source)
	return Player(source).state.lifeStyle or Config.DefaultLifeStyle
end

exports('GetLifeStyle', GetLifeStyle)