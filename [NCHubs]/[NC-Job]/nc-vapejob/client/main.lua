local QBCore = exports['qb-core']:GetCoreObject()

isLoggedIn = true

local onDuty = false

RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    QBCore.Functions.GetPlayerData(function(PlayerData)
        PlayerJob = PlayerData.job
        if PlayerData.job.onduty then
            if PlayerData.job.name == "smoking" then
                TriggerServerEvent("QBCore:ToggleDuty")
            end
        end
    end)
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate')
AddEventHandler('QBCore:Client:OnJobUpdate', function(JobInfo)
    PlayerJob = JobInfo
    onDuty = PlayerJob.onduty
end)

Citizen.CreateThread(function()
    SmokingShop = AddBlipForCoord(-1249.87, -1448.58, 4.37)
    SetBlipSprite (SmokingShop, 469)
    SetBlipDisplay(SmokingShop, 4)
    SetBlipScale  (SmokingShop, 0.5)
    SetBlipAsShortRange(SmokingShop, true)
    SetBlipColour(SmokingShop, 75)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentSubstringPlayerName("SmokingShop")
    EndTextCommandSetBlipName(SmokingShop)
end)

RegisterNetEvent("nc-vapejob:Duty")
AddEventHandler("nc-vapejob:Duty", function()
    TriggerServerEvent("QBCore:ToggleDuty")
end)

RegisterNetEvent("nc-vapejob:Tray1")
AddEventHandler("nc-vapejob:Tray1", function()
    TriggerEvent("inventory:client:SetCurrentStash", "Counter 1")
    TriggerServerEvent("inventory:server:OpenInventory", "stash", "Counter 1", {
        maxweight = 10000,
        slots = 6,
    })
end)

RegisterNetEvent("nc-vapejob:Tray2")
AddEventHandler("nc-vapejob:Tray2", function()
    TriggerEvent("inventory:client:SetCurrentStash", "Counter 2")
    TriggerServerEvent("inventory:server:OpenInventory", "stash", "Counter 2", {
        maxweight = 10000,
        slots = 6,
    })
end)

RegisterNetEvent("nc-vapejob:Storage")
AddEventHandler("nc-vapejob:Storage", function()
    TriggerEvent("inventory:client:SetCurrentStash", "Vape Storage 1")
    TriggerServerEvent("inventory:server:OpenInventory", "stash", "Vape Storage 1", {
        maxweight = 250000,
        slots = 40,
    })
end)

RegisterNetEvent("nc-vapejob:Storage2")
AddEventHandler("nc-vapejob:Storage2", function()
    TriggerEvent("inventory:client:SetCurrentStash", "Vape Storage 2")
    TriggerServerEvent("inventory:server:OpenInventory", "stash", "Vape Storage 2", {
        maxweight = 250000,
        slots = 40,
    })
end)

-- Getting Vape
RegisterNetEvent("nc-vapejob:TakeVape")
AddEventHandler("nc-vapejob:TakeVape", function()
		QBCore.Functions.Progressbar("pickup_sla", "Taking Vape", 4000, false, true, {
			disableMovement = true,
			disableCarMovement = true,
			disableMouse = false,
			disableCombat = true,
			}, {
			animDict = "mp_common",
			anim = "givetake1_a",
			flags = 8,
			}, {}, {}, function() -- Done
			TriggerServerEvent('QBCore:Server:AddItem', "vape", 1)
            TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["vape"], "add")
            QBCore.Functions.Notify("You have unboxed one vape!!", "success")
			end, function()
			QBCore.Functions.Notify("Cancelled..", "error")
		end)
	end)

-- Making Juice
RegisterNetEvent("nc-vapejob:VapeJuice1")
AddEventHandler("nc-vapejob:VapeJuice1", function()
	QBCore.Functions.TriggerCallback('nc-vapejob:server:get:ingredient', function(HasItems)  
    	if HasItems then
			QBCore.Functions.Progressbar("pickup_sla", "Making Chubby Bubble Blue Raz", 4000, false, true, {
				disableMovement = true,
				disableCarMovement = true,
				disableMouse = false,
				disableCombat = true,
			}, {
				animDict = "mp_common",
				anim = "givetake1_a",
				flags = 8,
			}, {}, {}, function() -- Done
				TriggerServerEvent('QBCore:Server:RemoveItem', "commonjuice", 1)
				TriggerServerEvent('QBCore:Server:RemoveItem', "juicebottle", 1)
				TriggerServerEvent('QBCore:Server:AddItem', "chubby", 2)
                    	TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["chubby"], "add")
                    		QBCore.Functions.Notify("You made chubby bubble blue raz", "success")
				end, function()
					QBCore.Functions.Notify("Cancelled..", "error")
				end)
			else
   				QBCore.Functions.Notify("You dont have the ingredients to make this", "error")
			end
		end)
	end)

-- Functions
   
RegisterNetEvent("nc-vapejob:shop")
AddEventHandler("nc-vapejob:shop", function()
    TriggerServerEvent("inventory:server:OpenInventory", "shop", "smoking", Config.Items)
end)
