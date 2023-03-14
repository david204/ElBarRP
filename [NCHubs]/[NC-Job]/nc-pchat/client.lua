local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('fix', function()
    local ped = PlayerPedId()
    local veh = GetVehiclePedIsIn(ped)
    if veh ~= 0 then
        if GetPedInVehicleSeat(veh, -1) == ped then
            QBCore.Functions.Progressbar("fix", "Fixing", 5000, false, true, {
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
                disableInventory = true,
            }, {}, {}, {}, function()
                SetVehicleFixed(veh)
                QBCore.Functions.Notify("Fixed!");
            end, function()end)
        else
            QBCore.Functions.Notify("You must be the driver.", "error");
        end
    else
        QBCore.Functions.Notify("You must be in vehicle.", "error");
    end  
end)

local crouched = false

RegisterCommand('+crouch', function()
    local ped = PlayerPedId()

    RequestAnimSet("move_ped_crouched")

    while not HasAnimSetLoaded("move_ped_crouched") do 
        Citizen.Wait(100)
    end 

    crouched = not crouched

    if not crouched then 
        ResetPedMovementClipset( ped, 0 )
    else
        SetPedMovementClipset( ped, "move_ped_crouched", 0.25 )
    end 
end)

RegisterKeyMapping('+crouch', 'Crouch', 'keyboard', 'LCONTROL')

CreateThread(function()
    while true do
        DisableControlAction(0, 36, true);
        Wait(1);
    end
end)