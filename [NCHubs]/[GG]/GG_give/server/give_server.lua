local QBCore = exports['qb-core']:GetCoreObject()


local NumberCharset = {}
local Charset = {}

for i = 48,  57 do table.insert(NumberCharset, string.char(i)) end
for i = 65,  90 do table.insert(Charset, string.char(i)) end
for i = 97, 122 do table.insert(Charset, string.char(i)) end

function GeneratePlate()
	local plate = tostring(GetRandomNumber(1)) .. GetRandomLetter(2) .. tostring(GetRandomNumber(3)) .. GetRandomLetter(2)
    local result = exports.oxmysql:executeSync('SELECT plate FROM player_vehicles WHERE plate=@plate', {['@plate'] = plate})
	if result then
		plate = tostring(GetRandomNumber(1)) .. GetRandomLetter(2) .. tostring(GetRandomNumber(3)) .. GetRandomLetter(2)
	end
	return plate:upper()
end
  
function GetRandomNumber(length)
	Wait(1)
	math.randomseed(GetGameTimer())
	if length > 0 then
	  return GetRandomNumber(length - 1) .. NumberCharset[math.random(1, #NumberCharset)]
	else
	  return ''
	end
end
  
function GetRandomLetter(length)
	Wait(1)
	math.randomseed(GetGameTimer())
	if length > 0 then
	  return GetRandomLetter(length - 1) .. Charset[math.random(1, #Charset)]
	else
	  return ''
	end
end




QBCore.Commands.Add("givecar", "Give Vehicle to Players (Admin Only)", {{name="id", help="Player ID"}, {name="model", help="Vehicle Model, for example: t20"}, {name="plate", help="Custom Number Plate (Leave to assign random) , for example: ABC123"}}, false, function(source, args)
    local ply = QBCore.Functions.GetPlayer(source)
    local veh = args[2]
    local plate = args[3]
    local tPlayer = QBCore.Functions.GetPlayer(tonumber(args[1]))
    if plate == nil or plate == "" then plate = GeneratePlate() end
    if veh ~= nil and args[1] ~= nil then
    TriggerClientEvent('GG:client:givecar', args[1], veh, plate)
	TriggerClientEvent("QBCore:Notify", source, "You gave vehilce to "..tPlayer.PlayerData.charinfo.firstname.." "..tPlayer.PlayerData.charinfo.lastname.." Vehicle :"..veh.." With Plate : "..plate, "success", 8000)
    else 
        TriggerClientEvent('QBCore:Notify', source, "Incorrect Format", "error")
    end
end, "god")



RegisterServerEvent('GG:server:SaveCar')
AddEventHandler('GG:server:SaveCar', function(mods, vehicle, hash, plate)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local result = exports.oxmysql:executeSync('SELECT plate FROM player_vehicles WHERE plate=@plate', {['@plate'] = plate})
    if result[1] == nil then
        exports.oxmysql:execute('INSERT INTO player_vehicles (license, citizenid, vehicle, hash, mods, plate, state) VALUES (@license, @citizenid, @vehicle, @hash, @mods, @plate, @state)', {
            ['@license'] = Player.PlayerData.license,
            ['@citizenid'] = Player.PlayerData.citizenid,
            ['@vehicle'] = vehicle.model,
            ['@hash'] = vehicle.hash,
            ['@mods'] = json.encode(mods),
            ['@plate'] = plate,
            ['@state'] = 0
        })
        TriggerClientEvent('QBCore:Notify', src, 'The vehicle is now yours!', 'success', 5000)
    else
        TriggerClientEvent('QBCore:Notify', src, 'This vehicle is already yours..', 'error', 3000)
    end
end)

