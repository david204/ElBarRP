local QBCore = exports['qb-core']:GetCoreObject()
local Webhook = 'https://discord.com/api/webhooks/935297411075670018/J47xPv7QzsAYz_xO8thVJd6tRExW4lwBVwDWy-aEHHHLlmBYmljdI6-7I63ogQseEr-o'

QBCore.Functions.CreateUseableItem('tablet', function(source, item)
	local src = source
	local xPlayer = QBCore.Functions.GetPlayer(src)
    TriggerClientEvent('okokMarketplace:open', src)
end)

QBCore.Functions.CreateCallback('okokMarketplace:getItems', function(source, cb)
	local _source = source
	local xPlayer = QBCore.Functions.GetPlayer(_source)
	local vehicles = {}

	exports.oxmysql:execute('SELECT * FROM player_vehicles WHERE citizenid = @citizenid AND `state` = 1', {
		['@citizenid'] = xPlayer.PlayerData.citizenid,
	}, function(data) 
		for _,v in pairs(data) do
			local vehicle = json.decode(v.vehicle)
			table.insert(vehicles, {vehicle = v.mods, plate = v.plate})
		end
		cb(vehicles, xPlayer.PlayerData.items)
	end)
end)

QBCore.Functions.CreateCallback('okokMarketplace:getAds', function(source, cb)
	local _source = source
	local xPlayer = QBCore.Functions.GetPlayer(_source)

	exports.oxmysql:execute('SELECT * FROM okokmarketplace_vehicles ORDER BY id ASC', {
	}, function(veh) 
		exports.oxmysql:execute('SELECT * FROM okokmarketplace_items ORDER BY id ASC', {
		}, function(items) 
			exports.oxmysql:execute('SELECT * FROM okokmarketplace_blackmarket ORDER BY id ASC', {
			}, function(blackmarket) 
				cb(veh, items, blackmarket, xPlayer.PlayerData.citizenid)
			end)
		end)
	end)
end)

QBCore.Functions.CreateCallback('okokMarketplace:phone', function(source, cb)
	local _source = source
	local xPlayer = QBCore.Functions.GetPlayer(_source)
	local charinfo = xPlayer.PlayerData.charinfo
	local phone_number = charinfo.phone
	
	cb(phone_number)
end)

RegisterServerEvent("okokMarketplace:addVehicle")
AddEventHandler("okokMarketplace:addVehicle", function(vehicle, price, desc, phone_number)
	local _source = source
	local xPlayer = QBCore.Functions.GetPlayer(_source)
	local plate = vehicle.plate
	local id = plate:gsub("%s+", "")

	exports.oxmysql:execute('UPDATE player_vehicles SET citizenid = @citizenid WHERE plate = @plate', {
		['@plate'] = vehicle.plate,
		['@citizenid'] = "selling",
	})

	exports.oxmysql:insert('INSERT INTO okokmarketplace_vehicles (item_id, plate, label, author_identifier, author_name, phone_number, description, price, start_date) VALUES (@item_id, @plate, @label, @author_identifier, @author_name, @phone_number, @description, @price, @start_date)', {
		['@item_id'] = id,
		['@plate'] = plate,
		['@label'] = vehicle.name,
		['@author_identifier'] = xPlayer.PlayerData.citizenid,
		['@author_name'] = xPlayer.PlayerData.charinfo.firstname.." "..xPlayer.PlayerData.charinfo.lastname,
		['@phone_number'] = phone_number,
		['@description'] = desc,
		['@price'] = price,
		['@start_date'] = os.date("%d/%m - %H:%M"),
	}, function(result)
		TriggerClientEvent('okokMarketplace:updateVehiclesDropdown', _source)
		TriggerClientEvent('okokMarketplace:updateVehicles', _source)
		TriggerClientEvent('okokMarketplace:updateMyAdsTable', _source)
		TriggerClientEvent('QBCore:Notify', _source, "You are now selling the vehicle "..vehicle.name.." ("..vehicle.plate..")", "success")

		if Webhook ~= '' then
			local identifierlist = ExtractIdentifiers(_source)
			local data = {
				playerid = _source,
				identifier = identifierlist.license:gsub("license2:", ""),
				discord = "<@"..identifierlist.discord:gsub("discord:", "")..">",
				type = "add",
				action = "Added an Ad",
				item = vehicle.name.." ("..vehicle.plate..")",
				price = price,
				desc = desc,
				title = "MARKETPLACE - Vehicles",
			}
			discordWenhook(data)
		end
	end)
end)

RegisterServerEvent("okokMarketplace:addItem")
AddEventHandler("okokMarketplace:addItem", function(item, amount, price, desc, phone_number)
	local _source = source
	local xPlayer = QBCore.Functions.GetPlayer(_source)
	local amount = tonumber(amount)

	if xPlayer.Functions.RemoveItem (item.id, amount) then
		exports.oxmysql:insert('INSERT INTO okokmarketplace_items (item_id, label, amount, author_identifier, author_name, phone_number, description, price, start_date) VALUES (@item_id, @label, @amount, @author_identifier, @author_name, @phone_number, @description, @price, @start_date)', {
			['@item_id'] = item.id,
			['@label'] = item.label,
			['@amount'] = amount,
			['@author_identifier'] = xPlayer.PlayerData.citizenid,
			['@author_name'] = xPlayer.PlayerData.charinfo.firstname.." "..xPlayer.PlayerData.charinfo.lastname,
			['@phone_number'] = phone_number,
			['@description'] = desc,
			['@price'] = price,
			['@start_date'] = os.date("%d/%m - %H:%M"),
		}, function(result)
			TriggerClientEvent('okokMarketplace:updateItemsDropdown', _source)
			TriggerClientEvent('okokMarketplace:updateItems', _source)
			TriggerClientEvent('okokMarketplace:updateMyAdsTable', _source)
			--xPlayer.removeInventoryItem(item.id, amount)
			TriggerClientEvent('QBCore:Notify', _source, "You are now selling the item "..item.label.." ("..amount..")", "success")

			if Webhook ~= '' then
				local identifierlist = ExtractIdentifiers(_source)
				local data = {
					playerid = _source,
					identifier = identifierlist.license:gsub("license2:", ""),
					discord = "<@"..identifierlist.discord:gsub("discord:", "")..">",
					type = "add",
					action = "Added an Ad",
					item = item.label.." (x"..amount..")",
					price = price,
					desc = desc,
					title = "MARKETPLACE - Items",
				}
				discordWenhook(data)
			end
		end)
	else
		TriggerClientEvent('QBCore:Notify', _source, "You don't have enough items to sell.", "error")
	end
end)

RegisterServerEvent("okokMarketplace:addBlackmarket")
AddEventHandler("okokMarketplace:addBlackmarket", function(item, price, desc, phone_number, amount)
	local _source = source
	local xPlayer = QBCore.Functions.GetPlayer(_source)

	if xPlayer.Functions.RemoveItem(item.id, amount) then
		exports.oxmysql:insert('INSERT INTO okokmarketplace_blackmarket (item_id, label, type, amount, author_identifier, author_name, phone_number, description, price, start_date) VALUES (@item_id, @label, @type, @amount, @author_identifier, @author_name, @phone_number, @description, @price, @start_date)', {
			['@item_id'] = item.id,
			['@label'] = item.label,
			['@type'] = item.type,
			['@amount'] = amount,
			['@author_identifier'] = xPlayer.PlayerData.citizenid,
			['@author_name'] = xPlayer.PlayerData.charinfo.firstname.." "..xPlayer.PlayerData.charinfo.lastname,
			['@phone_number'] = phone_number,
			['@description'] = desc,
			['@price'] = price,
			['@start_date'] = os.date("%d/%m - %H:%M"),
		}, function(result)
			TriggerClientEvent('okokMarketplace:updateBlackmarketDropdown', _source)
			TriggerClientEvent('okokMarketplace:updateBlackmarket', _source)
			TriggerClientEvent('okokMarketplace:updateMyAdsTable', _source)
			TriggerClientEvent('QBCore:Notify', _source, "You are now selling the item " ..item.label, "success")

			if Webhook ~= '' then
				local identifierlist = ExtractIdentifiers(_source)
				local data = {
					playerid = _source,
					identifier = identifierlist.license:gsub("license2:", ""),
					discord = "<@"..identifierlist.discord:gsub("discord:", "")..">",
					type = "add",
					action = "Added an Ad",
					item = item.label.." (x"..amount..")",
					price = price,
					desc = desc,
					title = "MARKETPLACE - Blackmarket",
				}
				discordWenhook(data)
			end
		end)
	else
		TriggerClientEvent('QBCore:Notify', _source, "You don't have enough items to sell", "error")
	end
end)

QBCore.Functions.CreateCallback('okokMarketplace:getVehicle', function(source, cb, id)
	local _source = source
	local xPlayer = QBCore.Functions.GetPlayer(_source)
	exports.oxmysql:execute('SELECT * FROM okokmarketplace_vehicles WHERE item_id = @item_id AND sold = false', {
		['@item_id'] = id,
	}, function(veh)
		if veh[1] ~= nil then
			cb(veh)
		else
			TriggerClientEvent('okokMarketplace:updateVehicles', _source)
			TriggerClientEvent('QBCore:Notify', _source, "This vehicle is no longer for sale", "error")
		end
	end)
end)

QBCore.Functions.CreateCallback('okokMarketplace:getItem', function(source, cb, id, item)
	local _source = source
	local xPlayer = QBCore.Functions.GetPlayer(_source)

	exports.oxmysql:execute('SELECT * FROM okokmarketplace_items WHERE id = @id AND item_id = @item_id AND sold = false', {
		['@id'] = id,
		['@item_id'] = item,
	}, function(item)
		if item[1] ~= nil then
			cb(item)
		else
			TriggerClientEvent('okokMarketplace:updateItems', _source)
			TriggerClientEvent('QBCore:Notify', _source, "This item is no longer for sale", "error")
		end
	end)
end)

QBCore.Functions.CreateCallback('okokMarketplace:getBlackmarket', function(source, cb, id, blackmarket)
	local _source = source
	local xPlayer = QBCore.Functions.GetPlayer(_source)

	exports.oxmysql:execute('SELECT * FROM okokmarketplace_blackmarket WHERE id = @id AND item_id = @item_id AND sold = false', {
		['@id'] = id,
		['@item_id'] = blackmarket,
	}, function(blackmarket)
		if blackmarket[1] ~= nil then
			cb(blackmarket)
		else
			TriggerClientEvent('okokMarketplace:updateBlackmarket', _source)
			TriggerClientEvent('QBCore:Notify', _source, "This item is no longer for sale", "error")
		end
	end)
end)

RegisterServerEvent("okokMarketplace:buyVehicle")
AddEventHandler("okokMarketplace:buyVehicle", function(veh)
	local _source = source
	local xPlayer = QBCore.Functions.GetPlayer(_source)
	local xTarget = QBCore.Functions.GetPlayerByCitizenId(veh[1].author_identifier)
	local money = xPlayer.PlayerData.money["bank"]
	local price = tonumber(veh[1].price)

	if money >= price then
		exports.oxmysql:execute('UPDATE okokmarketplace_vehicles SET sold = 1 WHERE plate = @plate AND sold = 0', {['@plate'] = veh[1].plate},
		function (rowsChanged)
			if rowsChanged.affectedRows > 0 then
				xPlayer.Functions.RemoveMoney('bank', price)
				exports.oxmysql:execute('UPDATE player_vehicles SET citizenid = @citizenid WHERE plate = @plate', {
					['@plate'] = veh[1].plate,
					['@citizenid'] = xPlayer.PlayerData.citizenid,
				})
				TriggerClientEvent('QBCore:Notify', _source, "You bought the vehicle "..veh[1].label.." ("..veh[1].plate..")", "success")
				TriggerClientEvent('okokMarketplace:updateVehiclesDropdown', _source)
				TriggerClientEvent('okokMarketplace:updateVehicles', _source)
				if xTarget ~= nil then
					TriggerClientEvent('QBCore:Notify', xTarget.PlayerData.source, "You sold the vehicle "..veh[1].label.." ("..veh[1].plate..")", "success")
				end
				if Webhook ~= '' then
					local identifierlist = ExtractIdentifiers(_source)
					local data = {
						playerid = _source,
						identifier = identifierlist.license:gsub("license2:", ""),
						discord = "<@"..identifierlist.discord:gsub("discord:", "")..">",
						type = "buy",
						action = "Bought a vehicle",
						item = veh[1].label.." ("..veh[1].plate..")",
						price = veh[1].price,
						desc = veh[1].description,
						from = veh[1].author_name.." ("..veh[1].author_identifier..")",
						title = "MARKETPLACE - Vehicles",
					}
					discordWenhook(data)
				end
			else
				TriggerClientEvent('QBCore:Notify', _source, "Something went wrong, please try again later!", "error")
			end
		end)
	else
		TriggerClientEvent('QBCore:Notify', _source, "You don't have enough money to buy this vehicle.", "error")
	end
end)

RegisterServerEvent("okokMarketplace:buyItem")
AddEventHandler("okokMarketplace:buyItem", function(item)
	local _source = source
	local xPlayer = QBCore.Functions.GetPlayer(_source)
	local xTarget = QBCore.Functions.GetPlayerByCitizenId(item[1].author_identifier)
	local money = xPlayer.PlayerData.money["bank"]
	local price = tonumber(item[1].price)

	if money >= price then
		if xPlayer.Functions.AddItem(item[1].item_id, item[1].amount) then
			exports.oxmysql:execute('UPDATE okokmarketplace_items SET sold = 1 WHERE id = @id AND item_id = @item_id AND sold = 0', {
				['@id'] = item[1].id,
				['@item_id'] = item[1].item_id,
			},function (rowsChanged)
				if rowsChanged.affectedRows > 0 then
					xPlayer.Functions.RemoveMoney('bank', price)
					TriggerClientEvent('QBCore:Notify', _source, "You bought the item "..item[1].label.." (x"..item[1].amount..").", "success")
					TriggerClientEvent('okokMarketplace:updateItemsDropdown', _source)
					TriggerClientEvent('okokMarketplace:updateItems', _source)
					if xTarget ~= nil then
						TriggerClientEvent('QBCore:Notify', xTarget.PlayerData.source, "You sold the item "..item[1].label.." (x"..item[1].amount..").", "success")
					end
					if Webhook ~= '' then
						local identifierlist = ExtractIdentifiers(_source)
						local data = {
							playerid = _source,
							identifier = identifierlist.license:gsub("license2:", ""),
							discord = "<@"..identifierlist.discord:gsub("discord:", "")..">",
							type = "buy",
							action = "Bought an item",
							item = item[1].label.." (x"..item[1].amount..")",
							price = item[1].price,
							desc = item[1].description,
							from = item[1].author_name.." ("..item[1].author_identifier..")",
							title = "MARKETPLACE - Items",
						}
						discordWenhook(data)
					end
				else
					TriggerClientEvent('QBCore:Notify', _source, "Something went wrong, please try again later!.", "error")
				end
			end)
		else
			TriggerClientEvent('QBCore:Notify', _source, "You can't carry this item.", "error")
		end
	else
		TriggerClientEvent('QBCore:Notify', _source, "You don't have enough money to buy this item.", "error")
	end
end)

RegisterServerEvent("okokMarketplace:buyBlackmarket")
AddEventHandler("okokMarketplace:buyBlackmarket", function(blackmarket)
	local _source = source
	local xPlayer = QBCore.Functions.GetPlayer(_source)
	local xTarget = QBCore.Functions.GetPlayerByCitizenId(blackmarket[1].author_identifier)
	local money = xPlayer.PlayerData.money["bank"]
	local money
	local price = tonumber(blackmarket[1].price)

	if Config.UseDirtyMoneyOnBlackmarket then
		money = xPlayer.Functions.GetItemByName('markedbills').amount
	else
		money = xPlayer.PlayerData.money["bank"]
	end

	if money >= price then
		if xPlayer.Functions.AddItem(blackmarket[1].item_id, blackmarket[1].amount) then
			exports.oxmysql:execute('UPDATE okokmarketplace_blackmarket SET sold = 1 WHERE id = @id AND item_id = @item_id AND sold = 0', {
				['@id'] = blackmarket[1].id,
				['@item_id'] = blackmarket[1].item_id,
			},function (rowsChanged)
				if rowsChanged.affectedRows > 0 then
					if Config.UseDirtyMoneyOnBlackmarket then
						xPlayer.Functions.RemoveItem('markedbills', price)
					else
						xPlayer.Functions.RemoveMoney('bank', price)
					end

					TriggerClientEvent('QBCore:Notify', _source, "You bought the item "..blackmarket[1].label, "success")
					TriggerClientEvent('okokMarketplace:updateBlackmarketDropdown', _source)
					TriggerClientEvent('okokMarketplace:updateBlackmarket', _source)
					if xTarget ~= nil then
						TriggerClientEvent('QBCore:Notify', xTarget.PlayerData.source, "You sold the item "..blackmarket[1].label, "success")
					end
					if Webhook ~= '' then
						local identifierlist = ExtractIdentifiers(_source)
						local data = {
							playerid = _source,
							identifier = identifierlist.license:gsub("license2:", ""),
							discord = "<@"..identifierlist.discord:gsub("discord:", "")..">",
							type = "buy",
							action = "Bought an item",
							item = blackmarket[1].label.." (x"..blackmarket[1].amount..")",
							price = blackmarket[1].price,
							desc = blackmarket[1].description,
							from = blackmarket[1].author_name.." ("..blackmarket[1].author_identifier..")",
							title = "MARKETPLACE - Blackmarket",
						}
						discordWenhook(data)
					end
				else
					TriggerClientEvent('QBCore:Notify', _source, "Something went wrong, please try again later!", "error")
				end
			end)
		else
			TriggerClientEvent('QBCore:Notify', _source, "You can't carry this item.", "error")
		end
	else
		TriggerClientEvent('QBCore:Notify', _source, "You don't have enough money to buy this item.", "error")
	end
end)

RegisterServerEvent("okokMarketplace:removeMyAd")
AddEventHandler("okokMarketplace:removeMyAd", function(item)
	local _source = source
	local xPlayer = QBCore.Functions.GetPlayer(_source)

	if item.item_id ~= nil and item.id ~= nil then

		if item.plate then
			exports.oxmysql:execute('SELECT * FROM okokmarketplace_vehicles WHERE item_id = @item_id AND id = @id', {
				['@item_id'] = item.item_id,
				['@id'] = item.id,
			}, function(veh)
				exports.oxmysql:execute('DELETE FROM okokmarketplace_vehicles WHERE item_id = @item_id AND id = @id', {
					['@id'] = veh[1].id,
					['@item_id'] = veh[1].item_id,
				},function (rowDeleted)
					if rowDeleted.affectedRows > 0 then
						if veh[1].sold then
							xPlayer.Functions.AddMoney('bank', tonumber(veh[1].price))
							TriggerClientEvent('QBCore:Notify', _source, "You claimed "..veh[1].price.." $", "success")
							if Webhook ~= '' then
								local identifierlist = ExtractIdentifiers(_source)
								local data = {
									playerid = _source,
									identifier = identifierlist.license:gsub("license2:", ""),
									discord = "<@"..identifierlist.discord:gsub("discord:", "")..">",
									type = "claim",
									action = "Claimed an Ad",
									item = veh[1].label.." ("..veh[1].plate..")",
									price = veh[1].price,
									desc = veh[1].description,
									title = "MARKETPLACE - Vehicles",
								}
								discordWenhook(data)
							end
						else
							exports.oxmysql:execute('UPDATE player_vehicles SET citizenid = @citizenid WHERE plate = @plate', {
								['@plate'] = veh[1].plate,
								['@citizenid'] = veh[1].author_identifier,
							})
							TriggerClientEvent('okokMarketplace:updateVehiclesDropdown', _source)
							TriggerClientEvent('QBCore:Notify', _source, "You canceled the AD "..veh[1].label.." ("..veh[1].plate..")", "success")
							if Webhook ~= '' then
								local identifierlist = ExtractIdentifiers(_source)
								local data = {
									playerid = _source,
									identifier = identifierlist.license:gsub("license2:", ""),
									discord = "<@"..identifierlist.discord:gsub("discord:", "")..">",
									type = "cancel",
									action = "Canceled an Ad",
									item = veh[1].label.." ("..veh[1].plate..")",
									price = veh[1].price,
									desc = veh[1].description,
									title = "MARKETPLACE - Vehicles",
								}
								discordWenhook(data)
							end
						end
					else
						TriggerClientEvent('QBCore:Notify', _source, "Something went wrong, please try again later!", "error")
					end
				end)
			end)
		elseif item.type then
			exports.oxmysql:execute('SELECT * FROM okokmarketplace_blackmarket WHERE item_id = @item_id AND id = @id', {
				['@item_id'] = item.item_id,
				['@id'] = item.id,
			}, function(blackmarket)
				if xPlayer.Functions.AddItem(blackmarket[1].item_id, tonumber(blackmarket[1].amount)) then
					exports.oxmysql:execute('DELETE FROM okokmarketplace_blackmarket WHERE item_id = @item_id AND id = @id', {
						['@id'] = blackmarket[1].id,
						['@item_id'] = blackmarket[1].item_id,
					},function (rowDeleted)
						if rowDeleted.affectedRows > 0 then
							if blackmarket[1].sold then
								xPlayer.Functions.RemoveItem(blackmarket[1].item_id, tonumber(blackmarket[1].amount))
								xPlayer.Functions.AddMoney('bank', tonumber(blackmarket[1].price))
								TriggerClientEvent('QBCore:Notify', _source, "You claimed "..blackmarket[1].price.." $", "success")
								if Webhook ~= '' then
									local identifierlist = ExtractIdentifiers(_source)
									local data = {
										playerid = _source,
										identifier = identifierlist.license:gsub("license2:", ""),
										discord = "<@"..identifierlist.discord:gsub("discord:", "")..">",
										type = "claim",
										action = "Claimed an Ad",
										item = blackmarket[1].label.." (x"..blackmarket[1].amount..")",
										price = blackmarket[1].price,
										desc = blackmarket[1].description,
										title = "MARKETPLACE - Blackmarket",
									}
									discordWenhook(data)
								end
							else
								TriggerClientEvent('okokMarketplace:updateBlackmarketDropdown', _source)
								TriggerClientEvent('QBCore:Notify', _source, "You canceled the AD "..blackmarket[1].label.." (x"..blackmarket[1].amount..")", "success")
								if Webhook ~= '' then
									local identifierlist = ExtractIdentifiers(_source)
									local data = {
										playerid = _source,
										identifier = identifierlist.license:gsub("license2:", ""),
										discord = "<@"..identifierlist.discord:gsub("discord:", "")..">",
										type = "cancel",
										action = "Canceled an Ad",
										item = blackmarket[1].label.." (x"..blackmarket[1].amount..")",
										price = blackmarket[1].price,
										desc = blackmarket[1].description,
										title = "MARKETPLACE - Blackmarket",
									}
									discordWenhook(data)
								end
							end
						else
							TriggerClientEvent('QBCore:Notify', _source, "Something went wrong, please try again later!", "error")
						end
					end)
				else
					TriggerClientEvent('QBCore:Notify', _source, "You don't have enough space to carry this item.", "error")
				end
			end)
		else
			exports.oxmysql:execute('SELECT * FROM okokmarketplace_items WHERE item_id = @item_id AND id = @id', {
				['@item_id'] = item.item_id,
				['@id'] = item.id,
			}, function(items)
				if xPlayer.Functions.AddItem(items[1].item_id, tonumber(items[1].amount)) then
					exports.oxmysql:execute('DELETE FROM okokmarketplace_items WHERE item_id = @item_id AND id = @id', {
						['@id'] = items[1].id,
						['@item_id'] = items[1].item_id,
					},function (rowDeleted)
						if rowDeleted.affectedRows > 0 then
							if items[1].sold then
								xPlayer.Functions.RemoveItem(items[1].item_id, tonumber(items[1].amount))
								xPlayer.Functions.AddMoney('bank', tonumber(items[1].price))
								TriggerClientEvent('QBCore:Notify', _source, "You claimed "..items[1].price.." $", "success")
								if Webhook ~= '' then
									local identifierlist = ExtractIdentifiers(_source)
									local data = {
										playerid = _source,
										identifier = identifierlist.license:gsub("license2:", ""),
										discord = "<@"..identifierlist.discord:gsub("discord:", "")..">",
										type = "claim",
										action = "Claimed an Ad",
										item = items[1].label.." (x"..items[1].amount..")",
										price = items[1].price,
										desc = items[1].description,
										title = "MARKETPLACE - Items",
									}
									discordWenhook(data)
								end
							else
								TriggerClientEvent('okokMarketplace:updateItemsDropdown', _source)
								TriggerClientEvent('QBCore:Notify', _source, "You canceled the AD "..items[1].label.." (x"..items[1].amount..")", "success")
								if Webhook ~= '' then
									local identifierlist = ExtractIdentifiers(_source)
									local data = {
										playerid = _source,
										identifier = identifierlist.license:gsub("license2:", ""),
										discord = "<@"..identifierlist.discord:gsub("discord:", "")..">",
										type = "cancel",
										action = "Canceled an Ad",
										item = items[1].label.." (x"..items[1].amount..")",
										price = items[1].price,
										desc = items[1].description,
										title = "MARKETPLACE - Items",
									}
									discordWenhook(data)
								end
							end
						else
							TriggerClientEvent('QBCore:Notify', _source, "Something went wrong, please try again later!", "error")
						end
					end)
				else
					TriggerClientEvent('QBCore:Notify', _source, "You don't have enough space to carry this item.", "error")
				end
			end)
		end
	end
	TriggerClientEvent('okokMarketplace:updateMyAds', _source)
end)

-------------------------- IDENTIFIERS

function ExtractIdentifiers(id)
	local identifiers = {
		steam = "",
		ip = "",
		discord = "",
		license = "",
		xbl = "",
		live = ""
	}

	for i = 0, GetNumPlayerIdentifiers(id) - 1 do
		local playerID = GetPlayerIdentifier(id, i)

		if string.find(playerID, "steam") then
			identifiers.steam = playerID
		elseif string.find(playerID, "ip") then
			identifiers.ip = playerID
		elseif string.find(playerID, "discord") then
			identifiers.discord = playerID
		elseif string.find(playerID, "license") then
			identifiers.license = playerID
		elseif string.find(playerID, "xbl") then
			identifiers.xbl = playerID
		elseif string.find(playerID, "live") then
			identifiers.live = playerID
		end
	end

	return identifiers
end

-------------------------- WEBHOOK

function discordWenhook(data)
	local color = '65352'
	local category = 'test'

	local information = {}

	if data.type == 'add' then
		color = Config.AddAdColor
	elseif data.type == 'buy' then
		color = Config.BuyItemColor
		information = {
			{
				["color"] = color,
				["author"] = {
					["icon_url"] = Config.IconURL,
					["name"] = Config.ServerName..' - Logs',
				},
				["title"] = data.title,
				["description"] = '**Action:** '..data.action..'\n**Item:** '..data.item..'\n**Price:** '..data.price..'\n**Description:** '..data.desc..'\n**From:** '..data.from..'\n\n**ID:** '..data.playerid..'\n**Identifier:** '..data.identifier..'\n**Discord:** '..data.discord,
				["footer"] = {
					["text"] = os.date(Config.DateFormat),
				}
			}
		}
	elseif data.type == 'cancel' then
		color = Config.RemoveAdColor
	elseif data.type == 'claim' then
		color = Config.ClaimAdColor
	end
	
	information = {
		{
			["color"] = color,
			["author"] = {
				["icon_url"] = Config.IconURL,
				["name"] = Config.ServerName..' - Logs',
			},
			["title"] = data.title,
			["description"] = '**Action:** '..data.action..'\n**Item:** '..data.item..'\n**Price:** '..data.price..'\n**Description:** '..data.desc..'\n\n**ID:** '..data.playerid..'\n**Identifier:** '..data.identifier..'\n**Discord:** '..data.discord,
			["footer"] = {
				["text"] = os.date(Config.DateFormat),
			}
		}
	}

	PerformHttpRequest(Webhook, function(err, text, headers) end, 'POST', json.encode({username = Config.BotName, embeds = information}), {['Content-Type'] = 'application/json'})
end