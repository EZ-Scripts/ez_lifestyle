local spawnLocation, spawnHeading = vector3(1,1,1), 0
GetLifeStyle = function()
    return LocalPlayer.state.lifeStyle or Config.DefaultLifeStyle
end

exports('GetLifeStyle', GetLifeStyle)

RegisterCommand("lifestyle", function()
    OpenStyleMenu()
end, true)

OpenStyleMenu = function()
    SetNuiFocus(true, true)
    SendNUIMessage({
        type = "open",
        lifeStyles = Config.LifeSyles
    })
end

RegisterNUICallback('play', function(data, cb)
    local id = data.id
    SetNuiFocus(false, false)
    TriggerServerEvent('ez_lifeStyle:chooseStyle', id, spawnLocation, spawnHeading)
end)

RegisterNUICallback('close', function(data, cb)
    SetNuiFocus(false, false)
end)

RegisterNetEvent('ez_lifeStyle:openStyles', function(_spawnLocation, _spawnHeading)
    OpenStyleMenu()
    spawnLocation, spawnHeading = _spawnLocation, _spawnHeading -- Only used when the lifeStyle chosen has false as the spawn location and heading
end)