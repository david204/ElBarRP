local QBCore = exports['qb-core']:GetCoreObject()

RegisterServerEvent('houseRobberies:removeLockpick')
AddEventHandler('houseRobberies:removeLockpick', function()
 local source = tonumber(source)
 local xPlayer = QBCore.Functions.GetPlayer(source)
 xPlayer.Functions.RemoveItem('advancedlockpick', 1)
 TriggerClientEvent('QBCore:Notify', source, 'The lockpick bent out of shape.', "error")
end)

RegisterServerEvent('houseRobberies:log')
AddEventHandler('houseRobberies:log', function(id, success)
  TriggerEvent('nn:log', {
    src = source, 
    webhook = "house-robbery",
    description = "Lockpick house #%s %s.",
    args = { id, success and 'successfully' or 'failed' }
  });
end)

RegisterServerEvent('houseRobberies:giveMoney')
AddEventHandler('houseRobberies:giveMoney', function()
 local source = tonumber(source)
 local xPlayer = QBCore.Functions.GetPlayer(source)
 local cash = math.random(300, 600)
 xPlayer.Functions.AddMoney('cash', cash)

  TriggerEvent('nn:log', {
    src = source, 
    webhook = "house-robbery",
    description = "Received $%s.",
    args = { cash }
  });

 TriggerClientEvent('QBCore:Notify', source, 'You found $'..cash)
end)

RegisterServerEvent('houseRobberies:searchItem')
AddEventHandler('houseRobberies:searchItem', function()
 local source = tonumber(source)
 local item = {}
 local xPlayer = QBCore.Functions.GetPlayer(source)
 local gotID = {}

 for i=1, math.random(1, 2) do
  item = Config.RobbableItems[math.random(1, #Config.RobbableItems)]
  if math.random(1, 10) >= item.chance then
   if tonumber(item.id) == 0 and not gotID[item.id] then
    gotID[item.id] = true
    xPlayer.Functions.AddMoney('cash', item.quantity)

    TriggerEvent('nn:log', {
      src = source, 
      webhook = "house-robbery",
      description = "Received $%s.",
      args = { item.quantity }
    });

    TriggerClientEvent('QBCore:Notify', source, 'You found $'..item.quantity)
   elseif not gotID[item.id] then
    gotID[item.id] = true
    xPlayer.Functions.AddItem(item.id, item.quantity)

    TriggerEvent('nn:log', {
      src = source, 
      webhook = "house-robbery",
      description = "Received %sx %s.",
      args = { item.quantity, item.id }
    });

    TriggerClientEvent('QBCore:Notify', source, "You got".. " ".. item.name)
   end
  end
 end
end)

QBCore.Functions.CreateCallback("srp:getCopsCount", function(src,cb)
  local players = QBCore.Functions.GetPlayers()
  local count = 0
  for k,v in next, players do 
      local player = QBCore.Functions.GetPlayer(v).PlayerData
      if player.job.name == "police" then 
          count = count + 1
      end
  end
  cb(count)
end)
