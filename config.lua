Config = {}
Core = exports.vorp_core:GetCore()
Config.DefaultLifeStyle = "civilian"
Config.GiveStarterItemsDelay = 5000

Config.LifeSyles = {
    outlaw = {
        name= "The Outlaw",
        description=  "A life of crime and rebellion. Rob, smuggle, and live by your own rules, always evading the law.",
        spawnLocation = vector3(1227.77, -1304.7, 76.95), -- Set to spawn location to spawn at
        spawnHeading = 140.49, -- Set to heading to spawn at
        starterItems = {
            {
                label = "Cattleman Revolver",
                quantity = 1,
                name = 'WEAPON_REVOLVER_CATTLEMAN',
                type = 'weapon'
            },
            {
                label = "Lockpick",
                quantity = 7,
                name = 'lockpick'
            },
            {
                label = "Whiskey Bottle",
                quantity = 5,
                name = 'whisky'
            },
            {
                label = "Cash",
                quantity = 50,
                type = 'money'
            }
        }
    },
    bounty_hunter = {
        name= "The Bounty Hunter",
        description=  "A skilled tracker paid to bring criminals to justice, dead or alive.",
        spawnLocation = vector3(-174.3, 621.18, 114.08),
        spawnHeading = 240.38,
        starterItems = {
            {
                label = "Cattleman Revolver",
                quantity = 1,
                name = 'WEAPON_REVOLVER_CATTLEMAN',
                type = 'weapon'
            },
            {
                label = "Lasso",
                quantity = 1,
                name = 'WEAPON_LASSO',
                type = 'weapon'
            },
            {
                label = "Whiskey Bottle",
                quantity = 5,
                name = 'whisky'
            },

        }
    },
    hunter = {
        name= "The Hunter",
        description=  "A self-reliant wanderer who hunts for food, trade, and survival in the wilderness.",
        spawnLocation = vector3(-687.3, -1242.249, 43.1),
        spawnHeading = 90.58,
        starterItems = {
            {
                label = "Bow",
                quantity = 1,
                name = 'WEAPON_BOW',
                type = 'weapon'
            },
            {
                label = "Arrows",
                quantity = 7,
                name = 'ammoarrownormal'
            },
            {
                label = "Hunting Knife",
                quantity = 5,
                name = 'WEAPON_MELEE_KNIFE',
                type = 'weapon'
            },
            {
                label = "Cash",
                quantity= 100,
                type = 'money'
            }
        }
    },
    civilian = {
        name= "The Civilian",
        description=  "An honest worker focused on stability, making a living through trade or craft.",
        starterItems = {
            {
                label = "Lantern",
                quantity = 1,
                name = 'WEAPON_MELEE_LANTERN',
                type = 'weapon'
            },
            {
                label = "Pocket Watch",
                quantity = 1,
                name = 'pocket_watch'
            },
            {
                label = "Food",
                quantity = 5,
                name = 'consumable_peach'
            },
            {
                label = "Water",
                quantity = 15,
                name = 'water'
            },
            {
                label = "Cash",
                quantity= 200,
                type = 'money'
            }
        }
    },
}

Config.GiveStarterItems = function(source, id)
    local VORPInv = exports.vorp_inventory
    local user = Core.getUser(source)
    if not user then
        print("User not found for source: ", source)
        return
    end
    local character = user.getUsedCharacter
    if not Config.LifeSyles[id] or not Config.LifeSyles[id].starterItems then
        print("Lifestyle or starter items not found for id: ", id)
        return
    end

    for k, v in pairs(Config.LifeSyles[id].starterItems) do
        print("Processing item: ", v.name, "type: ", v.type, "quantity: ", v.quantity)

        if v.type == "item" then
            local itemCheck = VORPInv:getItemDB(v.name)
            local canCarry = VORPInv:canCarryItems(source, v.quantity)
            local canCarry2 = VORPInv:canCarryItem(source, v.name, v.quantity)

            if not itemCheck or not canCarry or not canCarry2 then
                print("Cannot carry item or item not in DB: ", v.name)
                goto continue
            end

            VORPInv:addItem(source, v.name, v.quantity)
            print("Added item: ", v.name, "quantity: ", v.quantity)

        elseif v.type == "weapon" then
            local canCarry = VORPInv:canCarryWeapons(source, v.quantity, nil, v.name)
            if not canCarry then
                print("Cannot carry weapon: ", v.name)
                goto continue
            end

            local result = VORPInv:createWeapon(source, v.name, {})
            if not result then
                print("Failed to create weapon: ", v.name)
                goto continue
            end
            print("Created weapon: ", v.name)

        elseif v.type == "money" then
            character.addCurrency(0, v.quantity)
            print("Added money: ", v.quantity)

        elseif v.type == "gold" then
            character.addCurrency(1, v.quantity)
            print("Added gold: ", v.quantity)

        elseif v.type == "rol" then
            character.addCurrency(2, v.quantity)
            print("Added ROL: ", v.quantity)
        end
        ::continue::
    end
    return true
end


Config.GetUniqueIdentifierForCharacter = function(source)
    local Core = exports.vorp_core:GetCore()
    local user = Core.getUser(source)
    if not user then return end
    local character = user.getUsedCharacter
    return character.charIdentifier
end