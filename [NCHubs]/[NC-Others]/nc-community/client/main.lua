QBCore = exports['qb-core']:GetCoreObject() 
local Keys = {
["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

INPUT_CONTEXT = 51

local isSentenced = false
local communityServiceFinished = false
local actionsRemaining = 0
local availableActions = {}
local disable_actions = false

local vassoumodel = "prop_tool_broom"
local vassour_net = nil

local spatulamodel = "bkr_prop_coke_spatula_04"
local spatula_net = nil

RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    Wait(2000)
    TriggerServerEvent('qb-communityservice:checkIfSentenced')
end)

function FillActionTable(last_action)

    while #availableActions < 5 do

        local service_does_not_exist = true

        local random_selection = Config.ServiceLocations[math.random(1,#Config.ServiceLocations)]

        for i = 1, #availableActions do
            if random_selection.coords.x == availableActions[i].coords.x and random_selection.coords.y == availableActions[i].coords.y and random_selection.coords.z == availableActions[i].coords.z then

                service_does_not_exist = false

            end
        end

        if last_action ~= nil and random_selection.coords.x == last_action.coords.x and random_selection.coords.y == last_action.coords.y and random_selection.coords.z == last_action.coords.z then
            service_does_not_exist = false
        end

        if service_does_not_exist then
            table.insert(availableActions, random_selection)
        end

    end

end

RegisterNetEvent('qb-communityservice:inCommunityService', function(actions_remaining)
    local playerPed = PlayerPedId()
    local src = source
    if isSentenced then
        return
    end

    actionsRemaining = actions_remaining

    FillActionTable()
    print(":: Available Actions: " .. #availableActions)

   --[[  ApplyPrisonerSkin() ]]
    SetEntityCoords(playerPed, Config.ServiceLocation.x, Config.ServiceLocation.y, Config.ServiceLocation.z)
    isSentenced = true
    communityServiceFinished = false
    while actionsRemaining > 0 and communityServiceFinished ~= true do
        if IsPedInAnyVehicle(playerPed, false) then
            ClearPedTasksImmediately(playerPed)
        end
        Wait(20000)
        if GetDistanceBetweenCoords(GetEntityCoords(playerPed), Config.ServiceLocation.x, Config.ServiceLocation.y, Config.ServiceLocation.z) > 45 then
            SetEntityCoords(playerPed, Config.ServiceLocation.x, Config.ServiceLocation.y, Config.ServiceLocation.z)
            TriggerEvent('chat:addMessage', {args = {_U('judge'), _U('escape_attempt')}, color = {147, 196, 109}})
            TriggerServerEvent('qb-communityservice:extendService')
            actionsRemaining = actionsRemaining + Config.ServiceExtensionOnEscape
        end
    end

    TriggerServerEvent('qb-communityservice:finishCommunityService', -1)
    SetEntityCoords(playerPed, Config.ReleaseLocation.x, Config.ReleaseLocation.y, Config.ReleaseLocation.z)
    isSentenced = false
 
end)

RegisterNetEvent('qb-communityservice:finishCommunityService', function(source)
    communityServiceFinished = true
    isSentenced = false
    actionsRemaining = 0
    TriggerServerEvent("qb-clothes:loadPlayerSkin")
end)

CreateThread(function()
    while true do
        Wait(1)

        if actionsRemaining > 0 and isSentenced then
            draw2dText(('Actions Remaining: '..math.floor(actionsRemaining)), { 0.850, 0.001 } )
            DrawAvailableActions()
            DisableViolentActions()

            local pCoords    = GetEntityCoords(PlayerPedId())

            for i = 1, #availableActions do
                local distance = GetDistanceBetweenCoords(pCoords, availableActions[i].coords, true)

                if distance < 1.5 then
                    DisplayHelpText("Press ~g~[E]~w~ to start work")
                    if(IsControlJustReleased(1, 38))then
                        tmp_action = availableActions[i]
                        RemoveAction(tmp_action)
                        FillActionTable(tmp_action)
                        disable_actions = true

                        TriggerServerEvent('qb-communityservice:completeService')
                        actionsRemaining = actionsRemaining - 1

                        if tmp_action.type == "cleaning" then
                            local cSCoords = GetOffsetFromEntityInWorldCoords(GetPlayerPed(PlayerId()), 0.0, 0.0, -5.0)
                            local vassouspawn = CreateObject(GetHashKey(vassoumodel), cSCoords.x, cSCoords.y, cSCoords.z, 1, 1, 1)
                            local netid = ObjToNet(vassouspawn)

                            RequestDict("amb@world_human_janitor@male@idle_a")

                            RequestAnimDict("amb@world_human_janitor@male@idle_a")
                            Wait(100)
                            TaskPlayAnim(PlayerPedId(), "amb@world_human_janitor@male@idle_a", "idle_a", 8.0, -8.0, -1, 0, 0, false, false, false)
                            AttachEntityToEntity(vassouspawn,GetPlayerPed(PlayerId()),GetPedBoneIndex(GetPlayerPed(PlayerId()), 28422),-0.005,0.0,0.0,360.0,360.0,0.0,1,1,0,1,0,1)
                            vassour_net = netid

                            Wait(10000)
                            disable_actions = false
                            DetachEntity(NetToObj(vassour_net), 1, 1)
                            DeleteEntity(NetToObj(vassour_net))
                            vassour_net = nil
                            ClearPedTasks(PlayerPedId())

                        end

                        if tmp_action.type == "gardening" then
                            local cSCoords = GetOffsetFromEntityInWorldCoords(GetPlayerPed(PlayerId()), 0.0, 0.0, -5.0)
                            local spatulaspawn = CreateObject(GetHashKey(spatulamodel), cSCoords.x, cSCoords.y, cSCoords.z, 1, 1, 1)
                            local netid = ObjToNet(spatulaspawn)

                            TaskStartScenarioInPlace(PlayerPedId(), "world_human_gardener_plant", 0, false)
                            AttachEntityToEntity(spatulaspawn,GetPlayerPed(PlayerId()),GetPedBoneIndex(GetPlayerPed(PlayerId()), 28422),-0.005,0.0,0.0,190.0,190.0,-50.0,1,1,0,1,0,1)
                            spatula_net = netid

                            Wait(14000)
                            disable_actions = false
                            DetachEntity(NetToObj(spatula_net), 1, 1)
                            DeleteEntity(NetToObj(spatula_net))
                            spatula_net = nil
                            ClearPedTasks(PlayerPedId())
                        end
                    end
                end
            end
        else
            Wait(1000)
        end
    end
end)


--[[ function ApplyPrisonerSkin()
    local playerPed = PlayerPedId()
    local Player = QBCore.Functions.GetPlayerData()
    if DoesEntityExist(playerPed) then
        local DataMale = {--CHANGE CLOTH HERE
            outfitData = {
                ["t-shirt"] = {item = 15, texture = 0},
                ["torso2"] = {item = 292, texture = 0},
                ["decals"] = {item = 0, texutre = 0},
                ["arms"] = {item = 61, texture = 0},
                ["pants"] = {item = 48, texture = 0},
                ["shoes"] = {item = 49, texture = 0},
            }}
        local DataFemale = {
            outfitData = {
                ["t-shirt"] = {item = 15, texture = 0},
                ["torso2"] = {item = 36, texture = 0},
                ["decals"] = {item = 0, texutre = 0},
                ["arms"] = {item = 4, texture = 0},
                ["pants"] = {item = 36, texture = 0},
            }}
        if Player.charinfo.gender == 0 then
            TriggerEvent('qb-clothing:client:loadOutfit', DataMale)--Change Here the Clothing resource
        
        else
            TriggerEvent('qb-clothing:client:loadOutfit', DataFemale)--CHANGE HERE TOO
        
        end
        SetPedArmour(playerPed, 0)
        ClearPedBloodDamage(playerPed)
        ResetPedVisibleDamage(playerPed)
        ClearPedLastWeaponDamage(playerPed)
        ResetPedMovementClipset(playerPed, 0)
    end
end ]]

function RequestDict(dict)
    while not HasAnimDictLoaded(dict) do
        RequestAnimDict("amb@world_human_janitor@male@idle_a")
        Wait(100)
    end
end

function RemoveAction(action)

    local action_pos = -1

    for i=1, #availableActions do
        if action.coords.x == availableActions[i].coords.x and action.coords.y == availableActions[i].coords.y and action.coords.z == availableActions[i].coords.z then
            action_pos = i
        end
    end

    if action_pos ~= -1 then
        table.remove(availableActions, action_pos)
    else
        print("User tried to remove an unavailable action")
    end

end

function DisplayHelpText(str)
    SetTextComponentFormat("STRING")
    AddTextComponentString(str)
    DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end


function DrawAvailableActions()

    for i = 1, #availableActions do
        DrawMarker(2, availableActions[i].coords, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.1, 255, 0, 3, 100, false, true, 2, true, false, false, false)
    end

end

function DisableViolentActions()

    local playerPed = PlayerPedId()

    if disable_actions == true then
        DisableAllControlActions(0)
    end
    RemoveAllPedWeapons(playerPed, true)
    DisablePlayerFiring(playerPed,true) -- Disables firing all together if they somehow bypass inzone Mouse Disable
    DisableControlAction(0, 106, true) -- Disable in-game mouse controls
    DisableControlAction(0, 140, true)
    DisableControlAction(0, 141, true)
    DisableControlAction(0, 142, true)
end


function draw2dText(text, pos)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextScale(0.45, 0.45)
    SetTextColour(255, 255, 255, 255)
    SetTextDropShadow(0, 0, 0, 0, 255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    BeginTextCommandDisplayText('STRING')
    AddTextComponentSubstringPlayerName(text)
    EndTextCommandDisplayText(table.unpack(pos))
end