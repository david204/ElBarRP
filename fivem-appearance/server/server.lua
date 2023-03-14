local QBCore = exports['qb-core']:GetCoreObject()

-- Callback(s)

QBCore.Functions.CreateCallback('fivem-appearance:getPlayerSkin', function(source, cb)
	local Player = QBCore.Functions.GetPlayer(source)
	local players = exports.oxmysql:fetchSync('SELECT skin FROM players WHERE citizenid = ?', {Player.PlayerData.citizenid})
	local player, appearance = players[1]
	if player.skin then
		appearance = json.decode(player.skin)
	end
	cb(appearance)
end)

-- Net Events

RegisterNetEvent('fivem-appearance:save', function(appearance)
	local Player = QBCore.Functions.GetPlayer(source)
	exports.oxmysql:execute('UPDATE players SET skin = ? WHERE citizenid = ?', {json.encode(appearance), Player.PlayerData.citizenid})
end)

RegisterNetEvent('fivem-appearance:saveOutfit', function(name, pedModel, pedComponents, pedProps)
	local Player = QBCore.Functions.GetPlayer(source)
	exports.oxmysql:insert('INSERT INTO `player_outfits` (citizenid, name, ped, components, props) VALUES (?, ?, ?, ?, ?)', {Player.PlayerData.citizenid, name, json.encode(pedModel), json.encode(pedComponents), json.encode(pedProps)})
end)

RegisterNetEvent('fivem-appearance:getOutfit', function(name)
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	local outfit = exports.oxmysql:fetchSync('SELECT outfit FROM player_outfits WHERE citizenid = @citizenid AND name = @name', {['@citizenid'] = Player.PlayerData.citizenid, ['@name'] = name})
	local newOutfit = outfit
	if newOutfit then
		newOutfit = json.decode(newOutfit)
		TriggerClientEvent('fivem-appearance:setOutfit', src, newOutfit)
	end
end)

RegisterNetEvent('fivem-appearance:getOutfits', function()
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	local myOutfits = {}
	local result = exports.oxmysql:fetchSync('SELECT id, name, ped, components, props FROM player_outfits WHERE citizenid = ?', {Player.PlayerData.citizenid})
	for i=1, #result, 1 do
		table.insert(myOutfits, {id = result[i].id, name = result[i].name, ped = json.decode(result[i].ped), components = json.decode(result[i].components), props = json.decode(result[i].props)})
	end
	TriggerClientEvent('fivem-appearance:sendOutfits', src, myOutfits)
end)

RegisterNetEvent('fivem-appearance:deleteOutfit', function(id)
	local Player = QBCore.Functions.GetPlayer(source)
	exports.oxmysql:execute('DELETE FROM player_outfits WHERE id = ?', {id})
end)

RegisterServerEvent('fivem-appearances:buyclothing')
AddEventHandler('fivem-appearances:buyclothing', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
	if Config.Money < 0 then
		if Player.Functions.RemoveMoney('cash', Config.Money, "clothing-buy") then
			TriggerClientEvent('fivem-appearance:purchaseSuccessful', src)
		else
			TriggerClientEvent('QBCore:Notify', src, 'You dont have enough money!', 'error')
			TriggerClientEvent('fivem-appearance:purchaseFailed', src)
		end
	else
		TriggerClientEvent('fivem-appearance:purchaseSuccessful', src)
	end
end)