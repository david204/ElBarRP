QBCore = exports['qb-core']:GetCoreObject()

local LastZone = nil
local CurrentAction = nil
local CurrentActionMsg = ''
local hasAlreadyEnteredMarker = false
local allMyOutfits = {}
local isPurchaseSuccessful = false
local PlayerData = {}

-- Net Events

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    QBCore.Functions.TriggerCallback('fivem-appearance:getPlayerSkin', function(appearance)
		exports['fivem-appearance']:setPlayerAppearance(appearance)
		PlayerData = QBCore.Functions.GetPlayerData()
		
		if Config.Debug then  -- This will detect if the player model is set as "player_zero" aka michael. Will then set the character as a freemode ped based on gender.
			Wait(5000)
			if GetEntityModel(PlayerPedId()) == `player_zero` then
				print('Player detected as "player_zero", Starting CreateFirstCharacter event')
				TriggerEvent('qb-clothes:client:CreateFirstCharacter')
			end
		end
		
	end)
end)

RegisterNetEvent('fivem-appearance:CreateFirstCharacter', function()
	local config = {
		ped = true,
		headBlend = true,
		faceFeatures = true,
		headOverlays = true,
		components = true,
		props = true
	}

	exports['fivem-appearance']:setPlayerAppearance(pedAppearance)

	exports['fivem-appearance']:startPlayerCustomization(function(pedAppearance)
		local pedModel = GetEntityModel(PlayerPedId())
	    TriggerServerEvent("fivem-appearance:saveSkin", pedModel, pedAppearance)
		print('Saved')
		TriggerEvent("backitems:displayItems", true)
	end, config)
end, false)

AddEventHandler('fivem-appearance:hasExitedMarker', function(zone)
	CurrentAction = nil
end)

RegisterNetEvent('fivem-appearance:clothingShop', function()
    TriggerEvent('qb-menu:sendMenu', {
        {
            id = 1,
            header = "Change clothing",
            txt = "",
			params = {
				event = "fivem-appearance:clothingMenu"
			}
        },
        {
            id = 2,
            header = "Change Outfit",
            txt = "",
            params = {
                event = "fivem-appearance:pickNewOutfit",
                args = {
                    number = 1,
                    id = 2
                }
            }
        },
		{
            id = 3,
            header = "Save New Outfit",
            txt = "",
			params = {
				event = "fivem-appearance:saveOutfit"
			}
        },
		{
			id = 4,
            header = "Delete Outfit",
            txt = "",
            params = {
                event = "fivem-appearance:deleteOutfitMenu",
                args = {
                    number = 1,
                    id = 2
                }
            }
        }
    })
end)

RegisterNetEvent('fivem-appearance:getOutfits', function()
	TriggerServerEvent('fivem-appearance:getOutfits')
end)

RegisterNetEvent('fivem-appearance:sendOutfits', function(myOutfits)
	local Outfits = {}
	for i=1, #myOutfits, 1 do
		table.insert(Outfits, {id = myOutfits[i].id, name = myOutfits[i].name, pedModel = myOutfits[i].ped, pedComponents = myOutfits[i].components, pedProps = myOutfits[i].props})
	end
	allMyOutfits = Outfits
end)

RegisterNetEvent('fivem-appearance:setOutfit', function(data)
	local pedModel = data.ped
	local pedComponents = data.components
	local pedProps = data.props
	local playerPed = PlayerPedId()
	local currentPedModel = exports['fivem-appearance']:getPedModel(playerPed)
	if currentPedModel ~= pedModel then
    	exports['fivem-appearance']:setPlayerModel(pedModel)
		Wait(500)
		playerPed = PlayerPedId()
		exports['fivem-appearance']:setPedComponents(playerPed, pedComponents)
		exports['fivem-appearance']:setPedProps(playerPed, pedProps)
		local appearance = exports['fivem-appearance']:getPedAppearance(playerPed)
		TriggerServerEvent('fivem-appearance:save', appearance)
	else
		exports['fivem-appearance']:setPedComponents(playerPed, pedComponents)
		exports['fivem-appearance']:setPedProps(playerPed, pedProps)
		local appearance = exports['fivem-appearance']:getPedAppearance(playerPed)
		TriggerServerEvent('fivem-appearance:save', appearance)
	end
end)

RegisterNetEvent('fivem-appearance:saveOutfit', function()
	local keyboard = exports['qb-input']:ShowInput({
        header = "Name your outfit",
        submitText = "Create Outfit",
        inputs = {
            {
                text = "Outfit Name", -- text you want to be displayed as a place holder
                name = "input", -- name of the input should be unique otherwise it might override
                type = "text", -- type of the input
                isRequired = true -- Optional [accepted values: true | false] but will not submit the form if no value is inputted
            },
        },
    })

	if keyboard ~= nil then
		local playerPed = PlayerPedId()
		local pedModel = exports['fivem-appearance']:getPedModel(playerPed)
		local pedComponents = exports['fivem-appearance']:getPedComponents(playerPed)
		local pedProps = exports['fivem-appearance']:getPedProps(playerPed)
		Wait(500)
		TriggerServerEvent('fivem-appearance:saveOutfit', keyboard.input, pedModel, pedComponents, pedProps)
		QBCore.Functions.Notify('Outfit '..keyboard.input.. ' has been saved', 'success')
	end
end)

RegisterNetEvent('fivem-appearance:deleteOutfitMenu', function(data)
    local id = data.id
    local number = data.number
	TriggerEvent('fivem-appearance:getOutfits')
	Wait(150)
	local DeleteMenu = {
        {
            header = '< Go Back',
            params = {
                event = ''
            }
        }
    }
    for i=1, #allMyOutfits, 1 do
        DeleteMenu[#DeleteMenu + 1] = {
            header = 'Delete "'..allMyOutfits[i].name..'"',
			txt = 'You will never be able to get this back!',
            params = {
				event = 'fivem-appearance:deleteOutfit',
				args = allMyOutfits[i].id
			}
        }
    end
    exports['qb-menu']:openMenu(DeleteMenu)
end)

RegisterNetEvent('fivem-appearance:deleteOutfit', function(id)
	TriggerServerEvent('fivem-appearance:deleteOutfit', id)
	QBCore.Functions.Notify('Outfit Deleted', 'error')
end)

RegisterNetEvent("fivem-appearance:purchaseSuccessful")
AddEventHandler("fivem-appearance:purchaseSuccessful", function()
    isPurchaseSuccessful = true
end)

RegisterNetEvent("fivem-appearance:purchaseFailed")
AddEventHandler("fivem-appearance:purchaseFailed", function()
    isPurchaseSuccessful = false
end)

RegisterNetEvent('fivem-appearance:clothingMenu', function()
	TriggerServerEvent('fivem-appearances:buyclothing')
	Wait(500)
	if isPurchaseSuccessful then
		local config = {
			ped = false,
			headBlend = false,
			faceFeatures = false,
			headOverlays = false,
			components = true,
			props = true
		}
		
		exports['fivem-appearance']:startPlayerCustomization(function(appearance)
			if appearance then
				TriggerServerEvent('fivem-appearance:save', appearance)
				print('Player Clothing Saved')
			else
				print('Canceled')
			end
			TriggerEvent("backitems:displayItems", true)
		end, config)
	end
end)

RegisterNetEvent('fivem-appearance:barberMenu', function()
	local config = {
		ped = false,
		headBlend = false,
		faceFeatures = false,
		headOverlays = true,
		components = false,
		props = false
	}

	exports['fivem-appearance']:startPlayerCustomization(function (appearance)
		if appearance then
			TriggerServerEvent('fivem-appearance:save', appearance)
			print('Player Clothing Saved')
		else
			print('Canceled')
		end
		TriggerEvent("backitems:displayItems", true)
	end, config)
end)

-- Backwords Events so you dont need to replace these

RegisterNetEvent('qb-clothing:client:openMenu', function()  -- Admin Menu clothing event
	Wait(500)
	local config = {
		ped = true,
		headBlend = true,
		faceFeatures = true,
		headOverlays = true,
		components = true,
		props = true
	}
	
	exports['fivem-appearance']:startPlayerCustomization(function(appearance)
		if appearance then
			TriggerServerEvent('fivem-appearance:save', appearance)
			print('Player Clothing Saved')
		else
			print('Canceled')
		end
		TriggerEvent("backitems:displayItems", true)
	end, config)
end)

-- RegisterNetEvent('qb-clothing:client:openMenuu', function()  -- Admin Menu clothing event
-- 	Wait(500)
-- 	TriggerServerEvent("clothing:checkIfNew")
-- 	TriggerEvent("backitems:displayItems", true)
-- end)

RegisterNetEvent('qb-clothing:client:openMenuu', function()  -- Admin Menu clothing event
	Wait(500)
	local config = {
		ped = true,
		headBlend = true,
		faceFeatures = true,
		headOverlays = true,
		components = true,
		props = true
	}
	
	exports['fivem-appearance']:startPlayerCustomization(function(appearance)
		if appearance then
			TriggerServerEvent('fivem-appearance:save', appearance)
			TriggerEvent('introCinematic:start')
			print('Player Clothing Saved')
		else
			print('Canceled')
		end
		TriggerEvent("backitems:displayItems", true)
	end, config)
end)

RegisterNetEvent('qb-clothing:client:openOutfitMenu', function()  -- Name is so that you dont have to replace the event, Used in Appartments, Bossmenu, etc...
	exports['qb-menu']:openMenu({
        {
            header = "👔 | Outfit Options",
            isMenuHeader = true, -- Set to true to make a nonclickable title
        },
		{
            header = "Change Outfit",
			txt = "Pick from any of your currently saved outfits",
            params = {
                event = "fivem-appearance:pickNewOutfitApp",
                args = {
                    number = 1,
                    id = 2
                }
            }
        },
		{
            header = "Save New Outfit",
			txt = "Save a new outfit you can use later on",
            params = {
                event = "fivem-appearance:saveOutfit",
            }
        },
		{
            header = "Delete Outfit",
			txt = "Yeah... We didnt like that one either",
            params = {
                event = "fivem-appearance:deleteOutfitMenu",
                args = {
                    number = 1,
                    id = 2
                }
            }
        },
    })
end)


RegisterNetEvent('fivem-appearance:pickNewOutfitApp', function(data)
    local id = data.id
    local number = data.number
	TriggerEvent('fivem-appearance:getOutfits')
	Wait(150)
	local outfitMenu = {
        {
            header = '< Go Back',
            params = {
                event = 'qb-clothing:client:openOutfitMenu'
            }
        }
    }
    for i=1, #allMyOutfits, 1 do
        outfitMenu[#outfitMenu + 1] = {
            header = allMyOutfits[i].name,
            params = {
                event = 'fivem-appearance:setOutfit',
                args = {
					-- number = (1 + i),
					ped = allMyOutfits[i].pedModel, 
					components = allMyOutfits[i].pedComponents, 
					props = allMyOutfits[i].pedProps
				}
            }
        }
    end
    exports['qb-menu']:openMenu(outfitMenu)
end)

RegisterNetEvent('fivem-appearance:deleteOutfitMenuApp', function(data)
    local id = data.id
    local number = data.number
	TriggerEvent('fivem-appearance:getOutfits')
	Wait(150)
	local DeleteMenu = {
        {
            header = '< Go Back',
            params = {
                event = 'fivem-appearance:clothingShop'
            }
        }
    }
    for i=1, #allMyOutfits, 1 do
        DeleteMenu[#DeleteMenu + 1] = {
            header = 'Delete "'..allMyOutfits[i].name..'"',
			txt = 'You will never be able to get this back!',
            params = {
				event = 'fivem-appearance:deleteOutfit',
				args = allMyOutfits[i].id
			}
        }
    end
    exports['qb-menu']:openMenu(DeleteMenu)
end)

-- Theads

CreateThread(function()
	while true do

		Wait(0)

		if CurrentAction ~= nil then

			if IsControlPressed(1, 38) then
				Wait(500)

				if CurrentAction == 'clothingMenu' then
					TriggerEvent("fivem-appearance:clothingShop")
				end
				
				if CurrentAction == 'barberMenu' then
					TriggerEvent("fivem-appearance:barberMenu")
				end

			end
		end
	end
end)

CreateThread(function()
	for k,v in ipairs(Config.BarberShops) do
		local blip = AddBlipForCoord(v)

		SetBlipSprite (blip, 71)
		-- SetBlipColour (blip, 47)
		SetBlipScale (blip, 0.5)
		SetBlipAsShortRange(blip, true)

		BeginTextCommandSetBlipName('STRING')
		AddTextComponentSubstringPlayerName('Barber Shop')
		EndTextCommandSetBlipName(blip)
	end
	for k,v in ipairs(Config.ClothingShops) do
		local data = v
		if data.blip == true then
			local blip = AddBlipForCoord(data.coords)

			SetBlipSprite (blip, 73)
			-- SetBlipColour (blip, 47)
			SetBlipScale (blip, 0.5)
			SetBlipAsShortRange(blip, true)

			BeginTextCommandSetBlipName('STRING')
			AddTextComponentSubstringPlayerName('Clothing Store')
			EndTextCommandSetBlipName(blip)
		end
	end
end)

CreateThread(function()
	while true do
		local playerCoords, isInClothingShop, isInPDPresets, isInBarberShop, currentZone, letSleep = GetEntityCoords(PlayerPedId()), false, false, nil, true
		local sleep = 2000
		for k,v in pairs(Config.ClothingShops) do
			local data = v
			local distance = #(playerCoords - data.coords)

			if distance < Config.DrawDistance then
				sleep = 0
				if distance < data.MarkerSize.x then
					isInClothingShop, currentZone = true, k
				end
			end
		end

		for k,v in pairs(Config.BarberShops) do
			local distance = #(playerCoords - v)

			if distance < Config.DrawDistance then
				sleep = 0
				if distance < Config.MarkerSize.x then
					isInBarberShop, currentZone = true, k
				end
			end
		end
		if not isInClothingShop and not isInBarberShop and hasAlreadyEnteredMarker then
			hasAlreadyEnteredMarker = false
			sleep = 1000
			TriggerEvent('fivem-appearance:hasExitedMarker', LastZone)
			TriggerEvent('cd_drawtextui:HideUI')
		end
		Wait(sleep)
	end
end)

-- Command(s)

RegisterNetEvent('Kinghunter:try', function()
	QBCore.Functions.TriggerCallback('fivem-appearance:getPlayerSkin', function(appearance)
		exports['fivem-appearance']:setPlayerAppearance(appearance)
	end)
	for k, v in pairs(GetGamePool('CObject')) do
        if IsEntityAttachedToEntity(PlayerPedId(), v) then
            SetEntityAsMissionEntity(v, true, true)
            DeleteObject(v)
            DeleteEntity(v)
        end
    end
end)

