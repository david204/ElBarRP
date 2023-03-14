local QBCore = exports['qb-core']:GetCoreObject()

local weaponsRes = {}

RegisterNetEvent("srp-crafting:client:openUI")
AddEventHandler("srp-crafting:client:openUI", function(items)
    weaponsRes = items 
    SetNuiFocus(true, true)
    TriggerEvent('ui:state', true);
    for k,v in next,Config.Crafting do 
        if k == "usb" then 
            SendNUIMessage({
                action = "show",
                info = v
            })
        end
    end
end)

RegisterNUICallback("choose",function(data,cb)
    for k,v in next,Config.Crafting do
        if k == data.data then
            if data.item == "undefined" or not data.item or HasItem(data.item) then 
                SendNUIMessage({
                    action = "next",
                    invItems = weaponsRes,
                    weapons = v
                })
            else 
                TriggerEvent(Config.Core..':Notify', "You don't have this USB.", "error")
            end
        end
    end
end)

RegisterNUICallback("craft", function(data,cb)
    local CraftCoords = vector3(-160.2359, -345.6229, 34.751659)
    SetNuiFocus(false, false)
    TriggerEvent('ui:state', false);
    local PlayerPed = PlayerPedId()
    TaskLookAtCoord(PlayerPed, CraftCoords.x, CraftCoords.y, CraftCoords.z, 3.0, 0, 0)
    TaskPedSlideToCoord(PlayerPed, CraftCoords.x, CraftCoords.y, CraftCoords.z, 227.29, 1.0)
    Wait(2000)
    RonRequestAnimDict('mini@repair', function()
        TaskPlayAnim(PlayerPed, 'mini@repair', 'fixing_a_ped', 8.0, -8, -1, 49, 0, 0, 0, 0)
    end)
    QBCore.Functions.Progressbar("craft_weapon", "Crafting...", 10000, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "mini@repair",
        anim = "fixing_a_ped",
        flags = 16,
    }, {}, {}, function() -- Done
    end)
    TriggerServerEvent("srp-crafting:server:removeItems", data.weaponRes1,data.weaponRes2,data.weaponRes3,data.weaponRes4)
    TriggerServerEvent("srp-crafting:server:giveWeapon", data.currentWeapon)
    TriggerServerEvent("srp-crafting:removemoney", data.weaponPricee)
    Wait(13000)
    TriggerEvent('NNQBCore:Notify', "You've successfully craft your gun.", "success")
    show = true
end)

function RonRequestAnimDict(animdict,func)
    if not DoesAnimDictExist(animdict) then return end
    RequestAnimDict(animdict)
    while not HasAnimDictLoaded(animdict) do
        Wait(50)
    end
    return func()
end

RegisterNUICallback("close", function()
    SetNuiFocus(false, false)
    TriggerEvent('ui:state', false);
    show = true
end)

DrawText3Ds = function(x, y, z, text)
	SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end

RegisterNUICallback("chooseWeapon", function(data,cb)
    local res1 = false
    local res2 = false
    local res3 = false
    local res4 = false
    if data.resources.item1 <= weaponsRes.item1 then
        res1 = true
        SendNUIMessage({action = "have1"})
    else
        res1 = false
        SendNUIMessage({action = "donthave1"})
    end
    if data.resources.item2 <= weaponsRes.item2 then
        res2 = true
        SendNUIMessage({action = "have2"})
    else
        res2 = false
        SendNUIMessage({action = "donthave2"})
    end
    if data.resources.item3 <= weaponsRes.item3 then
        res3 = true
        SendNUIMessage({action = "have3"})
    else
        res3 = false
        SendNUIMessage({action = "donthave3"})
    end
    if data.resources.item4 <= weaponsRes.item4 then
        res4 = true
        SendNUIMessage({action = "have4"})
    else
        res4 = false
        SendNUIMessage({action = "donthave4"})
    end
    QBCore.Functions.TriggerCallback("srp-crafting:isHaveMoney",function(haveCash)
        if res1 and res2 and res3 and res4 and haveCash then
            SendNUIMessage({action = "addBtn"})
        else
            SendNUIMessage({action = "removeBtn"})
        end
    end, data.weaponPrice)
end)

function HasItem(item)
    local retval = nil
    QBCore.Functions.TriggerCallback(Config.Core .. ":HasItem", function(data)
        retval = data
    end, item)

    while retval == nil do
        Wait(1)
    end

    return retval
end


function buildInteract()
    -- exports[Config.TargetResource]:AddBoxZone("craft", Config.Coords, 2.0, 3.3, {
    --     name = name,
    --     heading = 94,
    --     minZ = Config.Coords.z - (3.0 / 2),
    --     maxZ = Config.Coords.z + (3.0 / 2),
    --     debugPoly = true
    --     }, {
    --         options = {
    --             {
    --                 event = "srp-crafting:server:openUI",
    --                 type = "server",
    --                 icon = "fas fa-tools",
    --                 label = "Craft"
    --             },
    --         },
    --         job = {"weapondealer"},
    --         distance = 2.0
    --     })
        exports['qb-target']:AddBoxZone("craft", Config.Coords, 2.0, 3.3, { -- The name has to be unique, the coords a vector3 as shown, the 1.5 is the length of the boxzone and the 1.6 is the width of the boxzone, the length and width have to be float values
        name = name, -- This is the name of the zone recognized by PolyZone, this has to be unique so it doesn't mess up with other zones
        heading = 94.0, -- The heading of the boxzone, this has to be a float value
        debugPoly = false, -- This is for enabling/disabling the drawing of the box, it accepts only a boolean value (true or false), when true it will draw the polyzone in green
        minZ = Config.Coords.z - (3.0 / 2), -- This is the bottom of the boxzone, this can be different from the Z value in the coords, this has to be a float value
        maxZ = Config.Coords.z + (3.0 / 2), -- This is the top of the boxzone, this can be different from the Z value in the coords, this has to be a float value
      }, {
        options = { -- This is your options table, in this table all the options will be specified for the target to accept
          { -- This is the first table with options, you can make as many options inside the options table as you want
            type = "server", -- This specifies the type of event the target has to trigger on click, this can be "client", "server", "command" or "qbcommand", this is OPTIONAL and will only work if the event is also specified
            event = "srp-crafting:server:openUI", -- This is the event it will trigger on click, this can be a client event, server event, command or qbQBCore registered command, NOTICE: Normal command can't have arguments passed through, QBQBCore registered ones can have arguments passed through
            icon = 'fas fa-tools', -- This is the icon that will display next to this trigger option
            label = 'Craft', -- This is the label of this option which you would be able to click on to trigger everything, this has to be a string
          }
        },
        distance = 2.5, -- This is the distance for you to be at for the target to turn blue, this is in GTA units and has to be a float value
      })      
end


CreateThread(buildInteract)