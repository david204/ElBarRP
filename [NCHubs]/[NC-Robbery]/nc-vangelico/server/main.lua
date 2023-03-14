if Config.Version == "new" then

    QBCore = exports['qb-core']:GetCoreObject()

elseif Config.Version == "old" then
    local QBCore = nil
    CreateThread(function()
        while QBCore == nil do
            TriggerEvent("QBCore:GetObject", function(obj)QBCore = obj end)
            Wait(200)
        end
    end)
end

RegisterServerEvent("yonatan:GiveItem")
AddEventHandler("yonatan:GiveItem", function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    Player.Functions.AddItem('security_card_03', 1)
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['security_card_03'], "add")
end)

RegisterServerEvent("yonatan:GiveUSB")
AddEventHandler("yonatan:GiveItem", function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    Player.Functions.AddItem('gold_usb', 1)
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['gold_usb'], "add")
end)

local timeOut = false
local alarmTriggered = false
local Cooldown = false

-- First Item Needed
QBCore.Functions.CreateUseableItem("thermite", function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
    TriggerClientEvent("thermite:UseThermite", source)
 end)

-- Second Item Needed
QBCore.Functions.CreateUseableItem("security_card_04", function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
    TriggerClientEvent('hackinglaptop:UseHackinglaptop',source)
 end)

RegisterServerEvent("Peely-particleserver")
AddEventHandler("Peely-particleserver", function(method)
    TriggerClientEvent("Peely-ptfxparticle", -1, method)
end)

RegisterServerEvent("Peely-particleserversec")
AddEventHandler("Peely-particleserversec", function(method)
    TriggerClientEvent("Peely-ptfxparticlesec", -1, method)
end)

RegisterServerEvent('nc-vangelico:server:SetJewelLocations')
AddEventHandler('nc-vangelico:server:SetJewelLocations', function()
    local src = source 
    TriggerClientEvent("nc-vangelico:server:SetJewelLocations", src, Config.JewelLocation)
end)

-- Register Cool Down Events For Locations
RegisterServerEvent('nc-vangelico:Server:BeginCooldown')
AddEventHandler('nc-vangelico:Server:BeginCooldown', function()
    Cooldown = true
    local timer = Config.Cooldown * 60000
    while timer > 0 do
        Wait(1000)
        timer = timer - 1000
        if timer == 0 then
            Cooldown = false
        end
    end
end)

-- CallBack For CoolDown
QBCore.Functions.CreateCallback("nc-vangelico:Callback:Cooldown",function(source, cb)
    if Cooldown then
        cb(true)
    else
        cb(false)
        
    end
end)

-- Callback For Cops
QBCore.Functions.CreateCallback('nc-vangelico:server:getCops', function(source, cb)
	local amount = 0
    for k, v in pairs(QBCore.Functions.GetQBPlayers()) do
        if v.PlayerData.job.name == "police" and v.PlayerData.job.onduty then
            amount = amount + 1
        end
    end
    cb(amount)
end)

-- Hack On Roof Of Vangelico
RegisterServerEvent('nc-vangelico:server:SetThermiteSecurityStatus')
AddEventHandler('nc-vangelico:server:SetThermiteSecurityStatus', function(stateType, state)
    if stateType == "isBusy" then
        Config.JewelLocation["ThermiteSecurity"].isBusy = state
    elseif stateType == "isDone" then
        Config.JewelLocation["ThermiteSecurity"].isDone = state
    end
    TriggerClientEvent('nc-vangelico:client:SetThermiteSecurityStatus', -1, stateType, state)
    TriggerEvent('nc-scoreboard:server:SetActivityBusy', "jewellery", false)
end)

-- Disbaled Cameras In Vangelico
RegisterServerEvent('nc-vangelico:server:SetCameraStatus')
AddEventHandler('nc-vangelico:server:SetCameraStatus', function(stateType, state)
    if stateType == "isBusy" then
        Config.JewelLocation["DisableCameras"].isBusy = state
    elseif stateType == "isDone" then
        Config.JewelLocation["DisableCameras"].isDone = state
    end
    TriggerClientEvent('nc-vangelico:client:SetCameraStatus', -1, stateType, state)
end)

-- Callback

QBCore.Functions.CreateCallback('nc-vangelico:server:getCops', function(source, cb)
	local amount = 0
    for k, v in pairs(QBCore.Functions.GetQBPlayers()) do
        if v.PlayerData.job.name == "police" and v.PlayerData.job.onduty then
            amount = amount + 1
        end
    end
    cb(amount)
end)

-- Events

RegisterNetEvent('nc-vangelico:server:setVitrineState', function(stateType, state, k)
    Config.Locations[k][stateType] = state
    TriggerClientEvent('nc-vangelico:client:setVitrineState', -1, stateType, state, k)
end)

RegisterNetEvent('nc-vangelico:server:vitrineReward', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local otherchance = math.random(1, 4)
    local odd = math.random(1, 4)

    if otherchance == odd then
        local item = math.random(1, #Config.VitrineRewards)
        local amount = math.random(Config.VitrineRewards[item]["amount"]["min"], Config.VitrineRewards[item]["amount"]["max"])
        if Player.Functions.AddItem(Config.VitrineRewards[item]["item"], amount) then
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[Config.VitrineRewards[item]["item"]], 'add')
        else
            TriggerClientEvent('QBCore:Notify', src, Lang:t("error.pockets_full"), "error")
            --TriggerClientEvent('QBCore:Notify', src, 'You Can\'t Carry Anymore!', 'error')
        end
    end
end)

QBCore.Functions.CreateCallback('nc-vangelico:server:setTimeout', function(source, cb)
	if not timeOut then
        timeOut = true
        Citizen.CreateThread(function()
            Citizen.Wait(Config.Timeout)

            for k, v in pairs(Config.Locations) do
                Config.Locations[k]["isOpened"] = false
                TriggerClientEvent('nc-vangelico:client:setVitrineState', -1, 'isOpened', false, k)
                TriggerClientEvent('nc-vangelico:client:setAlertState', -1, false)
            end
            timeOut = false
            alarmTriggered = false
        end)
    end
end)
