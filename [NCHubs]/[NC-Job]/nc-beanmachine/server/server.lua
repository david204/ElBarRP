local QBCore = exports['qb-core']:GetCoreObject()

CreateThread(function()
	local drinks = { "bigfruit", "highnoon", "speedball", "gunkaccino", "bratte", "flusher", "ecocoffee", "caffeagra", "ecola", "ecolalight", "sprunk", "sprunklight" }
    for k,v in pairs(drinks) do QBCore.Functions.CreateUseableItem(v, function(source, item) TriggerClientEvent('nc-beanmachine:client:Drink', source, item.name) end) end
	
	local food = { "cheesecake", "watermelon", "beandonut", "chocolate", "milk",  }
    for k,v in pairs(food) do QBCore.Functions.CreateUseableItem(v, function(source, item) TriggerClientEvent('nc-beanmachine:client:Eat', source, item.name) end) end
end)

RegisterServerEvent('nc-beanmachine:GetFood', function(ItemMake, tablenumber, craftable)
	local src = source
    local Player = QBCore.Functions.GetPlayer(src)
	--This grabs the table from client and removes the item requirements
	amount = 1
	if craftable ~= nil then
		for k, v in pairs(craftable[tonumber(tablenumber)][tostring(ItemMake)]) do
			if Config.Debug then print("GetFood Table Result: craftable["..tablenumber.."]['"..ItemMake.."']['"..k.."']['"..v.."']") end		
			TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[tostring(k)], "remove", v) 
			Player.Functions.RemoveItem(tostring(k), v)
		end
		if craftable[tonumber(tablenumber)]["amount"] ~= nil then amount = craftable[tonumber(tablenumber)]["amount"] else amount = 1 end
	end
	--This should give the item, while the rest removes the requirements
	Player.Functions.AddItem(ItemMake, amount, false, {["quality"] = nil})
	TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[ItemMake], "add", amount)
	
	if Config.Debug then print("Giving ["..src.."]: x"..amount.." "..ItemMake) end		
end)

---ITEM REQUIREMENT CHECKS
QBCore.Functions.CreateCallback('nc-beanmachine:get', function(source, cb, item, tablenumber, craftable)
	local src = source
	local hasitem = false
	local hasanyitem = nil
		for k, v in pairs(craftable[tonumber(tablenumber)][tostring(item)]) do
			if QBCore.Functions.GetPlayer(src).Functions.GetItemByName(k) then
				if QBCore.Functions.GetPlayer(src).Functions.GetItemByName(k).amount >= v then 
					number = tostring(QBCore.Functions.GetPlayer(src).Functions.GetItemByName(k).amount)
					hasitem = true
				else hasanyitem = false
				end
			end
			if Config.Debug then print("craftable["..tablenumber.."]['"..item.."']['"..k.."']['"..v.."'] = "..tostring(hasitem).." ("..tostring(number)..")") end		
		end
	if hasanyitem ~= nil then hasitem = false end
if hasitem then cb(true) else cb(false) end end)