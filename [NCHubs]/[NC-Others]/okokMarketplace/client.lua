local QBCore = exports['qb-core']:GetCoreObject()

Citizen.CreateThread(function() 
    while QBCore == nil do
        TriggerEvent("QBCore:GetObject", function(obj) QBCore = obj end)    
        Citizen.Wait(200)
    end
end)

local TE = TriggerEvent
local TSE = TriggerServerEvent
local job = nil
local isVisible = false
local tabletObject = nil

Citizen.CreateThread(function()
	while QBCore.Functions.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end
	job = QBCore.Functions.GetPlayerData().job
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate')
AddEventHandler('QBCore:Client:OnJobUpdate', function(JobInfo)
    job = JobInfo
end) 

RegisterNetEvent("okokMarketplace:open")
AddEventHandler("okokMarketplace:open", function()
	local vehiclesTable = {}
	local itemsTable = {}
	local blackmarketTable = {}
	local accessBlackmarket = false
	toggleTablet()
	if not isMarketOpen then
		QBCore.Functions.TriggerCallback("okokMarketplace:getItems", function(vehicles, items)
			local inv = items
			if inv[1] == nil then
				inv[1] = {}
			end
			for k,v in ipairs(vehicles) do
				local veh = json.decode(v.vehicle)
				local canAdd = true
				for k2,v2 in ipairs(Config.BlacklistVehicles) do
					if GetDisplayNameFromVehicleModel(veh.model) == v2 then
						canAdd = false
						break
					end
				end

				if canAdd then
					table.insert(vehiclesTable, {vehicle = v.vehicle, plate = v.plate, name = GetDisplayNameFromVehicleModel(veh.model)})
				end
			end

			local timesWithoutItem = 0
			for k,v in ipairs(inv) do
				if inv[k+1] == nil then
					inv[k+1] = {}
				end
				local canAdd = true
				local blackmarketItem = false
				if json.encode(v) ~= '[]' then
					timesWithoutItem = 0
					if v.amount > 0 then
						for k2,v2 in ipairs(Config.BlacklistItems) do
							if v.name == v2 then
								canAdd = false
								break
							end
						end

						if canAdd then
							table.insert(itemsTable, {id = v.name, label = QBCore.Shared.Items[v.name]["label"], count = v.amount})
						else
							for k2,v2 in ipairs(Config.Blackmarket) do
								if v.name == v2[1] then
									blackmarketItem = true
									break
								end
							end

							if blackmarketItem then
								table.insert(blackmarketTable, {id = v.name, label = QBCore.Shared.Items[v.name]["label"], count = v.amount, type = "item"})
							end
						end
					end
				else
					timesWithoutItem = timesWithoutItem + 1
					if timesWithoutItem == 50 then
						break
					end
				end
			end
			
			QBCore.Functions.TriggerCallback("okokMarketplace:getAds", function(vehAds, itemsAds, blackmarketAds, identifier)
				local vehAds1 = {}
				local itemsAds1 = {}
				local blackmarketAds1 = {}
				local myAds = {}

				for k,v in ipairs(vehAds) do
					if v.author_identifier ~= identifier then
						if not v.sold then
							table.insert(vehAds1, v)
						end
					else
						table.insert(myAds, v)
					end
				end

				for k,v in ipairs(itemsAds) do
					if v.author_identifier ~= identifier then
						if not v.sold then
							table.insert(itemsAds1, v)
						end
					else
						table.insert(myAds, v)
					end
				end

				for k,v in ipairs(blackmarketAds) do
					if v.author_identifier ~= identifier then
						if not v.sold then
							table.insert(blackmarketAds1, v)
						end
					else
						table.insert(myAds, v)
					end
				end
				
				isMarketOpen = true
				SetNuiFocus(true, true)
				SendNUIMessage({
					action = 'openVehicleMarket',
					vehicles = vehiclesTable,
					vehAds = vehAds1,
					items = itemsTable,
					itemsAds = itemsAds1,
					blackmarket = blackmarketTable,
					blackmarketAds = blackmarketAds1,
					myAds = myAds,
					accessBlackmarket = accessBlackmarket,
				})	
			end)
		end)
	end
end)

-- Black Market
RegisterNetEvent("okokMarketplace:openbmarket")
AddEventHandler("okokMarketplace:openbmarket", function()
	local vehiclesTable = {}
	local itemsTable = {}
	local blackmarketTable = {}
	local accessBlackmarket = true
	toggleTablet()
	if not isMarketOpen then
		QBCore.Functions.TriggerCallback("okokMarketplace:getItems", function(vehicles, items)
			local inv = items
			if inv[1] == nil then
				inv[1] = {}
			end
			for k,v in ipairs(vehicles) do
				local veh = json.decode(v.vehicle)
				local canAdd = true
				for k2,v2 in ipairs(Config.BlacklistVehicles) do
					if GetDisplayNameFromVehicleModel(veh.model) == v2 then
						canAdd = false
						break
					end
				end

				if canAdd then
					table.insert(vehiclesTable, {vehicle = v.vehicle, plate = v.plate, name = GetDisplayNameFromVehicleModel(veh.model)})
				end
			end

			local timesWithoutItem = 0
			for k,v in ipairs(inv) do
				if inv[k+1] == nil then
					inv[k+1] = {}
				end
				local canAdd = true
				local blackmarketItem = false
				if json.encode(v) ~= '[]' then
					timesWithoutItem = 0
					if v.amount > 0 then
						for k2,v2 in ipairs(Config.BlacklistItems) do
							if v.name == v2 then
								canAdd = false
								break
							end
						end

						if canAdd then
							table.insert(itemsTable, {id = v.name, label = QBCore.Shared.Items[v.name]["label"], count = v.amount})
						else
							for k2,v2 in ipairs(Config.Blackmarket) do
								if v.name == v2[1] then
									blackmarketItem = true
									break
								end
							end

							if blackmarketItem then
								table.insert(blackmarketTable, {id = v.name, label = QBCore.Shared.Items[v.name]["label"], count = v.amount, type = "item"})
							end
						end
					end
				else
					timesWithoutItem = timesWithoutItem + 1
					if timesWithoutItem == 50 then
						break
					end
				end
			end
			
			QBCore.Functions.TriggerCallback("okokMarketplace:getAds", function(vehAds, itemsAds, blackmarketAds, identifier)
				local vehAds1 = {}
				local itemsAds1 = {}
				local blackmarketAds1 = {}
				local myAds = {}

				for k,v in ipairs(vehAds) do
					if v.author_identifier ~= identifier then
						if not v.sold then
							table.insert(vehAds1, v)
						end
					else
						table.insert(myAds, v)
					end
				end

				for k,v in ipairs(itemsAds) do
					if v.author_identifier ~= identifier then
						if not v.sold then
							table.insert(itemsAds1, v)
						end
					else
						table.insert(myAds, v)
					end
				end

				for k,v in ipairs(blackmarketAds) do
					if v.author_identifier ~= identifier then
						if not v.sold then
							table.insert(blackmarketAds1, v)
						end
					else
						table.insert(myAds, v)
					end
				end
				
				isMarketOpen = true
				SetNuiFocus(true, true)
				SendNUIMessage({
					action = 'openVehicleMarket',
					vehicles = vehiclesTable,
					vehAds = vehAds1,
					items = itemsTable,
					itemsAds = itemsAds1,
					blackmarket = blackmarketTable,
					blackmarketAds = blackmarketAds1,
					myAds = myAds,
					accessBlackmarket = accessBlackmarket,
				})	
			end)
		end)
	end
end)

function toggleTablet()
    local playerPed = PlayerPedId()

    if not isVisible then
        local dict = "amb@world_human_seat_wall_tablet@female@base"
        RequestAnimDict(dict)
        if tabletObject == nil then
            tabletObject = CreateObject(GetHashKey("prop_cs_tablet"), GetEntityCoords(playerPed), 1, 1, 1)
            AttachEntityToEntity(
                tabletObject,
                playerPed,
                GetPedBoneIndex(playerPed, 28422),
                0.0,
                0.0,
                0.03,
                0.0,
                0.0,
                0.0,
                1,
                1,
                0,
                1,
                0,
                1
            )
        end
        while not HasAnimDictLoaded(dict) do
            Citizen.Wait(100)
        end
        if not IsEntityPlayingAnim(playerPed, dict, "base", 3) then
            TaskPlayAnim(playerPed, dict, "base", 8.0, 1.0, -1, 49, 1.0, 0, 0, 0)
        end
        isVisible = true
    else
        ClearPedTasks(playerPed)
        DeleteEntity(tabletObject)
        tabletObject = nil
        isVisible = false
    end
end

RegisterNetEvent("okokMarketplace:updateVehicles")
AddEventHandler("okokMarketplace:updateVehicles", function()
	Citizen.Wait(100)
	QBCore.Functions.TriggerCallback("okokMarketplace:getAds", function(vehAds, itemsAds, blackmarketAds, identifier)
		local vehAds1 = {}

		for k,v in ipairs(vehAds) do
			if v.author_identifier ~= identifier and not v.sold then
				table.insert(vehAds1, v)
			end
		end

		SendNUIMessage({
			action = 'updateVehicles',
			vehAds = vehAds1,
		})	
	end)
end)

RegisterNetEvent("okokMarketplace:updateItems")
AddEventHandler("okokMarketplace:updateItems", function()
	Citizen.Wait(100)
	QBCore.Functions.TriggerCallback("okokMarketplace:getAds", function(vehAds, itemsAds, blackmarketAds, identifier)
		local itemsAds1 = {}

		for k,v in ipairs(itemsAds) do
			if v.author_identifier ~= identifier and not v.sold then
				table.insert(itemsAds1, v)
			end
		end

		SendNUIMessage({
			action = 'updateItems',
			itemsAds = itemsAds1,
		})	
	end)
end)

RegisterNetEvent("okokMarketplace:updateBlackmarket")
AddEventHandler("okokMarketplace:updateBlackmarket", function()
	Citizen.Wait(100)
	QBCore.Functions.TriggerCallback("okokMarketplace:getAds", function(vehAds, itemsAds, blackmarketAds, identifier)
		local blackmarketAds1 = {}

		for k,v in ipairs(blackmarketAds) do
			if v.author_identifier ~= identifier and not v.sold then
				table.insert(blackmarketAds1, v)
			end
		end

		SendNUIMessage({
			action = 'updateBlackmarket',
			blackmarketAds = blackmarketAds1,
		})	
	end)
end)

RegisterNetEvent("okokMarketplace:updateMyAds")
AddEventHandler("okokMarketplace:updateMyAds", function()
	Citizen.Wait(100)
	QBCore.Functions.TriggerCallback("okokMarketplace:getAds", function(vehAds, itemsAds, blackmarketAds, identifier)
		local myAds = {}

		for k,v in ipairs(vehAds) do
			if v.author_identifier == identifier then
				table.insert(myAds, v)
			end
		end

		for k,v in ipairs(itemsAds) do
			if v.author_identifier == identifier then
				table.insert(myAds, v)
			end
		end

		for k,v in ipairs(blackmarketAds) do
			if v.author_identifier == identifier then
				table.insert(myAds, v)
			end
		end

		SendNUIMessage({
			action = 'updateMyAds',
			myAds = myAds,
		})	
	end)
end)

RegisterNetEvent("okokMarketplace:updateMyAdsTable")
AddEventHandler("okokMarketplace:updateMyAdsTable", function()
	Citizen.Wait(100)
	QBCore.Functions.TriggerCallback("okokMarketplace:getAds", function(vehAds, itemsAds, blackmarketAds, identifier)
		local myAds = {}

		for k,v in ipairs(vehAds) do
			if v.author_identifier == identifier then
				table.insert(myAds, v)
			end
		end

		for k,v in ipairs(itemsAds) do
			if v.author_identifier == identifier then
				table.insert(myAds, v)
			end
		end

		for k,v in ipairs(blackmarketAds) do
			if v.author_identifier == identifier then
				table.insert(myAds, v)
			end
		end

		SendNUIMessage({
			action = 'updateMyAdsTable',
			myAds = myAds,
		})	
	end)
end)

RegisterNetEvent("okokMarketplace:updateVehiclesDropdown")
AddEventHandler("okokMarketplace:updateVehiclesDropdown", function()
	Citizen.Wait(100)
	local vehiclesTable = {}
	QBCore.Functions.TriggerCallback("okokMarketplace:getItems", function(vehicles, items)
		for k,v in ipairs(vehicles) do
			local veh = json.decode(v.vehicle)
			local canAdd = true
			for k2,v2 in ipairs(Config.BlacklistVehicles) do
				if GetDisplayNameFromVehicleModel(veh.model) == v2 then
					canAdd = false
					break
				end
			end

			if canAdd then
				table.insert(vehiclesTable, {vehicle = v.vehicle, plate = v.plate, name = GetDisplayNameFromVehicleModel(veh.model)})
			end
		end
		SendNUIMessage({
			action = 'updateVehiclesDropdown',
			vehicles = vehiclesTable,
		})
	end)
end)

RegisterNetEvent("okokMarketplace:updateItemsDropdown")
AddEventHandler("okokMarketplace:updateItemsDropdown", function()
	Citizen.Wait(100)
	local itemsTable = {}
	QBCore.Functions.TriggerCallback("okokMarketplace:getItems", function(vehicles, items)
		local inv = items
		if inv[1] == nil then
			inv[1] = {}
		end
		
		local timesWithoutItem = 0
		for k,v in ipairs(inv) do
			if inv[k+1] == nil then
				inv[k+1] = {}
			end
			local canAdd = true
			local blackmarketItem = false
			if json.encode(v) ~= '[]' then
				timesWithoutItem = 0
				if v.amount > 0 then
					for k2,v2 in ipairs(Config.BlacklistItems) do
						if v.name == v2 then
							canAdd = false
							break
						end
					end

					if canAdd then
						table.insert(itemsTable, {id = v.name, label = QBCore.Shared.Items[v.name]["label"], count = v.amount})
					end
				end
			else
				timesWithoutItem = timesWithoutItem + 1
				if timesWithoutItem == 50 then
					break
				end
			end
		end

		SendNUIMessage({
			action = 'updateItemsDropdown',
			items = itemsTable,
		})
	end)
end)

RegisterNetEvent("okokMarketplace:updateBlackmarketDropdown")
AddEventHandler("okokMarketplace:updateBlackmarketDropdown", function()
	Citizen.Wait(100)
	local blackmarketTable = {}
	QBCore.Functions.TriggerCallback("okokMarketplace:getItems", function(vehicles, items)
		local inv = items
		if inv[1] == nil then
			inv[1] = {}
		end
		local timesWithoutItem = 0
		for k,v in ipairs(inv) do
			if inv[k+1] == nil then
				inv[k+1] = {}
			end
			local canAdd = true
			local blackmarketItem = false
			if json.encode(v) ~= '[]' then
				timesWithoutItem = 0
				if v.amount > 0 then
					for k2,v2 in ipairs(Config.BlacklistItems) do
						if v.name == v2 then
							canAdd = false
							break
						end
					end

					if not canAdd then
						for k2,v2 in ipairs(Config.Blackmarket) do
							if v.name == v2[1] then
								blackmarketItem = true
								break
							end
						end

						if blackmarketItem then
							table.insert(blackmarketTable, {id = v.name, label = QBCore.Shared.Items[v.name]["label"], count = v.amount, type = "item"})
						end
					end
				end
			else
				timesWithoutItem = timesWithoutItem + 1
				if timesWithoutItem == 50 then
					break
				end
			end
		end

		SendNUIMessage({
			action = 'updateBlackmarketDropdown',
			blackmarket = blackmarketTable,
		})
	end)
end)

RegisterNUICallback("action", function(data, cb)
	if data.action == "close" then
		isMarketOpen = false
		toggleTablet()
		SetNuiFocus(false, false)
	elseif data.action == "placeAd" then
		if data.window == "vehicles" then
			QBCore.Functions.TriggerCallback("okokMarketplace:phone", function(phone)
				if data.desc == "" then
					local desc = "Nothing to add"
					TSE('okokMarketplace:addVehicle', data.item, data.price, desc, phone)
				else
					TSE('okokMarketplace:addVehicle', data.item, data.price, data.desc, phone)
				end
			end)
		elseif data.window == "items" then
			QBCore.Functions.TriggerCallback("okokMarketplace:phone", function(phone)
				if data.desc == "" then
					local desc = "Nothing to add"
					TSE('okokMarketplace:addItem', data.item, tonumber(data.amount), data.price, desc, phone)
				else
					TSE('okokMarketplace:addItem', data.item, tonumber(data.amount), data.price, data.desc, phone)
				end
			end)
		elseif data.window == "blackmarket" then
			QBCore.Functions.TriggerCallback("okokMarketplace:phone", function(phone)
				if data.desc == "" then
					local desc = "Nothing to add"
					TSE('okokMarketplace:addBlackmarket', data.item, data.price, desc, phone, tonumber(data.amount))
				else
					TSE('okokMarketplace:addBlackmarket', data.item, data.price, data.desc, phone, tonumber(data.amount))
				end
			end)
		end
	elseif data.action == "missing" then
		TriggerEvent('QBCore:Notify', "Please fill in all the required fields", "error")
	elseif data.action == "missingSearch" then
		TriggerEvent('QBCore:Notify', "Search field empty", "error")
	elseif data.action == "high" then
		TriggerEvent('QBCore:Notify', "You don't have enough items to sell", "error")
	elseif data.action == "buyVehicle" then
		QBCore.Functions.TriggerCallback("okokMarketplace:getVehicle", function(veh)
			TSE('okokMarketplace:buyVehicle', veh)
		end, data.id)
	elseif data.action == "buyItem" then
		QBCore.Functions.TriggerCallback("okokMarketplace:getItem", function(item)
			TSE('okokMarketplace:buyItem', item)
		end, data.id, data.item)
	elseif data.action == "buyBlackmarket" then
		QBCore.Functions.TriggerCallback("okokMarketplace:getBlackmarket", function(blackmarket)
			TSE('okokMarketplace:buyBlackmarket', blackmarket)
		end, data.id, data.blackmarket)
	elseif data.action == "myAd" then
		TSE('okokMarketplace:removeMyAd', data.item)
	elseif data.action == "refresh" then
		if data.window == "vehicles" then
			TriggerEvent('okokMarketplace:updateVehicles')
		elseif data.window == "items" then
			TriggerEvent('okokMarketplace:updateItems')
		elseif data.window == "blackmarket" then
			TriggerEvent('okokMarketplace:updateBlackmarket')
		end
	end
end)