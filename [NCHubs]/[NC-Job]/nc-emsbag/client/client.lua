local QBCore = exports['qb-core']:GetCoreObject()

local ObjectList = {}

RegisterNetEvent('nc-EmsBag:Client:SpawnAmbulanceBag', function(objectId, type, player)
    local coords = GetEntityCoords(GetPlayerPed(GetPlayerFromServerId(player)))
    local heading = GetEntityHeading(GetPlayerPed(GetPlayerFromServerId(player)))
    local forward = GetEntityForwardVector(PlayerPedId())
    local x, y, z = table.unpack(coords + forward * 0.5)
    local spawnedObj = CreateObject(Config.Bag.AmbulanceBag[type].model, x, y, coords.z-1, true, false, false)
    PlaceObjectOnGroundProperly(spawnedObj)
    SetEntityHeading(spawnedObj, heading)
    FreezeEntityPosition(spawnedObj, Config.Bag.AmbulanceBag[type].freeze)
    ObjectList[objectId] = {
        id = objectId,
        object = spawnedObj,
        coords = vector3(x, y, z - 0.3),
    }
    TriggerServerEvent("nc-EmsBag:Server:RemoveItem","emsbag",1)
end)

RegisterNetEvent('nc-EmsBag:Client:spawnLight', function()
    local playerPed = PlayerPedId()
    TaskStartScenarioInPlace(playerPed, "CODE_HUMAN_MEDIC_TEND_TO_DEAD")
    progressBar("Putting the Ems Bag...")
    Wait(2500)
    TriggerServerEvent("nc-EmsBag:Server:SpawnAmbulanceBag", "emsbag")
end)

RegisterNetEvent('nc-EmsBag:Client:GuardarAmbulanceBag')
AddEventHandler("nc-EmsBag:Client:GuardarAmbulanceBag", function()
    local x, y, z = table.unpack(GetEntityCoords(PlayerPedId(), true))
    local playerPedPos = GetEntityCoords(PlayerPedId(), true)
    local AmbulanceBag = GetClosestObjectOfType(playerPedPos, 10.0, GetHashKey("prop_cs_shopping_bag"), false, false, false)
    local playerPed = PlayerPedId()
    TaskStartScenarioInPlace(playerPed, "CODE_HUMAN_MEDIC_TEND_TO_DEAD")
    progressBar("Taking Back the Ems Bag...")
    Wait(2500)
    Notify("Ems Bag Taken Back with success.")
    SetEntityAsMissionEntity(AmbulanceBag, 1, 1)
    DeleteObject(AmbulanceBag)
    TriggerServerEvent("nc-EmsBag:Server:AddItem","emsbag",1)
end)

local citizenid = nil
AddEventHandler("nc-EmsBag:Client:StorageAmbulanceBag", function()
    local charinfo = QBCore.Functions.GetPlayerData().charinfo
    citizenid = QBCore.Functions.GetPlayerData().citizenid
    TriggerEvent("inventory:client:SetCurrentStash", "Ambulance Bag",citizenid)
    TriggerServerEvent("inventory:server:OpenInventory", "stash", "Ambulance Bag",citizenid, {
        maxweight = 50000,
        slots = 52,
    })
end)

local AmbulanceBags = {
    `prop_cs_shopping_bag`,
}

exports['qb-target']:AddTargetModel(AmbulanceBags, {
    options = {{event   = "nc-EmsBag:Client:MenuAmbulanceBag",icon    = "fa-solid fa-suitcase-medical",label   = "Ems Bag"},
    {event   = "nc-EmsBag:Client:GuardarAmbulanceBag",icon    = "fa-solid fa-suitcase-medical",label   = "Take Back Ems Bag"},},distance = 2.0 })