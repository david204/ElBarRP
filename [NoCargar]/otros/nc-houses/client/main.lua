QBCore = exports['qb-core']:GetCoreObject()
IsInside = false
ClosestHouse = nil
HasKey = false
contractOpen = false
local isOwned = false
local cam = nil
local viewCam = false
local FrontCam = false
local stashLocation = nil
local outfitLocation = nil
local logoutLocation = nil
local OwnedHouseBlips = {}
local UnownedHouseBlips = {}
local CurrentDoorBell = 0
local rangDoorbell = nil
local houseObj = {}
local POIOffsets = nil
local entering = false
local data = nil
local CurrentHouse = nil
local RamsDone = 0
local keyholderMenu = {}
local keyholderOptions = {}
local p = nil

-- Functions

local function DrawText3Ds(x, y, z, text)
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

local function loadAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Wait(5)
    end
end

local function openHouseAnim()
    loadAnimDict("anim@heists@keycard@")
    TaskPlayAnim( PlayerPedId(), "anim@heists@keycard@", "exit", 5.0, 1.0, -1, 16, 0, 0, 0, 0 )
    Wait(400)
    ClearPedTasks(PlayerPedId())
end

local function openContract(bool)
    SetNuiFocus(bool, bool)
    SendNUIMessage({
        type = "toggle",
        status = bool,
    })
    contractOpen = bool
end

local function GetClosestPlayer()
    local closestPlayers = QBCore.Functions.GetPlayersFromCoords()
    local closestDistance = -1
    local closestPlayer = -1
    local coords = GetEntityCoords(PlayerPedId())
    for i=1, #closestPlayers, 1 do
        if closestPlayers[i] ~= PlayerId() then
            local pos = GetEntityCoords(GetPlayerPed(closestPlayers[i]))
            local distance = #(pos - coords)

            if closestDistance == -1 or closestDistance > distance then
                closestPlayer = closestPlayers[i]
                closestDistance = distance
            end
        end
	end
	return closestPlayer, closestDistance
end

local function DoRamAnimation(bool)
    local ped = PlayerPedId()
    local dict = "missheistfbi3b_ig7"
    local anim = "lift_fibagent_loop"
    if bool then
        RequestAnimDict(dict)
        while not HasAnimDictLoaded(dict) do
            Wait(1)
        end
        TaskPlayAnim(ped, dict, anim, 8.0, 8.0, -1, 1, -1, false, false, false)
    else
        RequestAnimDict(dict)
        while not HasAnimDictLoaded(dict) do
            Wait(1)
        end
        TaskPlayAnim(ped, dict, "exit", 8.0, 8.0, -1, 1, -1, false, false, false)
    end
end

local function setViewCam(coords, h, yaw)
    cam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", coords.x, coords.y, coords.z, yaw, 0.00, h, 80.00, false, 0)
    SetCamActive(cam, true)
    RenderScriptCams(true, true, 500, true, true)
    viewCam = true
end

local function InstructionButton(ControlButton)
    N_0xe83a3e3557a56640(ControlButton)
end

local function InstructionButtonMessage(text)
    BeginTextCommandScaleformString("STRING")
    AddTextComponentScaleform(text)
    EndTextCommandScaleformString()
end

local function CreateInstuctionScaleform(scaleform)
    local scaleform = RequestScaleformMovie(scaleform)
    while not HasScaleformMovieLoaded(scaleform) do
        Wait(0)
    end
    PushScaleformMovieFunction(scaleform, "CLEAR_ALL")
    PopScaleformMovieFunctionVoid()
    PushScaleformMovieFunction(scaleform, "SET_CLEAR_SPACE")
    PushScaleformMovieFunctionParameterInt(200)
    PopScaleformMovieFunctionVoid()
    PushScaleformMovieFunction(scaleform, "SET_DATA_SLOT")
    PushScaleformMovieFunctionParameterInt(1)
    InstructionButton(GetControlInstructionalButton(1, 194, true))
    InstructionButtonMessage("Exit Camera")
    PopScaleformMovieFunctionVoid()
    PushScaleformMovieFunction(scaleform, "DRAW_INSTRUCTIONAL_BUTTONS")
    PopScaleformMovieFunctionVoid()
    PushScaleformMovieFunction(scaleform, "SET_BACKGROUND_COLOUR")
    PushScaleformMovieFunctionParameterInt(0)
    PushScaleformMovieFunctionParameterInt(0)
    PushScaleformMovieFunctionParameterInt(0)
    PushScaleformMovieFunctionParameterInt(80)
    PopScaleformMovieFunctionVoid()
    return scaleform
end

local function FrontDoorCam(coords)
    DoScreenFadeOut(150)
    Wait(500)
    cam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", coords.x, coords.y, coords.z + 0.5, 0.0, 0.00, coords.h - 180, 80.00, false, 0)
    SetCamActive(cam, true)
    RenderScriptCams(true, true, 500, true, true)
    FrontCam = true
    FreezeEntityPosition(PlayerPedId(), true)
    Wait(500)
    DoScreenFadeIn(150)
    SendNUIMessage({
        type = "frontcam",
        toggle = true,
        label = Config.Houses[ClosestHouse].adress
    })
    CreateThread(function()
        while FrontCam do
            local instructions = CreateInstuctionScaleform("instructional_buttons")
            DrawScaleformMovieFullscreen(instructions, 255, 255, 255, 255, 0)
            SetTimecycleModifier("scanline_cam_cheap")
            SetTimecycleModifierStrength(1.0)
            if IsControlJustPressed(1, 194) then -- Backspace
                DoScreenFadeOut(150)
                SendNUIMessage({
                    type = "frontcam",
                    toggle = false,
                })
                Wait(500)
                RenderScriptCams(false, true, 500, true, true)
                FreezeEntityPosition(PlayerPedId(), false)
                SetCamActive(cam, false)
                DestroyCam(cam, true)
                ClearTimecycleModifier("scanline_cam_cheap")
                cam = nil
                FrontCam = false
                Wait(500)
                DoScreenFadeIn(150)
            end

            local getCameraRot = GetCamRot(cam, 2)

            -- ROTATE UP
            if IsControlPressed(0, 32) then -- W
                if getCameraRot.x <= 0.0 then
                    SetCamRot(cam, getCameraRot.x + 0.7, 0.0, getCameraRot.z, 2)
                end
            end

            -- ROTATE DOWN
            if IsControlPressed(0, 33) then -- S
                if getCameraRot.x >= -50.0 then
                    SetCamRot(cam, getCameraRot.x - 0.7, 0.0, getCameraRot.z, 2)
                end
            end

            -- ROTATE LEFT
            if IsControlPressed(0, 34) then -- A
                SetCamRot(cam, getCameraRot.x, 0.0, getCameraRot.z + 0.7, 2)
            end

            -- ROTATE RIGHT
            if IsControlPressed(0, 35) then -- D
                SetCamRot(cam, getCameraRot.x, 0.0, getCameraRot.z - 0.7, 2)
            end

            Wait(1)
        end
    end)
end

local function disableViewCam()
    if viewCam then
        RenderScriptCams(false, true, 500, true, true)
        SetCamActive(cam, false)
        DestroyCam(cam, true)
        viewCam = false
    end
end

local function SetClosestHouse()
    local pos = GetEntityCoords(PlayerPedId(), true)
    local current = nil
    local dist = nil
    if not IsInside then
        for id, house in pairs(Config.Houses) do
            local distcheck = #(pos - vector3(Config.Houses[id].coords.enter.x, Config.Houses[id].coords.enter.y, Config.Houses[id].coords.enter.z))
            if current ~= nil then
                if distcheck < dist then
                    current = id
                    dist = distcheck
                end
            else
                dist = distcheck
                current = id
            end
        end
        ClosestHouse = current
        if ClosestHouse ~= nil and tonumber(dist) < 30 then
            QBCore.Functions.TriggerCallback('nc-houses:server:ProximityKO', function(key, owned)
                HasKey = key
                isOwned = owned
            end, ClosestHouse)
        end
    end
    TriggerEvent('nc-garages:client:setHouseGarage', ClosestHouse, HasKey)
end

local function setHouseLocations()
    if ClosestHouse ~= nil then
        QBCore.Functions.TriggerCallback('nc-houses:server:getHouseLocations', function(result)
            if result ~= nil then
                if result.stash ~= nil then
                    stashLocation = json.decode(result.stash)
                end

                if result.outfit ~= nil then
                    outfitLocation = json.decode(result.outfit)
                end

                if result.logout ~= nil then
                    logoutLocation = json.decode(result.logout)
                end
            end
        end, ClosestHouse)
    end
end

local function UnloadDecorations()
	if ObjectList ~= nil then
		for k, v in pairs(ObjectList) do
			if DoesEntityExist(v.object) then
				DeleteObject(v.object)
			end
		end
	end
end

local function LoadDecorations(house)
	if Config.Houses[house].decorations == nil or next(Config.Houses[house].decorations) == nil then
		QBCore.Functions.TriggerCallback('nc-houses:server:getHouseDecorations', function(result)
			Config.Houses[house].decorations = result
			if Config.Houses[house].decorations ~= nil then
				ObjectList = {}
				for k, v in pairs(Config.Houses[house].decorations) do
					if Config.Houses[house].decorations[k] ~= nil then
						if Config.Houses[house].decorations[k].object ~= nil then
							if DoesEntityExist(Config.Houses[house].decorations[k].object) then
								DeleteObject(Config.Houses[house].decorations[k].object)
							end
						end
						local modelHash = GetHashKey(Config.Houses[house].decorations[k].hashname)
						RequestModel(modelHash)
						while not HasModelLoaded(modelHash) do
							Wait(10)
						end
						local decorateObject = CreateObject(modelHash, Config.Houses[house].decorations[k].x, Config.Houses[house].decorations[k].y, Config.Houses[house].decorations[k].z, false, false, false)
						SetEntityRotation(decorateObject, Config.Houses[house].decorations[k].rotx, Config.Houses[house].decorations[k].roty, Config.Houses[house].decorations[k].rotz)
						ObjectList[Config.Houses[house].decorations[k].objectId] = {hashname = Config.Houses[house].decorations[k].hashname, x = Config.Houses[house].decorations[k].x, y = Config.Houses[house].decorations[k].y, z = Config.Houses[house].decorations[k].z, rotx = Config.Houses[house].decorations[k].rotx, roty = Config.Houses[house].decorations[k].roty, rotz = Config.Houses[house].decorations[k].rotz, object = decorateObject, objectId = Config.Houses[house].decorations[k].objectId}
						FreezeEntityPosition(decorateObject, true)
					end
				end
			end
		end, house)
	elseif Config.Houses[house].decorations ~= nil then
		ObjectList = {}
		for k, v in pairs(Config.Houses[house].decorations) do
			if Config.Houses[house].decorations[k] ~= nil then
				if Config.Houses[house].decorations[k].object ~= nil then
					if DoesEntityExist(Config.Houses[house].decorations[k].object) then
						DeleteObject(Config.Houses[house].decorations[k].object)
					end
				end
				local modelHash = GetHashKey(Config.Houses[house].decorations[k].hashname)
				RequestModel(modelHash)
				while not HasModelLoaded(modelHash) do
					Wait(10)
				end
				local decorateObject = CreateObject(modelHash, Config.Houses[house].decorations[k].x, Config.Houses[house].decorations[k].y, Config.Houses[house].decorations[k].z, false, false, false)
				Config.Houses[house].decorations[k].object = decorateObject
				SetEntityRotation(decorateObject, Config.Houses[house].decorations[k].rotx, Config.Houses[house].decorations[k].roty, Config.Houses[house].decorations[k].rotz)
				ObjectList[Config.Houses[house].decorations[k].objectId] = {hashname = Config.Houses[house].decorations[k].hashname, x = Config.Houses[house].decorations[k].x, y = Config.Houses[house].decorations[k].y, z = Config.Houses[house].decorations[k].z, rotx = Config.Houses[house].decorations[k].rotx, roty = Config.Houses[house].decorations[k].roty, rotz = Config.Houses[house].decorations[k].rotz, object = decorateObject, objectId = Config.Houses[house].decorations[k].objectId}
				FreezeEntityPosition(decorateObject, true)
			end
		end
	end
end

local function CheckDistance(target, distance)
    local ped = PlayerPedId()
    local pos = GetEntityCoords(ped)

    return #(pos - target) <= distance
end

-- GUI Functions

function CloseMenuFull()
    exports['qb-menu']:closeMenu()
end

local function RemoveHouseKey(citizenData)
    TriggerServerEvent('nc-houses:server:removeHouseKey', ClosestHouse, citizenData)
    CloseMenuFull()
end

local function getKeyHolders()
    if p then return end
    p = promise.new()
    QBCore.Functions.TriggerCallback('nc-houses:server:getHouseKeyHolders', function(holders)
        p:resolve(holders)
    end,ClosestHouse)
    return Citizen.Await(p)
end

function HouseKeysMenu()
    local holders = getKeyHolders()
    p = nil
    if holders == nil or next(holders) == nil then
        QBCore.Functions.Notify("No key holders found..", "error", 3500)
        CloseMenuFull()
    else
        keyholderMenu = {}

        for k, v in pairs(holders) do
            keyholderMenu[#keyholderMenu+1] = {
                header = holders[k].firstname .. " " .. holders[k].lastname,
                params = {
                    event = "nc-houses:client:OpenClientOptions",
                    args = {
                        citizenData = holders[k]
                    }
                }
            }
        end
        exports['qb-menu']:openMenu(keyholderMenu)
    end

end

local function optionMenu(citizenData)
    keyholderOptions = {
        {
            header = "Remove Key",
            params = {
                events = "nc-houses:client:RevokeKey",
                args = {
                    citizenData = citizenData
                }
            }
        },
        {
            header = "Back",
            params = {
                event = "nc-houses:client:removeHouseKey",
                args = {}
            }
        },
    }

    exports['qb-menu']:openMenu(keyholderOptions)
end

-- Shell Configuration
local function getDataForHouseTier(house, coords)
    local houseTier = Config.Houses[house].tier
    local shells = {
        [1] = function(coords) return exports['nc-interior']:CreateApartmentShell(coords) end,
        [2] = function(coords) return exports['nc-interior']:CreateTier1House(coords) end,
        [3] = function(coords) return exports['nc-interior']:CreateTrevorsShell(coords) end,
        [4] = function(coords) return exports['nc-interior']:CreateCaravanShell(coords) end,
        [5] = function(coords) return exports['nc-interior']:CreateLesterShell(coords) end,
        [6] = function(coords) return exports['nc-interior']:CreateRanchShell(coords) end
    }

    if not shells[houseTier] then
        QBCore.Functions.Notify('Invalid House Tier', 'error')
        return nil
    else
        return shells[houseTier](coords)
    end
end

-- If you are using paid shells the comment function above and uncomment this or grab the ones you need

-- local function getDataForHouseTier(house, coords)
--     if Config.Houses[house].tier == 1 then
--         return exports['nc-interior']:CreateApartmentShell(coords)
--     elseif Config.Houses[house].tier == 2 then
--         return exports['nc-interior']:CreateTier1House(coords)
--     elseif Config.Houses[house].tier == 3 then
--         return exports['nc-interior']:CreateTrevorsShell(coords)
--     elseif Config.Houses[house].tier == 4 then
--         return exports['nc-interior']:CreateCaravanShell(coords)
--     elseif Config.Houses[house].tier == 5 then
--         return exports['nc-interior']:CreateLesterShell(coords)
--     elseif Config.Houses[house].tier == 6 then
--         return exports['nc-interior']:CreateRanchShell(coords)
--     elseif Config.Houses[house].tier == 7 then
--         return exports['nc-interior']:CreateFranklinAunt(coords)
--     elseif Config.Houses[house].tier == 8 then
--         return exports['nc-interior']:CreateMedium2(coords)
--     elseif Config.Houses[house].tier == 9 then
--         return exports['nc-interior']:CreateMedium3(coords)
--     elseif Config.Houses[house].tier == 10 then
--         return exports['nc-interior']:CreateBanham(coords)
--     elseif Config.Houses[house].tier == 11 then
--         return exports['nc-interior']:CreateWestons(coords)
--     elseif Config.Houses[house].tier == 12 then
--         return exports['nc-interior']:CreateWestons2(coords)
--     elseif Config.Houses[house].tier == 13 then
--         return exports['nc-interior']:CreateClassicHouse(coords)
--     elseif Config.Houses[house].tier == 14 then
--         return exports['nc-interior']:CreateClassicHouse2(coords)
--     elseif Config.Houses[house].tier == 15 then
--         return exports['nc-interior']:CreateClassicHouse3(coords)
--     elseif Config.Houses[house].tier == 16 then
--         return exports['nc-interior']:CreateHighend1(coords)
--     elseif Config.Houses[house].tier == 17 then
--         return exports['nc-interior']:CreateHighend2(coords)
--     elseif Config.Houses[house].tier == 18 then
--         return exports['nc-interior']:CreateHighend3(coords)
--     elseif Config.Houses[house].tier == 19 then
--         return exports['nc-interior']:CreateHighend(coords)
--     elseif Config.Houses[house].tier == 20 then
--         return exports['nc-interior']:CreateHighendV2(coords)
--     elseif Config.Houses[house].tier == 21 then
--         return exports['nc-interior']:CreateMichael(coords)
--     elseif Config.Houses[house].tier == 22 then
--         return exports['nc-interior']:CreateStashHouse(coords)
--     elseif Config.Houses[house].tier == 23 then
--         return exports['nc-interior']:CreateStashHouse2(coords)
--     elseif Config.Houses[house].tier == 24 then
--         return exports['nc-interior']:CreateContainer(coords)
--     elseif Config.Houses[house].tier == 25 then
--         return exports['nc-interior']:CreateGarageLow(coords)
--     elseif Config.Houses[house].tier == 26 then
--         return exports['nc-interior']:CreateGarageMed(coords)
--     elseif Config.Houses[house].tier == 27 then
--         return exports['nc-interior']:CreateGarageHigh(coords)
--     elseif Config.Houses[house].tier == 28 then
--         return exports['nc-interior']:CreateOffice1(coords)
--     elseif Config.Houses[house].tier == 29 then
--         return exports['nc-interior']:CreateOffice2(coords)
--     elseif Config.Houses[house].tier == 30 then
--         return exports['nc-interior']:CreateOfficeBig(coords)
--     elseif Config.Houses[house].tier == 31 then
--         return exports['nc-interior']:CreateBarber(coords)
--     elseif Config.Houses[house].tier == 32 then
--         return exports['nc-interior']:CreateGunstore(coords)
--     elseif Config.Houses[house].tier == 33 then
--         return exports['nc-interior']:CreateStore1(coords)
--     elseif Config.Houses[house].tier == 34 then
--         return exports['nc-interior']:CreateStore2(coords)
--     elseif Config.Houses[house].tier == 35 then
--         return exports['nc-interior']:CreateStore3(coords)
--     elseif Config.Houses[house].tier == 36 then
--         return exports['nc-interior']:CreateWarehouse1(coords)
--     elseif Config.Houses[house].tier == 37 then
--         return exports['nc-interior']:CreateWarehouse2(coords)
--     elseif Config.Houses[house].tier == 38 then
--         return exports['nc-interior']:CreateWarehouse3(coords)
--     elseif Config.Houses[house].tier == 39 then
--         return exports['nc-interior']:CreateK4Coke(coords)
--     elseif Config.Houses[house].tier == 40 then
--         return exports['nc-interior']:CreateK4Meth(coords)
--     elseif Config.Houses[house].tier == 41 then
--         return exports['nc-interior']:CreateK4Weed(coords)
--     elseif Config.Houses[house].tier == 42 then
--         return exports['nc-interior']:CreateContainer2(coords)
--     elseif Config.Houses[house].tier == 43 then
--         return exports['nc-interior']:CreateFurniStash1(coords)
--     elseif Config.Houses[house].tier == 44 then
--         return exports['nc-interior']:CreateFurniStash3(coords)
--     elseif Config.Houses[house].tier == 45 then
--         return exports['nc-interior']:CreateFurniLow(coords)
--     elseif Config.Houses[house].tier == 46 then
--         return exports['nc-interior']:CreateFurniMid(coords)
--     elseif Config.Houses[house].tier == 47 then
--         return exports['nc-interior']:CreateFurniMotel(coords)
--     elseif Config.Houses[house].tier == 48 then
--         return exports['nc-interior']:CreateFurniMotelClassic(coords)
--     elseif Config.Houses[house].tier == 49 then
--         return exports['nc-interior']:CreateFurniMotelStandard(coords)
--     elseif Config.Houses[house].tier == 50 then
--         return exports['nc-interior']:CreateFurniMotelHigh(coords)
--     elseif Config.Houses[house].tier == 51 then
--         return exports['nc-interior']:CreateFurniMotelModern(coords)
--     elseif Config.Houses[house].tier == 52 then
--         return exports['nc-interior']:CreateFurniMotelModern2(coords)
--     elseif Config.Houses[house].tier == 53 then
--         return exports['nc-interior']:CreateFurniMotelModern3(coords)
--     elseif Config.Houses[house].tier == 54 then
--         return exports['nc-interior']:CreateCoke(coords)
--     elseif Config.Houses[house].tier == 55 then
--         return exports['nc-interior']:CreateCoke2(coords)
--     elseif Config.Houses[house].tier == 56 then
--         return exports['nc-interior']:CreateMeth(coords)
--     elseif Config.Houses[house].tier == 57 then
--         return exports['nc-interior']:CreateWeed(coords)
--     elseif Config.Houses[house].tier == 58 then
--         return exports['nc-interior']:CreateWeed2(coords)
--     elseif Config.Houses[house].tier == 59 then
--         return exports['nc-interior']:CreateMansion(coords)
--     elseif Config.Houses[house].tier == 60 then
--         return exports['nc-interior']:CreateMansion2(coords)
--     elseif Config.Houses[house].tier == 61 then
--         return exports['nc-interior']:CreateMansion3(coords)
--     else
--         QBCore.Functions.Notify('Invalid House Tier', 'error')
--     end
-- end

local function enterOwnedHouse(house)
    CurrentHouse = house
    TriggerServerEvent("InteractSound_SV:PlayOnSource", "houses_door_open", 0.25)
    openHouseAnim()
    IsInside = true
    Wait(250)
    local coords = { x = Config.Houses[house].coords.enter.x, y = Config.Houses[house].coords.enter.y, z= Config.Houses[house].coords.enter.z - Config.MinZOffset}
    LoadDecorations(house)
    data = getDataForHouseTier(house, coords)
    Wait(100)
    houseObj = data[1]
    POIOffsets = data[2]
    entering = true
    Wait(500)
    TriggerServerEvent('nc-houses:server:SetInsideMeta', house, true)
    TriggerEvent('nc-weathersync:client:DisableSync')
    TriggerEvent('nc-weed:client:getHousePlants', house)
    entering = false
    setHouseLocations()
    CloseMenuFull()
end

local function LeaveOwnedHouse(house)
    if not FrontCam then
        IsInside = false
        TriggerServerEvent("InteractSound_SV:PlayOnSource", "houses_door_open", 0.25)
        openHouseAnim()
        Wait(250)
        DoScreenFadeOut(250)
        Wait(500)
        exports['nc-interior']:DespawnInterior(houseObj, function()
            UnloadDecorations()
            TriggerEvent('nc-weathersync:client:EnableSync')
            Wait(250)
            DoScreenFadeIn(250)
            SetEntityCoords(PlayerPedId(), Config.Houses[CurrentHouse].coords.enter.x, Config.Houses[CurrentHouse].coords.enter.y, Config.Houses[CurrentHouse].coords.enter.z + 0.2)
            SetEntityHeading(PlayerPedId(), Config.Houses[CurrentHouse].coords.enter.h)
            TriggerEvent('nc-weed:client:leaveHouse')
            TriggerServerEvent('nc-houses:server:SetInsideMeta', house, false)
            CurrentHouse = nil
        end)
    end
end

local function enterNonOwnedHouse(house)
    CurrentHouse = house
    TriggerServerEvent("InteractSound_SV:PlayOnSource", "houses_door_open", 0.25)
    openHouseAnim()
    IsInside = true
    Wait(250)
    local coords = { x = Config.Houses[ClosestHouse].coords.enter.x, y = Config.Houses[ClosestHouse].coords.enter.y, z= Config.Houses[ClosestHouse].coords.enter.z - Config.MinZOffset}
    LoadDecorations(house)
    data = getDataForHouseTier(house, coords)
    houseObj = data[1]
    POIOffsets = data[2]
    entering = true
    Wait(500)
    TriggerServerEvent('nc-houses:server:SetInsideMeta', house, true)
    TriggerEvent('nc-weathersync:client:DisableSync')
    TriggerEvent('nc-weed:client:getHousePlants', house)
    entering = false
    InOwnedHouse = true
    setHouseLocations()
end

-- Is there a purpose to this?
local function LeaveNonOwnedHouse(house)
    if not FrontCam then
        IsInside = false
        TriggerServerEvent("InteractSound_SV:PlayOnSource", "houses_door_open", 0.25)
        openHouseAnim()
        Wait(250)
        DoScreenFadeOut(250)
        Wait(500)
        exports['nc-interior']:DespawnInterior(houseObj, function()
            UnloadDecorations()
            TriggerEvent('nc-weathersync:client:EnableSync')
            Wait(250)
            DoScreenFadeIn(250)
            SetEntityCoords(PlayerPedId(), Config.Houses[CurrentHouse].coords.enter.x, Config.Houses[CurrentHouse].coords.enter.y, Config.Houses[CurrentHouse].coords.enter.z + 0.2)
            SetEntityHeading(PlayerPedId(), Config.Houses[CurrentHouse].coords.enter.h)
            InOwnedHouse = false
            TriggerEvent('nc-weed:client:leaveHouse')
            TriggerServerEvent('nc-houses:server:SetInsideMeta', house, false)
            CurrentHouse = nil
        end)
    end
end

-- Events

RegisterNetEvent('nc-houses:server:sethousedecorations', function(house, decorations)
	Config.Houses[house].decorations = decorations
	if IsInside and ClosestHouse == house then
		LoadDecorations(house)
	end
end)

RegisterNetEvent('nc-houses:client:sellHouse', function()
    if ClosestHouse and HasKey then
        TriggerServerEvent('nc-houses:server:viewHouse', ClosestHouse)
    end
end)

RegisterNetEvent('nc-houses:client:EnterHouse', function()
    local ped = PlayerPedId()
    local pos = GetEntityCoords(ped)

    if ClosestHouse ~= nil then
        local dist = #(pos - vector3(Config.Houses[ClosestHouse].coords.enter.x, Config.Houses[ClosestHouse].coords.enter.y, Config.Houses[ClosestHouse].coords.enter.z))
        if dist <= 1.5 then
            if HasKey then
                enterOwnedHouse(ClosestHouse)
            else
                if not Config.Houses[ClosestHouse].locked then
                    enterNonOwnedHouse(ClosestHouse)
                end
            end
        end
    end
end)

RegisterNetEvent('nc-houses:client:RequestRing', function()
    if ClosestHouse ~= nil then
        TriggerServerEvent('nc-houses:server:RingDoor', ClosestHouse)
    end
end)

AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    TriggerServerEvent('nc-houses:client:setHouses')
    SetClosestHouse()
    TriggerEvent('nc-houses:client:setupHouseBlips')
    if Config.UnownedBlips then TriggerEvent('nc-houses:client:setupHouseBlips2') end
    Wait(100)
    TriggerEvent('nc-garages:client:setHouseGarage', ClosestHouse, HasKey)
    TriggerServerEvent("nc-houses:server:setHouses")
end)

RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
    IsInside = false
    ClosestHouse = nil
    HasKey = false
    isOwned = false
    for k, v in pairs(OwnedHouseBlips) do
        RemoveBlip(v)
    end
    if Config.UnownedBlips then
        for k,v in pairs(UnownedHouseBlips) do
            RemoveBlip(v)
        end
    end
end)

RegisterNetEvent('nc-houses:client:setHouseConfig', function(houseConfig)
    Config.Houses = houseConfig
end)

RegisterNetEvent('nc-houses:client:lockHouse', function(bool, house)
    Config.Houses[house].locked = bool
end)

RegisterNetEvent('nc-houses:client:createHouses', function(price, tier)
    local pos = GetEntityCoords(PlayerPedId())
    local heading = GetEntityHeading(PlayerPedId())
	local s1, s2 = GetStreetNameAtCoord(pos.x, pos.y, pos.z)
    local street = GetStreetNameFromHashKey(s1)
    local coords = {
        enter 	= { x = pos.x, y = pos.y, z = pos.z, h = heading},
        cam 	= { x = pos.x, y = pos.y, z = pos.z, h = heading, yaw = -10.00},
    }
    street = street:gsub("%-", " ")
    TriggerServerEvent('nc-houses:server:addNewHouse', street, coords, price, tier)
    if Config.UnownedBlips then TriggerServerEvent('nc-houses:server:createBlip') end
end)

RegisterNetEvent('nc-houses:client:addGarage', function()
    if ClosestHouse ~= nil then
        local pos = GetEntityCoords(PlayerPedId())
        local heading = GetEntityHeading(PlayerPedId())
        local coords = {
            x = pos.x,
            y = pos.y,
            z = pos.z,
            h = heading,
        }
        TriggerServerEvent('nc-houses:server:addGarage', ClosestHouse, coords)
    else
        QBCore.Functions.Notify("No house around..", "error")
    end
end)

RegisterNetEvent('nc-houses:client:toggleDoorlock', function()
    local pos = GetEntityCoords(PlayerPedId())
    local dist = #(pos - vector3(Config.Houses[ClosestHouse].coords.enter.x, Config.Houses[ClosestHouse].coords.enter.y, Config.Houses[ClosestHouse].coords.enter.z))
    if dist <= 1.5 then
        if HasKey then
            if Config.Houses[ClosestHouse].locked then
                TriggerServerEvent('nc-houses:server:lockHouse', false, ClosestHouse)
                QBCore.Functions.Notify("House is unlocked!", "success", 2500)
            else
                TriggerServerEvent('nc-houses:server:lockHouse', true, ClosestHouse)
                QBCore.Functions.Notify("House is locked!", "error", 2500)
            end
        else
            QBCore.Functions.Notify("You don't have the keys of the house...", "error", 3500)
        end
    else
        QBCore.Functions.Notify("There is no door nearby", "error", 3500)
    end
end)

RegisterNetEvent('nc-houses:client:RingDoor', function(player, house)
    if ClosestHouse == house and IsInside then
        CurrentDoorBell = player
        TriggerServerEvent("InteractSound_SV:PlayOnSource", "doorbell", 0.1)
        QBCore.Functions.Notify("Someone is ringing the door!")
    end
end)

RegisterNetEvent('nc-houses:client:giveHouseKey', function()
    local player, distance = GetClosestPlayer()
    if player ~= -1 and distance < 2.5 and ClosestHouse ~= nil then
        local playerId = GetPlayerServerId(player)
        local pedpos = GetEntityCoords(PlayerPedId())
        local housedist = #(pedpos - vector3(Config.Houses[ClosestHouse].coords.enter.x, Config.Houses[ClosestHouse].coords.enter.y, Config.Houses[ClosestHouse].coords.enter.z))
        if housedist < 10 then
            TriggerServerEvent('nc-houses:server:giveHouseKey', playerId, ClosestHouse)
        else
            QBCore.Functions.Notify("You're not close enough to the door..", "error")
        end
    elseif ClosestHouse == nil then
        QBCore.Functions.Notify("There is no house near you", "error")
    else
        QBCore.Functions.Notify("No one around!", "error")
    end
end)

RegisterNetEvent('nc-houses:client:removeHouseKey', function()
    if ClosestHouse ~= nil then
        local pedpos = GetEntityCoords(PlayerPedId())
        local housedist = #(pedpos - vector3(Config.Houses[ClosestHouse].coords.enter.x, Config.Houses[ClosestHouse].coords.enter.y, Config.Houses[ClosestHouse].coords.enter.z))
        if housedist <= 5 then
            QBCore.Functions.TriggerCallback('nc-houses:server:getHouseOwner', function(result)
                if QBCore.Functions.GetPlayerData().citizenid == result then
                    HouseKeysMenu()
                else
                    QBCore.Functions.Notify("You're not a house owner..", "error")
                end
            end, ClosestHouse)
        else
            QBCore.Functions.Notify("You're not close enough to the door..", "error")
        end
    else
        QBCore.Functions.Notify("You're not close enough to the door..", "error")
    end
end)

RegisterNetEvent('nc-houses:client:RevokeKey', function(data)
    RemoveHouseKey(data.citizenData)
end)

RegisterNetEvent('nc-houses:client:refreshHouse', function(data)
    Wait(100)
    SetClosestHouse()
end)

RegisterNetEvent('nc-houses:client:SpawnInApartment', function(house)
    local pos = GetEntityCoords(PlayerPedId())
    if rangDoorbell ~= nil then
        if #(pos - vector3(Config.Houses[house].coords.enter.x, Config.Houses[house].coords.enter.y, Config.Houses[house].coords.enter.z)) > 5 then
            return
        end
    end
    ClosestHouse = house
    enterNonOwnedHouse(house)
end)

RegisterNetEvent('nc-houses:client:enterOwnedHouse', function(house)
    QBCore.Functions.GetPlayerData(function(PlayerData)
		if PlayerData.metadata["injail"] == 0 then
			enterOwnedHouse(house)
		end
	end)
end)

RegisterNetEvent('nc-houses:client:LastLocationHouse', function(houseId)
    QBCore.Functions.GetPlayerData(function(PlayerData)
		if PlayerData.metadata["injail"] == 0 then
			enterOwnedHouse(houseId)
		end
	end)
end)

RegisterNetEvent('nc-houses:client:setupHouseBlips', function() -- Setup owned on load
    CreateThread(function()
        Wait(2000)
        if LocalPlayer.state['isLoggedIn'] then
            QBCore.Functions.TriggerCallback('nc-houses:server:getOwnedHouses', function(ownedHouses)
                if ownedHouses then
                    for k, v in pairs(ownedHouses) do
                        local house = Config.Houses[ownedHouses[k]]
                        HouseBlip = AddBlipForCoord(house.coords.enter.x, house.coords.enter.y, house.coords.enter.z)
                        SetBlipSprite (HouseBlip, 40)
                        SetBlipDisplay(HouseBlip, 4)
                        SetBlipScale  (HouseBlip, 0.65)
                        SetBlipAsShortRange(HouseBlip, true)
                        SetBlipColour(HouseBlip, 3)
                        AddTextEntry('OwnedHouse', house.adress)
                        BeginTextCommandSetBlipName('OwnedHouse')
                        EndTextCommandSetBlipName(HouseBlip)
                        OwnedHouseBlips[#OwnedHouseBlips+1] = HouseBlip
                    end
                end
            end)
        end
    end)
end)

RegisterNetEvent('nc-houses:client:setupHouseBlips2', function() -- Setup unowned on load
    for k,v in pairs(Config.Houses) do
        if not v.owned then
            HouseBlip2 = AddBlipForCoord(v.coords.enter.x, v.coords.enter.y, v.coords.enter.z)
            SetBlipSprite (HouseBlip2, 40)
            SetBlipDisplay(HouseBlip2, 4)
            SetBlipScale  (HouseBlip2, 0.65)
            SetBlipAsShortRange(HouseBlip2, true)
            SetBlipColour(HouseBlip2, 3)
            AddTextEntry('UnownedHouse', 'House For Sale')
            BeginTextCommandSetBlipName('UnownedHouse')
            EndTextCommandSetBlipName(HouseBlip2)
            UnownedHouseBlips[#UnownedHouseBlips+1] = HouseBlip2
        end
    end
end)

RegisterNetEvent('nc-houses:client:createBlip', function(coords) -- Create unowned on command
    NewHouseBlip = AddBlipForCoord(coords.x, coords.y, coords.z)
    SetBlipSprite (NewHouseBlip, 40)
    SetBlipDisplay(NewHouseBlip, 4)
    SetBlipScale  (NewHouseBlip, 0.65)
    SetBlipAsShortRange(NewHouseBlip, true)
    SetBlipColour(NewHouseBlip, 3)
    AddTextEntry('NewHouseBlip', 'House For Sale')
    BeginTextCommandSetBlipName('NewHouseBlip')
    EndTextCommandSetBlipName(NewHouseBlip)
    UnownedHouseBlips[#UnownedHouseBlips+1] = NewHouseBlip
end)

RegisterNetEvent('nc-houses:client:refreshBlips', function() -- Refresh unowned on buy
    for k,v in pairs(UnownedHouseBlips) do RemoveBlip(v) end
    Wait(250)
    TriggerEvent('nc-houses:client:setupHouseBlips2')
end)

RegisterNetEvent('nc-houses:client:SetClosestHouse', function()
    SetClosestHouse()
end)

RegisterNetEvent('nc-houses:client:viewHouse', function(houseprice, brokerfee, bankfee, taxes, firstname, lastname)
    setViewCam(Config.Houses[ClosestHouse].coords.cam, Config.Houses[ClosestHouse].coords.cam.h, Config.Houses[ClosestHouse].coords.yaw)
    Wait(500)
    openContract(true)
    SendNUIMessage({
        type = "setupContract",
        firstname = firstname,
        lastname = lastname,
        street = Config.Houses[ClosestHouse].adress,
        houseprice = houseprice,
        brokerfee = brokerfee,
        bankfee = bankfee,
        taxes = taxes,
        totalprice = (houseprice + brokerfee + bankfee + taxes)
    })
end)

RegisterNetEvent('nc-houses:client:setStash', function(data)
    local ped = PlayerPedId()
    local pos = GetEntityCoords(ped)
    local coords = {x = pos.x, y = pos.y, z = pos.z}
    if IsInside then
        if HasKey then
                TriggerServerEvent('nc-houses:server:setLocation', coords, ClosestHouse, 1)
        else
            QBCore.Functions.Notify('You do not own this house', 'error')
        end
    else
        QBCore.Functions.Notify('You are not in a house', 'error')
    end
end)

RegisterNetEvent('nc-houses:client:setOutfit', function(data)
    local ped = PlayerPedId()
    local pos = GetEntityCoords(ped)
    local coords = {x = pos.x, y = pos.y, z = pos.z}
    if IsInside then
        if HasKey then
                TriggerServerEvent('nc-houses:server:setLocation', coords, ClosestHouse, 2)
        else
            QBCore.Functions.Notify('You do not own this house', 'error')
        end
    else
        QBCore.Functions.Notify('You are not in a house', 'error')
    end
end)

RegisterNetEvent('nc-houses:client:setLogout ', function(data)
    local ped = PlayerPedId()
    local pos = GetEntityCoords(ped)
    local coords = {x = pos.x, y = pos.y, z = pos.z}
    if IsInside then
        if HasKey then
                TriggerServerEvent('nc-houses:server:setLocation', coords, ClosestHouse, 3)
        else
            QBCore.Functions.Notify('You do not own this house', 'error')
        end
    else
        QBCore.Functions.Notify('You are not in a house', 'error')
    end
end)

RegisterNetEvent('nc-houses:client:refreshLocations', function(house, location, type)
    if ClosestHouse == house then
        if IsInside then
            if type == 1 then
                stashLocation = json.decode(location)
            elseif type == 2 then
                outfitLocation = json.decode(location)
            elseif type == 3 then
                logoutLocation = json.decode(location)
            end
        end
    end
end)

RegisterNetEvent('nc-houses:client:HomeInvasion', function()
    local ped = PlayerPedId()
    local pos = GetEntityCoords(ped)
    local Skillbar = exports['nc-skillbar']:GetSkillbarObject()
    if ClosestHouse ~= nil then
        QBCore.Functions.TriggerCallback('police:server:IsPoliceForcePresent', function(IsPresent)
            if IsPresent then
                local dist = #(pos - vector3(Config.Houses[ClosestHouse].coords.enter.x, Config.Houses[ClosestHouse].coords.enter.y, Config.Houses[ClosestHouse].coords.enter.z))
                if Config.Houses[ClosestHouse].IsRaming == nil then
                    Config.Houses[ClosestHouse].IsRaming = false
                end
                if dist < 1 then
                    if Config.Houses[ClosestHouse].locked then
                        if not Config.Houses[ClosestHouse].IsRaming then
                            DoRamAnimation(true)
                            Skillbar.Start({
                                duration = math.random(5000, 10000),
                                pos = math.random(10, 30),
                                width = math.random(10, 20),
                            }, function()
                                if RamsDone + 1 >= Config.RamsNeeded then
                                    TriggerServerEvent('nc-houses:server:lockHouse', false, ClosestHouse)
                                    QBCore.Functions.Notify('It worked the door is now out.', 'success')
                                    TriggerServerEvent('nc-houses:server:SetHouseRammed', true, ClosestHouse)
                                    DoRamAnimation(false)
                                else
                                    DoRamAnimation(true)
                                    Skillbar.Repeat({
                                        duration = math.random(500, 1000),
                                        pos = math.random(10, 30),
                                        width = math.random(5, 12),
                                    })
                                    RamsDone = RamsDone + 1
                                end
                            end, function()
                                RamsDone = 0
                                TriggerServerEvent('nc-houses:server:SetRamState', false, ClosestHouse)
                                QBCore.Functions.Notify('It failed try again.', 'error')
                                DoRamAnimation(false)
                            end)
                            TriggerServerEvent('nc-houses:server:SetRamState', true, ClosestHouse)
                        else
                            QBCore.Functions.Notify('Someone is already working on the door..', 'error')
                        end
                    else
                        QBCore.Functions.Notify('19/5000 This house is already open..', 'error')
                    end
                else
                    QBCore.Functions.Notify('You\'re not near a house..', 'error')
                end
            else
                QBCore.Functions.Notify('There is no police force present..', 'error')
            end
        end)
    else
        QBCore.Functions.Notify('You\'re not near a house..', 'error')
    end
end)

RegisterNetEvent('nc-houses:client:SetRamState', function(bool, house)
    Config.Houses[house].IsRaming = bool
end)

RegisterNetEvent('nc-houses:client:SetHouseRammed', function(bool, house)
    Config.Houses[house].IsRammed = bool
end)

RegisterNetEvent('nc-houses:client:ResetHouse', function()
    if ClosestHouse ~= nil then
        if Config.Houses[ClosestHouse].IsRammed == nil then
            Config.Houses[ClosestHouse].IsRammed = false
            TriggerServerEvent('nc-houses:server:SetHouseRammed', false, ClosestHouse)
            TriggerServerEvent('nc-houses:server:SetRamState', false, ClosestHouse)
        end
        if Config.Houses[ClosestHouse].IsRammed then
            openHouseAnim()
            TriggerServerEvent('nc-houses:server:SetHouseRammed', false, ClosestHouse)
            TriggerServerEvent('nc-houses:server:SetRamState', false, ClosestHouse)
            TriggerServerEvent('nc-houses:server:lockHouse', true, ClosestHouse)
            RamsDone = 0
            QBCore.Functions.Notify('You locked the house again..', 'success')
        else
            QBCore.Functions.Notify('This door is not broken open ..', 'error')
        end
    end
end)

RegisterNetEvent('nc-houses:client:ExitOwnedHouse', function()
    local door = vector3(Config.Houses[CurrentHouse].coords.enter.x + POIOffsets.exit.x, Config.Houses[CurrentHouse].coords.enter.y + POIOffsets.exit.y, Config.Houses[CurrentHouse].coords.enter.z - Config.MinZOffset + POIOffsets.exit.z)
    if CheckDistance(door, 1.5) then
        LeaveOwnedHouse(CurrentHouse)
    end
end)

RegisterNetEvent('nc-houses:client:FrontDoorCam', function()
    local door = vector3(Config.Houses[CurrentHouse].coords.enter.x + POIOffsets.exit.x, Config.Houses[CurrentHouse].coords.enter.y + POIOffsets.exit.y, Config.Houses[CurrentHouse].coords.enter.z - Config.MinZOffset + POIOffsets.exit.z)
    if CheckDistance(door, 1.5) then
        FrontDoorCam(Config.Houses[CurrentHouse].coords.enter)
    end
end)

RegisterNetEvent('nc-houses:client:AnswerDoorbell', function()
    local door = vector3(Config.Houses[CurrentHouse].coords.enter.x + POIOffsets.exit.x, Config.Houses[CurrentHouse].coords.enter.y + POIOffsets.exit.y, Config.Houses[CurrentHouse].coords.enter.z - Config.MinZOffset + POIOffsets.exit.z)
    if CheckDistance(door, 1.5) and CurrentDoorBell ~= 0 then
        TriggerServerEvent("nc-houses:server:OpenDoor", CurrentDoorBell, ClosestHouse)
        CurrentDoorBell = 0
    end
end)

RegisterNetEvent('nc-houses:client:OpenStash', function()
    local stashLoc = vector3(stashLocation.x, stashLocation.y, stashLocation.z)
    if CheckDistance(stashLoc, 1.5) then
        TriggerServerEvent("inventory:server:OpenInventory", "stash", CurrentHouse)
        TriggerServerEvent("InteractSound_SV:PlayOnSource", "StashOpen", 0.4)
        TriggerEvent("inventory:client:SetCurrentStash", CurrentHouse)
    end
end)

RegisterNetEvent('nc-houses:client:ChangeCharacter', function()
    local stashLoc = vector3(logoutLocation.x, logoutLocation.y, logoutLocation.z)
    if CheckDistance(stashLoc, 1.5) then
        DoScreenFadeOut(250)
        while not IsScreenFadedOut() do
            Wait(10)
        end
        exports['nc-interior']:DespawnInterior(houseObj, function()
            TriggerEvent('nc-weathersync:client:EnableSync')
            SetEntityCoords(PlayerPedId(), Config.Houses[CurrentHouse].coords.enter.x, Config.Houses[CurrentHouse].coords.enter.y, Config.Houses[CurrentHouse].coords.enter.z + 0.5)
            SetEntityHeading(PlayerPedId(), Config.Houses[CurrentHouse].coords.enter.h)
            InOwnedHouse = false
            IsInside = false
            TriggerServerEvent('nc-houses:server:LogoutLocation')
        end)
    end
end)

RegisterNetEvent('nc-houses:client:ChangeOutfit', function()
    local outfitLoc = vector3(outfitLocation.x, outfitLocation.y, outfitLocation.z)
    if CheckDistance(outfitLoc, 1.5) then
        TriggerServerEvent("InteractSound_SV:PlayOnSource", "Clothes1", 0.4)
        TriggerEvent('fivem-appearance:outfitsMenu')
    end
end)

RegisterNetEvent('nc-houses:client:ViewHouse', function()
    local houseCoords = vector3(Config.Houses[ClosestHouse].coords.enter.x, Config.Houses[ClosestHouse].coords.enter.y, Config.Houses[ClosestHouse].coords.enter.z)
    if CheckDistance(houseCoords, 1.5) then
        TriggerServerEvent('nc-houses:server:viewHouse', ClosestHouse)
    end
end)

RegisterNetEvent('nc-houses:client:KeyholderOptions', function(data)
    optionMenu(data.citizenData)
end)
-- NUI Callbacks

RegisterNUICallback('HasEnoughMoney', function(data, cb)
    QBCore.Functions.TriggerCallback('nc-houses:server:HasEnoughMoney', function(hasEnough)
    end, data.objectData)
end)

RegisterNUICallback('buy', function()
    openContract(false)
    disableViewCam()
    Config.Houses[ClosestHouse].owned = true
    if Config.UnownedBlips then TriggerEvent('nc-houses:client:refreshBlips') end
    TriggerServerEvent('nc-houses:server:buyHouse', ClosestHouse)
end)

RegisterNUICallback('exit', function()
    openContract(false)
    disableViewCam()
end)

-- Threads

CreateThread(function()
    Wait(1000)
    TriggerServerEvent('nc-houses:client:setHouses')
    SetClosestHouse()
    TriggerEvent('nc-houses:client:setupHouseBlips')
    if Config.UnownedBlips then TriggerEvent('nc-houses:client:setupHouseBlips2') end
    Wait(100)
    TriggerEvent('nc-garages:client:setHouseGarage', ClosestHouse, HasKey)
    TriggerServerEvent("nc-houses:server:setHouses")
end)

CreateThread(function()
    while true do
        Wait(5000)
        if LocalPlayer.state['isLoggedIn'] then
            if not IsInside then
                SetClosestHouse()
            end
        end
    end
end)

-----/ STASH
if inside then
    if CurrentHouse ~= nil then
        if stashLocation ~= nil then
            if #(pos - vector3(stashLocation.x, stashLocation.y, stashLocation.z)) < 1.5 then
                DrawText3Ds(stashLocation.x, stashLocation.y, stashLocation.z, '~g~[E]~w~ - Stash')
                if IsControlJustPressed(0, 38) then -- E
                    local other = {}
                    if Config.Houses[CurrentHouse].tier == 2 then -- CreateMichaelShell
                        other.maxweight = 2400000
                        other.slots = 60
                    elseif Config.Houses[CurrentHouse].tier == 3 then -- CreateApartmentShell
                        other.maxweight = 150000
                        other.slots = 60
                    elseif Config.Houses[CurrentHouse].tier == 4 then -- CreateCaravanShell
                        other.maxweight = 1000000
                        other.slots = 60
                    elseif Config.Houses[CurrentHouse].tier == 5 then -- CreateFranklinShell
                        other.maxweight = 2400000
                        other.slots = 60
                    elseif Config.Houses[CurrentHouse].tier == 6 then -- CreateFranklinAuntShell
                        other.maxweight = 1800000
                        other.slots = 60
                    elseif Config.Houses[CurrentHouse].tier == 7 then -- CreateTrevorsShell
                        other.maxweight = 1800000
                        other.slots = 60
                    else
                        other.maxweight = 1800000 -- tier 1 house
                        other.slots = 60
                    end
                    TriggerServerEvent("inventory:server:OpenInventory", "stash", CurrentHouse, other)
                    TriggerEvent("inventory:client:SetCurrentStash", CurrentHouse)
                end
            elseif #(pos - vector3(stashLocation.x, stashLocation.y, stashLocation.z)) < 3 then
                DrawText3Ds(stashLocation.x, stashLocation.y, stashLocation.z, 'Stash')
            end
        end
    end
end

---

CreateThread(function()
    local shownMenu = false

    while true do
        local pos = GetEntityCoords(PlayerPedId())
        local inRange = false
        local nearLocation = false
        local houseMenu = {}

        if ClosestHouse ~= nil then
            local dist2 = vector3(Config.Houses[ClosestHouse].coords.enter.x, Config.Houses[ClosestHouse].coords.enter.y, Config.Houses[ClosestHouse].coords.enter.z)
            if #(pos.xy - dist2.xy) < 30 then
                inRange = true
                if HasKey then
                    -- ENTER HOUSE

                    if not IsInside then
                        if ClosestHouse ~= nil then
                            if #(pos - dist2) <= 1.5 then
                                houseMenu = {
                                    {
                                        header = "Enter house",
                                        params = {
                                            event = 'nc-houses:client:enterOwnedHouse',
                                            args = ClosestHouse
                                        }
                                    }
                                }
                                nearLocation = true
                            end
                        end
                    else
                        if not entering and POIOffsets ~= nil then
                            local exitOffset = vector3(Config.Houses[CurrentHouse].coords.enter.x + POIOffsets.exit.x, Config.Houses[CurrentHouse].coords.enter.y + POIOffsets.exit.y, Config.Houses[CurrentHouse].coords.enter.z - Config.MinZOffset + POIOffsets.exit.z + 1.0)
                            if #(pos - exitOffset) <= 1.5 then
                                houseMenu = {
                                    {
                                        header = "Exit Property",
                                        params = {
                                            event = 'nc-houses:client:ExitOwnedHouse',
                                            args = {}
                                        }
                                    },
                                    {
                                        header = "Front Camera",
                                        params = {
                                            event = 'nc-houses:client:FrontDoorCam',
                                            args = {}
                                        }
                                    }
                                }

                                if CurrentDoorBell ~= 0 then
                                    houseMenu[#houseMenu+1] = {
                                        header = 'Open Door',
                                        params = {
                                            event = 'nc-houses:client:AnswerDoorbell',
                                            args = {}
                                        }
                                    }
                                end
                                nearLocation = true
                            end
                        end
                    end
                else

                    if ClosestHouse ~= nil and not IsInside  then
                        if not isOwned then
                            local houseCoords = vector3(Config.Houses[ClosestHouse].coords.enter.x, Config.Houses[ClosestHouse].coords.enter.y, Config.Houses[ClosestHouse].coords.enter.z)
                            if #(pos - houseCoords) <= 1.5 then
                                if not viewCam and Config.Houses[ClosestHouse].locked then
                                    houseMenu = {
                                        {
                                            header = "View House",
                                            params = {
                                                event = 'nc-houses:client:ViewHouse',
                                                args = {}
                                            }
                                        }
                                    }
                                    nearLocation = true
                                end
                            end
                        end

                        if isOwned then
                            local houseCoords = vector3(Config.Houses[ClosestHouse].coords.enter.x, Config.Houses[ClosestHouse].coords.enter.y, Config.Houses[ClosestHouse].coords.enter.z)
                            if #(pos - houseCoords) <= 1.5 then
                                nearLocation = true
                                houseMenu = {
                                    {
                                        header = "Ring Doorbell",
                                        params = {
                                            event = 'nc-houses:client:RequestRing',
                                            args = {}
                                        }
                                    }
                                }
                            end
                        end
                    end
                end

                if IsInside and CurrentHouse ~= nil and not entering and isOwned then
                    if stashLocation ~= nil then
                        if #(pos - vector3(stashLocation.x, stashLocation.y, stashLocation.z)) <= 1.5 then
                            nearLocation = true
                            houseMenu = {
                                {
                                    header = "Open Stash",
                                    params = {
                                        event = "nc-houses:client:OpenStash",
                                        args = {}
                                    }
                                }
                            }

                        elseif #(pos - vector3(stashLocation.x, stashLocation.y, stashLocation.z)) <= 3 then
                            DrawText3Ds(stashLocation.x, stashLocation.y, stashLocation.z, 'Stash')
                        end
                    end

                    if outfitLocation ~= nil then
                        if #(pos - vector3(outfitLocation.x, outfitLocation.y, outfitLocation.z)) <= 1.5 then
                            nearLocation = true
                            houseMenu = {
                                {
                                    header = "Change Outfit",
                                    params = {
                                        event = "nc-houses:client:ChangeOutfit",
                                        args = {}
                                    }
                                }
                            }
                        elseif #(pos - vector3(outfitLocation.x, outfitLocation.y, outfitLocation.z)) <= 3 then
                            DrawText3Ds(outfitLocation.x, outfitLocation.y, outfitLocation.z, 'Outfits')
                        end
                    end

                    if logoutLocation ~= nil then
                        if #(pos - vector3(logoutLocation.x, logoutLocation.y, logoutLocation.z)) <= 1.5 then
                            nearLocation = true
                            houseMenu = {
                                {
                                    header = "Change Characters",
                                    params = {
                                        event = "nc-houses:client:ChangeCharacter",
                                        args = {}
                                    }
                                }
                            }
                        elseif #(pos - vector3(logoutLocation.x, logoutLocation.y, logoutLocation.z)) < 3 then
                            DrawText3Ds(logoutLocation.x, logoutLocation.y, logoutLocation.z, 'Change Characters')
                        end
                    end
                end

                if nearLocation and not shownMenu then
                    exports['qb-menu']:showHeader(houseMenu)
                    shownMenu = true
                end

                if not nearLocation and shownMenu then
                    CloseMenuFull()
                    shownMenu = false
                end
            end
        end

        if not inRange then
            Wait(1500)

            if shownMenu then
                CloseMenuFull()
                shownMenu = false
            end
        end
        Wait(3)
    end
end)

RegisterCommand('getoffset', function()
    local coords = GetEntityCoords(PlayerPedId())
    local houseCoords = vector3(
        Config.Houses[CurrentHouse].coords.enter.x,
        Config.Houses[CurrentHouse].coords.enter.y,
        Config.Houses[CurrentHouse].coords.enter.z - Config.MinZOffset
    )
    if IsInside then
        local xdist = coords.x - houseCoords.x
        local ydist = coords.y - houseCoords.y
        local zdist = coords.z - houseCoords.z
        print('X: '..xdist)
        print('Y: '..ydist)
        print('Z: '..zdist)
    end
end)

RegisterNetEvent('nc-houses:client:deletehouses', function(selectedHouse)
    Config.Houses[selectedHouse.name] = nil
    SetClosestHouse()
end)