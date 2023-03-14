local QBCore = exports['qb-core']:GetCoreObject()
isLoggedIn = false
PlayerJob = {}

local onDuty = false

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
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end


RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    QBCore.Functions.GetPlayerData(function(PlayerData)
        PlayerJob = PlayerData.job
        if PlayerData.job.onduty then
            if PlayerData.job.name == "burgershot" then
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

RegisterNetEvent('QBCore:Client:SetDuty', function(duty)
    onDuty = duty
end)

CreateThread(function()
    BurgerShot = AddBlipForCoord(-1197.32, -897.655, 13.995)
    SetBlipSprite (BurgerShot, 106)
    SetBlipDisplay(BurgerShot, 4)
    SetBlipScale  (BurgerShot, 0.5)
    SetBlipAsShortRange(BurgerShot, true)
    SetBlipColour(BurgerShot, 75)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentSubstringPlayerName("BurgerShot")
    EndTextCommandSetBlipName(BurgerShot)
end) 

-- New Blips
CreateThread(function()
    Casino = AddBlipForCoord(948.81, 34.26, 71.83)
    SetBlipSprite (Casino, 680)
    SetBlipDisplay(Casino, 4)
    SetBlipScale  (Casino, 0.6)
    SetBlipAsShortRange(Casino, true)
    SetBlipColour(Casino, 18)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentSubstringPlayerName("Casino")
    EndTextCommandSetBlipName(Casino)
end) 

CreateThread(function()
    Callisto = AddBlipForCoord(390.68, 0.88, 91.94)
    SetBlipSprite (Callisto, 475)
    SetBlipDisplay(Callisto, 4)
    SetBlipScale  (Callisto, 0.6)
    SetBlipAsShortRange(Callisto, true)
    SetBlipColour(Callisto, 11)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentSubstringPlayerName("Callisto Motel")
    EndTextCommandSetBlipName(Callisto)
end) 

CreateThread(function()
    MetalDetecting = AddBlipForCoord(-1343.15, -1234.89, 5.94)
    SetBlipSprite (MetalDetecting, 256)
    SetBlipDisplay(MetalDetecting, 4)
    SetBlipScale  (MetalDetecting, 0.6)
    SetBlipAsShortRange(MetalDetecting, true)
    SetBlipColour(MetalDetecting, 8)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentSubstringPlayerName("Metal Detecting Sales")
    EndTextCommandSetBlipName(MetalDetecting)
end) 

CreateThread(function()
    CityBank = AddBlipForCoord(-1317.47, -831.85, 16.97)
    SetBlipSprite (CityBank, 464)
    SetBlipDisplay(CityBank, 4)
    SetBlipScale  (CityBank, 0.6)
    SetBlipAsShortRange(CityBank, true)
    SetBlipColour(CityBank, 66)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentSubstringPlayerName("CityBank Paychecks")
    EndTextCommandSetBlipName(CityBank)
end) 

CreateThread(function()
	Diving = AddBlipForCoord(-1684.71, -1068.9, 13.15)
	SetBlipSprite (Diving, 186)
	SetBlipDisplay(Diving, 4)
	SetBlipScale  (Diving, 0.6)
	SetBlipAsShortRange(Diving, true)
	SetBlipColour(Diving, 5)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentSubstringPlayerName("Buy & Sell Diving Stuff")
	EndTextCommandSetBlipName(Diving)
  end) 

CreateThread(function()
	QuickD = AddBlipForCoord(474.71, -1456.45, 29.29)
	SetBlipSprite (QuickD, 126)
	SetBlipDisplay(QuickD, 4)
	SetBlipScale  (QuickD, 0.6)
	SetBlipAsShortRange(QuickD, true)
	SetBlipColour(QuickD, 48)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentSubstringPlayerName("Quick Delivery Work")
	EndTextCommandSetBlipName(QuickD)
  end) 

CreateThread(function()
	ArcadeBar = AddBlipForCoord(-1270.04, -305.22, 36.99)
	SetBlipSprite (ArcadeBar, 266)
	SetBlipDisplay(ArcadeBar, 4)
	SetBlipScale  (ArcadeBar, 0.6)
	SetBlipAsShortRange(ArcadeBar, true)
	SetBlipColour(ArcadeBar, 32)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentSubstringPlayerName("ArcadeBar")
	EndTextCommandSetBlipName(ArcadeBar)
  end) 
  
CreateThread(function()
	VespucciB = AddBlipForCoord(-1289.34, -1415.07, 4.84)
	SetBlipSprite (VespucciB, 304)
	SetBlipDisplay(VespucciB, 4)
	SetBlipScale  (VespucciB, 0.6)
	SetBlipAsShortRange(VespucciB, true)
	SetBlipColour(VespucciB, 36)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentSubstringPlayerName("Vespucci Beach")
	EndTextCommandSetBlipName(VespucciB)
  end) 

CreateThread(function()
	Polices = AddBlipForCoord(375.96, -1595.56, 30.05)
	SetBlipSprite (Polices, 60)
	SetBlipDisplay(Polices, 4)
	SetBlipScale  (Polices, 0.6)
	SetBlipAsShortRange(Polices, true)
	SetBlipColour(Polices, 5)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentSubstringPlayerName("DavisPD Stastion")
	EndTextCommandSetBlipName(Polices)
  end) 

CreateThread(function()
	Cdealership = AddBlipForCoord(-920.84, -2032.97, 9.5)
	SetBlipSprite (Cdealership, 523)
	SetBlipDisplay(Cdealership, 4)
	SetBlipScale  (Cdealership, 0.6)
	SetBlipAsShortRange(Cdealership, true)
	SetBlipColour(Cdealership, 43)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentSubstringPlayerName("Car Dealership")
	EndTextCommandSetBlipName(Cdealership)
  end) 

CreateThread(function()
	Pokeshop = AddBlipForCoord(-143.92, 229.75, 94.94)
	SetBlipSprite (Pokeshop, 368)
	SetBlipDisplay(Pokeshop, 4)
	SetBlipScale  (Pokeshop, 0.6)
	SetBlipAsShortRange(Pokeshop, true)
	SetBlipColour(Pokeshop, 43)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentSubstringPlayerName("Pokemon Cards Shop")
	EndTextCommandSetBlipName(Pokeshop)
  end) 
-- New Blips

RegisterNetEvent("qb-burgershot:DutyB", function()
    TriggerServerEvent("QBCore:ToggleDuty")
end)

RegisterNetEvent("qb-burgershot:Tray1", function()
    TriggerEvent("inventory:client:SetCurrentStash", "burgertray1")
    TriggerServerEvent("inventory:server:OpenInventory", "stash", "burgertray1", {
        maxweight = 10000,
        slots = 6,
    })
end)

RegisterNetEvent("qb-burgershot:Tray4", function()
    TriggerEvent("inventory:client:SetCurrentStash", "burgertray4")
    TriggerServerEvent("inventory:server:OpenInventory", "stash", "burgertray4", {
        maxweight = 10000,
        slots = 6,
    })
end)

RegisterNetEvent("qb-burgershot:Tray3", function()
    TriggerEvent("inventory:client:SetCurrentStash", "burgertray3")
    TriggerServerEvent("inventory:server:OpenInventory", "stash", "burgertray3", {
        maxweight = 10000,
        slots = 6,
    })
end)

RegisterNetEvent("qb-burgershot:Storage", function()
    TriggerEvent("inventory:client:SetCurrentStash", "burgerstorage")
    TriggerServerEvent("inventory:server:OpenInventory", "stash", "burgerstorage", {
        maxweight = 250000,
        slots = 40,
    })
end)

RegisterNetEvent("qb-burgershot:Storage2", function()
    TriggerEvent("inventory:client:SetCurrentStash", "burgerstorage2")
    TriggerServerEvent("inventory:server:OpenInventory", "stash", "burgerstorage2", {
        maxweight = 250000,
        slots = 40,
    })
end)

--Meal Creations
RegisterNetEvent("qb-burgershot:MurderMeal", function()
		local randomToy = math.random(1,10)
		--remove box
		TriggerServerEvent('QBCore:Server:RemoveItem', "burger-murdermeal", 1)
		--add items from box
		TriggerServerEvent('QBCore:Server:AddItem', "burger-heartstopper", 1)
		TriggerServerEvent('QBCore:Server:AddItem', "burger-softdrink", 1)
		TriggerServerEvent('QBCore:Server:AddItem', "burger-fries", 1)

		if randomToy < 4 then
			QBCore.Functions.Notify("No toy in Box Looool", "error")
		elseif randomToy == 4 then
			TriggerServerEvent('QBCore:Server:AddItem', "burger-toy1", 1)
            		TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["burger-toy1"], "add")
		elseif randomToy < 10 and randomToy > 4 then
			QBCore.Functions.Notify("No toy in Box Looool", "error")
		elseif randomToy == 10 then
			TriggerServerEvent('QBCore:Server:AddItem', "burger-toy2", 1)
            		TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["burger-toy2"], "add")
		else
            		QBCore.Functions.Notify("No toy in Box Looool", "error")
        	end
end)

RegisterNetEvent("qb-burgershot:CreateMurderMeal", function()
    if onDuty then
    	QBCore.Functions.TriggerCallback('qb-burgershot:server:get:ingredientMurderMeal', function(HasItems)  
    		if HasItems then
				QBCore.Functions.Progressbar("pickup_sla", "Making A Murder Meal..", 4000, false, true, {
					disableMovement = true,
					disableCarMovement = true,
					disableMouse = false,
					disableCombat = true,
				}, {
					animDict = "mp_common",
					anim = "givetake1_a",
					flags = 8,
				}, {}, {}, function() -- Done
					TriggerServerEvent('QBCore:Server:RemoveItem', "burger-fries", 1)
                    			TriggerServerEvent('QBCore:Server:RemoveItem', "burger-heartstopper", 1)
					TriggerServerEvent('QBCore:Server:RemoveItem', "burger-softdrink", 1)
					TriggerServerEvent('QBCore:Server:AddItem', "burger-murdermeal", 1)
                    			TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["burger-murdermeal"], "add")
                    			QBCore.Functions.Notify("You made a A Murder Meal", "success")
				end, function()
					QBCore.Functions.Notify("Cancelled..", "error")
				end)
			else
   				QBCore.Functions.Notify("You dont have the items to make this", "error")
			end
		end)
	else 
		QBCore.Functions.Notify("You must be Clocked into work", "error")
	end  
end)

RegisterNetEvent("qb-burgershot:BleederBurger", function()
    if onDuty then
    	QBCore.Functions.TriggerCallback('qb-burgershot:server:get:ingredientBurger', function(HasItems)  
    		if HasItems then
				QBCore.Functions.Progressbar("pickup_sla", "Making Burgers..", 4000, false, true, {
					disableMovement = true,
					disableCarMovement = true,
					disableMouse = false,
					disableCombat = true,
				}, {
					animDict = "mp_common",
					anim = "givetake1_a",
					flags = 8,
				}, {}, {}, function() -- Done
					TriggerServerEvent('QBCore:Server:RemoveItem', "burger-meat", 1)
					TriggerServerEvent('QBCore:Server:RemoveItem', "burger-lettuce", 1)
					TriggerServerEvent('QBCore:Server:RemoveItem', "burger-bun", 1)
					TriggerServerEvent('QBCore:Server:RemoveItem', "burger-tomato", 1)
					TriggerServerEvent('QBCore:Server:AddItem', "burger-bleeder", 1)
                    			TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["burger-bleeder"], "add")
                    			QBCore.Functions.Notify("You made a Bleeder Burger", "success")
				end, function()
					QBCore.Functions.Notify("Cancelled..", "error")
				end)
			else
   				QBCore.Functions.Notify("You dont have the ingredients to make this", "error")
			end
		end)
	else 
		QBCore.Functions.Notify("You must be Clocked into work", "error")
	end
end)

RegisterNetEvent("qb-burgershot:MoneyShot", function()
    if onDuty then
    	QBCore.Functions.TriggerCallback('qb-burgershot:server:get:ingredientBurger', function(HasItems)  
    		if HasItems then
				QBCore.Functions.Progressbar("pickup_sla", "Making Burgers..", 4000, false, true, {
					disableMovement = true,
					disableCarMovement = true,
					disableMouse = false,
					disableCombat = true,
				}, {
					animDict = "mp_common",
					anim = "givetake1_a",
					flags = 8,
				}, {}, {}, function() -- Done
					TriggerServerEvent('QBCore:Server:RemoveItem', "burger-meat", 1)
					TriggerServerEvent('QBCore:Server:RemoveItem', "burger-lettuce", 1)
					TriggerServerEvent('QBCore:Server:RemoveItem', "burger-bun", 1)
					TriggerServerEvent('QBCore:Server:RemoveItem', "burger-tomato", 1)
					TriggerServerEvent('QBCore:Server:AddItem', "burger-moneyshot", 1)
                    			TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["burger-moneyshot"], "add")
                    			QBCore.Functions.Notify("You made a MoneyShot Burger", "success")
				end, function()
					QBCore.Functions.Notify("Cancelled..", "error")
				end)
			else
   				QBCore.Functions.Notify("You dont have the ingredients to make this", "error")
			end
		end)
	else 
		QBCore.Functions.Notify("You must be Clocked into work", "error")
	end
end)

RegisterNetEvent("qb-burgershot:HeartStopper", function()
    if onDuty then
    	QBCore.Functions.TriggerCallback('qb-burgershot:server:get:ingredientBurger', function(HasItems)  
    		if HasItems then
				QBCore.Functions.Progressbar("pickup_sla", "Making Burgers..", 4000, false, true, {
					disableMovement = true,
					disableCarMovement = true,
					disableMouse = false,
					disableCombat = true,
				}, {
					animDict = "mp_common",
					anim = "givetake1_a",
					flags = 8,
				}, {}, {}, function() -- Done
					TriggerServerEvent('QBCore:Server:RemoveItem', "burger-meat", 1)
					TriggerServerEvent('QBCore:Server:RemoveItem', "burger-lettuce", 1)
					TriggerServerEvent('QBCore:Server:RemoveItem', "burger-bun", 1)
					TriggerServerEvent('QBCore:Server:RemoveItem', "burger-tomato", 1)
					TriggerServerEvent('QBCore:Server:AddItem', "burger-heartstopper", 1)
                    			TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["burger-heartstopper"], "add")
                    			QBCore.Functions.Notify("You made a Heart Stopper", "success")
				end, function()
					QBCore.Functions.Notify("Cancelled..", "error")
				end)
			else
   				QBCore.Functions.Notify("You dont have the ingredients to make this", "error")
			end
		end)
	else 
		QBCore.Functions.Notify("You must be Clocked into work", "error")
	end
end)


RegisterNetEvent("qb-burgershot:Torpedo", function()
    if onDuty then
    	QBCore.Functions.TriggerCallback('qb-burgershot:server:get:ingredientTorpedo', function(HasItems)  
    		if HasItems then
				QBCore.Functions.Progressbar("pickup_sla", "Making A Torpedo..", 4000, false, true, {
					disableMovement = true,
					disableCarMovement = true,
					disableMouse = false,
					disableCombat = true,
				}, {
					animDict = "mp_common",
					anim = "givetake1_a",
					flags = 8,
				}, {}, {}, function() -- Done
					TriggerServerEvent('QBCore:Server:RemoveItem', "burger-meat", 1)
					TriggerServerEvent('QBCore:Server:RemoveItem', "burger-bun", 1)
					TriggerServerEvent('QBCore:Server:AddItem', "burger-torpedo", 1)
                    			TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["burger-torpedo"], "add")
                    			QBCore.Functions.Notify("You made a Torpedo Roll", "success")
				end, function()
					QBCore.Functions.Notify("Cancelled..", "error")
				end)
			else
   				QBCore.Functions.Notify("You dont have the ingredients to make this", "error")
			end
		end)
	else 
		QBCore.Functions.Notify("You must be Clocked into work", "error")
	end  
end)

RegisterNetEvent("qb-burgershot:MeatFree", function()
    if onDuty then
    	QBCore.Functions.TriggerCallback('qb-burgershot:server:get:ingredientMeatfree', function(HasItems)  
    		if HasItems then
				QBCore.Functions.Progressbar("pickup_sla", "Making A Meat Free Burger..", 4000, false, true, {
					disableMovement = true,
					disableCarMovement = true,
					disableMouse = false,
					disableCombat = true,
				}, {
					animDict = "mp_common",
					anim = "givetake1_a",
					flags = 8,
				}, {}, {}, function() -- Done
					TriggerServerEvent('QBCore:Server:RemoveItem', "burger-tomato", 1)
                    			TriggerServerEvent('QBCore:Server:RemoveItem', "burger-lettuce", 1)
					TriggerServerEvent('QBCore:Server:RemoveItem', "burger-bun", 1)
					TriggerServerEvent('QBCore:Server:AddItem', "burger-meatfree", 1)
                    			TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["burger-meatfree"], "add")
                   			QBCore.Functions.Notify("You made a Meat Free Burger", "success")
				end, function()
					QBCore.Functions.Notify("Cancelled..", "error")
				end)
			else
   				QBCore.Functions.Notify("You dont have the ingredients to make this", "error")
			end
		end)
	else 
		QBCore.Functions.Notify("You must be Clocked into work", "error")
	end  
end)



RegisterNetEvent("qb-burgershot:SoftDrink", function()
    if onDuty then
    QBCore.Functions.TriggerCallback('QBCore:HasItem', function(HasItem)
        if HasItem then
           MakeSoftDrink()
        else
            QBCore.Functions.Notify("You don't have any soda syrup..", "error")
        end
      end, 'burger-sodasyrup')
    else
        QBCore.Functions.Notify("You must be Clocked into work", "error")
    end
end)

RegisterNetEvent("qb-burgershot:mShake", function()
    if onDuty then
    QBCore.Functions.TriggerCallback('QBCore:HasItem', function(HasItem)
        if HasItem then
           MakeMShake()
        else
            QBCore.Functions.Notify("You don't have any Milkshake Formula..", "error")
        end
      end, 'burger-mshakeformula')
    else
        QBCore.Functions.Notify("You must be Clocked into work", "error")
    end
end)

RegisterNetEvent("qb-burgershot:Fries", function()
    if onDuty then
    QBCore.Functions.TriggerCallback('QBCore:HasItem', function(HasItem)
        if HasItem then
           MakeFries()
        else
            QBCore.Functions.Notify("You don't have any potatoes..", "error")
        end
      end, 'burger-potato')
    else
        QBCore.Functions.Notify("You must be Clocked into work", "error")
    end
end)


RegisterNetEvent("qb-burgershot:PattyFry", function()
    if onDuty then
    QBCore.Functions.TriggerCallback('QBCore:HasItem', function(HasItem)
        if HasItem then
           MakePatty()
        else
            QBCore.Functions.Notify("You don't have any raw patties..", "error", 5000)
        end
      end, 'burger-raw')
    else
        QBCore.Functions.Notify("You must be Clocked into work", "error", 5000)
    end
end)

-- Functions --
function MakeFries()
	TriggerServerEvent('QBCore:Server:RemoveItem', "burger-potato", 1)
	QBCore.Functions.Progressbar("pickup", "Frying the fries..", 4000, false, true, {
	    disableMovement = true,
	    disableCarMovement = true,
	    disableMouse = false,
	    disableCombat = true,
	},{
	    animDict = "amb@prop_human_bbq@male@base",
	    anim = "base",
	    flags = 8,
	    }, {
		model = "prop_cs_fork",
		bone = 28422,
		coords = vector3(-0.005, 0.00, 0.00),
		rotation = vector3(175.0, 160.0, 0.0),
	    }
	)
	Wait(4000)
	TriggerServerEvent('QBCore:Server:AddItem', "burger-fries", 4)
	TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["burger-fries"], "add")
	QBCore.Functions.Notify("You made 4 fries", "success")
	StopAnimTask(PlayerPedId(), "amb@prop_human_bbq@male@base", "base", 1.0)
end


function MakePatty()
    TriggerServerEvent('QBCore:Server:RemoveItem', "burger-raw", 1)
    QBCore.Functions.Progressbar("pickup", "Cooking the Patty..", 4000, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    },{
        animDict = "amb@prop_human_bbq@male@base",
        anim = "base",
        flags = 8,
    }, {
        model = "prop_cs_fork",
        bone = 28422,
        coords = vector3(-0.005, 0.00, 0.00),
        rotation = vector3(175.0, 160.0, 0.0),
    }    
)
    Wait(4000)
    TriggerServerEvent('QBCore:Server:AddItem', "burger-meat", 1)
    TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["burger-meat"], "add")
    QBCore.Functions.Notify("You cooked the meat", "success")
    StopAnimTask(PlayerPedId(), "amb@prop_human_bbq@male@base", "base", 1.0)
end

function MakeSoftDrink()
    TriggerServerEvent('QBCore:Server:RemoveItem', "burger-sodasyrup", 1)
    QBCore.Functions.Progressbar("pickup", "Filling a cup..", 4000, false, true, {
        disableMovement = true,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = false,
    })
    Wait(4000)
    TriggerServerEvent('QBCore:Server:AddItem', "burger-softdrink", 1)
    TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["burger-softdrink"], "add")
    QBCore.Functions.Notify("You made a Soda", "success")
end  


function MakeMShake()
    TriggerServerEvent('QBCore:Server:RemoveItem', "burger-mshakeformula", 1)
    QBCore.Functions.Progressbar("pickup", "Filling up a cup..", 4000, false, true, {
        disableMovement = true,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = false,
    })
    Wait(4000)
    TriggerServerEvent('QBCore:Server:AddItem', "burger-mshake", 1)
    TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["burger-mshake"], "add")
    QBCore.Functions.Notify("You made a Milkshake", "success")
end  
   
RegisterNetEvent("qb-burgershot:shop", function()
    TriggerServerEvent("inventory:server:OpenInventory", "shop", "burgershot", Config.Items)
end)

--Gift Box Creations
RegisterNetEvent("qb-burgershot:GiftBox", function()
    QBCore.Functions.Progressbar("pickup", "Opening Gift Box..", 4000, false, true, {
        disableMovement = true,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = false,
    })
        local randomToy = math.random(1,50)
        --remove box
        TriggerServerEvent('QBCore:Server:RemoveItem', "gift_box", 1)
        --add items from box
		TriggerServerEvent('QBCore:Server:AddItem', "phone", 1)
        TriggerServerEvent('QBCore:Server:AddItem', "sandwich", 5)
        TriggerServerEvent('QBCore:Server:AddItem', "water_bottle", 5)
		TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["phone"], "add")
        TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["sandwich"], "add")
        TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["water_bottle"], "add")

        if randomToy < 4 then
            QBCore.Functions.Notify("Not So Lucky", "error")
        elseif randomToy == 4 then
            TriggerServerEvent('QBCore:Server:AddItem', "lockpick", 1)
                    TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["lockpick"], "add")
        elseif randomToy < 10 and randomToy > 4 then
            QBCore.Functions.Notify("Not So Lucky", "error")
        elseif randomToy == 10 then
            TriggerServerEvent('QBCore:Server:AddItem', "screwdriverset", 1)
                    TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["screwdriverset"], "add")
        else
                    QBCore.Functions.Notify("Not So Lucky", "error")
            end
end)