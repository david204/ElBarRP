local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('nc-mysteryboxes:client:ComprarCaixa', function(args, data)
    local args = tonumber(args)

    if args == 1 then
        TriggerServerEvent('nc-mysteryboxes:server:ComprarPequena')
    elseif args == 2 then
        TriggerServerEvent('nc-mysteryboxes:server:ComprarMedia')
    elseif args == 3 then
        TriggerServerEvent('nc-mysteryboxes:server:ComprarGrande')
    elseif args == 4 then
        TriggerServerEvent('nc-mysteryboxes:server:ComprarSuper')
    end
end)

RegisterNetEvent('nc-mysteryboxes:client:ComprarCaixas', function()
    exports['qb-menu']:openMenu({
        {
            header = "Mysterious Shop",
            isMenuHeader = true,
        },
        {
            header = "< Close Menu",
            txt = "",
            params = {
                event = "qb-menu:closeMenu",
            }
        },
        {
            header = "<img src=nui://qb-inventory/html/images/"..QBCore.Shared.Items['mystery_smallbox'].image.." width=35px style='margin-right: 10px'> Small Mystery Box",
            txt = "Price: 100$",
            params = {
                event = "nc-mysteryboxes:client:ComprarCaixa",
                args = 1,
            }
        },
        {
            header = "<img src=nui://qb-inventory/html/images/"..QBCore.Shared.Items['mystery_mediumbox'].image.." width=35px style='margin-right: 10px'> Medium Mystery Box",
            txt = "Price: 500$",
            params = {
                event = "nc-mysteryboxes:client:ComprarCaixa",
                args = 2,
            }
        },
        {
            header = "<img src=nui://qb-inventory/html/images/"..QBCore.Shared.Items['mystery_bigbox'].image.." width=35px style='margin-right: 10px'> Big Mystery Box",
            txt = "Price: 1000$",
            params = {
                event = "nc-mysteryboxes:client:ComprarCaixa",
                args = 3,
            }
        },
        {
            header = "<img src=nui://qb-inventory/html/images/"..QBCore.Shared.Items['mystery_expensivebox'].image.." width=35px style='margin-right: 10px'> Super Mystery Box",
            txt = "Price: 3000$",
            params = {
                event = "nc-mysteryboxes:client:ComprarCaixa",
                args = 4,
            }
        },
    })
end)

CreateThread(function()
    RequestModel(Config.ShopPed['PedModel'])
      while not HasModelLoaded(Config.ShopPed['PedModel']) do
      Wait(1)
    end
    MysteryShopPed = CreatePed(2, Config.ShopPed['PedModel'], Config.ShopPed['PedLoc'], false, false)
      SetPedFleeAttributes(MysteryShopPed, 0, 0)
      SetPedDiesWhenInjured(MysteryShopPed, false)
      TaskStartScenarioInPlace(MysteryShopPed, "missheistdockssetup1clipboard@base", 0, true)
      SetPedKeepTask(MysteryShopPed, true)
      SetBlockingOfNonTemporaryEvents(MysteryShopPed, true)
      SetEntityInvincible(MysteryShopPed, true)
      FreezeEntityPosition(MysteryShopPed, true)

    exports['qb-target']:AddBoxZone("MysteryShopPed", Config.ShopPed['PedTarget'], 1, 1, {
        name="MysteryShopPed",
        heading=0,
        debugpoly = false,
    }, {
        options = {
            {
                event = "nc-mysteryboxes:client:ComprarCaixas",
                icon = "fas fa-thumbs-up",
                label = "Talk to this mysterious guy",
            }
        },
        distance = 2.5
    })
end)

RegisterNetEvent('nc-mysteryboxes:client:AbrirPequena', function()
    local playerPed = PlayerPedId()
    local coords    = GetEntityCoords(playerPed)
    local forward   = GetEntityForwardVector(playerPed)
    local x, y, z   = table.unpack(coords + forward * 1.0)

    local model = `prop_cs_box_clothes`
    RequestModel(model)
    while (not HasModelLoaded(model)) do
        Wait(1)
    end
    local obj = CreateObject(model, x, y, z, true, false, true)
    PlaceObjectOnGroundProperly(obj)
    SetEntityAsMissionEntity(obj)

    TriggerEvent('animations:client:EmoteCommandStart', {"mechanic3"})
    QBCore.Functions.Progressbar('name_here', 'OPENING MYSTERY BOX...', 5000, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function()
        TriggerEvent('animations:client:EmoteCommandStart', {"c"})

        DeleteEntity(obj)

        TriggerServerEvent('QBCore:Server:RemoveItem', 'mystery_smallbox', 1)
        TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items['mystery_smallbox'], "remove")

        TriggerServerEvent('nc-mysteryboxes:server:RewardPequena')
    end)
end)

RegisterNetEvent('nc-mysteryboxes:client:AbrirMedia', function()
    local playerPed = PlayerPedId()
    local coords    = GetEntityCoords(playerPed)
    local forward   = GetEntityForwardVector(playerPed)
    local x, y, z   = table.unpack(coords + forward * 1.0)

    local model = `prop_cs_cardbox_01`
    RequestModel(model)
    while (not HasModelLoaded(model)) do
        Wait(1)
    end
    local obj = CreateObject(model, x, y, z, true, false, true)
    PlaceObjectOnGroundProperly(obj)
    SetEntityAsMissionEntity(obj)

    TriggerEvent('animations:client:EmoteCommandStart', {"mechanic3"})
    QBCore.Functions.Progressbar('name_here', 'OPENING MYSTERY BOX...', 5000, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function()
        TriggerEvent('animations:client:EmoteCommandStart', {"c"})

        DeleteEntity(obj)

        TriggerServerEvent('QBCore:Server:RemoveItem', 'mystery_mediumbox', 1)
        TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items['mystery_mediumbox'], "remove")

        TriggerServerEvent('nc-mysteryboxes:server:RewardMedia')
    end)
end)

RegisterNetEvent('nc-mysteryboxes:client:AbrirGrande', function()
    local playerPed = PlayerPedId()
    local coords    = GetEntityCoords(playerPed)
    local forward   = GetEntityForwardVector(playerPed)
    local x, y, z   = table.unpack(coords + forward * 1.0)

    local model = `prop_cs_rub_box_01`
    RequestModel(model)
    while (not HasModelLoaded(model)) do
        Wait(1)
    end
    local obj = CreateObject(model, x, y, z, true, false, true)
    PlaceObjectOnGroundProperly(obj)
    SetEntityAsMissionEntity(obj)

    TriggerEvent('animations:client:EmoteCommandStart', {"mechanic3"})
    QBCore.Functions.Progressbar('name_here', 'OPENING MYSTERY BOX...', 5000, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function()
        TriggerEvent('animations:client:EmoteCommandStart', {"c"})

        DeleteEntity(obj)

        TriggerServerEvent('QBCore:Server:RemoveItem', 'mystery_bigbox', 1)
        TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items['mystery_bigbox'], "remove")

        TriggerServerEvent('nc-mysteryboxes:server:RewardGrande')
    end)
end)

RegisterNetEvent('nc-mysteryboxes:client:AbrirSuper', function()
    local playerPed = PlayerPedId()
    local coords    = GetEntityCoords(playerPed)
    local forward   = GetEntityForwardVector(playerPed)
    local x, y, z   = table.unpack(coords + forward * 1.0)

    local model = `prop_cardbordbox_04a`
    RequestModel(model)
    while (not HasModelLoaded(model)) do
        Wait(1)
    end
    local obj = CreateObject(model, x, y, z, true, false, true)
    PlaceObjectOnGroundProperly(obj)
    SetEntityAsMissionEntity(obj)

    TriggerEvent('animations:client:EmoteCommandStart', {"mechanic3"})
    QBCore.Functions.Progressbar('name_here', 'OPENING MYSTERY BOX...', 5000, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function()
        TriggerEvent('animations:client:EmoteCommandStart', {"c"})

        DeleteEntity(obj)

        TriggerServerEvent('QBCore:Server:RemoveItem', 'mystery_expensivebox', 1)
        TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items['mystery_expensivebox'], "remove")

        TriggerServerEvent('nc-mysteryboxes:server:RewardSuper')
    end)
end)