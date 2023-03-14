-- Variables

local Plates = {}
local PlayerStatus = {}
local Casings = {}
local BloodDrops = {}
local FingerDrops = {}
local Objects = {}
local QBCore = exports['qb-core']:GetCoreObject()

-- Functions

local function UpdateBlips()
    local dutyPlayers = {}
    local players = QBCore.Functions.GetQBPlayers()
    for k, v in pairs(players) do
        if (v.PlayerData.job.name == "police" or v.PlayerData.job.name == "ambulance") and v.PlayerData.job.onduty then
            local coords = GetEntityCoords(GetPlayerPed(v.PlayerData.source))
            local heading = GetEntityHeading(GetPlayerPed(v.PlayerData.source))
            dutyPlayers[#dutyPlayers+1] = {
                source = v.PlayerData.source,
                label = v.PlayerData.metadata["callsign"],
                job = v.PlayerData.job.name,
                location = {
                    x = coords.x,
                    y = coords.y,
                    z = coords.z,
                    w = heading
                }
            }
        end
    end
    TriggerClientEvent("police:client:UpdateBlips", -1, dutyPlayers)
end

local function CreateBloodId()
    if BloodDrops then
        local bloodId = math.random(10000, 99999)
        while BloodDrops[bloodId] do
            bloodId = math.random(10000, 99999)
        end
        return bloodId
    else
        local bloodId = math.random(10000, 99999)
        return bloodId
    end
end

local function CreateFingerId()
    if FingerDrops then
        local fingerId = math.random(10000, 99999)
        while FingerDrops[fingerId] do
            fingerId = math.random(10000, 99999)
        end
        return fingerId
    else
        local fingerId = math.random(10000, 99999)
        return fingerId
    end
end

local function CreateCasingId()
    if Casings then
        local caseId = math.random(10000, 99999)
        while Casings[caseId] do
            caseId = math.random(10000, 99999)
        end
        return caseId
    else
        local caseId = math.random(10000, 99999)
        return caseId
    end
end

local function CreateObjectId()
    if Objects then
        local objectId = math.random(10000, 99999)
        while Objects[objectId] do
            objectId = math.random(10000, 99999)
        end
        return objectId
    else
        local objectId = math.random(10000, 99999)
        return objectId
    end
end

local function IsVehicleOwned(plate)
    local result = exports.oxmysql:scalarSync('SELECT plate FROM player_vehicles WHERE plate = ?', {plate})
    return result
end

local function GetCurrentCops()
    local amount = 0
    local players = QBCore.Functions.GetQBPlayers()
    for k, v in pairs(players) do
        if v.PlayerData.job.name == "police" and v.PlayerData.job.onduty then
            amount = amount + 1
        end
    end
    return amount
end

local function DnaHash(s)
    local h = string.gsub(s, ".", function(c)
        return string.format("%02x", string.byte(c))
    end)
    return h
end

-- Commands

--[[QBCore.Commands.Add("spikestrip", "Place Spike Strip (Police Only)", {}, false, function(source)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player then
        if Player.PlayerData.job.name == "police" and Player.PlayerData.job.onduty then
            TriggerClientEvent('police:client:SpawnSpikeStrip', src)
        end
    end
end)]]

QBCore.Commands.Add("gl", "Grant a license to someone", {{name = "id", help = "ID of a person"}, {name = "license", help = "License Type"}}, true, function(source, args)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player.PlayerData.job.name == "police" and Player.PlayerData.job.grade.level >= 2 then
        if args[2] == "driver" or args[2] == "weapon" then
            local SearchedPlayer = QBCore.Functions.GetPlayer(tonumber(args[1]))
            if SearchedPlayer then
                local licenseTable = SearchedPlayer.PlayerData.metadata["licences"]
                licenseTable[args[2]] = true
                SearchedPlayer.Functions.SetMetaData("licences", licenseTable)
                TriggerClientEvent('QBCore:Notify', SearchedPlayer.PlayerData.source, "You have been granted a license",
                    "success", 5000)
                TriggerClientEvent('QBCore:Notify', src, "You granted a license", "success", 5000)
            end
        else
            TriggerClientEvent('QBCore:Notify', src, "Invalid license type", "error")
        end
    else
        TriggerClientEvent('QBCore:Notify', src, "You must be a Sergeant to grant licenses!", "error")
    end
end)

QBCore.Commands.Add("tl", "Revoke a license from someone", {{name = "id", help = "ID of a person"}, {name = "license", help = "License Type"}}, true, function(source, args)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player.PlayerData.job.name == "police" and Player.PlayerData.job.grade.level >= 2 then
        if args[2] == "driver" or args[2] == "weapon" then
            local SearchedPlayer = QBCore.Functions.GetPlayer(tonumber(args[1]))
            if SearchedPlayer then
                local licenseTable = SearchedPlayer.PlayerData.metadata["licences"]
                licenseTable[args[2]] = false
                SearchedPlayer.Functions.SetMetaData("licences", licenseTable)
                TriggerClientEvent('QBCore:Notify', SearchedPlayer.PlayerData.source, "You've had a license revoked",
                    "error", 5000)
                TriggerClientEvent('QBCore:Notify', src, "You revoked a license", "success", 5000)
            end
        else
            TriggerClientEvent('QBCore:Notify', src, "Invalid license type", "error")
        end
    else
        TriggerClientEvent('QBCore:Notify', src, "You must be a Sergeant to revoke licenses!", "error")
    end
end)

--[[QBCore.Commands.Add("pobject", "Place/Delete An Object (Police Only)", {{name = "type",help = "Type object you want or 'delete' to delete"}}, true, function(source, args)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local type = args[1]:lower()
    if Player.PlayerData.job.name == "police" and Player.PlayerData.job.onduty then
        if type == "pion" then
            TriggerClientEvent("police:client:spawnCone", src)
        elseif type == "barier" then
            TriggerClientEvent("police:client:spawnBarier", src)
        elseif type == "schotten" then
            TriggerClientEvent("police:client:spawnSchotten", src)
        elseif type == "tent" then
            TriggerClientEvent("police:client:spawnTent", src)
        elseif type == "light" then
            TriggerClientEvent("police:client:spawnLight", src)
        elseif type == "delete" then
            TriggerClientEvent("police:client:deleteObject", src)
        end
    else
        TriggerClientEvent('QBCore:Notify', src, 'For on-duty police only', 'error')
    end
end)]]
QBCore.Commands.Add("cuff", "Cuff Player (Police Only)", {}, false, function(source, args)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player.PlayerData.job.name == "police" and Player.PlayerData.job.onduty then
        TriggerClientEvent("police:client:CuffPlayer", src)
    else
        TriggerClientEvent('QBCore:Notify', src, 'For on-duty police only', 'error')
    end
end)

QBCore.Commands.Add("escort", "Escort Player", {}, false, function(source, args)
    local src = source
    TriggerClientEvent("police:client:EscortPlayer", src)
end)

QBCore.Commands.Add("callsign", "Give Yourself A Callsign", {{name = "name", help = "Name of your callsign"}}, false, function(source, args)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    Player.Functions.SetMetaData("callsign", table.concat(args, " "))
end)

QBCore.Commands.Add("clearcasings", "Clear Area of Casings (Police Only)", {}, false, function(source)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player.PlayerData.job.name == "police" and Player.PlayerData.job.onduty then
        TriggerClientEvent("evidence:client:ClearCasingsInArea", src)
    else
        TriggerClientEvent('QBCore:Notify', src, 'For on-duty police only', 'error')
    end
end)

QBCore.Commands.Add("jail", "Jail Player (Police Only)", {{name = "id", help = "Player ID"}, {name = "time", help = "Time they have to be in jail"}}, true, function(source, args)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player.PlayerData.job.name == "police" and Player.PlayerData.job.onduty then
        local playerId = tonumber(args[1])
        local time = tonumber(args[2])
        if time > 0 then
            TriggerClientEvent("police:client:JailCommand", src, playerId, time)
        else
            TriggerClientEvent('QBCore:Notify', src, 'Cannot sentence for 0', 'error')
        end
    else
        TriggerClientEvent('QBCore:Notify', src, 'For on-duty police only', 'error')
    end
end)

QBCore.Commands.Add("unjail", "Unjail Player (Police Only)", {{name = "id", help = "Player ID"}}, true, function(source, args)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player.PlayerData.job.name == "police" and Player.PlayerData.job.onduty then
        local playerId = tonumber(args[1])
        TriggerClientEvent("prison:client:UnjailPerson", playerId)
    else
        TriggerClientEvent('QBCore:Notify', src, 'For on-duty police only', 'error')
    end
end)

QBCore.Commands.Add("clearblood", "Clear The Area of Blood (Police Only)", {}, false, function(source)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player.PlayerData.job.name == "police" and Player.PlayerData.job.onduty then
        TriggerClientEvent("evidence:client:ClearBlooddropsInArea", src)
    else
        TriggerClientEvent('QBCore:Notify', src, 'For on-duty police only', 'error')
    end
end)

QBCore.Commands.Add("seizecash", "Seize Cash (Police Only)", {}, false, function(source)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player.PlayerData.job.name == "police" and Player.PlayerData.job.onduty then
        TriggerClientEvent("police:client:SeizeCash", src)
    else
        TriggerClientEvent('QBCore:Notify', src, 'For on-duty police only', 'error')
    end
end)

QBCore.Commands.Add("sc", "Soft Cuff (Police Only)", {}, false, function(source)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player.PlayerData.job.name == "police" and Player.PlayerData.job.onduty then
        TriggerClientEvent("police:client:CuffPlayerSoft", src)
    else
        TriggerClientEvent('QBCore:Notify', src, 'For on-duty police only', 'error')
    end
end)

QBCore.Commands.Add("cam", "View Security Camera (Police Only)", {{name = "camid", help = "Camera ID"}}, false, function(source, args)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player.PlayerData.job.name == "police" and Player.PlayerData.job.onduty then
        TriggerClientEvent("police:client:ActiveCamera", src, tonumber(args[1]))
    else
        TriggerClientEvent('QBCore:Notify', src, 'For on-duty police only', 'error')
    end
end)

QBCore.Commands.Add("impound", "Impound With Price (Police Only)", {{name = "price", help = "Price for how much the person has to pay (may be empty)"}}, false, function(source, args)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player.PlayerData.job.name == "police" and Player.PlayerData.job.onduty then
        TriggerClientEvent("police:client:ImpoundVehicle", src, false, tonumber(args[1]))
    else
        TriggerClientEvent('QBCore:Notify', src, 'For on-duty police only', 'error')
    end
end)

QBCore.Commands.Add("seize", "Impound A Vehicle (Police Only)", {}, false, function(source)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player.PlayerData.job.name == "police" or Player.PlayerData.job.name == "cardealer" and Player.PlayerData.job.onduty then
        TriggerClientEvent("police:client:ImpoundVehicle", src, true)
    else
        TriggerClientEvent('QBCore:Notify', src, 'For on-duty police only', 'error')
    end
end)

--[[QBCore.Commands.Add("paylawyer", "Pay Lawyer (Police, Judge Only)", {{name = "id",help = "ID of the player"}}, true, function(source, args)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player.PlayerData.job.name == "police" or Player.PlayerData.job.name == "judge" then
        local playerId = tonumber(args[1])
        local OtherPlayer = QBCore.Functions.GetPlayer(playerId)
        if OtherPlayer then
            if OtherPlayer.PlayerData.job.name == "lawyer" then
                OtherPlayer.Functions.AddMoney("bank", 500, "police-lawyer-paid")
                TriggerClientEvent('QBCore:Notify', OtherPlayer.PlayerData.source, 'You were paid $500', 'success')
                TriggerClientEvent('QBCore:Notify', src, 'You paid a lawyer')
            else
                TriggerClientEvent('QBCore:Notify', src, 'Person is not a lawyer', "error")
            end
        end
    else
        TriggerClientEvent('QBCore:Notify', src, 'For on-duty police only', 'error')
    end
end)]]

QBCore.Commands.Add("takedrivinglicense", "Seize Drivers License (Police Only)", {}, false, function(source, args)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player.PlayerData.job.name == "police" and Player.PlayerData.job.onduty then
        TriggerClientEvent("police:client:SeizeDriverLicense", source)
    else
        TriggerClientEvent('QBCore:Notify', src, 'For on-duty police only', 'error')
    end
end)

QBCore.Commands.Add("takedna", "Take a DNA sample from a person (empty evidence bag needed) (Police Only)", {{name="id", help="ID of the person"}}, true, function(source, args)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local OtherPlayer = QBCore.Functions.GetPlayer(tonumber(args[1]))
    if ((Player.PlayerData.job.name == "police") and Player.PlayerData.job.onduty) and OtherPlayer then
        if Player.Functions.RemoveItem("empty_evidence_bag", 1) then
            local info = {
                label = "DNA Sample",
                type = "dna",
                dnalabel = DnaHash(OtherPlayer.PlayerData.citizenid)
            }
            if Player.Functions.AddItem("filled_evidence_bag", 1, false, info) then
                TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items["filled_evidence_bag"], "add")
            end
        else
            TriggerClientEvent('QBCore:Notify', src, "You must have an empty evidence bag with you", "error")
        end
    end
end)

QBCore.Commands.Add('911', 'Police Report', {{name="id", help="Your ID"}, {name="YourName", help="Your Name"}, {name="Message", help="Message to be sent"}}, true, function(source, args)
    local src = source
    if args[1] then message = table.concat(args, " ") else message = 'Civilian Call' end
    local ped = GetPlayerPed(src)
    local coords = GetEntityCoords(ped)
    local players = QBCore.Functions.GetQBPlayers()
    for k,v in pairs(players) do
        if v.PlayerData.job.name == 'police' and v.PlayerData.job.onduty then
            local alertData = {title = 'New 911 Call', coords = {coords.x, coords.y, coords.z}, description = message}
            TriggerClientEvent("qb-phone:client:addPoliceAlert", v.PlayerData.source, alertData)
            TriggerClientEvent('police:client:policeAlert', v.PlayerData.source, coords, message)
            TriggerClientEvent("police:client:CallAnim", source)
        end
    end
end)

QBCore.Commands.Add("911r", "Send a message back to a alert", {{name="id", help="ID of the alert"}, {name="Message", help="Message you want to send"}}, true, function(source, args)
    local Player = QBCore.Functions.GetPlayer(source)
    local OtherPlayer = QBCore.Functions.GetPlayer(tonumber(args[1]))
    table.remove(args, 1)
    local message = table.concat(args, " ")
    local Prefix = "POLICE"
    if Player.PlayerData.job.name == "doctor"  then
        Prefix = "AMBULANCE"
    end
    if OtherPlayer ~= nil then
        TriggerClientEvent('chatMessage', OtherPlayer.PlayerData.source, "("..Prefix..") " ..Player.PlayerData.charinfo.firstname .. " " .. Player.PlayerData.charinfo.lastname, "error", message)
        TriggerClientEvent("police:client:EmergencySound", OtherPlayer.PlayerData.source)
        TriggerClientEvent("police:client:CallAnim", source)
    end
end)

-- Items

QBCore.Functions.CreateUseableItem("handcuffs", function(source, item)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player.Functions.GetItemByName(item.name) then
        TriggerClientEvent("police:client:CuffPlayerSoft", src)
    end
end)

QBCore.Functions.CreateUseableItem("moneybag", function(source, item)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player.Functions.GetItemByName(item.name) then
        if item.info and item.info ~= "" then
            if Player.PlayerData.job.name ~= "police" then
                if Player.Functions.RemoveItem("moneybag", 1, item.slot) then
                    Player.Functions.AddMoney("cash", tonumber(item.info.cash), "used-moneybag")
                end
            end
        end
    end
end)

-- Callbacks

QBCore.Functions.CreateCallback('police:server:isPlayerDead', function(source, cb, playerId)
    local Player = QBCore.Functions.GetPlayer(playerId)
    cb(Player.PlayerData.metadata["isdead"])
end)

QBCore.Functions.CreateCallback('police:GetPlayerStatus', function(source, cb, playerId)
    local Player = QBCore.Functions.GetPlayer(playerId)
    local statList = {}
    if Player then
        if PlayerStatus[Player.PlayerData.source] and next(PlayerStatus[Player.PlayerData.source]) then
            for k, v in pairs(PlayerStatus[Player.PlayerData.source]) do
                statList[#statList+1] = PlayerStatus[Player.PlayerData.source][k].text
            end
        end
    end
    cb(statList)
end)

QBCore.Functions.CreateCallback('police:IsSilencedWeapon', function(source, cb, weapon)
    local Player = QBCore.Functions.GetPlayer(source)
    local itemInfo = Player.Functions.GetItemByName(QBCore.Shared.Weapons[weapon]["name"])
    local retval = false
    if itemInfo then
        if itemInfo.info and itemInfo.info.attachments then
            for k, v in pairs(itemInfo.info.attachments) do
                if itemInfo.info.attachments[k].component == "COMPONENT_AT_AR_SUPP_02" or
                    itemInfo.info.attachments[k].component == "COMPONENT_AT_AR_SUPP" or
                    itemInfo.info.attachments[k].component == "COMPONENT_AT_PI_SUPP_02" or
                    itemInfo.info.attachments[k].component == "COMPONENT_AT_PI_SUPP" then
                    retval = true
                end
            end
        end
    end
    cb(retval)
end)

QBCore.Functions.CreateCallback('police:GetDutyPlayers', function(source, cb)
    local dutyPlayers = {}
    local players = QBCore.Functions.GetQBPlayers()
    for k, v in pairs(players) do
        if v.PlayerData.job.name == "police" and v.PlayerData.job.onduty then
            dutyPlayers[#dutyPlayers+1] = {
                source = Player.PlayerData.source,
                label = Player.PlayerData.metadata["callsign"],
                job = Player.PlayerData.job.name
            }
        end
    end
    cb(dutyPlayers)
end)

QBCore.Functions.CreateCallback('police:GetImpoundedVehicles', function(source, cb)
    local vehicles = {}
    exports.oxmysql:execute('SELECT * FROM player_vehicles WHERE state = ?', {2}, function(result)
        if result[1] then
            vehicles = result
        end
        cb(vehicles)
    end)
end)

QBCore.Functions.CreateCallback('police:IsPlateFlagged', function(source, cb, plate)
    local retval = false
    if Plates and Plates[plate] then
        if Plates[plate].isflagged then
            retval = true
        end
    end
    cb(retval)
end)

QBCore.Functions.CreateCallback('police:GetCops', function(source, cb)
    local amount = 0
    local players = QBCore.Functions.GetQBPlayers()
    for k, v in pairs(players) do
        if v.PlayerData.job.name == "police" and v.PlayerData.job.onduty then
            amount = amount + 1
        end
    end
    cb(amount)
end)

QBCore.Functions.CreateCallback('police:server:IsPoliceForcePresent', function(source, cb)
    local retval = false
    local players = QBCore.Functions.GetQBPlayers()
    for k, v in pairs(players) do
        if v.PlayerData.job.name == "police" and v.PlayerData.job.grade.level >= 2 then
            retval = true
            break
        end
    end
    cb(retval)
end)

-- Events

AddEventHandler('onResourceStart', function(resourceName)
    if resourceName == GetCurrentResourceName() then
        CreateThread(function()
            exports.oxmysql:execute('DELETE FROM stashitems WHERE stash="policetrash"')
        end)
    end
end)

RegisterNetEvent('police:server:policeAlert', function(text)
    local src = source
    local ped = GetPlayerPed(src)
    local coords = GetEntityCoords(ped)
    local players = QBCore.Functions.GetQBPlayers()
    for k,v in pairs(players) do
        if v.PlayerData.job.name == 'police' and v.PlayerData.job.onduty then
            local alertData = {title = 'New Call', coords = {coords.x, coords.y, coords.z}, description = text}
            TriggerClientEvent("qb-phone:client:addPoliceAlert", v.PlayerData.source, alertData)
            TriggerClientEvent('police:client:policeAlert', v.PlayerData.source, coords, text)
        end
    end
end)

RegisterNetEvent('police:server:TakeOutImpound', function(plate)
    local src = source
    exports.oxmysql:execute('UPDATE player_vehicles SET state = ? WHERE plate  = ?', {0, plate})
    TriggerClientEvent('QBCore:Notify', src, "Vehicle unimpounded!", 'success')
end)

RegisterNetEvent('police:server:CuffPlayer', function(playerId, isSoftcuff)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local CuffedPlayer = QBCore.Functions.GetPlayer(playerId)
    if CuffedPlayer then
        if Player.Functions.GetItemByName("handcuffs") or Player.PlayerData.job.name == "police" then
            TriggerClientEvent("police:client:GetCuffed", CuffedPlayer.PlayerData.source, Player.PlayerData.source, isSoftcuff)
        end
    end
end)

RegisterNetEvent('police:server:EscortPlayer', function(playerId)
    local src = source
    local Player = QBCore.Functions.GetPlayer(source)
    local EscortPlayer = QBCore.Functions.GetPlayer(playerId)
    if EscortPlayer then
        if (Player.PlayerData.job.name == "police" or Player.PlayerData.job.name == "ambulance") or (EscortPlayer.PlayerData.metadata["ishandcuffed"] or EscortPlayer.PlayerData.metadata["isdead"] or EscortPlayer.PlayerData.metadata["inlaststand"]) then
            TriggerClientEvent("police:client:GetEscorted", EscortPlayer.PlayerData.source, Player.PlayerData.source)
        else
            TriggerClientEvent('QBCore:Notify', src, "Civilian isn't cuffed or dead", 'error')
        end
    end
end)

RegisterNetEvent('police:server:KidnapPlayer', function(playerId)
    local src = source
    local Player = QBCore.Functions.GetPlayer(source)
    local EscortPlayer = QBCore.Functions.GetPlayer(playerId)
    if EscortPlayer then
        if EscortPlayer.PlayerData.metadata["ishandcuffed"] or EscortPlayer.PlayerData.metadata["isdead"] or
            EscortPlayer.PlayerData.metadata["inlaststand"] then
            TriggerClientEvent("police:client:GetKidnappedTarget", EscortPlayer.PlayerData.source, Player.PlayerData.source)
            TriggerClientEvent("police:client:GetKidnappedDragger", Player.PlayerData.source, EscortPlayer.PlayerData.source)
        else
            TriggerClientEvent('QBCore:Notify', src, "Civilian isn't cuffed or dead", 'error')
        end
    end
end)

RegisterNetEvent('police:server:SetPlayerOutVehicle', function(playerId)
    local src = source
    local Player = QBCore.Functions.GetPlayer(source)
    local EscortPlayer = QBCore.Functions.GetPlayer(playerId)
    if EscortPlayer then
        TriggerClientEvent("police:client:SetOutVehicle", EscortPlayer.PlayerData.source)
    end
end)

RegisterNetEvent('police:server:PutPlayerInVehicle', function(playerId)
    local src = source
    local EscortPlayer = QBCore.Functions.GetPlayer(playerId)
    if EscortPlayer then
        TriggerClientEvent("police:client:PutInVehicle", EscortPlayer.PlayerData.source)
    end
end)

RegisterNetEvent('police:server:BillPlayer', function(playerId, price)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local OtherPlayer = QBCore.Functions.GetPlayer(playerId)
    if Player.PlayerData.job.name == "police" then
        if OtherPlayer then
            OtherPlayer.Functions.RemoveMoney("bank", price, "paid-bills")
            TriggerEvent('qb-bossmenu:server:addAccountMoney', "police", price)
            TriggerClientEvent('QBCore:Notify', OtherPlayer.PlayerData.source, "You received a fine of $" .. price)
        end
    end
end)

RegisterNetEvent('police:server:JailPlayer', function(playerId, time)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local OtherPlayer = QBCore.Functions.GetPlayer(playerId)
    local currentDate = os.date("*t")
    if currentDate.day == 31 then
        currentDate.day = 30
    end

    if Player.PlayerData.job.name == "police" then
        if OtherPlayer then
            OtherPlayer.Functions.SetMetaData("injail", time)
            OtherPlayer.Functions.SetMetaData("criminalrecord", {
                ["hasRecord"] = true,
                ["date"] = currentDate
            })
            TriggerClientEvent("police:client:SendToJail", OtherPlayer.PlayerData.source, time)
            TriggerClientEvent('QBCore:Notify', src, "You sent the person to prison for " .. time .. " months")
        end
    end
end)

RegisterNetEvent('police:server:SetHandcuffStatus', function(isHandcuffed)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player then
        Player.Functions.SetMetaData("ishandcuffed", isHandcuffed)
    end
end)

RegisterNetEvent('heli:spotlight', function(state)
    local serverID = source
    TriggerClientEvent('heli:spotlight', -1, serverID, state)
end)

RegisterNetEvent('police:server:SearchPlayer', function(playerId)
    local src = source
    local SearchedPlayer = QBCore.Functions.GetPlayer(playerId)
    if SearchedPlayer then
        TriggerClientEvent('QBCore:Notify', src, 'Found $'..SearchedPlayer.PlayerData.money["cash"]..' on the civilian')
        TriggerClientEvent('QBCore:Notify', SearchedPlayer.PlayerData.source, "You are being searched")
    end
end)

RegisterNetEvent('police:server:SeizeCash', function(playerId)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local SearchedPlayer = QBCore.Functions.GetPlayer(playerId)
    if SearchedPlayer then
        local moneyAmount = SearchedPlayer.PlayerData.money["cash"]
        local info = { cash = moneyAmount }
        SearchedPlayer.Functions.RemoveMoney("cash", moneyAmount, "police-cash-seized")
        Player.Functions.AddItem("moneybag", 1, false, info)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["moneybag"], "add")
        TriggerClientEvent('QBCore:Notify', SearchedPlayer.PlayerData.source, 'Your cash was confiscated')
    end
end)

RegisterNetEvent('police:server:SeizeDriverLicense', function(playerId)
    local src = source
    local SearchedPlayer = QBCore.Functions.GetPlayer(playerId)
    if SearchedPlayer then
        local driverLicense = SearchedPlayer.PlayerData.metadata["licences"]["driver"]
        if driverLicense then
            local licenses = {["driver"] = false, ["business"] = SearchedPlayer.PlayerData.metadata["licences"]["business"]}
            SearchedPlayer.Functions.SetMetaData("licences", licenses)
            TriggerClientEvent('QBCore:Notify', SearchedPlayer.PlayerData.source, 'Your driving license has been confiscated')
        else
            TriggerClientEvent('QBCore:Notify', src, 'No drivers license', 'error')
        end
    end
end)

RegisterNetEvent('police:server:RobPlayer', function(playerId)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local SearchedPlayer = QBCore.Functions.GetPlayer(playerId)
    if SearchedPlayer then
        local money = SearchedPlayer.PlayerData.money["cash"]
        Player.Functions.AddMoney("cash", money, "police-player-robbed")
        SearchedPlayer.Functions.RemoveMoney("cash", money, "police-player-robbed")
        TriggerClientEvent('QBCore:Notify', SearchedPlayer.PlayerData.source, "You have been robbed of $" .. money)
        TriggerClientEvent('QBCore:Notify', Player.PlayerData.source, "You have stolen $" .. money)
    end
end)

RegisterNetEvent('police:server:UpdateBlips', function()
    -- KEEP FOR REF BUT NOT NEEDED ANYMORE.
end)

RegisterNetEvent('police:server:spawnObject', function(type)
    local src = source
    local objectId = CreateObjectId()
    Objects[objectId] = type
    TriggerClientEvent("police:client:spawnObject", src, objectId, type, src)
end)

RegisterNetEvent('police:server:deleteObject', function(objectId)
    TriggerClientEvent('police:client:removeObject', -1, objectId)
end)

RegisterNetEvent('police:server:Impound', function(plate, fullImpound, price, body, engine, fuel)
    local src = source
    local price = price and price or 0
    if IsVehicleOwned(plate) then
        if not fullImpound then
            exports.oxmysql:execute(
                'UPDATE player_vehicles SET state = ?, depotprice = ?, body = ?, engine = ?, fuel = ? WHERE plate = ?',
                {0, price, body, engine, fuel, plate})
            TriggerClientEvent('QBCore:Notify', src, "Vehicle taken into depot for $" .. price .. "!")
        else
            exports.oxmysql:execute(
                'UPDATE player_vehicles SET state = ?, body = ?, engine = ?, fuel = ? WHERE plate = ?',
                {2, body, engine, fuel, plate})
            TriggerClientEvent('QBCore:Notify', src, "Vehicle seized")
        end
    end
end)

RegisterNetEvent('evidence:server:UpdateStatus', function(data)
    local src = source
    PlayerStatus[src] = data
end)

RegisterNetEvent('evidence:server:CreateBloodDrop', function(citizenid, bloodtype, coords)
    local bloodId = CreateBloodId()
    BloodDrops[bloodId] = {
        dna = citizenid,
        bloodtype = bloodtype
    }
    TriggerClientEvent("evidence:client:AddBlooddrop", -1, bloodId, citizenid, bloodtype, coords)
end)

RegisterNetEvent('evidence:server:CreateFingerDrop', function(coords)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local fingerId = CreateFingerId()
    FingerDrops[fingerId] = Player.PlayerData.metadata["fingerprint"]
    TriggerClientEvent("evidence:client:AddFingerPrint", -1, fingerId, Player.PlayerData.metadata["fingerprint"], coords)
end)

RegisterNetEvent('evidence:server:ClearBlooddrops', function(blooddropList)
    if blooddropList and next(blooddropList) then
        for k, v in pairs(blooddropList) do
            TriggerClientEvent("evidence:client:RemoveBlooddrop", -1, v)
            BloodDrops[v] = nil
        end
    end
end)

RegisterNetEvent('evidence:server:AddBlooddropToInventory', function(bloodId, bloodInfo)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player.Functions.RemoveItem("empty_evidence_bag", 1) then
        if Player.Functions.AddItem("filled_evidence_bag", 1, false, bloodInfo) then
            TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items["filled_evidence_bag"], "add")
            TriggerClientEvent("evidence:client:RemoveBlooddrop", -1, bloodId)
            BloodDrops[bloodId] = nil
        end
    else
        TriggerClientEvent('QBCore:Notify', src, "You must have an empty evidence bag with you", "error")
    end
end)

RegisterNetEvent('evidence:server:AddFingerprintToInventory', function(fingerId, fingerInfo)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player.Functions.RemoveItem("empty_evidence_bag", 1) then
        if Player.Functions.AddItem("filled_evidence_bag", 1, false, fingerInfo) then
            TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items["filled_evidence_bag"], "add")
            TriggerClientEvent("evidence:client:RemoveFingerprint", -1, fingerId)
            FingerDrops[fingerId] = nil
        end
    else
        TriggerClientEvent('QBCore:Notify', src, "You must have an empty evidence bag with you", "error")
    end
end)

RegisterNetEvent('evidence:server:CreateCasing', function(weapon, coords)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local casingId = CreateCasingId()
    local weaponInfo = QBCore.Shared.Weapons[weapon]
    local serieNumber = nil
    if weaponInfo then
        local weaponItem = Player.Functions.GetItemByName(weaponInfo["name"])
        if weaponItem then
            if weaponItem.info and weaponItem.info ~= "" then
                serieNumber = weaponItem.info.serie
            end
        end
    end
    TriggerClientEvent("evidence:client:AddCasing", -1, casingId, weapon, coords, serieNumber)
end)

RegisterNetEvent('police:server:UpdateCurrentCops', function()
    local amount = 0
    local players = QBCore.Functions.GetQBPlayers()
    for k, v in pairs(players) do
        if v.PlayerData.job.name == "police" and v.PlayerData.job.onduty then
            amount = amount + 1
        end
    end
    TriggerClientEvent("police:SetCopCount", -1, amount)
end)

RegisterNetEvent('evidence:server:ClearCasings', function(casingList)
    if casingList and next(casingList) then
        for k, v in pairs(casingList) do
            TriggerClientEvent("evidence:client:RemoveCasing", -1, v)
            Casings[v] = nil
        end
    end
end)

RegisterNetEvent('evidence:server:AddCasingToInventory', function(casingId, casingInfo)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player.Functions.RemoveItem("empty_evidence_bag", 1) then
        if Player.Functions.AddItem("filled_evidence_bag", 1, false, casingInfo) then
            TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items["filled_evidence_bag"], "add")
            TriggerClientEvent("evidence:client:RemoveCasing", -1, casingId)
            Casings[casingId] = nil
        end
    else
        TriggerClientEvent('QBCore:Notify', src, "You must have an empty evidence bag with you", "error")
    end
end)

RegisterNetEvent('police:server:showFingerprint', function(playerId)
    local src = source
    TriggerClientEvent('police:client:showFingerprint', playerId, src)
    TriggerClientEvent('police:client:showFingerprint', src, playerId)
end)

RegisterNetEvent('police:server:showFingerprintId', function(sessionId)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local fid = Player.PlayerData.metadata["fingerprint"]
    TriggerClientEvent('police:client:showFingerprintId', sessionId, fid)
    TriggerClientEvent('police:client:showFingerprintId', src, fid)
end)

RegisterNetEvent('police:server:SetTracker', function(targetId)
    local src = source
    local Target = QBCore.Functions.GetPlayer(targetId)
    local TrackerMeta = Target.PlayerData.metadata["tracker"]
    if TrackerMeta then
        Target.Functions.SetMetaData("tracker", false)
        TriggerClientEvent('QBCore:Notify', targetId, 'Your anklet is taken off.', 'error', 5000)
        TriggerClientEvent('QBCore:Notify', src, 'You took off an ankle bracelet from ' .. Target.PlayerData.charinfo.firstname .. " " .. Target.PlayerData.charinfo.lastname, 'error', 5000)
        TriggerClientEvent('police:client:SetTracker', targetId, false)
    else
        Target.Functions.SetMetaData("tracker", true)
        TriggerClientEvent('QBCore:Notify', targetId, 'You put on an ankle strap.', 'error', 5000)
        TriggerClientEvent('QBCore:Notify', src, 'You put on an ankle strap to ' .. Target.PlayerData.charinfo.firstname .. " " .. Target.PlayerData.charinfo.lastname, 'error', 5000)
        TriggerClientEvent('police:client:SetTracker', targetId, true)
    end
end)

-- Threads

CreateThread(function()
    while true do
        Wait(1000 * 60 * 10)
        local curCops = GetCurrentCops()
        TriggerClientEvent("police:SetCopCount", -1, curCops)
    end
end)

CreateThread(function()
    while true do
        Wait(5000)
        UpdateBlips()
    end
end)



QBCore.Commands.Add('livery', 'Set vehicle livery (Emergency Only)', {}, false, function(source, args)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local livery = tonumber(args[1])

    if Player and (Player.PlayerData.job.name == "police" or Player.PlayerData.job.name == "doctor" ) then
        if Player then
            TriggerClientEvent('police:livery', src, livery)
        else
            TriggerClientEvent('chat:addMessage', src, {
                template = '<div class="chat-message server">SYSTEM: {0}</div>',
                args = { 'This command is for emergency services!' }
            })
        end
    else
        TriggerClientEvent('chat:addMessage', src, {
            template = '<div class="chat-message server">Usage /livery [Number]</div>',
        })
    end
end)

QBCore.Commands.Add("embutton", "Send a Message back to a report", {}, false, function(source, args)
    local Player = QBCore.Functions.GetPlayer(source)
    if (Player.PlayerData.job.name == "police" and Player.PlayerData.job.onduty) then
        TriggerClientEvent("police:client:SendEmergencyMessage", source)
    end
end)



QBCore.Commands.Add("rob", "Rob A Player", {}, false, function(source, args)
	local Player = QBCore.Functions.GetPlayer(source)
    TriggerClientEvent("police:client:RobPlayer", source)
end)

RegisterServerEvent('police:server:checkBank')
AddEventHandler('police:server:checkBank', function(playerId)
    local src = source
    local SearchedPlayer = QBCore.Functions.GetPlayer(playerId)
    if SearchedPlayer ~= nil then 
        TriggerClientEvent('chat:addMessage', source, {
        template = '<div class="chat-message success">Player has €'..SearchedPlayer.PlayerData.money["bank"]..' in his bank account.</div>',
        })
    end
end)

RegisterServerEvent('police:server:checkLicenses')
AddEventHandler('police:server:checkLicenses', function(playerId)
    local src = source
    local SearchedPlayer = QBCore.Functions.GetPlayer(playerId)
    if SearchedPlayer ~= nil then 
        local licences = SearchedPlayer["PlayerData"]['metadata']['licences']
        local str = ""
        local index = 0
        local max = 0

        for k,v in pairs(licences) do
            if k and v then
                str = str .. k:gsub("^%l", string.upper) .. ', '
            end
        end
        TriggerClientEvent('chat:addMessage', source, {
            template = '<div class="chat-message success">Player Licenses: ' .. (#str == 0 and "No Licenses" or str:sub(1,#str-2)) .. '</div>',
        })
    end
end)

RegisterServerEvent('police:server:checkFines')
AddEventHandler('police:server:checkFines', function(playerId)
    local src = source
    local SearchedPlayer = QBCore.Functions.GetPlayer(playerId)
    if SearchedPlayer ~= nil then 
        QBCore.Functions.ExecuteSql(false, "SELECT * FROM phone_invoices WHERE `citizenid` = '"..SearchedPlayer.PlayerData.citizenid.."' AND `society`='police'", function(invoices)
            if #invoices == 0 then
                TriggerClientEvent('chat:addMessage', src, {
                    template = '<div class="chat-message server"><strong>SYSTEM:</strong> Player have no unpaid fines.</div>',
                })
            else
                local str = ""
                for i=1,#invoices do
                    local invoice = invoices[i]
                    str = str .. '<br>'
                    str = str .. i .. '. ' .. invoice.title .. ' - $' .. invoice.amount
                end
    
                TriggerClientEvent('chat:addMessage', src, {
                    template = '<div class="chat-message emergency">Player Unpaid Fines: '.. str ..' </div>',
                })
            end
        end)
    end
end)

--------------Fine
QBCore.Commands.Add('pfine', 'Fine A Person', {{name = 'id', help = 'Player ID'}, {name = 'amount', help = 'Fine Amount'}}, false, function(source, args)
    local biller = QBCore.Functions.GetPlayer(source)
    local Ply = QBCore.Functions.GetPlayer(tonumber(args[1]))
    local billed = QBCore.Functions.GetPlayer(tonumber(args[1]))
    local amount = tonumber(args[2])
    if biller.PlayerData.job.name == "police" then
        if billed ~= nil then
            if biller.PlayerData.citizenid ~= billed.PlayerData.citizenid then
                if amount and amount > 0 then
                    Ply.Functions.RemoveMoney('bank', amount, "paid-fine")
                    TriggerClientEvent('QBCore:Notify', source, 'Fine has been issued to offender succesfully', 'success')
                    TriggerClientEvent('QBCore:Notify', billed.PlayerData.source, 'State Debt Recovery has automatically recovered the fines owed...')
                    TriggerEvent('qb-banking:society:server:DepositMoney', src, 150 , 'police')
                    TriggerEvent('qb-police:server:glichy')
                else
                    TriggerClientEvent('QBCore:Notify', source, 'Must Be A Valid Amount Above 0', 'error')
                end
            else
                TriggerClientEvent('QBCore:Notify', source, 'You Cannot Fine Yourself', 'error')
            end
        else
            TriggerClientEvent('QBCore:Notify', source, 'Person Not Online', 'error')
        end
    else
        TriggerClientEvent('QBCore:Notify', source, 'No Access', 'error')
    end
end)