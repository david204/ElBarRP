local QBCore = exports['qb-core']:GetCoreObject()

local isActive = false

discord = {
    ['webhook'] = "YOUR WEBHOOK",
    ['name'] = 'nc-policegarage',
    ['image'] = "YOUR IMAGE"
}

function DiscordLog(name, message, color)
    local embed = {
        {
            ["color"] = 04255, 
            ["title"] = "NCHub Police Garage",
            ["description"] = message,
            ["url"] = "https://discord.gg/nchub",
            ["footer"] = {
            ["text"] = "By CloudDevelopment",
            ["icon_url"] = "YOUR IMAGE"
        },
            ["thumbnail"] = {
                ["url"] = "YOUR IMAGE",
            },
    }
}
    PerformHttpRequest(discord['webhook'], function(err, text, headers) end, 'POST', json.encode({username = discord['name'], embeds = embed, avatar_url = discord['image']}), { ['Content-Type'] = 'application/json' })
end

QBCore.Functions.CreateCallback('nc-policegarage:CheckIfActive', function(source, cb)
    local src = source

    if not isActive then
        TriggerEvent("nc-policegarage:server:SetActive", true)
        cb(true)
    else
        cb(false)
        TriggerClientEvent("QBCore:Notify", src, "Someone Is In The Menu Please Wait !", "error")
    end
end)

RegisterNetEvent('nc-policegarage:server:SetActive', function(status)
    if status ~= nil then
        isActive = status
        TriggerClientEvent('nc-policegarage:client:SetActive', -1, isActive)
    else
        TriggerClientEvent('nc-policegarage:client:SetActive', -1, isActive)
    end
end)

RegisterServerEvent("nc-policegarage:AddVehicleSQL")
AddEventHandler('nc-policegarage:AddVehicleSQL', function(mods, vehicle, hash, plate)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    MySQL.Async.insert('INSERT INTO player_vehicles (license, citizenid, vehicle, hash, mods, plate, state) VALUES (?, ?, ?, ?, ?, ?, ?)', {
        Player.PlayerData.license,
        Player.PlayerData.citizenid,
        vehicle,
        hash,
        json.encode(mods),
        plate,
        0
    })
end)

RegisterServerEvent('nc-policegarage:TakeMoney', function(data)
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
    local steamname = GetPlayerName(src)
    if Player.PlayerData.money.cash >= data.price then
        TriggerClientEvent("nc-policegarage:SpawnVehicle", src, data.vehicle)  
        Player.Functions.RemoveMoney("cash", data.price)
        TriggerClientEvent('QBCore:Notify', src, 'Vehicle Successfully Bought', "success")    
        DiscordLog(discord['webhook'], 'New Vehicle Bought By: **'..steamname..'** ID: **' ..source.. '** Bought: **' ..data.vehiclename.. '** For: **' ..data.price.. '$**', 14177041) 
    else
        TriggerClientEvent('QBCore:Notify', src, 'You Dont Have Enough Money !', "error")              
    end    
end)