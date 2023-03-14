Core = nil
if NCConfig.NewCore then
    Core = exports[NCConfig.Exports]:GetCoreObject()
else
    while Core == nil do
        Wait(10)
        TriggerEvent(NCConfig.Core .. ":GetSharedObject", function(obj) Core = obj end)
    end
end
Employees = {}

local Codes = json.decode(LoadResourceFile(GetCurrentResourceName(), "codes.json")) or {}
local Colors = json.decode(LoadResourceFile(GetCurrentResourceName(), "colors.json")) or {}

Core.Functions.CreateCallback('nc-10system:server:GetTagsColors', function(source, cb)
	cb(json.decode(LoadResourceFile(GetCurrentResourceName(), "colors.json")) or {})
end)

Core.Functions.CreateCallback('nc-10system:server:GetTagsColorsAndJob', function(source, cb)
    local src = source
    local Player = Core.Functions.GetPlayer(src)
    if Player ~= nil then
	cb(json.decode(LoadResourceFile(GetCurrentResourceName(), "colors.json")) or {}, Player.PlayerData.job.name)
end
end)


Citizen.CreateThread(function()
    for k, v in pairs(NCConfig.WhitelistedJobs) do
        if v.SortBy ~= 'tag' and v.SortBy ~= 'job' then
            while true do
                Wait(1000)
                print("you have problem with the "..k.." config at SortBy it have to be job/tag")
            end
        end
    end

    Wait(1000)
    for k, v in pairs(NCConfig.WhitelistedJobs) do
        Employees[k] = {}
    end
end)


RegisterNetEvent('nc-employeelist:server:addToList', function(jobName, dutyStatus)
    local src = source
    local Player = Core.Functions.GetPlayer(src)
    local code = getPlayerInfo(src)
    if Player.PlayerData.job.name == jobName then
        Employees[jobName][tostring(src)] = {
            src = src,
            name = Player.PlayerData.charinfo.firstname .. " " .. Player.PlayerData.charinfo.lastname,
            grade = Player.PlayerData.job.grade.name or "Employee",
            gradenumber = Player.PlayerData.job.level,
            code = code or NCConfig.DefaultCodename,
            onduty = Player.PlayerData.job.onduty or false,
            job = Player.PlayerData.job
        }
        for k, v in pairs(Employees[Player.PlayerData.job.name]) do
            TriggerClientEvent('nc-10system:client:updateList', k, Employees[Player.PlayerData.job.name])
        end
    end
end)

RegisterNetEvent("nc-10system:server:removeFromList")
AddEventHandler("nc-10system:server:removeFromList", function()
	local src = source
	for k,v in pairs(Employees) do
		if v[src] then
			v[src] = nil
		end
	end
end)

RegisterNetEvent(NCConfig.UpdateChannelEvent)
AddEventHandler(NCConfig.UpdateChannelEvent, function(sid,channel)
    local Player = Core.Functions.GetPlayer(sid)
    local jobname = Player.PlayerData.job.name
    sid = tostring(sid)
    if jobname and Employees[jobname] and Employees[jobname][sid] then
        Employees[jobname][sid].channel = channel
        for k, v in pairs(Employees[Player.PlayerData.job.name]) do
            TriggerClientEvent('nc-10system:client:updateList', k, Employees[Player.PlayerData.job.name])
        end
    end
end)

RegisterNetEvent("nc-10system:server:updateCallsign")
AddEventHandler("nc-10system:server:updateCallsign", function(callsign)
    local src = source
    local Player = Core.Functions.GetPlayer(src)
    Player.Functions.SetMetaData("callsign", callsign)
    if not Codes[Player.PlayerData.job.name] then
        Codes[Player.PlayerData.job.name] = {}
    end
    Codes[Player.PlayerData.job.name][tostring(Player.PlayerData.citizenid)] = callsign
    Employees[Player.PlayerData.job.name][tostring(src)]["code"] = callsign
    SaveResourceFile(GetCurrentResourceName(), "codes.json", json.encode(Codes), -1)
    for k,v in pairs(Employees[Player.PlayerData.job.name]) do    
        TriggerClientEvent('nc-10system:client:updateList', k, Employees[Player.PlayerData.job.name])
    end
end)

RegisterNetEvent(NCConfig.UpdateTalkingEvent)
AddEventHandler(NCConfig.UpdateTalkingEvent, function(state)
    local Player = Core.Functions.GetPlayer(source)
    local jobname = Player.PlayerData.job.name
    local sid = tostring(source)
    if jobname and Employees[jobname] and Employees[jobname][sid] then 
        Employees[jobname][sid].talking = state
        for k, v in pairs(Employees[Player.PlayerData.job.name]) do
            TriggerClientEvent('nc-10system:client:updateList', k, Employees[Player.PlayerData.job.name])
        end
    end
end)

RegisterNetEvent("nc-10system:server:saveTagsColors")
AddEventHandler("nc-10system:server:saveTagsColors", function(tags)
    local src = source
    local Player = Core.Functions.GetPlayer(src)
    if not Colors[Player.PlayerData.job.name] then
        Colors[Player.PlayerData.job.name] = {}
    end
    for k, v in pairs(tags) do
        local minmaxtags = v.min .."-".. v.max
        Colors[Player.PlayerData.job.name][minmaxtags] = v.color
    end
    SaveResourceFile(GetCurrentResourceName(), "./colors.json", json.encode(Colors), -1)
    TriggerClientEvent('nc-10system:client:updateTagsColorsList', -1, Colors[Player.PlayerData.job.name])
end)

RegisterNetEvent("nc-10system:server:saveNewTagsColors")
AddEventHandler("nc-10system:server:saveNewTagsColors", function(tags)
    local src = source
    local Player = Core.Functions.GetPlayer(src)
    local NewColors = {}
    if not NewColors[Player.PlayerData.job.name] then
        NewColors[Player.PlayerData.job.name] = {}
    end
    for k, v in pairs(tags) do
        local minmaxtags = v.min .."-".. v.max
        NewColors[Player.PlayerData.job.name][minmaxtags] = v.color
    end
    SaveResourceFile(GetCurrentResourceName(), "./colors.json", json.encode(NewColors), -1)
    TriggerClientEvent('nc-10system:client:updateTagsColorsList', -1, NewColors[Player.PlayerData.job.name])
end)




function getPlayerInfo(src)
    local Player = Core.Functions.GetPlayer(src)
    if not player then
        return nil
    end
    if Codes[Player.PlayerData.job.name] and Codes[Player.PlayerData.job.name][tostring(Player.PlayerData.citizenid)] then
        return Codes[Player.PlayerData.job.name][tostring(Player.PlayerData.citizenid)]
    end

    return nil
end 
