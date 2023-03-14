local lastRob = 0
ESX, QBCore = nil
Citizen.CreateThread(function()
    if Config['PaletoHeist']['framework']['name'] == 'ESX' then
        TriggerEvent(Config['PaletoHeist']['framework']['eventName'], function(library) 
            ESX = library 
        end)
        ESX.RegisterServerCallback('paletoheist:server:checkPoliceCount', function(source, cb)
            local src = source
            local players = ESX.GetPlayers()
            local policeCount = 0
        
            for i = 1, #players do
                local player = ESX.GetPlayerFromId(players[i])
                if player['job']['name'] == Config['PaletoHeist']['setjobForPolice'] then
                    policeCount = policeCount + 1
                end
            end
        
            if policeCount >= Config['PaletoHeist']['requiredPoliceCount'] then
                cb({status = true})
            else
                cb({status = false})
                TriggerClientEvent('paletoheist:client:showNotification', src, Strings['need_police'])
            end
        end)
        ESX.RegisterServerCallback('paletoheist:server:checkTime', function(source, cb, index)
            local src = source
            local player = ESX.GetPlayerFromId(src)
            
            if (os.time() - lastRob) < Config['PaletoHeist']['nextRob'] and lastRob ~= 0 then
                local seconds = Config['PaletoHeist']['nextRob'] - (os.time() - lastRob)
                TriggerClientEvent('paletoheist:client:showNotification', src, Strings['wait_nextrob'] .. ' ' .. math.floor(seconds / 60) .. ' ' .. Strings['minute'])
                cb({status = false})
            else
                lastRob = os.time()
                discordLog(player.getName() ..  ' - ' .. player.getIdentifier(), ' started the Paleto Heist!')
                cb({status = true})
            end
        end)
        ESX.RegisterServerCallback('paletoheist:server:hasItem', function(source, cb, data)
            local src = source
            local player = ESX.GetPlayerFromId(src)
            local playerItem = player.getInventoryItem(data.itemName)
        
            if player and playerItem ~= nil then
                if playerItem.count >= 1 then
                    cb({status = true, label = playerItem.label})
                else
                    cb({status = false, label = playerItem.label})
                end
            else
                print('[rm_paletoheist] you need add required items to server database')
            end
        end)
    elseif Config['PaletoHeist']['framework']['name'] == 'QB' then
        while not QBCore do
            pcall(function() QBCore =  exports['qb-core']:GetCoreObject() end)
            if not QBCore then
                pcall(function() QBCore =  exports['qb-core']:GetSharedObject() end)
            end
            if not QBCore then
                TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)
            end
            Citizen.Wait(1)
        end
        QBCore.Functions.CreateCallback('paletoheist:server:checkPoliceCount', function(source, cb)
            local src = source
            local players = QBCore.Functions.GetPlayers()
            local policeCount = 0
        
            for i = 1, #players do
                local player = QBCore.Functions.GetPlayer(players[i])
                if player.PlayerData.job.name == Config['PaletoHeist']['setjobForPolice'] then
                    policeCount = policeCount + 1
                end
            end
        
            if policeCount >= Config['PaletoHeist']['requiredPoliceCount'] then
                cb({status = true})
            else
                cb({status = false})
                TriggerClientEvent('paletoheist:client:showNotification', src, Strings['need_police'])
            end
        end)
        QBCore.Functions.CreateCallback('paletoheist:server:checkTime', function(source, cb, index)
            local src = source
            local player = QBCore.Functions.GetPlayer(src)

            if (os.time() - lastRob) < Config['PaletoHeist']['nextRob'] and lastRob ~= 0 then
                local seconds = Config['PaletoHeist']['nextRob'] - (os.time() - lastRob)
                TriggerClientEvent('paletoheist:client:showNotification', src, Strings['wait_nextrob'] .. ' ' .. math.floor(seconds / 60) .. ' ' .. Strings['minute'])
                cb({status = false})
            else
                lastRob = os.time()
                discordLog(player.PlayerData.name ..  ' - ' .. player.PlayerData.license, ' started the Paleto Heist!')
                cb({status = true})
            end
        end)
        QBCore.Functions.CreateCallback('paletoheist:server:hasItem', function(source, cb, data)
            local src = source
            local player = QBCore.Functions.GetPlayer(src)
            local playerItem = player.Functions.GetItemByName(data.itemName)
        
            if player then 
                if playerItem ~= nil then
                    if playerItem.amount >= 1 then
                        cb({status = true, label = data.itemName})
                    end
                else
                    cb({status = false, label = data.itemName})
                end
            end
        end)
    end
end)

RegisterServerEvent("poleto:goldbargive")
AddEventHandler("poleto:goldbargive", function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    Player.Functions.AddItem('goldbar', 3)
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['goldbar'], "add")
end)


RegisterServerEvent("poleto:marktetbills")
AddEventHandler("poleto:marktetbills", function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    Player.Functions.AddItem("markedbills", math.random(20, 30))
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['markedbills'], "add")
end)


RegisterServerEvent("nc-paletoheist:yonatan:GiveCard")
AddEventHandler("nc-paletoheist:yonatan:GiveCard", function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    Player.Functions.AddItem('security_card_02', 1)
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['security_card_02'], "add")
end)

RegisterServerEvent("nc-paletoheist:yonatan:GreenUSB")
AddEventHandler("nc-paletoheist:yonatan:GreenUSB", function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    Player.Functions.AddItem('green_usb', 1)
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['green_usb'], "add")
end)

RegisterServerEvent('paletoheist:server:removeItem')
AddEventHandler('paletoheist:server:removeItem', function(item)
    local src = source
    if Config['PaletoHeist']['framework']['name'] == 'ESX' then
        local player = ESX.GetPlayerFromId(src)
        if player then
            player.removeInventoryItem(item, 1)
        end
    elseif Config['PaletoHeist']['framework']['name'] == 'QB' then
        local player = QBCore.Functions.GetPlayer(src)
        if player then
            player.Functions.RemoveItem(item, 1)
        end 
    end
end)

RegisterServerEvent('paletoheist:server:rewardItem')
AddEventHandler('paletoheist:server:rewardItem', function(item, count, type)
    local src = source

    if Config['PaletoHeist']['framework']['name'] == 'ESX' then
        local player = ESX.GetPlayerFromId(src)
        local whitelistItems = {}

        if player then
            if type == 'money' then
                local sourcePed = GetPlayerPed(src)
                local sourceCoords = GetEntityCoords(sourcePed)
                local dist = #(sourceCoords - vector3(-103.84, 6471.73, 31.6267))
                if dist > 100.0 then
                    print('[rm_paletoheist] add money exploit playerID: '.. src .. ' name: ' .. GetPlayerName(src))
                else
                    if Config['PaletoHeist']['black_money']['status'] then
                        player.addAccountMoney('black_money', count)
                        discordLog(player.getName() ..  ' - ' .. player.getIdentifier(), ' Gain ' .. count .. '$ on Paleto Heist!')
                    else
                        player.addMoney(count)
                        discordLog(player.getName() ..  ' - ' .. player.getIdentifier(), ' Gain ' .. count .. '$ on Paleto Heist!')
                    end
                end
            else
                for k, v in pairs(Config['PaletoHeist']['rewardItems']) do
                    whitelistItems[v['itemName']] = true
                end

                if whitelistItems[item] then
                    if count then 
                        player.addInventoryItem(item, count)
                        discordLog(player.getName() ..  ' - ' .. player.getIdentifier(), ' Gain ' .. item .. ' x' .. count .. ' on Paleto Heist!')
                    else
                        player.addInventoryItem(item, 1)
                        discordLog(player.getName() ..  ' - ' .. player.getIdentifier(), ' Gain ' .. item .. ' x' .. 1 .. ' on Paleto Heist!')
                    end
                else
                    print('[rm_paletoheist] add item exploit playerID: '.. src .. ' name: ' .. GetPlayerName(src))
                end
            end
        end
    elseif Config['PaletoHeist']['framework']['name'] == 'QB' then
        local player = QBCore.Functions.GetPlayer(src)
        local whitelistItems = {}

        if player then
            if type == 'money' then
                local sourcePed = GetPlayerPed(src)
                local sourceCoords = GetEntityCoords(sourcePed)
                local dist = #(sourceCoords - vector3(-103.84, 6471.73, 31.6267))
                if dist > 100.0 then
                    print('[rm_paletoheist] add money exploit playerID: '.. src .. ' name: ' .. GetPlayerName(src))
                else
                    if Config['PaletoHeist']['black_money']['status'] then
                        player.Functions.AddItem(Config['PaletoHeist']['black_money']['itemName'], count)
                        discordLog(player.PlayerData.name ..  ' - ' .. player.PlayerData.license, ' Gain ' .. count .. '$ on Paleto Heist!')
                    else
                        player.Functions.AddMoney('cash', count)
                        discordLog(player.PlayerData.name ..  ' - ' .. player.PlayerData.license, ' Gain ' .. count .. '$ on Paleto Heist!')
                    end
                end
            else
                for k, v in pairs(Config['PaletoHeist']['rewardItems']) do
                    whitelistItems[v['itemName']] = true
                end

                if whitelistItems[item] then
                    if count then 
                        player.Functions.AddItem(item, count)
                        discordLog(player.PlayerData.name ..  ' - ' .. player.PlayerData.license, ' Gain ' .. item .. ' x' .. count .. ' on Paleto Heist!')
                    else
                        player.Functions.AddItem(item, 1)
                        discordLog(player.PlayerData.name ..  ' - ' .. player.PlayerData.license, ' Gain ' .. item .. ' x' .. 1 .. ' on Paleto Heist!')
                    end
                else
                    print('[rm_paletoheist] add item exploit playerID: '.. src .. ' name: ' .. GetPlayerName(src))
                end
            end
        end
    end
end)

RegisterServerEvent('paletoheist:server:sellRewardItems')
AddEventHandler('paletoheist:server:sellRewardItems', function()
    local src = source

    if Config['PaletoHeist']['framework']['name'] == 'ESX' then
        local player = ESX.GetPlayerFromId(src)
        local totalMoney = 0

        if player then
            for k, v in pairs(Config['PaletoHeist']['rewardItems']) do
                local playerItem = player.getInventoryItem(v['itemName'])
                if playerItem.count >= 1 then
                    player.removeInventoryItem(v['itemName'], playerItem.count)
                    if Config['PaletoHeist']['black_money']['status'] then
                        player.addAccountMoney('black_money', playerItem.count * v['sellPrice'])
                    else
                        if Config['PaletoHeist']['moneyItem']['status'] then
                            player.addInventoryItem(Config['PaletoHeist']['moneyItem']['itemName'], playerItem.count * v['sellPrice'])
                        else
                            player.addMoney(playerItem.count * v['sellPrice'])
                        end
                    end
                    totalMoney = totalMoney + (playerItem.count * v['sellPrice'])
                end
            end

            discordLog(player.getName() ..  ' - ' .. player.getIdentifier(), ' Gain $' .. math.floor(totalMoney) .. ' on the Union Heist Buyer!')
            TriggerClientEvent('paletoheist:client:showNotification', src, Strings['total_money'] .. ' $' .. math.floor(totalMoney))
        end
    elseif Config['PaletoHeist']['framework']['name'] == 'QB' then
        local player = QBCore.Functions.GetPlayer(src)
        local totalMoney = 0

        if player then
            for k, v in pairs(Config['PaletoHeist']['rewardItems']) do
                local playerItem = player.Functions.GetItemByName(v['itemName'])
                if playerItem ~= nil and playerItem.amount > 0 then
                    player.Functions.RemoveItem(v['itemName'], playerItem.amount)
                    if Config['PaletoHeist']['black_money']['status'] then
                        player.Functions.AddItem(Config['PaletoHeist']['black_money']['itemName'], playerItem.amount * v['sellPrice'])
                    else
                        player.Functions.AddMoney('cash', playerItem.amount * v['sellPrice'])
                    end
                    totalMoney = totalMoney + (playerItem.amount * v['sellPrice'])
                end
            end

            discordLog(player.PlayerData.name ..  ' - ' .. player.PlayerData.license, ' Gain $' .. math.floor(totalMoney) .. ' on the Union Heist Buyer!')
            TriggerClientEvent('paletoheist:client:showNotification', src, Strings['total_money'] .. ' $' .. math.floor(totalMoney))
        end
    end
end)

RegisterCommand('pdpaleto', function(source, args)
    local src = source

    if Config['PaletoHeist']['framework']['name'] == 'ESX' then
        local player = ESX.GetPlayerFromId(src)
        
        if player then
            if player['job']['name'] == Config['PaletoHeist']['setjobForPolice'] then
                TriggerClientEvent('paletoheist:client:resetHeist', -1)
            else
                TriggerClientEvent('paletoheist:client:showNotification', src, Strings['not_cop'])
            end
        end
    elseif Config['PaletoHeist']['framework']['name'] == 'QB' then
        local player = QBCore.Functions.GetPlayer(src)
    
        if player then
            if player.PlayerData.job.name == Config['PaletoHeist']['setjobForPolice'] then
                TriggerClientEvent('paletoheist:client:resetHeist', -1)
            else
                TriggerClientEvent('paletoheist:client:showNotification', src, Strings['not_cop'])
            end
        end
    end
end)

RegisterServerEvent('paletoheist:server:sync')
AddEventHandler('paletoheist:server:sync', function(type, args)
    TriggerClientEvent('paletoheist:client:sync', -1, type, args)
end)

RegisterServerEvent('paletoheist:server:sceneSync')
AddEventHandler('paletoheist:server:sceneSync', function(model, animDict, animName, pos, rotation)
    TriggerClientEvent('paletoheist:client:sceneSync', -1, model, animDict, animName, pos, rotation)
end)