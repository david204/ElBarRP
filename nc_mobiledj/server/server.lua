local QBCore = exports['qb-core']:GetCoreObject()
local xSound = exports.xsound
local isPlaying = false

QBCore.Functions.CreateUseableItem("djstand", function(source, item)
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	TriggerClientEvent('nc_mobiledj:client:placeDJEquipment', src)
	Player.Functions.RemoveItem('djstand', 1)
	TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['djstand'], "remove")
end)

RegisterNetEvent('nc_mobiledj:server:playMusic', function(song, entity, coords)
    local src = source
    xSound:PlayUrlPos(-1, tostring(entity), song, Config.DefaultVolume, coords)
    xSound:Distance(-1, tostring(entity), Config.radius)
    isPlaying = true
end)

RegisterNetEvent('nc_mobiledj:server:pickedup', function(entity)
    local src = source
    xSound:Destroy(-1, tostring(entity))
end)

RegisterNetEvent('nc_mobiledj:server:stopMusic', function(data)
    local src = source
    xSound:Destroy(-1, tostring(data.entity))
    TriggerClientEvent('nc_mobiledj:client:playMusic', src)
end)

RegisterNetEvent('nc_mobiledj:server:pauseMusic', function(data)
    local src = source
    xSound:Pause(-1, tostring(data.entity))
end)

RegisterNetEvent('nc_mobiledj:server:resumeMusic', function(data)
    local src = source
    xSound:Resume(-1, tostring(data.entity))
end)

RegisterNetEvent('nc_mobiledj:server:changeVolume', function(volume, entity)
    local src = source
    if not tonumber(volume) then return end
    xSound:setVolume(-1, tostring(entity), volume)
end)

RegisterServerEvent('nc_mobiledj:server:pickeupdecks')
AddEventHandler('nc_mobiledj:server:pickeupdecks', function()
	local src = source
    local Player = QBCore.Functions.GetPlayer(src)
	Player.Functions.AddItem('djstand', 1)
	TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['djstand'], "add")
end)