local QBCore = exports['qb-core']:GetCoreObject()
local PlayerData = {}

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    PlayerData = QBCore.Functions.GetPlayerData()
end)

RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
    PlayerData = {}
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate', function(JobInfo)
    PlayerData.job = JobInfo
end)

RegisterNetEvent('QBCore:Client:OnGangUpdate', function(GangInfo)
    PlayerData.gang = GangInfo
end)

RegisterNetEvent('QBCore:Player:SetPlayerData', function(val)
    PlayerData = val
end)

RegisterNetEvent('qb-okokCrafting:client:AbrirMenuCraft', function()
    local columns = {
        {
            header = Lang.menuHeader,
            isMenuHeader = true,
        },
    }
    for k, v in pairs(Config.Main) do
        local item = {}
        item.header = "<img src=nui://qb-inventory/html/images/"..QBCore.Shared.Items[v.itemName].image.." width=35px style='margin-right: 10px'> " .. v.label .. "<br> Required Points: " .. v.level
        local text = ""
        for k, v in pairs(v.items) do
            text = text .. "• " .. QBCore.Shared.Items[v.item].label .. ": " .. v.amount .. "x <br>"
        end
        item.text = text
        item.params = {
            event = 'qb-okokCrafting:client:CraftItems',
            args = {
                type = k
            }
        }
        table.insert(columns, item)
    end

    exports['qb-menu']:openMenu(columns)
end)

local function CraftItems(item)
    local playername = GetPlayerName(PlayerId())
    local playerid = GetPlayerServerId(PlayerId())
    local pontos = Config.Main[item].points
    local prob = math.random(1, 100)
    if QBCore.Functions.GetPlayerData().metadata["craftinglevel"] >= Config.Main[item].level then
        QBCore.Functions.Progressbar('crafting', Lang.crafting .. Config.Main[item].label, 5000, false, false, {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        }, {
            animDict = "mini@repair",
            anim = "fixing_a_ped",
            }, {}, {}, function()
                ClearPedTasks(PlayerPedId())
                if prob <= Config.Main[item].chance then
                    if Config.Logs['UseLogs'] == true then
                        TriggerServerEvent('nc-log:server:CreateLog', 'crafting', 'Item Crafted', 'green', string.format(playername.. ' id ' ..playerid.. ' was crafted 1 ' ..Config.Main[item].label.. ' and earn '..pontos.. ' points', true))
                        QBCore.Functions.Notify(Lang.craftSuccess .. Config.Main[item].label, 'success')
                    else
                        QBCore.Functions.Notify(Lang.craftSuccess .. Config.Main[item].label, 'success')
                    end
                TriggerServerEvent('qb-okokCrafting:server:AddItem', Config.Main[item].itemName, 1)
                TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items[Config.Main[item].itemName], "add")
                TriggerServerEvent('qb-okokCrafting:server:AddPontos', pontos)
                for k, v in pairs(Config.Main[item].items) do
                    TriggerServerEvent('qb-okokCrafting:server:RemoveItem', v.item, v.amount)
                    TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items[v.item], "remove")
                end
            elseif QBCore.Functions.GetPlayerData().metadata["craftinglevel"] >= Config.Main[item].lostpoints then
                local pontosPerdidos = Config.Main[item].lostpoints
                QBCore.Functions.Notify(Lang.craftFailed1 .. Config.Main[item].lostpoints .. Lang.points, 'error', 7500)
                TriggerServerEvent('qb-okokCrafting:server:TirarPontos', pontosPerdidos)
            else
                QBCore.Functions.Notify(Lang.craftFailed2, 'error', 7500)
            end
        end)
    else
        QBCore.Functions.Notify('You dont have requeried level to craft this item!', 'error', 7500)
    end
end

RegisterNetEvent('qb-okokCrafting:client:CraftItems', function(data)
    QBCore.Functions.TriggerCallback("qb-okokCrafting:server:ItemsSuficientes", function(hasItems)
        if (hasItems) then
            CraftItems(data.type)
        else
            QBCore.Functions.Notify(Lang.errorRightItems, "error")
            return
        end
    end, Config.Main[data.type].items)
end)

RegisterNetEvent('qb-okokCrafting:client:SpawnarMesa', function()
    local playerPed = PlayerPedId()
    local coords    = GetEntityCoords(playerPed)
    local forward   = GetEntityForwardVector(playerPed)
    local x, y, z   = table.unpack(coords + forward * 1.0)

    local model = `prop_tool_bench02_ld`
    RequestModel(model)
    while (not HasModelLoaded(model)) do
        Wait(1)
    end
    QBCore.Functions.Progressbar('name_here', 'PLACING TABLE...', 1000, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = 'missfinale_c2ig_11',
        anim = 'pushcar_offcliff_f',
        flags = 16,
    }, {}, {}, function()
        local obj = CreateObject(model, x, y, z, true, false, true)
        PlaceObjectOnGroundProperly(obj)
        SetEntityAsMissionEntity(obj)

        TriggerServerEvent('qb-okokCrafting:server:RemoveItem', 'mesa_craft', 1)
        TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items['mesa_craft'], "remove")
    end)
end)

RegisterNetEvent('qb-okokCrafting:client:EliminarMesa', function(obj)
    if DoesEntityExist(obj) then
        QBCore.Functions.Progressbar('name_here', 'TAKING TABLE...', 1000, false, true, {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        }, {
            animDict = 'missfinale_c2ig_11',
            anim = 'pushcar_offcliff_f',
            flags = 16,
        }, {}, {}, function()
            DeleteEntity(obj)
        end)
    end
end)

CreateThread(function()
    if Config.MainLocation['UseLocation'] == true then
        exports['qb-target']:AddBoxZone("MainCraft", Config.MainLocation['Location'], 1, 1, {
            name="MainCraft",
            heading=0,
            debugpoly = false,
        }, {
            options = {
                {
                    event = "qb-okokCrafting:client:AbrirMenuCraft",
                    icon = "fas fa-table",
                    label = Lang.targetLabel,
                },
                {
                    event = "qb-okokCrafting:client:VerificarPontos",
                    icon = "fas fa-coins",
                    label = Lang.targetPoints,
                },
            },
            distance = 1.5
        })
    end
end)

RegisterCommand('craftpoints', function()
    local pontos = QBCore.Functions.GetPlayerData().metadata["craftinglevel"]

    QBCore.Functions.Notify(Lang.pointsCommand1 ..pontos.. Lang.pointsCommand2, 'primary', 7500)
end)

RegisterNetEvent('qb-okokCrafting:client:VerificarPontos', function()
    local pontos = QBCore.Functions.GetPlayerData().metadata["craftinglevel"]

    QBCore.Functions.Notify(Lang.pointsCommand1 ..pontos.. Lang.pointsCommand2, 'primary', 7500)
end)