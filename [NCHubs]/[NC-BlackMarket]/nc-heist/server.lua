local QBCore = exports['qb-core']:GetCoreObject()

local hiddencoords = vector3(707.28, -966.98, 30.41)
local onDuty = 0

QBCore.Functions.CreateCallback('perico:getlocation', function(source, cb)
    cb(hiddencoords)
end)

QBCore.Functions.CreateCallback('perico:getCops', function(source, cb)
    cb(getCops())
end)

function getCops()
    local Players = QBCore.Functions.GetPlayers()
    onDuty = 0
    return 5
end


RegisterServerEvent("perico:GiveItem")
AddEventHandler("perico:GiveItem", function(x, y, z)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    Player.Functions.RemoveItem('black_usb', 1)
    Player.Functions.AddItem('markedbills', math.random(6,10))
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['black_usb'], "remove")
end)

RegisterNetEvent('perico:updatetable')
AddEventHandler('perico:updatetable', function(bool)
    TriggerClientEvent('perico:synctable', -1, bool)
end)

RegisterServerEvent("perico:syncMission")
AddEventHandler("perico:syncMission", function(missionData)
    local missionData = missionData
    TriggerClientEvent('perico:syncMissionClient', -1, missionData)
end)

