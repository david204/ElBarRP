Core = nil
if NCConfig.NewCore then
    Core = exports[NCConfig.Exports]:GetCoreObject()
else
    while Core == nil do
        Wait(10)
        TriggerEvent(NCConfig.Core .. ":GetSharedObject", function(obj) Core = obj end)
    end
end
canBeSeen = false
toggled = false
playerLoaded = false
menuToggled = false
job = {}


RegisterNetEvent(NCConfig.Core .. ":Client:OnPlayerLoaded")
AddEventHandler(NCConfig.Core..":Client:OnPlayerLoaded", function()
    playerLoaded = true
    job = Core.Functions.GetPlayerData().job or {}
    
    if job and CheckValidJob(job.name) then
        TriggerServerEvent('nc-employeelist:server:addToList', job.name, job.onduty)
        toggleList(true)
        Core.Functions.TriggerCallback('nc-10system:server:GetTagsColorsAndJob', function (tagColors, job_)
            SendNUIMessage({
                action = 'updatelist',
                tagstable = tagColors[job_]
            })
        end)
        if NCConfig.ShowOnOffDuty then
            if job.onduty then
                canBeSeen = true
            end
        else
            canBeSeen = true
        end
    else
        canBeSeen = false
    end
end)

AddEventHandler(NCConfig.Core .. ":Client:OnPlayerUnload", function()
    TriggerServerEvent('nc-10system:server:removeFromList')
end)

Citizen.CreateThread(function()
    Core.Functions.TriggerCallback('nc-10system:server:GetTagsColorsAndJob', function (tagColors, job_)
        SendNUIMessage({
            action = 'updatelist',
            tagstable = tagColors[job_]
        })
    end)
end)

Citizen.CreateThread(function()
    Wait(1000)
    --if playerLoaded then
        job = Core.Functions.GetPlayerData().job

        if CheckValidJob(job.name) then
            TriggerServerEvent('nc-employeelist:server:addToList', job.name, job.onduty)
            toggleList(true)
            Core.Functions.TriggerCallback('nc-10system:server:GetTagsColorsAndJob', function(tagColors, job_)
                SendNUIMessage({
                    action = 'updatelist',
                    tagstable = tagColors[job_]
                })
            end)
            if NCConfig.ShowOnOffDuty then
                if job.onduty then
                    canBeSeen = true
                end
            else
                canBeSeen = true
            end
        else
            canBeSeen = false
        end
    --end
end)

RegisterNetEvent(NCConfig.Core .. ':Client:OnJobUpdate')
AddEventHandler(NCConfig.Core..':Client:OnJobUpdate', function(job_)
    job = job_
    if CheckValidJob(job.name) then
        TriggerServerEvent('nc-10system:server:removeFromList')
        TriggerServerEvent('nc-employeelist:server:addToList', job.name, job.onduty)
        if NCConfig.ShowOnOffDuty then
            if job.onduty then
                toggleList(true)
                canBeSeen = true
            end
        else
            canBeSeen = true
        end
    else
        canBeSeen = false
        TriggerServerEvent('nc-10system:server:removeFromList')
        SendNUIMessage({ action = "close" })
    end
end)

local playerConnected = {}

RegisterNetEvent('nc-10system:client:updateList')
AddEventHandler('nc-10system:client:updateList', function(data)
    playerConnected = data
    local id = GetPlayerServerId(PlayerId())
    for k,v in pairs(data) do
        if v.job.name == job.name then
            if v.src == id then
                v.me = true
            end
            if job.grade then
                v.job = job.grade.level
            end
        end
    end
    SendNuiMessage(json.encode({
        action = 'update',
        jobinfo = Core.Shared.Jobs[job.name],
        sortby = NCConfig.WhitelistedJobs[job.name].SortBy,
        showjob = NCConfig.ShowJob,
        data = data
    }))
    
end)

RegisterNetEvent('nc-10system:client:updateTagsColorsList')
AddEventHandler('nc-10system:client:updateTagsColorsList', function(tags)
    SendNUIMessage({
        action = 'updatelist',
        tagstable = tags
    })
end)


function toggleList(toggle)
    if toggle then
        SendNUIMessage({
            action = 'open',
            jobinfo = Core.Shared.Jobs[job.name],
            sortby = NCConfig.WhitelistedJobs[job.name].SortBy,
            showjob = NCConfig.ShowJob,
            data = playerConnected
        })
    else
        SendNUIMessage({
            action = 'close',
        })
    end
end

function toggleMenu(job)
    if canBeSeen then
        Core.Functions.TriggerCallback('nc-10system:server:GetTagsColors', function (tagColors)
            SendNUIMessage({
                action = 'menu',
                isboss = job.isboss,
                colorstags = tagColors[job.name]
            })
            SetNuiFocus(true, true)
        end)
    end
end

RegisterNUICallback("toggleList", function(data)
    toggleList(data.toggled)
end)

RegisterNUICallback("saveChanges", function(data)
    TriggerServerEvent('nc-10system:server:updateCallsign', data.callsign)
end)

RegisterNUICallback("toggleFocus", function(toggle)
    SetNuiFocus(toggle, toggle)
end)

RegisterNUICallback("closeMenu", function()
    SetNuiFocus(false, false)
end)

RegisterNUICallback("saveTags", function(tagsTable)
    tagsTable = tagsTable.alltags
    TriggerServerEvent('nc-10system:server:saveTagsColors', tagsTable)
end)

RegisterNUICallback("saveNewTags", function(tagsTable)
    tagsTable = tagsTable.alltags
    TriggerServerEvent('nc-10system:server:saveNewTagsColors', tagsTable)
end)

RegisterCommand("plist", function(source)
    if canBeSeen then
        toggleMenu(job)
    end
end)


RegisterKeyMapping("plist", "Toggle nc-10system", 'keyboard', "EQUALS")
