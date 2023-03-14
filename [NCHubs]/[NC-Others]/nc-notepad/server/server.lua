local QBCore = exports['qb-core']:GetCoreObject()
RegisterNetEvent('QBCore:Server:UpdateObject', function() if source ~= '' then return false end	QBCore = exports['qb-core']:GetCoreObject() end)

local Notes = {}

discord = {
    ['webhook'] = "",
    ['name'] = 'Notepad',
    ['image'] = "https://i.imgur.com/G3jeSZv.png"
}

function DiscordLog(name, message, color)
    local embed = {
        {
            ["color"] = 04255,
            ["title"] = "**Note Dropped:**",
            ["description"] = message,
            ["url"] = "",
            ["footer"] = {
            ["text"] = "Dropped by: "..name,
            ["icon_url"] = ""
        },
            ["thumbnail"] = {
                ["url"] = "",
            },
		}
	}
    PerformHttpRequest(discord['webhook'], function(err, text, headers) end, 'POST', json.encode({username = discord['name'], embeds = embed, avatar_url = discord['image']}), { ['Content-Type'] = 'application/json' })
end

QBCore.Functions.CreateUseableItem("notepad", function(source, item) TriggerClientEvent("nc-notepad:Client:CreateNote", source) end)

QBCore.Functions.CreateCallback('nc-notepad:Server:SyncNotes', function(source, cb) cb(Notes) end)

RegisterNetEvent("nc-notepad:Server:CreateNote", function(data)
	local charset = {
		"q","w","e","r","t","y","u","i","o","p","a","s","d","f","g","h","j","k","l","z","x","c","v","b","n","m",
		"Q","W","E","R","T","Y","U","I","O","P","A","S","D","F","G","H","J","K","L","Z","X","C","V","B","N","M",
		"1","2","3","4","5","6","7","8","9","0"
	}
	local GeneratedID = ""
	for i = 1, 12 do GeneratedID = GeneratedID..charset[math.random(1, #charset)] end

	local creator = QBCore.Functions.GetPlayer(source).PlayerData.charinfo.firstname..' '..QBCore.Functions.GetPlayer(source).PlayerData.charinfo.lastname

	DiscordLog(creator, data.message, 14177041)

	if data.anon == true then creator = "Anonymous" end

	Notes[GeneratedID] = {
		id = GeneratedID,
		coords = data.coords,
		message = data.image or data.message,
		creator = creator,
	}

	TriggerClientEvent("nc-notepad:Client:SyncNotes", -1, Notes)
end)

RegisterNetEvent("nc-notepad:Server:DestroyNote", function(data)
	Notes[data] = nil
	TriggerClientEvent("nc-notepad:Client:SyncNotes", -1, Notes)
end)

RegisterNetEvent("nc-notepad:Server:ReadNote", function(data)
	local src = source
	TriggerClientEvent("nc-notepad:Client:ReadNote", src, Notes[data.noteid])
end)

RegisterNetEvent("nc-notepad:Server:SyncEffect", function(coords)
	TriggerClientEvent("nc-notepad:Client:SyncEffect", -1, coords)
end)