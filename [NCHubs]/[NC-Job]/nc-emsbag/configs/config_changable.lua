local QBCore = exports['qb-core']:GetCoreObject()


-- Simple Event's , you can create yours and put on qb-menu :)

RegisterNetEvent('nc-EmsBag:Client:GiveRadio')
AddEventHandler("nc-EmsBag:Client:GiveRadio", function()
    local playerPed = PlayerPedId()
    TaskStartScenarioInPlace(playerPed, "CODE_HUMAN_MEDIC_TEND_TO_DEAD")
    progressBar("Taking a Radio ...")
    TriggerServerEvent("nc-EmsBag:Server:AddItem", "radio", 1)
    TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["radio"], "add", 1)
end)

RegisterNetEvent('nc-EmsBag:Client:Givebandage')
AddEventHandler("nc-EmsBag:Client:Givebandage", function()
    local playerPed = PlayerPedId()
    TaskStartScenarioInPlace(playerPed, "CODE_HUMAN_MEDIC_TEND_TO_DEAD")
    progressBar("Taking Bandage ...")
    TriggerServerEvent("nc-EmsBag:Server:AddItem", "bandage", 1)
    TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["bandage"], "add", 1)
end)
RegisterNetEvent('nc-EmsBag:Client:Givepainkillers')
AddEventHandler("nc-EmsBag:Client:Givepainkillers", function()
    local playerPed = PlayerPedId()
    TaskStartScenarioInPlace(playerPed, "CODE_HUMAN_MEDIC_TEND_TO_DEAD")
    progressBar("Taking Painkillers ...")
    TriggerServerEvent("nc-EmsBag:Server:AddItem", "painkillers", 1)
    TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["painkillers"], "add", 1)
end)
RegisterNetEvent('nc-EmsBag:Client:Givefirstaid')
AddEventHandler("nc-EmsBag:Client:Givefirstaid", function()
    local playerPed = PlayerPedId()
    TaskStartScenarioInPlace(playerPed, "CODE_HUMAN_MEDIC_TEND_TO_DEAD")
    progressBar("Taking Firstaid ...")
    TriggerServerEvent("nc-EmsBag:Server:AddItem", "firstaid", 1)
    TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["firstaid"], "add", 1)
end)
RegisterNetEvent('nc-EmsBag:Client:Giveweapon_flashlight')
AddEventHandler("nc-EmsBag:Client:Giveweapon_flashlight", function()
    local playerPed = PlayerPedId()
    TaskStartScenarioInPlace(playerPed, "CODE_HUMAN_MEDIC_TEND_TO_DEAD")
    progressBar("Taking Flashlight ...")
    TriggerServerEvent("nc-EmsBag:Server:AddItem", "weapon_flashlight", 1)
    TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["weapon_flashlight"], "add", 1)
end)


RegisterNetEvent('nc-EmsBag:Client:MenuAmbulanceBag', function()
    local playerPed = PlayerPedId()
    if IsEntityDead(playerPed) then return Notify("You cannot Open Bag while dead", "error") end
    if IsPedSwimming(playerPed) then return Notify("You cannot Open Bag in the water.", "error") end
    if IsPedSittingInAnyVehicle(playerPed) then return Notify("You cannot Open Bag inside a vehicle", "error") end
    local job = QBCore.Functions.GetPlayerData().job.name
    if Config.Bag.NeedJob == true then
        if job ~= Config.Bag.Job then
            Notify("You dont have permissions to Open The Bag")
            return false
        end
    end
    exports['qb-menu']:openMenu({
        { header = "[🚑] Ambulance Box", txt = "", isMenuHeader = true },
        { header = "[👜] Open AmbulanceBag",  params = { event = "nc-EmsBag:Client:StorageAmbulanceBag" } },
        { header = "[🩹]Take Bandage ",  params = { event = "nc-EmsBag:Client:Givebandage" } },
        { header = "[💊] Take Painkillers ",  params = { event = "nc-EmsBag:Client:Givepainkillers" } },
        { header = "[💉] Take Firstaid ",  params = { event = "nc-EmsBag:Client:Givefirstaid" } },
        { header = "[🔦] Take FlashLight ",  params = { event = "nc-EmsBag:Client:Giveweapon_flashlight" } },
        { header = "[📻] Take Radio",  params = { event = "nc-EmsBag:Client:GiveRadio" } },
        -- You can add more menus with your's personal events...
        { header = "", txt = "❌ Close", params = { event = "qb-menu:closeMenu" } },
    })
end)

