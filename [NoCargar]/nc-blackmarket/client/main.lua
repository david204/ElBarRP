QBCore = exports['qb-core']:GetCoreObject()

CreateThread(function()
    while true do
        local InRange = false
        local PlayerPed = PlayerPedId()
        local PlayerPos = GetEntityCoords(PlayerPed)
        for shop, _ in pairs(Config.Locations) do
            local position = Config.Locations[shop]["coords"]
            for _, loc in pairs(position) do
                local dist = #(PlayerPos - vector3(loc["x"], loc["y"], loc["z"]))
                if dist <= 500.0 then
                    if not DoesEntityExist(dealer) then
                        RequestModel('g_m_m_chicold_01')
                        while not HasModelLoaded('g_m_m_chicold_01') do
                            Wait(10)
                        end
                        dealer = CreatePed(26, 'g_m_m_chicold_01', loc["x"], loc["y"], loc["z"] - 1 , loc["h"], false, false)
                        SetEntityHeading(dealer, loc["h"])
                        SetBlockingOfNonTemporaryEvents(dealer, true)
                        TaskStartScenarioInPlace(dealer, 'WORLD_HUMAN_AA_SMOKE', 0, false)
                        FreezeEntityPosition(dealer, true)
	                    SetEntityInvincible(dealer, true)
                    end
                else
                    Wait(1500)
                end
                if dist <= 10 then
                    InRange = true
                    if dist <= 2 then
                        if IsControlJustPressed(0, 38) then
                            if GetClockHours() >= Config.Open and GetClockHours() <= Config.Close then
                                TriggerEvent('market:client:HomeMenu')
                            else
                                QBCore.Functions.Notify("Come back another time.", 'error', 500)
                            end
                        end
                    end
                end
            end
        end
        if not InRange then
            Wait(5000)
        end
        Wait(5)
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
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end
-- Sell menu

RegisterNetEvent('market:client:SellMenu', function()
    exports['qb-menu']:openMenu({
        {
            header = "Black Market",
            isMenuHeader = true        
        },
        {
            header = "What Do you Have?",
			txt = "Sell your items",
			params = {
                event = 'market:client:SellItems'

            }
        },
        {
            header = "Close menu",
			txt = "",
			params = {
                event = 'qb-menu:closeMenu'
            }
        },
    })
end)

-- Selling function

RegisterNetEvent("market:client:SellItems", function()
    TaskStartScenarioInPlace(PlayerPedId(), "WORLD_HUMAN_STAND_IMPATIENT", 0, true)
    QBCore.Functions.Progressbar("sell_items", "Checking items of value", 3000, false, true, {}, {}, {}, {}, function() -- Done
        ClearPedTasks(PlayerPedId())
        TriggerServerEvent('market:server:SellItems')
    end, function() -- Cancel
        ClearPedTasks(PlayerPedId())
        QBCore.Functions.Notify("Canceled...", 'error')
    end) 
end)
