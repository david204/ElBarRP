local QBCore = exports['qb-core']:GetCoreObject()
QBCore.Commands.Add('s0', 'Take off your Shirt', {}, false, function(source, args)
    TriggerClientEvent("clothes:shirtoff", source)
end)

QBCore.Commands.Add('s1', 'Put on your Shirt', {}, false, function(source, args)
    TriggerClientEvent("clothes:shirton", source)
end)

QBCore.Commands.Add('j0', 'Take off your Jacket', {}, false, function(source, args)
    TriggerClientEvent("clothes:jacketoff", source)
end)

QBCore.Commands.Add('j1', 'Put on your Jacket', {}, false, function(source, args)
    TriggerClientEvent("clothes:jacketon", source)
end)

QBCore.Commands.Add('j0', 'Take off your Pants', {}, false, function(source, args)
    TriggerClientEvent("clothes:pantsoff", source)
end)

QBCore.Commands.Add('j1', 'Put on your Pants', {}, false, function(source, args)
    TriggerClientEvent("clothes:pantson", source)
end)

QBCore.Commands.Add('s0', 'Take off your Shoes', {}, false, function(source, args)
    TriggerClientEvent("clothes:shoesoff", source)
end)

QBCore.Commands.Add('s1', 'Put on your Shoes', {}, false, function(source, args)
    TriggerClientEvent("clothes:shoeson", source)
end)

QBCore.Commands.Add('g0', 'Take off your Glasses', {}, false, function(source, args)
    TriggerClientEvent("clothes:glassesoff", source)
end)

QBCore.Commands.Add('g1', 'Put on your Glasses', {}, false, function(source, args)
    TriggerClientEvent("clothes:glasseson", source)
end)

QBCore.Commands.Add('n0', 'Take off your Necklece', {}, false, function(source, args)
    TriggerClientEvent("clothes:neckleceoff", source)
end)

QBCore.Commands.Add('n1', 'Put on your Necklece', {}, false, function(source, args)
    TriggerClientEvent("clothes:neckleceon", source)
end)

QBCore.Commands.Add('b0', 'Take off your Bag', {}, false, function(source, args)
    TriggerClientEvent("clothes:bagoff", source)
end)

QBCore.Commands.Add('b1', 'Put on your Bag', {}, false, function(source, args)
    TriggerClientEvent("clothes:bagon", source)
end)

QBCore.Commands.Add('v0', 'Take off your Vest', {}, false, function(source, args)
    TriggerClientEvent("clothes:vestoff", source)
end)

QBCore.Commands.Add('v1', 'Put on your Vest', {}, false, function(source, args)
    TriggerClientEvent("clothes:veston", source)
end)

QBCore.Commands.Add('m0', 'Take off your Mask', {}, false, function(source, args)
    TriggerClientEvent("clothes:maskoff", source)
end)

QBCore.Commands.Add('m1', 'Put on your Mask', {}, false, function(source, args)
    TriggerClientEvent("clothes:maskon", source)
end)

QBCore.Commands.Add('e0', 'Take off your Ear Pieces', {}, false, function(source, args)
    TriggerClientEvent("clothes:earringsoff", source)
end)

QBCore.Commands.Add('e1', 'Put on your Ear Pieces', {}, false, function(source, args)
    TriggerClientEvent("clothes:earringson", source)
end)

QBCore.Commands.Add('w0', 'Take off your Watch', {}, false, function(source, args)
    TriggerClientEvent("clothes:watchoff", source)
end)

QBCore.Commands.Add('w1', 'Put on your Watch', {}, false, function(source, args)
    TriggerClientEvent("clothes:watchon", source)
end)

QBCore.Commands.Add('h0', 'Take off your Hat', {}, false, function(source, args)
    TriggerClientEvent("clothes:hatoff", source)
end)

QBCore.Commands.Add('h1', 'Put on your Hat', {}, false, function(source, args)
    TriggerClientEvent("clothes:haton", source)
end)

QBCore.Commands.Add('Restore', 'Restore your clothing', {}, false, function(source, args)
    TriggerClientEvent("clothes:restore", source)
end)