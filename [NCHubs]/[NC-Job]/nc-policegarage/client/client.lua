local QBCore = exports['qb-core']:GetCoreObject()

local InPreview = false

local isActive = false

PlayerJob = {}

RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    QBCore.Functions.GetPlayerData(function(PlayerData)
        PlayerJob = PlayerData.job
    end)
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate')
AddEventHandler('QBCore:Client:OnJobUpdate', function(JobInfo)
    PlayerJob = JobInfo
end)

AddEventHandler('onClientResourceStart',function()
    Citizen.CreateThread(function()
        while true do
            if QBCore ~= nil and QBCore.Functions.GetPlayerData ~= nil then
                QBCore.Functions.GetPlayerData(function(PlayerData)
                    if PlayerData.job then
                        PlayerJob = PlayerData.job
                    end
                end)
                break
            end
        end
        Citizen.Wait(1)
    end)
end)

RegisterNetEvent('nc-policegarage:Menu', function()
    local Menu = {
        {
            header = "Police Garage",
            txt = "View Vehicles",
            params = {
                event = "nc-policegarage:Catalog",
            }
        }
    }
    Menu[#Menu+1] = {
        header = "Preview Vehicles",
        txt = "View Vehicles",
        params = {
            event = "nc-policegarage:PreviewCarMenu",
        }
    }
    if not Config.UseMarkerInsteadOfMenu then
        Menu[#Menu+1] = {
            header = "⬅ Store Vehicle",
            params = {
                event = "nc-policegarage:StoreVehicle"
            }
        }
    end
    Menu[#Menu+1] = {
        header = "⬅ Close Menu",
        params = {
            event = "qb-menu:client:closeMenu"
        }
    }
    exports['qb-menu']:openMenu(Menu)
end)

RegisterNetEvent("nc-policegarage:Catalog", function()
    local vehicleMenu = {
        {
            header = "Police Garage",
            isMenuHeader = true,
        }
    }
    for k, v in pairs(Config.Vehicles) do
        vehicleMenu[#vehicleMenu+1] = {
            header = v.vehiclename,
            txt = "Buy: " .. v.vehiclename .. " For: " .. v.price .. "$",
            params = {
                isServer = true,
                event = "nc-policegarage:TakeMoney",
                args = {
                    price = v.price,
                    vehiclename = v.vehiclename,
                    vehicle = v.vehicle
                }
            }
        }
    end
    vehicleMenu[#vehicleMenu+1] = {
        header = "⬅ Go Back",
        params = {
            event = "nc-policegarage:Menu"
        }
    }
    exports['qb-menu']:openMenu(vehicleMenu)
end)

RegisterNetEvent('nc-policegarage:PreviewCarMenu', function()
    local PreviewMenu = {
        {
            header = "Preview Menu",
            isMenuHeader = true
        }
    }
    for k, v in pairs(Config.Vehicles) do
        PreviewMenu[#PreviewMenu+1] = {
            header = v.vehiclename,
            txt = "Preview: " .. v.vehiclename,
            params = {
                event = "nc-policegarage:PreviewVehicle",
                args = {
                    vehicle = v.vehicle,
                }
            }
        }
    end
    PreviewMenu[#PreviewMenu+1] = {
        header = "⬅ Go Back",
        params = {
            event = "nc-policegarage:Menu"
        }
    }
    exports['qb-menu']:openMenu(PreviewMenu)
end)

--[[CreateThread(function()
    while true do
        local plyPed = PlayerPedId()
        local plyCoords = GetEntityCoords(plyPed) 
        local letSleep = true

        if PlayerJob.name == Config.Job then
            if (GetDistanceBetweenCoords(plyCoords.x, plyCoords.y, plyCoords.z, 441.45, -975.07, 25.7, true) < 10) then
                letSleep = false
                -- DrawMarker(36, 441.45, -975.07, 25.7 + 0.2, 0.0, 0.0, 0.0, 0.0, 0.0, 0.7, 0.7, 0.5, 0.5, 0, 0, 0, 255, true, false, false, true, false, false, false)
                if Config.UseMarkerInsteadOfMenu then
                    if (GetDistanceBetweenCoords(plyCoords.x, plyCoords.y, plyCoords.z, 441.45, -975.07, 25.7, true) < 1.5) and not IsPedInAnyVehicle(PlayerPedId(), false) then
                        DrawText3D(441.45, -975.07, 28.7, "~g~E~w~ - Police Garage") 
                        if IsControlJustReleased(0, 38) then
                            TriggerEvent("nc-policegarage:Menu")
                        end
                    end
                    if IsPedInAnyVehicle(PlayerPedId(), false) then   
                        DrawText3D(441.45, -975.07, 25.7, "~g~E~w~ - Store Vehicle (Will Get Impounded)") 
                    end
                    if IsControlJustReleased(0, 38) and IsPedInAnyVehicle(PlayerPedId(), false) then
                        TriggerEvent("nc-policegarage:StoreVehicle")
                    end
                else
                    if (GetDistanceBetweenCoords(plyCoords.x, plyCoords.y, plyCoords.z, 441.45, -975.07, 25.7, true) < 1.5) then
                        DrawText3D(441.45, -975.07, 25.7, "~g~E~w~ - Police Garage") 
                        if IsControlJustReleased(0, 38) then
                            TriggerEvent("nc-policegarage:Menu")
                        end
                    end
                end
            end
        end

        if letSleep then
            Wait(2000)
        end

        Wait(1)
    end
end)]]

CreateThread(function()
	exports['qb-target']:AddBoxZone("Policegarage", vector3(441.45, -975.07, 26.2), 1, 1.2, {
		name = "Policegarage",
		heading = 32,
		debugPoly = false,
		minZ=25.0,
		maxZ=26.5,
	}, {
		options = {
		    {  
			event = "nc-policegarage:Menu",
			icon = "far fa-clipboard",
			label = "Open Garage",
			job = "police",
		    },
		},
		distance = 1.5
	})
end)

RegisterNetEvent("nc:policegarage:open")
AddEventHandler("nc:policegarage:open", function()
    TriggerEvent("nc-policegarage:Menu")
end)

RegisterNetEvent('nc-policegarage:client:SetActive', function(status)
    isActive = status
end)

RegisterNetEvent('nc-policegarage:StoreVehicle')
AddEventHandler('nc-policegarage:StoreVehicle', function()
    local ped = PlayerPedId()
    local car = GetVehiclePedIsIn(PlayerPedId(),true)
    if IsPedInAnyVehicle(ped, false) then
        TaskLeaveVehicle(ped, car, 1)
        Citizen.Wait(2000)
        QBCore.Functions.Notify('Vehicle Stored!')
        DeleteVehicle(car)
        DeleteEntity(car)
    else
        QBCore.Functions.Notify("You Are Not In Any Vehicle !", "error")
    end
end)

local function SetCarItemsInfo()
	local items = {}
	for k, item in pairs(Config.CarItems) do
		local itemInfo = QBCore.Shared.Items[item.name:lower()]
		items[item.slot] = {
			name = itemInfo["name"],
			amount = tonumber(item.amount),
			info = item.info,
			label = itemInfo["label"],
			description = itemInfo["description"] and itemInfo["description"] or "",
			weight = itemInfo["weight"],
			type = itemInfo["type"],
			unique = itemInfo["unique"],
			useable = itemInfo["useable"],
			image = itemInfo["image"],
			slot = item.slot,
		}
	end
	Config.CarItems = items
end

RegisterNetEvent("nc-policegarage:SpawnVehicle")
    AddEventHandler("nc-policegarage:SpawnVehicle", function(vehicle)
    local coords = vector4(452.11, -992.76, 25.31, 359.31)
    local v = Config.Vehicles
    QBCore.Functions.SpawnVehicle(vehicle, function(veh)
    local props = QBCore.Functions.GetVehicleProperties(veh)
    SetVehicleNumberPlateText(veh, "POL"..tostring(math.random(1000, 9999)))
    exports['nc-fuel']:SetFuel(veh, 100)
    CloseMenu()
    if Config.UseColors == true then
    SetVehicleCustomPrimaryColour(veh, v.r, v.g, v.b)
    SetVehicleCustomSecondaryColour(veh, v.r, v.g, v.b)
    end
    TaskWarpPedIntoVehicle(PlayerPedId(), veh, -1)
    TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(veh))
    TriggerServerEvent("inventory:server:addTrunkItems", QBCore.Functions.GetPlate(veh), Config.CarItems)
    SetVehicleEngineOn(veh, true, true)
    TriggerServerEvent("nc-policegarage:AddVehicleSQL", props, vehicle, GetHashKey(veh), QBCore.Functions.GetPlate(veh))
    end, coords, true)
end)

RegisterNetEvent("nc-policegarage:PreviewVehicle")
AddEventHandler("nc-policegarage:PreviewVehicle", function(data)
    if Config.UsePreviewMenuSync then
        QBCore.Functions.TriggerCallback('nc-policegarage:CheckIfActive', function(result)
            if result then
                InPreview = true
                local coords = vector4(436.3, -975.93, 25.31, 89.64) 
                QBCore.Functions.SpawnVehicle(data.vehicle, function(veh)
                    SetEntityVisible(PlayerPedId(), false, 1)
                    if Config.SetVehicleTransparency == 'low' then
                        SetEntityAlpha(veh, 400)
                    elseif Config.SetVehicleTransparency == 'medium' then
                        SetEntityAlpha(veh, 93)
                    elseif Config.SetVehicleTransparency == 'high' then
                        SetEntityAlpha(veh, 40)
                    elseif Config.SetVehicleTransparency == 'none' then
                        
                    end
                    FreezeEntityPosition(PlayerPedId(), true)
                    SetVehicleNumberPlateText(veh, "POL"..tostring(math.random(1000, 9999)))
                    exports['nc-fuel']:SetFuel(veh, 0.0)
                    CloseMenu()
                    FreezeEntityPosition(veh, true)
                    SetVehicleEngineOn(veh, false, false)
                    DoScreenFadeOut(200)
                    Citizen.Wait(500)
                    DoScreenFadeIn(200)
                    SetVehicleUndriveable(veh, true)
                
                    VehicleCam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", 436.16, -980.46, 27.06, 50, 0.00, 1.84, 100.00, false, 0)   
                    SetCamActive(VehicleCam, true)
                    RenderScriptCams(true, true, 500, true, true)
                    
                    if Config.MS == 'high' then
                        Citizen.CreateThread(function()
                            while true do
                                if InPreview then
                                    ShowHelpNotification("Press ~INPUT_FRONTEND_RRIGHT~ To Close")
                                elseif not InPreview then
                                    break
                                end
                                Citizen.Wait(1)
                            end
                        end)
                    elseif Config.MS == 'low' then
                        ShowHelpNotification("Press ~INPUT_FRONTEND_RRIGHT~ To Close")
                    end
            
                    Citizen.CreateThread(function()
                        while true do
                            if IsControlJustReleased(0, 177) then
                                SetEntityVisible(PlayerPedId(), true, 1)
                                FreezeEntityPosition(PlayerPedId(), false)
                                PlaySoundFrontend(-1, "NO", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
                                QBCore.Functions.DeleteVehicle(veh)
                                DoScreenFadeOut(200)
                                Citizen.Wait(500)
                                DoScreenFadeIn(200)
                                RenderScriptCams(false, false, 1, true, true)
                                InPreview = false
                                TriggerServerEvent("nc-policegarage:server:SetActive", false)
                                break
                            end
                            Citizen.Wait(1)
                        end
                    end)
                end, coords, true)
            end
        end)
    else
        InPreview = true
        local coords = vector4(452.11, -992.76, 25.31, 359.31) 
        QBCore.Functions.SpawnVehicle(data.vehicle, function(veh)
            SetEntityVisible(PlayerPedId(), false, 1)
            if Config.SetVehicleTransparency == 'low' then
                SetEntityAlpha(veh, 400)
            elseif Config.SetVehicleTransparency == 'medium' then
                SetEntityAlpha(veh, 93)
            elseif Config.SetVehicleTransparency == 'high' then
                SetEntityAlpha(veh, 40)
            elseif Config.SetVehicleTransparency == 'none' then
                
            end
            FreezeEntityPosition(PlayerPedId(), true)
            SetVehicleNumberPlateText(veh, "POL"..tostring(math.random(1000, 9999)))
            exports['nc-fuel']:SetFuel(veh, 0.0)
            CloseMenu()
            FreezeEntityPosition(veh, true)
            SetVehicleEngineOn(veh, false, false)
            DoScreenFadeOut(200)
            Citizen.Wait(500)
            DoScreenFadeIn(200)
            SetVehicleUndriveable(veh, true)
        
            VehicleCam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", 436.16, -980.46, 27.06, 50, 0.00, 1.84, 100.00, false, 0)
            SetCamActive(VehicleCam, true)
            RenderScriptCams(true, true, 500, true, true)
            
            if Config.MS == 'high' then
                Citizen.CreateThread(function()
                    while true do
                        if InPreview then
                            ShowHelpNotification("Press ~INPUT_FRONTEND_RRIGHT~ To Close")
                        elseif not InPreview then
                            break
                        end
                        Citizen.Wait(1)
                    end
                end)
            elseif Config.MS == 'low' then
                ShowHelpNotification("Press ~INPUT_FRONTEND_RRIGHT~ To Close")
            end
    
            Citizen.CreateThread(function()
                while true do
                    if IsControlJustReleased(0, 177) then
                        SetEntityVisible(PlayerPedId(), true, 1)
                        FreezeEntityPosition(PlayerPedId(), false)
                        PlaySoundFrontend(-1, "NO", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
                        QBCore.Functions.DeleteVehicle(veh)
                        DoScreenFadeOut(200)
                        Citizen.Wait(500)
                        DoScreenFadeIn(200)
                        RenderScriptCams(false, false, 1, true, true)
                        InPreview = false
                        break
                    end
                    Citizen.Wait(1)
                end
            end)
        end, coords, true)
    end
end)

function CloseMenu()
    exports['qb-menu']:closeMenu()
end

function DrawText3D(x, y, z, text)
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

function ShowHelpNotification(text)
    SetTextComponentFormat("STRING")
    AddTextComponentString(text)
    DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end