AddEventHandler("vorp:SelectedCharacter",function(source,character)
    if character.getUsedCharacter then
		MySQL.Async.fetchAll("SELECT lifeStyle FROM users WHERE identifier = @identifier", {
			['@identifier'] = character.getUsedCharacter
		}, function(result)
			if result[1] then
				Player(source).state.lifeStyle = result[1].lifeStyle
			end
		end)
	end
end)

RegisterServerEvent('ez_lifeStyle:chooseStyle', function(id)
	local src = source
	Player(source).state.lifeStyle = id

	local uniqueId = Config.GetUniqueIdentifierForCharacter(src)

    MySQL.Sync.execute("UPDATE characters SET lifestyle = @lifeStyle WHERE charidentifier = @identifier", {
        ['@identifier'] = uniqueId,
        ['@lifeStyle'] = id
    })

	SetTimeout(Config.GiveStarterItemsDelay, function()
		Config.GiveStarterItems(src, id)
	end)
end)

GetLifeStyle = function(source)
	return Player(source).state.lifeStyle or "civilian"
end

exports('GetLifeStyle', GetLifeStyle)