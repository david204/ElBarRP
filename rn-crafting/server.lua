local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent("srp-crafting:server:openUI")
AddEventHandler("srp-crafting:server:openUI", function()
  local src = tonumber(source)
  local Player = QBCore.Functions.GetPlayer(src)
  local item = {
    item1 = Player.Functions.GetItemByName("aluminum") and Player.Functions.GetItemByName("aluminum").amount or 0,
    item2 = Player.Functions.GetItemByName("metalscrap") and Player.Functions.GetItemByName("metalscrap").amount or 0,
    item3 = Player.Functions.GetItemByName("steel") and Player.Functions.GetItemByName("steel").amount or 0,
    item4 = Player.Functions.GetItemByName("plastic") and Player.Functions.GetItemByName("plastic").amount or 0
  }
  TriggerClientEvent("srp-crafting:client:openUI", src, item)
end)

RegisterNetEvent("srp-crafting:server:giveWeapon")
AddEventHandler("srp-crafting:server:giveWeapon", function(weapon)
  local src = tonumber(source)
  local playerName = GetPlayerName(src)
  local Player = QBCore.Functions.GetPlayer(src)
  Player.Functions.AddItem(weapon, 1)
  TriggerEvent('nn-logs:server:createLog', 'crafting', 'The weapon:', "**"..playerName.."** ".."build this weapon: **"..weapon, src)
end)

RegisterNetEvent("srp-crafting:server:removeItems")
AddEventHandler("srp-crafting:server:removeItems", function(amount1,amount2,amount3,amount4)
  local src = tonumber(source)
  local Player = QBCore.Functions.GetPlayer(src)
  Player.Functions.RemoveItem("aluminum", amount1)
  Player.Functions.RemoveItem("metalscrap", amount2)
  Player.Functions.RemoveItem("steel", amount3)
  Player.Functions.RemoveItem("plastic", amount4)
end)

QBCore.Functions.CreateCallback("srp-crafting:isHaveMoney", function(src,cb,amount)
    local ply = QBCore.Functions.GetPlayer(src)
    cb(ply.PlayerData.money["cash"] >= amount)      
end)

RegisterNetEvent("srp-crafting:removemoney",function(money)
  local src = source
  local ply = QBCore.Functions.GetPlayer(src)
  ply.Functions.RemoveMoney('cash', money, "Crafting")
end)



-- CreateThread(function()
--   local loc = vector4(1011.9946, -3248.241, -18.77049, 34.087108)
--   while true do 
--     local veh = GetAllVehicles()
--     for i = 1,#veh do 
--       if checkDistance(loc,GetEntityCoords(veh[i])) < 400 then 
--         if GetEntityModel(veh[i]) == 1951180813 then 
--           DeleteEntity(veh[i])
--         end
--       end
--     end
--     Wait(2000)
--   end
-- end)

-- function checkDistance(vec1,vec2)
--   vec1 = vec2 - vec1 
--   return (vec1.x * vec1.x) + (vec1.y * vec1.y) + (vec1.z * vec1.z)
-- end