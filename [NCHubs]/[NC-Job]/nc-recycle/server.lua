

local QBCore = exports['qb-core']:GetCoreObject()

local ItemTable = {
    "metalscrap",
    "plastic",
    "copper",
    "iron",
    "aluminum",
    "steel",
    "steel",
    "glass",
    "rubber",
	"bottle",
	"can",
}

--- Event For Getting Recyclable Material----

RegisterServerEvent("nc-recycle:getrecyclablematerial")
AddEventHandler("nc-recycle:getrecyclablematerial", function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local amount = math.random(10, 30)
    Player.Functions.AddItem("recyclablematerial", amount, false, {["quality"] = nil})
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["recyclablematerial"], 'add', amount)
    Citizen.Wait(500)
end)

--------------------------------------------------

---- Trade Event Starts Over Here ------

RegisterServerEvent("nc-recycle:TradeItems")
AddEventHandler("nc-recycle:TradeItems", function(data)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
	local randItem = ""
	local amount = 0
	if data == 1 then
		if Player.Functions.GetItemByName('recyclablematerial') ~= nil and Player.Functions.GetItemByName('recyclablematerial').amount >= 10 then
			Player.Functions.RemoveItem("recyclablematerial", 10)
			TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["recyclablematerial"], 'remove', 10)
			Citizen.Wait(1000)
			randItem = ItemTable[math.random(1, #ItemTable)]
			amount = math.random(Config.tenmin, Config.tenmax)
			Player.Functions.AddItem(randItem, amount, false, {["quality"] = nil})
			TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[randItem], 'add', amount)
			randItem = ItemTable[math.random(1, #ItemTable)]
			amount = math.random(Config.tenmin, Config.tenmax)
			Citizen.Wait(1000)
			Player.Functions.AddItem(randItem, amount, false, {["quality"] = nil})
			TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[randItem], 'add', amount)
			randItem = ItemTable[math.random(1, #ItemTable)]
			amount = math.random(Config.tenmin, Config.tenmax)
			Citizen.Wait(1000)
			Player.Functions.AddItem(randItem, amount, false, {["quality"] = nil})
			TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[randItem], 'add', amount)
			else
				TriggerClientEvent('QBCore:Notify', src, "You Don't Have Enough Items")
			end
	elseif data == 2 then
		if Player.Functions.GetItemByName('recyclablematerial') ~= nil and Player.Functions.GetItemByName('recyclablematerial').amount >= 100 then
			Player.Functions.RemoveItem("recyclablematerial", "100")
			TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["recyclablematerial"], 'remove', 100)
			Citizen.Wait(1000)

			randItem = ItemTable[math.random(1, #ItemTable)]
			amount = math.random(Config.bulkmin, Config.bulkmax)
			Player.Functions.AddItem(randItem, amount, false, {["quality"] = nil})
			TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[randItem], 'add', amount)
			Citizen.Wait(1000) 

			randItem = ItemTable[math.random(1, #ItemTable)]
			amount = math.random(Config.bulkmin, Config.bulkmax)
			Player.Functions.AddItem(randItem, amount, false, {["quality"] = nil})
			TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[randItem], 'add', amount)
			Citizen.Wait(1000)

			randItem = ItemTable[math.random(1, #ItemTable)]
			amount = math.random(Config.bulkmin, Config.bulkmax)
			Player.Functions.AddItem(randItem, amount, false, {["quality"] = nil})
			TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[randItem], 'add', amount)
			Citizen.Wait(1000)

			randItem = ItemTable[math.random(1, #ItemTable)]
			amount = math.random(Config.bulkmin, Config.bulkmax)
			Player.Functions.AddItem(randItem, amount, false, {["quality"] = nil})
			TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[randItem], 'add', amount)
			Citizen.Wait(1000)

			randItem = ItemTable[math.random(1, #ItemTable)]
			amount = math.random(Config.bulkmin, Config.bulkmax)
			Player.Functions.AddItem(randItem, amount, false, {["quality"] = nil})
			TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[randItem], 'add', amount)
			Citizen.Wait(1000)

			randItem = ItemTable[math.random(1, #ItemTable)]
			amount = math.random(Config.bulkmin, Config.bulkmax)       
			Player.Functions.AddItem(randItem, amount, false, {["quality"] = nil})
			TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[randItem], 'add', amount)
			Citizen.Wait(1000)
			
			randItem = ItemTable[math.random(1, #ItemTable)]
			amount = math.random(Config.bulkmin, Config.bulkmax)
			Player.Functions.AddItem(randItem, amount, false, {["quality"] = nil})
			TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[randItem], 'add', amount)
			Citizen.Wait(1000)

			randItem = ItemTable[math.random(1, #ItemTable)]
			amount = math.random(Config.bulkmin, Config.bulkmax)
			Player.Functions.AddItem(randItem, amount, false, {["quality"] = nil})
			TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[randItem], 'add', amount)
			Citizen.Wait(1000)
		else
			TriggerClientEvent('QBCore:Notify', src, "You Do Not Have Enough Items")
		end
    end
end)

---- Trade Event End Over Here ------

RegisterServerEvent("nc-recycle:Selling:All")
AddEventHandler("nc-recycle:Selling:All", function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local payment = 0
	for k, v in pairs(Config.Prices) do
        if Player.Functions.GetItemByName(v.name) ~= nil then
            copper = Player.Functions.GetItemByName(v.name).amount
            pay = (copper * v.amount)
            Player.Functions.RemoveItem(v.name, copper)
            Player.Functions.AddMoney('cash', pay)
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[v.name], 'remove', copper)
        payment = payment + pay
        end
    end
    Citizen.Wait(500)
	TriggerClientEvent("QBCore:Notify", src, "Total: $"..payment, 'success')
end)

RegisterNetEvent("nc-recycle:Selling:Mat")
AddEventHandler("nc-recycle:Selling:Mat", function(data)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    if Player.Functions.GetItemByName(data) ~= nil then
        local amount = Player.Functions.GetItemByName(data).amount
        local pay = (amount * Config.Prices[data].amount)
        Player.Functions.RemoveItem(data, amount)
        Player.Functions.AddMoney('cash', pay)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[data], 'remove', amount)
        TriggerClientEvent("QBCore:Notify", src, "Payment received", "Total: $"..pay, "error")
    else
        TriggerClientEvent("QBCore:Notify", src, "You don't have any "..QBCore.Shared.Items[data].label.. "", "error")
    end
    Citizen.Wait(1000)
end)


RegisterServerEvent('nc-recycle:Dumpsters:Reward')
AddEventHandler('nc-recycle:Dumpsters:Reward', function(listKey)
    local src = source 
    local Player = QBCore.Functions.GetPlayer(src)
        for i = 1, math.random(1, 4), 1 do
            local item = Config.DumpItems[math.random(1, #Config.DumpItems)]
            local amount = math.random(1, 4)
            Player.Functions.AddItem(item, amount, false, {["quality"] = nil})
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item], 'add', amount)
            Citizen.Wait(500)
        end
        local Luck = math.random(1, 4)
        local Odd = math.random(1, 4)
        if Luck == Odd then
            local random = math.random(1, 4)
            Player.Functions.AddItem("rubber", random, false, {["quality"] = nil})
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["rubber"], 'add', random)
        end
end)
