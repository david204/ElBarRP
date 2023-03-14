local QBCore = exports['qb-core']:GetCoreObject()

function GiveCash(source, args)
    local ply = QBCore.Functions.GetPlayer(source)
    if ply then
        local targetId = args[1] and tonumber(args[1])
        if targetId then
            local target = QBCore.Functions.GetPlayer(targetId)
            if target then
                if target.PlayerData.source ~= ply.PlayerData.source then
                    if #(GetEntityCoords(GetPlayerPed(source)) - GetEntityCoords(GetPlayerPed(targetId))) <= 3.5 then
                        local amount = args[2] and tonumber(args[2])
                        if amount then
                            if ply.PlayerData.money.cash >= amount then
                                ply.Functions.RemoveMoney('cash', amount)
                                target.Functions.AddMoney('cash', amount)
                                TriggerClientEvent('animations:client:EmoteCommandStart', source, {"id"})
                                TriggerClientEvent('animations:client:EmoteCommandStart', targetId, {"id"})
                                TriggerClientEvent('QBCore:Notify', ("You got $%d from %d"):format(amount, targetId))
                                return false, ("You gave %d$ to #%d."):format(amount, targetId)
                            else
                                return "You dont have that amount of cash."
                            end
                        else
                            return "Amount must be a number"
                        end
                    else
                        return "Target too far."
                    end
                else
                    return "You cannot give cash to yourself daddy."
                end
            else
                return "Player id must be attached to a real player."
            end
        else
            return "Player id must be a number."
        end
    end
end

QBCore.Commands.Add('givecash', 'Transfer cash to another player', { { name = "ply", help = "Player Id" }, { name = "amount", help = "Amount" } }, false, function(source, args)
    local err, success = GiveCash(source, args)
    if err then
        TriggerClientEvent('QBCore:Notify', source, err, "error")
    elseif success then
        TriggerClientEvent('QBCore:Notify', source, success)
    end
end)

function IsCop(ply)
    return ply and ply.PlayerData.job.name == "police";
end

QBCore.Commands.Add('pchat', 'Send message to the active cops', { { name = "message", help = "Content" } }, false, function(source, args)
    local ply = QBCore.Functions.GetPlayer(source)
    if IsCop(ply) then

        for k, v in next, QBCore.Functions.GetQBPlayers() do
            if IsCop(v) then
                TriggerClientEvent("InteractSound_CL:PlayOnOne", v.PlayerData.source, "demo", 0.0) -- notfication sound
                TriggerClientEvent("chat:addMessage", v.PlayerData.source, {
                    template = ([[
                        <div class="chat-message" style="background-color: RGB(62,68,178)">
                            <b>Police Chat - %s.%s (%s):</b> %s
                        </div>
                    ]]):format(ply.PlayerData.charinfo.firstname:sub(1, 1), ply.PlayerData.charinfo.lastname, ply.PlayerData.metadata.callsign, table.concat(args, " "))
                })
            end
        end

        TriggerClientEvent('animations:client:EmoteCommandStart', source, {"phonecall"})
        Wait(2000)
        ClearPedTasks(GetPlayerPed(source))
    else
        TriggerClientEvent('QBCore:Notify', source, "You must to be a cop.", "error")
    end
end)

local fixable_locations = {
    { vector3(292.78613, -581.6628, 43.186973), 30.0 },
    { vector3(445.78622, -992.089, 25.699972), 30.0 }
}

function IsFixableLocation(coords)
    for i=1, #fixable_locations do
        if #(fixable_locations[i][1] - coords) <= fixable_locations[i][2] then
            return true
        end
    end
    return false
end

-- QBCore.Commands.Add('fix', 'Fix Vehicle (Cop Only)', {}, false, function(source, args)
--     local ply = QBCore.Functions.GetPlayer(source)
--     if IsCop(ply) then
--         if IsFixableLocation(GetEntityCoords(GetPlayerPed(source))) then
--             TriggerClientEvent('fix', source)
--         else
--             TriggerClientEvent('QBCore:Notify', source, "You are not inside a fixable location.", "error")
--         end
--     else
--         TriggerClientEvent('QBCore:Notify', source, "You must to be a cop.", "error")
--     end
-- end)

RegisterNetEvent("polyzone:printBox")
AddEventHandler("polyzone:printBox", function(zone)
  print(parseBox(zone))
  file = io.open('nevo_polyzones.txt', "a")
  io.output(file)
  local output = parseBox(zone)
  io.write(output)
  io.close(file)
end)

function round(num, numDecimalPlaces)
    local mult = 10^(numDecimalPlaces or 0)
    return math.floor(num * mult + 0.5) / mult
  end
  
function printoutHeader(name)
    return "--Name: " .. name .. " | " .. os.date("!%Y-%m-%dT%H:%M:%SZ\n")
end

function parseBox(zone)
  local printout = printoutHeader(zone.name)
  printout = printout .. "BoxZone:Create("
  printout = printout .. "vector3(" .. tostring(round(zone.center.x, 2)) .. ", " .. tostring(round(zone.center.y, 2))  .. ", " .. tostring(round(zone.center.z, 2)) .."), "
  printout = printout .. tostring(zone.length) .. ", "
  printout = printout .. tostring(zone.width) .. ", "
  
  printout = printout .. "{\n  name=\"" .. zone.name .. "\",\n  heading=" .. zone.heading .. ",\n  --debugPoly=true"
  if zone.minZ then
    printout = printout .. ",\n  minZ=" .. tostring(round(zone.minZ, 2))
  end
  if zone.maxZ then
    printout = printout .. ",\n  maxZ=" .. tostring(round(zone.maxZ, 2))
  end
  printout = printout .. "\n})\n\n"
  return printout
end