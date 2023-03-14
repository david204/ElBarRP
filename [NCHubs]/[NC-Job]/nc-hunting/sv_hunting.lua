local QBCore = exports['qb-core']:GetCoreObject()

local playersInZone = {}

RegisterNetEvent("qb-hunting:server:sellMeat", function()
    local src      = source
    local Player   = QBCore.Functions.GetPlayer(src)
    local total    = 0


    for itemName, itemPrices in pairs(Config.Prices.Items) do
        local item = Player.Functions.GetItemByName(itemName)
        if(item ~= nil) then
            --local multi = Config.Levels[item.cutBy] or 1
            local price = math.random(itemPrices.min, itemPrices.max)

            total = total + price
            Player.Functions.RemoveItem(itemName, 1)
        end
    end

    Player.Functions.AddMoney("cash", total, "qb-hunting:server:sellMeat")
end)

RegisterNetEvent("qb-hunting:server:collectMeat", function(animalHash, item)
    local src      = source
    local Player   = QBCore.Functions.GetPlayer(src)
    local itemName = Config.Animals[animalHash].meatName

    if(itemName == nil) then
        DropPlayer(src, "Used unauthorized trigger")
    end

    local amount = math.random(Config.Animals[animalHash].meatAmount.min, Config.Animals[animalHash].meatAmount.max)

    if (Player ~= nil) then 
        print(itemName)
        print(amount)
        Player.Functions.AddItem(itemName, amount)
        TriggerClientEvent("QBCore:Notify", src, "Collected " .. amount .. "kg of " .. itemName)

        Player = QBCore.Functions.GetPlayer(src)

        -- Level system and all this shit
        if(item.info.animals == nil) then
            item.info.animals = 0
        end

        if(item.info.level == nil) then
            item.info.level = 1
        end

        item.info.level = tonumber(item.info.level)
        item.info.animals = tonumber(item.info.animals)
        item.info.cutBy = item.info.level

        local level = item.info.level

        if(item.info.level == 3) then
            item.info.animals = item.info.animals + 1
            item.info.animalsMax = "Maxed"
        --[[elseif(item.info.animals + 1 >= Config.Levels[level + 1]) then
            -- Should Rank Up
            item.info.animals = 0
            item.info.level = item.info.level + 1
            item.info.animalsMax = Config.Levels[item.info.level + 1]
          ]]
            if(item.info.level == 3) then
                item.info.animalsMax = "Maxed"
            end

            TriggerClientEvent("QBCore:Notify", src, "You knife leveled up to " .. item.info.level, "success", 10000)
        else
            item.info.animals = item.info.animals + 1
            --item.info.animalsMax = Config.Levels[item.info.level + 1]
        end

        Player.PlayerData.items[item.slot] = item
        Player.Functions.SetInventory(Player.PlayerData.items, false)
    end
end)

QBCore.Functions.CreateUseableItem("hunting_knife", function(source, item)
    TriggerClientEvent("qb-hunting:client:useKnife", source, item.info.level or 1, item.info.animals or 0, item)
end)