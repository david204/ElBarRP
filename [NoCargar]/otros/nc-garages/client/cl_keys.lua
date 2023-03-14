local Keys = {
    ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
    ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
    ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
    ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
    ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
    ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
    ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
    ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
}

local HasKey, IsHotwiring, IsRobbing, isLoggedIn, AlertSend = false, false, false, false, false
local LastVehicle = nil
local NeededAttempts, SucceededAttempts, FailedAttemps = 0, 0, 0
local vehicleSearched, vehicleHotwired = {}, {}

local QBCore = exports['qb-core']:GetCoreObject()

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(5)

        if QBCore ~= nil then
            if IsPedInAnyVehicle(PlayerPedId(), false) and GetPedInVehicleSeat(GetVehiclePedIsIn(PlayerPedId(), true), -1) == PlayerPedId() then
                local plate = GetVehicleNumberPlateText(GetVehiclePedIsIn(PlayerPedId(), true))
                if LastVehicle ~= GetVehiclePedIsIn(PlayerPedId(), false) then
                    QBCore.Functions.TriggerCallback('vehiclekeys:CheckHasKey', function(result)
                        if result then
                            HasKey = true
                            SetVehicleEngineOn(veh, true, false, true)
                        else
                            HasKey = false
                            SetVehicleEngineOn(veh, false, false, true)
                        end
                        LastVehicle = GetVehiclePedIsIn(PlayerPedId(), false)
                    end, plate)
                end
            else
                if SucceededAttempts ~= 0 then
                    SucceededAttempts = 0
                end
                if NeededAttempts ~= 0 then
                    NeededAttempts = 0
                end
                if FailedAttemps ~= 0 then
                    FailedAttemps = 0
                end
            end
        end

        if not HasKey and IsPedInAnyVehicle(PlayerPedId(), false) and GetPedInVehicleSeat(GetVehiclePedIsIn(PlayerPedId(), false), -1) == PlayerPedId() and QBCore ~= nil and not IsHotwiring then
            local veh = GetVehiclePedIsIn(PlayerPedId(), false)
            SetVehicleEngineOn(veh, false, false, true)
            local veh = GetVehiclePedIsIn(PlayerPedId(), false)
            local vehpos = GetOffsetFromEntityInWorldCoords(veh, 0.0, 2.0, 1.0)
            SetVehicleEngineOn(veh, false, false, true)
        end

        if IsControlJustPressed(1, Keys["L"]) then
            LockVehicle()
        end
    end
end)

function DrawText3Ds(x, y, z, text)
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
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 41, 11, 41, 68)
    ClearDrawOrigin()
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(7)
        if not IsRobbing and isLoggedIn and QBCore ~= nil then
            if GetVehiclePedIsTryingToEnter(PlayerPedId()) ~= nil and GetVehiclePedIsTryingToEnter(PlayerPedId()) ~= 0 then
                local vehicle = GetVehiclePedIsTryingToEnter(PlayerPedId())
                local driver = GetPedInVehicleSeat(vehicle, -1)
                if driver ~= 0 and not IsPedAPlayer(driver) then
                    if IsEntityDead(driver) then
                        IsRobbing = true
                        QBCore.Functions.Progressbar("rob_keys", "Taking Keys", 3000, false, true, {}, {}, {}, {}, function() -- Done
                            TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(vehicle), vehicle)
                            HasKey = true
                            IsRobbing = false

                        end)
                    end
                end
            end
        end
    end
end)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    isLoggedIn = true
end)

RegisterNetEvent('QBCore:Client:OnPlayerUnload')
AddEventHandler('QBCore:Client:OnPlayerUnload', function()
    isLoggedIn = false
end)

RegisterNetEvent('vehiclekeys:client:SetOwner')
AddEventHandler('vehiclekeys:client:SetOwner', function(plate, vehicle)
    local VehPlate = plate
    if VehPlate == nil then
        VehPlate = GetVehicleNumberPlateText(GetVehiclePedIsIn(PlayerPedId(), true))
    end

    TriggerServerEvent('vehiclekeys:server:SetVehicleOwner', VehPlate, vehicle)
    if IsPedInAnyVehicle(PlayerPedId()) and plate == GetVehicleNumberPlateText(GetVehiclePedIsIn(PlayerPedId(), true)) then
        SetVehicleEngineOn(GetVehiclePedIsIn(PlayerPedId(), true), true, false, true)
    end
    HasKey = true
end)

RegisterNetEvent('vehiclekeys:client:GiveKeys')
AddEventHandler('vehiclekeys:client:GiveKeys', function()
    local coordA = GetEntityCoords(PlayerPedId(), 1)
    local coordB = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 100.0, 0.0)
    local latestveh = getVehicleInDirection(coordA, coordB)
    
    if latestveh == nil or not DoesEntityExist(latestveh) then
        QBCore.Functions.Notify("Vehicle not found!", 'error')
        return
    end
    
    QBCore.Functions.TriggerCallback('vehiclekeys:CheckHasKey', function(hasKey)
        if not hasKey then
            QBCore.Functions.Notify("No keys for target vehicle!", 'error')
            return
        end

        if #(GetEntityCoords(latestveh) - GetEntityCoords(PlayerPedId(), 0)) > 5 then
            QBCore.Functions.Notify("You are too far away from the vehicle!", 'error')
            return
        end
        
        t, distance = QBCore.Functions.GetClosestPlayer()
        if(distance ~= -1 and distance < 5) then
            TriggerServerEvent('vehiclekeys:server:GiveVehicleKeys', GetVehicleNumberPlateText(latestveh), GetPlayerServerId(t))
            TriggerEvent("debug", 'Keys: Give Vehicle Keys', 'success')
        else
            QBCore.Functions.Notify("No player near you!", 'error')
            TriggerEvent("debug", 'Keys: No Player Nearby', 'error')
        end
    end, GetVehicleNumberPlateText(latestveh))
end)

function getVehicleInDirection(coordFrom, coordTo)
    local offset = 0
    local rayHandle
    local vehicle
  
    for i = 0, 100 do
      rayHandle = CastRayPointToPoint(coordFrom.x, coordFrom.y, coordFrom.z, coordTo.x, coordTo.y, coordTo.z + offset, 10, PlayerPedId(), 0) 
      a, b, c, d, vehicle = GetRaycastResult(rayHandle)
      
      offset = offset - 1
  
      if vehicle ~= 0 then break end
    end
    
    local distance = Vdist2(coordFrom, GetEntityCoords(vehicle))
    
    if distance > 25 then vehicle = nil end
  
      return vehicle ~= nil and vehicle or 0
  end

RegisterNetEvent('vehiclekeys:client:ToggleEngine')
AddEventHandler('vehiclekeys:client:ToggleEngine', function()
    local EngineOn = IsVehicleEngineOn(GetVehiclePedIsIn(PlayerPedId()))
    local veh = GetVehiclePedIsIn(PlayerPedId(), true)
    if HasKey then
        if EngineOn then
            SetVehicleEngineOn(veh, false, false, true)
        else
            SetVehicleEngineOn(veh, true, false, true)
        end
    end
end)

RegisterNetEvent('lockpicks:UseLockpick')
AddEventHandler('lockpicks:UseLockpick', function(isAdvanced)
    if (IsPedInAnyVehicle(PlayerPedId())) then
        if not HasKey then
            LockpickIgnition(isAdvanced)
        end
    else
        LockpickDoor(isAdvanced)
    end
end)

-- function LockVehicle()
--     local veh = QBCore.Functions.GetClosestVehicle()
--     local coordA = GetEntityCoords(PlayerPedId(), true)
--     local coordB = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 255.0, 0.0)
--     local veh = GetClosestVehicleInDirection(coordA, coordB)
--     local pos = GetEntityCoords(PlayerPedId(), true)
--     if IsPedInAnyVehicle(PlayerPedId()) then
--         veh = GetVehiclePedIsIn(PlayerPedId())
--     end
--     local plate = GetVehicleNumberPlateText(veh)
--     local vehpos = GetEntityCoords(veh, false)
--     if veh ~= nil and GetDistanceBetweenCoords(pos.x, pos.y, pos.z, vehpos.x, vehpos.y, vehpos.z, true) < 10.0 then
--         QBCore.Functions.TriggerCallback('vehiclekeys:CheckHasKey', function(result)
--             if result then
--                     if HasKey then
--                         local vehLockStatus = GetVehicleDoorLockStatus(veh)
--                         TriggerEvent("dooranim")
                    
--                         if vehLockStatus == 1 then
--                             TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 3.0, 'lock', 0.4)
--                             SetVehicleDoorsLocked(veh, 2)
--                             if(GetVehicleDoorLockStatus(veh) == 2)then
--                                 QBCore.Functions.Notify("Vehicle Locked.")
--                             else
--                                 QBCore.Functions.Notify("Something is wrong with the locking system...")
--                             end
--                         else
--                             TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 5.0, 'unlock', 0.1)
--                             SetVehicleDoorsLocked(veh, 1)
--                             if(GetVehicleDoorLockStatus(veh) == 1)then
--                                 QBCore.Functions.Notify("Vehicle Unlocked.")
--                             else
--                                 QBCore.Functions.Notify("Something is wrong with the locking system...")
--                             end
--                         end
                    
--                         if not IsPedInAnyVehicle(PlayerPedId()) then
--                             SetVehicleLights(veh, 2)
--                             SetVehicleBrakeLights(veh, true)
--                             SetVehicleInteriorlight(veh, true)
--                             SetVehicleIndicatorLights(veh, 0, true)
--                             SetVehicleIndicatorLights(veh, 1, true)
--                             Citizen.Wait(450)
--                             SetVehicleIndicatorLights(veh, 0, false)
--                             SetVehicleIndicatorLights(veh, 1, false)
--                             Citizen.Wait(450)
--                             SetVehicleInteriorlight(veh, true)
--                             SetVehicleIndicatorLights(veh, 0, true)
--                             SetVehicleIndicatorLights(veh, 1, true)
--                             Citizen.Wait(450)
--                             SetVehicleLights(veh, 0)
--                             SetVehicleBrakeLights(veh, false)
--                             SetVehicleInteriorlight(veh, false)
--                             SetVehicleIndicatorLights(veh, 0, false)
--                             SetVehicleIndicatorLights(veh, 1, false)
--                         end
--                     end
--             else
--                 QBCore.Functions.Notify("No keys for target vehicle!", 'error')
--             end
--         end, plate, veh)
--     end
-- end

local openingDoor = false
function LockpickDoor(isAdvanced)
    local vehicle = QBCore.Functions.GetClosestVehicle()
    if vehicle ~= nil and vehicle ~= 0 then
        local vehpos = GetEntityCoords(vehicle)
        local pos = GetEntityCoords(PlayerPedId())
        if GetDistanceBetweenCoords(pos.x, pos.y, pos.z, vehpos.x, vehpos.y, vehpos.z, true) < 1.5 then
            local vehLockStatus = GetVehicleDoorLockStatus(vehicle)
            if (vehLockStatus > 1) then
                local lockpickTime = math.random(15, 30) * 1000
                if isAdvanced then
                    lockpickTime = math.random(15, 30) * 1000
                end
                LockpickDoorAnim(lockpickTime)
                IsHotwiring = true
                SetVehicleAlarm(vehicle, true)
                SetVehicleAlarmTimeLeft(vehicle, lockpickTime)
                QBCore.Functions.Progressbar("lockpick_vehicledoor", "Lockpicking", lockpickTime, false, true, {
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = false,
                    disableCombat = true,
                }, {}, {}, {}, function() -- Done
                    openingDoor = false
                    StopAnimTask(PlayerPedId(), "veh@break_in@0h@p_m_one@", "low_force_entry_ds", 1.0)
                    IsHotwiring = false
                        TriggerEvent("debug", 'Lockpick: Success', 'success')
                        TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 5, "unlock", 0.1)
                        SetVehicleDoorsLocked(vehicle, 0)
                        SetVehicleDoorsLockedForAllPlayers(vehicle, false)
                   
                    
                end, function() -- Cancel
                    openingDoor = false
                    StopAnimTask(PlayerPedId(), "veh@break_in@0h@p_m_one@", "low_force_entry_ds", 1.0)
                    QBCore.Functions.Notify("Failed!", "error")
                    TriggerEvent("debug", 'Lockpick: Canceled', 'error')
                    IsHotwiring = false
                end)
            end
        end
    else
        QBCore.Functions.Notify('You can\'t use lockpick on parked vehicles.', 'error')
    end
end

function LockpickDoorAnim(time)
    time = time / 1000
    loadAnimDict("veh@break_in@0h@p_m_one@")
    TaskPlayAnim(PlayerPedId(), "veh@break_in@0h@p_m_one@", "low_force_entry_ds" ,3.0, 3.0, -1, 16, 0, false, false, false)
    openingDoor = true
    Citizen.CreateThread(function()
        while openingDoor do
            TaskPlayAnim(PlayerPedId(), "veh@break_in@0h@p_m_one@", "low_force_entry_ds", 3.0, 3.0, -1, 16, 0, 0, 0, 0)
            Citizen.Wait(1000)
            time = time - 1
            if time <= 0 then
                openingDoor = false
                StopAnimTask(PlayerPedId(), "veh@break_in@0h@p_m_one@", "low_force_entry_ds", 1.0)
            end
        end
    end)
end

function LockpickIgnition(isAdvanced)
    if not HasKey then 
        local vehicle = GetVehiclePedIsIn(PlayerPedId(), true)
        if vehicle ~= nil and vehicle ~= 0 then
            if GetPedInVehicleSeat(vehicle, -1) == PlayerPedId() then
                IsHotwiring = true

                local dict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@"
                local anim = "machinic_loop_mechandplayer"
				TaskPlayAnim(PlayerPedId(), 'anim@amb@clubhouse@tutorial@bkr_tut_ig3@', 'machinic_loop_mechandplayer' ,1.0, 4.0, -1, 49, 0, false, false, false)

                RequestAnimDict(dict)
                while not HasAnimDictLoaded(dict) do
                    RequestAnimDict(dict)
                    Citizen.Wait(100)
                end

                if exports["nc-taskbarskill"]:taskBar(math.random(5000,25000),math.random(10,20)) ~= 100 then             
					StopAnimTask(PlayerPedId(), "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer", 1.0)
                    HasKey = false
                    SetVehicleEngineOn(vehicle, false, false, true)
                    QBCore.Functions.Notify("Lockpicking failed!", "error")
                    IsHotwiring = false
                    local c = math.random(2)
                    local o = math.random(2)
                    if c == o then
                        TriggerServerEvent('hud:server:GainStress', math.random(1, 4))
                    end
                    return
                end
    
                if exports["nc-taskbarskill"]:taskBar(math.random(5000,25000),math.random(10,20)) ~= 100 then
                    StopAnimTask(PlayerPedId(), "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer", 1.0)
                    HasKey = false
                    SetVehicleEngineOn(vehicle, false, false, true)
                    QBCore.Functions.Notify("Lockpicking failed!", "error")
                    IsHotwiring = false
                    local c = math.random(2)
                    local o = math.random(2)
                    if c == o then
                        TriggerServerEvent('hud:server:GainStress', math.random(1, 4))
                    end
                    return
                end

                if exports["nc-taskbarskill"]:taskBar(1500,math.random(5,15)) ~= 100 then
                    StopAnimTask(PlayerPedId(), "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer", 1.0)
                    HasKey = false
                    SetVehicleEngineOn(vehicle, false, false, true)
                    QBCore.Functions.Notify("Lockpicking failed!", "error")
                    IsHotwiring = false
                    local c = math.random(2)
                    local o = math.random(2)
                    if c == o then
                        TriggerServerEvent('hud:server:GainStress', math.random(1, 4))
                    end
                    return
                end 

                TriggerEvent("debug", 'Hotwire: Success', 'success')
                StopAnimTask(PlayerPedId(), "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer", 1.0)
                QBCore.Functions.Notify("Ignition Working.")
                HasKey = true
                TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(vehicle))
                IsHotwiring = false
                TriggerServerEvent('hud:server:GainStress', math.random(2, 4))

            end
        end
    end
end

-- functions
function GetClosestVehicleInDirection(coordFrom, coordTo)
	local offset = 0
	local rayHandle
	local vehicle

	for i = 0, 100 do
		rayHandle = CastRayPointToPoint(coordFrom.x, coordFrom.y, coordFrom.z, coordTo.x, coordTo.y, coordTo.z + offset, 10, PlayerPedId(), 0)	
		a, b, c, d, vehicle = GetRaycastResult(rayHandle)
		
		offset = offset - 1

		if vehicle ~= 0 then break end
	end
	
	local distance = Vdist2(coordFrom, GetEntityCoords(vehicle))
	
	if distance > 25 then vehicle = nil end

    return vehicle ~= nil and vehicle or 0
end

function loadAnimDict( dict )
    while ( not HasAnimDictLoaded( dict ) ) do
        RequestAnimDict( dict )
        Citizen.Wait( 0 )
    end
end

--fake plate 
RegisterNetEvent('nc-garages:client:fakeplate:steal')
AddEventHandler('nc-garages:client:fakeplate:steal', function(data)
    local playerPed = PlayerPedId()
    local pedCoords = GetEntityCoords(playerPed)
    local vehicle = QBCore.Functions.GetClosestVehicle(pedCoords)
    local vehicleCoords = GetEntityCoords(vehicle)
    local dst = #(vehicleCoords - pedCoords)
    local plate = GetVehicleNumberPlateText(vehicle)

    if dst <= 7.0 then
        if plate:gsub(" ", "") ~= '' and plate:gsub(" ", "") ~= '       ' then
            local plateHeading = GetEntityHeading(vehicleplateEntity)
            TaskTurnPedToFaceEntity(PlayerPedId(), vehicle, 3.0)
            playAnim()
            Wait(1000)

            local skillbarAmount = math.random(4)
		    for counter = 1, skillbarAmount do
		    	local finished = exports["nc-taskbarskill"]:taskBar(math.random(600, 2500), math.random(5, 15))
                if finished ~= 100 then
                    Wait(500)
                    local chances = math.random(10)
                    if chances <= 3 then
                        TriggerServerEvent('nc-garages:server:fakeplate:breakScrewdriver')
                    end
            		ClearPedTasks(playerPed)
            		return
		    	end
            end

            Wait(3000)
            NetworkRequestControlOfEntity(vehicle)
            while not NetworkHasControlOfEntity(vehicle) do Wait(0) end

            TriggerServerEvent('nc-garages:server:isPlayerVehicle', 'STEAL', plate, vehicle)
            SetVehicleNumberPlateText(vehicle, '')
            TriggerServerEvent('nc-garages:server:fakeplate:createLicensePlate', plate)

            ClearPedTasks(PlayerPedId())
        else
            TriggerEvent('QBCore:Notify', "This vehicle doesn\'t have license plate on, what are you trying to do bruh", "error")
        end
    else
        ClearPedTasksImmediately(PlayerPedId())
    end
end)

RegisterNetEvent('nc-garages:client:fakeplate:usePlate')
AddEventHandler('nc-garages:client:fakeplate:usePlate', function(data)
    local playerPed = PlayerPedId()
    local pedCoords = GetEntityCoords(playerPed)
    local vehicle = QBCore.Functions.GetClosestVehicle(pedCoords)
    local vehicleCoords = GetEntityCoords(vehicle)
    local plate = GetVehicleNumberPlateText(vehicle)
    local dst = #(vehicleCoords - pedCoords)

    if dst <= 7.0 then
        if plate == '' or plate == '        ' then
            TaskTurnPedToFaceEntity(PlayerPedId(), vehicle, 3.0)
            Wait(1000)
            playAnim()
            Wait(7000)
            
            NetworkRequestControlOfEntity(vehicle)
            while not NetworkHasControlOfEntity(vehicle) do Wait(0) end

            TriggerServerEvent('nc-garages:server:isPlayerVehicle', 'SET', data['info']['plate'], vehicle)
            SetVehicleNumberPlateText(vehicle, data['info']['plate'])
            TriggerServerEvent('nc-garages:server:fakeplate:removeLicensePlate', data['slot'])
            ClearPedTasks(PlayerPedId())
        else
            TriggerEvent('QBCore:Notify', "This vehicle already has license plate on, remove it first", "error")
        end
    else
        ClearPedTasksImmediately(PlayerPedId())
    end
end)

function playAnim()
    local ped = PlayerPedId()
    local animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@"
    local animation = "machinic_loop_mechandplayer"
    if IsPedArmed(ped, 7) then
        SetCurrentPedWeapon(ped, 0xA2719263, true)
    end

    if IsEntityPlayingAnim(ped, animDict, animation, 3) then
        ClearPedSecondaryTask(ped)
    else
        loadAnimDict(animDict)
        local animLength = GetAnimDuration(animDict, animation)
        TaskPlayAnim(PlayerPedId(), animDict, animation, 1.0, 4.0, animLength, 0, 0, 0, 0, 0)
    end
end

function loadAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        RequestAnimDict(dict)
        Citizen.Wait(5)
    end
end