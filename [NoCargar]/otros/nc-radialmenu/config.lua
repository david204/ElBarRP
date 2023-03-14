local QBCore = exports['qb-core']:GetCoreObject()

rootMenuConfig =  {
    {
        id = "TruckRob",
        displayName = "Crack Container",
        icon = "#container-rob",
        functionName = "nc-containerrobbery:truck",
        enableMenu = function()
            local Data = QBCore.Functions.GetPlayerData()
            local isNearTruck = exports["nc-containerrobbery"]:isNearTruck()
            local hasItem = GetSelectedPedWeapon(PlayerPedId()) == `weapon_crowbar`
            return hasItem and isNearTruck and (not Data.metadata["isdead"] and not Data.metadata["inlaststand"])
        end
    },
    {
        id = "radio",
        displayName = "Radio",
        icon = "#radio",
        enableMenu = function()
            local Data, hasItem = QBCore.Functions.GetPlayerData()

            QBCore.Functions.TriggerCallback('QBCore:HasItem', function(result)
                hasItem = result
            end, "radio")

            while hasItem == nil do
                Wait(10)
            end

            return hasItem and not Data.metadata["isdead"] and (Data.job.name == "police" or Data.job.name == "sheriff")
        end,
        subMenus = {'power:off',"radio:1","radio:2","radio:3","radio:4","radio:5"}
    },
    {
        id = "radio",
        displayName = "Radio",
        icon = "#radio",
        enableMenu = function()
            local Data, hasItem = QBCore.Functions.GetPlayerData()

            QBCore.Functions.TriggerCallback('QBCore:HasItem', function(result)
                hasItem = result
            end, "radio")

            while hasItem == nil do
                Wait(10)
            end

            return hasItem and not Data.metadata["isdead"] and (Data.job.name == "ambulance")
        end,
        subMenus = {'power:off',"radio:6","radio:7","radio:8","radio:9","radio:10"}
    },
    -- {
    --     id = "policeDeadA",
    --     displayName = "Panic Button",
    --     icon = "#police-panic",
    --     functionName = "dispatch:panicButton",
    --     enableMenu = function()
    --         local Data, hasItem = QBCore.Functions.GetPlayerData()

    --         QBCore.Functions.TriggerCallback('QBCore:HasItem', function(result)
    --             hasItem = result
    --         end, "signalradar")

    --         while hasItem == nil do
    --             Wait(10)
    --         end

    --         return hasItem and (not Data.metadata["isdead"] and not Data.metadata["inlaststand"]) and (Data.job.name == 'police' and Data.job.onduty)
    --     end
    -- },
    -- {
    --     id = "neons",
    --     displayName = "Neon",
    --     icon = "#neons",
    --     functionName = "neons:toggle",
    --     enableMenu = function()
    --         local Data = QBCore.Functions.GetPlayerData()
    --         return (not Data.metadata["isdead"] and not Data.metadata["inlaststand"] and IsPedInAnyVehicle(PlayerPedId(), false))
    --     end
    -- },
    -- {
    --     id = "vanilla",
    --     displayName = "Vanilla",
    --     icon = "#vanilla",
    --     enableMenu =function()
    --         local Data = QBCore.Functions.GetPlayerData()
    --         return (not Data.metadata["isdead"] and not Data.metadata["inlaststand"] and Data.job ~= nil and Data.job.name == "vanilla")
    --     end,
    --     subMenus = { "vanilla:place" }
    -- },

    -- General --
    {
        id = "general",
        displayName = "General",
        icon = "#globe-europe",
        enableMenu = function()
            local Data = QBCore.Functions.GetPlayerData()
            return not Data.metadata["isdead"] and not Data.metadata["inlaststand"]
        end,
        subMenus = {"vehicle:giveKeys", "general:flipveh", "general:hotdog", "general:getintrunk", "general:cornerselling"}
    },

    {
        id = "carry",
        displayName = "Carry",
        icon = "#animation-hurry",
        functionName = "carry:Event",
        enableMenu = function()
            local Data = QBCore.Functions.GetPlayerData()
            return (not Data.metadata["isdead"] and not Data.metadata["inlaststand"])
        end
    },

    {
        id = "house",
        displayName = "House Interaction",
        icon = "#house",
        enableMenu = function()
            local Data = QBCore.Functions.GetPlayerData()
            return not Data.metadata["isdead"] and not Data.metadata["inlaststand"]
        end,
        subMenus = {"house:give","house:remove", "house:doorlock", "house:reset", "house:decorate", "house:setstash", "house:setoutift", "house:setlogout"}
    },

    {
        id = "vehicle",
        displayName = "Vehicle",
        icon = "#vehicle-options",
        functionName = "veh:optionss",
        enableMenu = function()
            local Data = QBCore.Functions.GetPlayerData()
            return (not Data.metadata["isdead"] and not Data.metadata["inlaststand"] and IsPedInAnyVehicle(PlayerPedId(), false))
        end
    },

    -- {
    --     id = "shoes",
    --     displayName = "Steal Shoes",
    --     icon = "#steal-shoes",
    --     functionName = "twiztidshittz:clientShoesSteal",
    --     enableMenu = function()
    --         local Data = QBCore.Functions.GetPlayerData()
    --         return not Data.metadata["isdead"] and not Data.metadata["inlaststand"] and CanRoBShoe()
    --     end,
    -- },

    {
        id = "blips",
        displayName = "Blips",
        icon = "#blips",
        enableMenu = function()
            local Data = QBCore.Functions.GetPlayerData()
            return (not Data.metadata["isdead"] and not Data.metadata["inlaststand"])
        end,
        subMenus = {"blips:gasstations", "blips:barbershop", "blips:tattooshop"}
    },

    {
        id = "cuff",
        displayName = "Cuff Actions",
        icon = "#cuffs",
        enableMenu = function()
            local Data = QBCore.Functions.GetPlayerData()
            return not Data.metadata["isdead"] and not Data.metadata["inlaststand"]
        end,
        subMenus = { "cuffing:cuff", "cuffing:steal", 'ems:putinvehicle','ems:unseatvehicle', 'police:drag' }
    },   

    -- Police --
    {
        id = "policeDeadA",
        displayName = "10-13A",
        icon = "#police-dead",
        functionName = "nc:dispatch:officerdown",
        enableMenu = function()
            local Data = QBCore.Functions.GetPlayerData()

            return (Data.metadata["isdead"] or Data.metadata["inlaststand"]) and (Data.job.name == 'police' and Data.job.onduty)
        end
    },

    {
        id = "police",
        displayName = "Police Actions",
        icon = "#police-action",
        enableMenu =function()
            local Data = QBCore.Functions.GetPlayerData()
            return (not Data.metadata["isdead"] and not Data.metadata["inlaststand"] and (Data.job ~= nil and Data.job.name == "police" and Data.job.onduty))
        end,
        subMenus = {"police:drag", "police:softcuff", "police:cuff", "ems:putinvehicle","ems:unseatvehicle","police:unmask"}
    },

    {
        id = "police-check",
        displayName = "Police Checks",
        icon = "#police-check",
        enableMenu = function()
            local Data = QBCore.Functions.GetPlayerData()
            return (not Data.metadata["isdead"] and not Data.metadata["inlaststand"] and (Data.job ~= nil and Data.job.name == "police" and Data.job.onduty))
        end,
        subMenus = {"police:checkbank", "police:checklicenses","police:checkfines", "police:search" }
    },

    {
        id = "objects",
        displayName = "Objects",
        icon = "#objects",
        enableMenu =function()
            local Data = QBCore.Functions.GetPlayerData()
            return (not Data.metadata["isdead"] and not Data.metadata["inlaststand"] and (Data.job ~= nil and Data.job.name == "police" and Data.job.onduty))
        end,
        subMenus = {"objects:barier", "objects:cone", "objects:tent", "objects:spike", "objects:light", "objects:remove"}
    },

    -- {
    --     id = "radio",
    --     displayName = "Radio",
    --     icon = "#radio",
    --     enableMenu = function()
    --         local Data, hasItem = QBCore.Functions.GetPlayerData()

    --         QBCore.Functions.TriggerCallback('QBCore:HasItem', function(result)
    --             hasItem = result
    --         end, "radio")

    --         while hasItem == nil do
    --             Wait(10)
    --         end

    --         return hasItem and not Data.metadata["isdead"] and Data.job.name == "police"
    --     end,
    --     subMenus = {"radio:1","radio:2","radio:3","radio:4","radio:5","radio:6"}
    -- },
    -- EMS --
    {
        id = "ems",
        displayName = "EMS",
        icon = "#medic",
        enableMenu = function()
            local Data = QBCore.Functions.GetPlayerData()
            return (not Data.metadata["isdead"] and not Data.metadata["inlaststand"] and (Data.job ~= nil and Data.job.name == "ambulance" and Data.job.onduty))
        end,
        subMenus = { 'police:drag', "ems:revive", "ems:status", 'ems:heal',  'ems:putinvehicle','ems:unseatvehicle'}
    },
    
    {
        id = "objects",
        displayName = "Objects",
        icon = "#objects",
        enableMenu =function()
            local Data = QBCore.Functions.GetPlayerData()
            return (not Data.metadata["isdead"] and not Data.metadata["inlaststand"] and (Data.job ~= nil and Data.job.name == "ambulance" and Data.job.onduty))
        end,
        subMenus = {"objects:barier", "objects:cone", "objects:tent"}
    },

    {
        id = "realestate",
        displayName = "List of houses",
        icon = "#house",
        functionName = "qb-realestate:client:OpenHouseListMenu",
        enableMenu =function()
            local Data = QBCore.Functions.GetPlayerData()
            return (not Data.metadata["isdead"] and not Data.metadata["inlaststand"] and (Data.job ~= nil and Data.job.name == "realestate" and Data.job.onduty))
        end,
    },

    {
        id = "emsDeadA",
        displayName = "10-14A",
        icon = "#ems-dead",
        functionName = "dispatch:emsDown",
        enableMenu = function()
            local Data = QBCore.Functions.GetPlayerData()
            return (Data.metadata["isdead"] or Data.metadata["inlaststand"]) and (Data.job.name == 'ambulance' and Data.job.onduty)
        end
    },

    {
        id = "deadblip",
        displayName = "10-11",
        icon = "#police-dead",
        enableMenu =function()
            local Data = QBCore.Functions.GetPlayerData()
            return (isDead and Data.job ~= nil and (Data.job.name == "police" or Data.job.name == "ambulance"))
        end,
        subMenus = { "esx_outlawalert:deadofficerinprogress"}
    },
    -- Jobs --
    {
        id = "tow",
        displayName = "Tow Actions",
        icon = "#mechanic",
        enableMenu = function()
            local Data = QBCore.Functions.GetPlayerData()
            return (not Data.metadata["isdead"] and not Data.metadata["inlaststand"] and Data.job ~= nil and (Data.job.name == "mechanic"))
        end,
        subMenus = {"mechanic:impound","tow:towvehicle"} --[[,"tow:checkstatus", "tow:togglenpc"]]--
    },
    

    {
        id = "mechanic",
        displayName = "Mechanic Actions",
        icon = "#mechanic",
        enableMenu =function()
            local Data = QBCore.Functions.GetPlayerData()
            return (not Data.metadata["isdead"] and not Data.metadata["inlaststand"] and Data.job ~= nil and Data.job.name == "mechanic")
        end,
        subMenus = { "mechanic:impound", "mechanic:flatbed", "mechanic:repair", "mechanic:repairfull", "mechanic:clean" }
    },

    {
        id = "judge",
        displayName = "Judge Actions",
        icon = "judge-actions",
        enableMenu =function()
            local Data = QBCore.Functions.GetPlayerData()
            return (not Data.metadata["isdead"] and not Data.metadata["inlaststand"] and Data.job ~= nil and Data.job.name == "mayor" and Data.job.grade >= 2)
        end,
        subMenus = { 'judge:mdt' }
    },

    {
        id = "taxi",
        displayName = "Taxi Actions",
        icon = "#taxi-togglemeter",
        enableMenu =function()
            local Data = QBCore.Functions.GetPlayerData()
            return (not Data.metadata["isdead"] and not Data.metadata["inlaststand"] and Data.job ~= nil and Data.job.name == "taxi")
        end,
        subMenus = { "taxi:togglemeter", "taxi:npcmission", "npc_mission" }
    },

    {
        id = "news",
        displayName = "News",
        icon = "#news",
        enableMenu =function()
            local Data = QBCore.Functions.GetPlayerData()
            return (not Data.metadata["isdead"] and not Data.metadata["inlaststand"] and Data.job ~= nil and (Data.job.name == "reporter"))
        end,
        subMenus = { "news:boom", "news:mic", "news:cam" }
    },

    -- Garages
    {
        id = "open-garage",
        displayName = "Vehicle List",
        icon = "#garages",
        functionName = "nc-garages:open",
        enableMenu = function()
            local pData = QBCore.Functions.GetPlayerData()
            return (not pData.metadata["isdead"] and not pData.metadata["inlaststand"] and inGarage and not isCloseVeh() and not IsPedInAnyVehicle(PlayerPedId(), false))
        end
    },
    
    {
        id = "park-vehicle-garage",
        displayName = "Park Vehicle",
        icon = "#garages-parking",
        functionName = "nc-garages:store",
        enableMenu = function()

            local pData = QBCore.Functions.GetPlayerData()
            return (not pData.metadata["isdead"] and not pData.metadata["inlaststand"] and inGarage and isCloseVeh() and not IsPedInAnyVehicle(PlayerPedId(), false))
        end
    },

    {
        id = "general:depots",
        displayName = "Impound: Vehicle List",
        icon = "#garages",
        functionName = "nc-garages:open",
        enableMenu = function()
            local pData = QBCore.Functions.GetPlayerData()
            return (not pData.metadata["isdead"] and not pData.metadata["inlaststand"] and inDepots and not IsPedInAnyVehicle(PlayerPedId(), false))
        end
    },
--[[]
    {
        id = "open-house-garage",
        displayName = "Vehicle List",
        icon = "#garages",
        functionName = "nc-garages:open",
        enableMenu = function()
            local Data = QBCore.Functions.GetPlayerData()
            if not Data.metadata["isdead"] and not Data.metadata["inlaststand"] and exports['nc-garages']:isNearHouseGarage() and not IsPedInAnyVehicle(PlayerPedId()) then
                return true
            end
            return false
        end
    },

    {
        id = "park-house-garage",
        displayName = "Park Vehicle",
        icon = "#garages-parking",
        functionName = "nc-garages:store",
        enableMenu = function()
            local Data = QBCore.Functions.GetPlayerData()
            if not Data.metadata["isdead"] and not Data.metadata["inlaststand"] and exports['nc-garages']:isNearHouseGarage() and NearAnyVehicle() then
                return true
            end
            return false
        end
    },]]
}

newSubMenus = {
    -- General --
    ['vehicle:giveKeys'] = {
        title = "Give Keys",
        icon = "#vehicle-givekeys",
        functionName = "vehiclekeys:client:GiveKeys"
    },

    ['general:flipveh'] = {
        title = "Flip Vehicle",
        icon = "#general-flip-vehicle",
        functionName = "vehicle:flipit"
    },

    ['general:hotdog'] = {
        title = "Toggle Sale",
        icon = "#hotdog",
        functionName = "qb-hotdogjob:client:ToggleSell"
    },
    
    ['general:givenum'] = {
        title = "Provide Contact Details",
        icon = "#givenum",
        functionName = "qb-phone:client:GiveContactDetails"
    },

    ['general:getintrunk'] = {
        title = "Enter Trunk",
        icon = "#getintrunk",
        functionName = "nc-trunk:client:GetIn"
    },

    ['general:cornerselling'] = {
        title = "Corner Selling",
        icon = "#cornerselling",
        functionName = "qb-drugs:client:cornerselling"
    },

    ['general:cornerselling'] = {
        title = "Corner Selling",
        icon = "#cornerselling",
        functionName = "qb-drugs:client:cornerselling"
    },

    ['house:give'] = {
        title = "Give House Key",
        icon = "#house-givekey",
        functionName = "nc-houses:client:giveHouseKey"
    },

    ['power:off'] = {
        title = "Disconnect",
        icon = "#radio",
        functionName = "remove:radio"
    },

    ['house:remove'] = {
        title = "Remove House Key",
        icon = "#house-removekey",
        functionName = "nc-houses:client:removeHouseKey"
    },

    ['house:doorlock'] = {
        title = "Toggle Door lock",
        icon = "#police-jail",
        functionName = "nc-houses:client:toggleDoorlock"
    },

    ['house:reset'] = {
        title = "Reset Home lock",
        icon = "#house-resetlock",
        functionName = "nc-houses:client:ResetHouse"
    },

    ['house:decorate'] = {
        title = "Decorate house",
        icon = "#house-decorate",
        functionName = "nc-houses:client:decorate",
        enableMenu = function()
            local Data = QBCore.Functions.GetPlayerData()
            return not Data.metadata["isdead"] and not Data.metadata["inlaststand"]
        end,
    },

    ['house:setstash'] = {
        title = "Set Stash",
        icon = "#house-setstash",
        functionName = "nc-houses:client:setStash",
        functionParameters =  "setstash"
    },
    
    ['house:setoutift'] = {
        title = "Outfit Set",
        icon = "#house-setoutift",
        functionName = "nc-houses:client:setOutfit",
        functionParameters =  "setoutift"
    },
    
    ['house:setlogout'] = {
        title = "Logout",
        icon = "#house-logout",
        functionName = "nc-houses:client:setLogout",
        functionParameters =  "setlogout"
    },

    ['blips:gasstations'] = {
        title = "Gas Stations",
        icon = "#blips-gasstations",
        functionName = "nc-fuel:GasBlips"
    },   

    ['blips:barbershop'] = {
        title = "Barber Shop",
        icon = "#blips-barbershop",
        functionName = "nc-clothes:ToggleHair"
    },   

    ['blips:tattooshop'] = {
        title = "Tattoo Shop",
        icon = "#blips-tattooshop",
        functionName = "nc-clothes:ToggleTattoo"
    },

    ['cuffing:cuff'] = {
        title = "Cuff",
        icon = "#cuffs-cuff",
        enableMenu = function()
            local Data = QBCore.Functions.GetPlayerData()
            return (not Data.metadata["isdead"] and not Data.metadata["inlaststand"] and Data.job ~= nil and Data.job.name ~= "ambulance" and Data.job.name ~= "police" and not IsPedInAnyVehicle(ped, true))
        end,
        functionName = "police:client:CuffPlayerSoft",
    },

    ['cuffing:steal'] = {
        title = "Rob Person",
        icon = "#cuffs-steal",
        functionName = "police:client:RobPlayer",
    },

    ['kidnap:person'] = {
        title = "Kidnap Person",
        icon = "#cuffs-steal",
        functionName = "police:client:KidnapPlayer",
    },
    
    ['kidnap:trunk'] = {
        title = "Kidnap into Trunk",
        icon = "#cuffs-steal",
        functionName = "nc-trunk:client:KidnapTrunk",
    },

    -- Police --
    ['police:drag'] = {
        title = "Escort",
        icon = "#general-escort",
        functionName = "police:client:EscortPlayer",
    },

    ['police:softcuff'] = {
        title = "Soft Cuff",
        icon = "#cuffs-cuff",
        functionName = "police:client:CuffPlayerSoft"
    },
    
    ['police:cuff'] = {
        title = "Cuff",
        icon = "#cuffs-cuff",
        functionName = "police:client:CuffPlayer"
    },

    ['police:unmask'] = {
        title = "Remove Mask Hat",
        icon = "#police-unmask",
        functionName = "police:unmask"
    },

    ['police:checkbank'] = {
        title = "Check Bank",
        icon = "#police-check-bank",
        functionName = "police:client:checkBank"
    },

    ['police:checklicenses'] = {
        title = "Check Licenses",
        icon = "#police-check-licenses",
        functionName = "police:client:checkLicenses"
    },

    ['police:checkfines'] = {
        title = "Check Fines",
        icon = "#police-check-fines",
        functionName = "police:client:checkFines"
    },

    ['police:search'] = {
        title = "Frisk",
        icon = "#police-search",
        functionName = "police:client:SearchPlayer"
    },

    ['deadblip:sendBlip'] = {
        title = "10-11 Distress Call",
        icon = "#police-dead",
        functionName = "qb-menu:senddeadblip"
    },

    ['objects:barier'] = {
        title = "Barrier",
        icon = "#barier",
        functionName = "police:client:spawnBarier"
    },

    ['objects:cone'] = {
        title = "Cone",
        icon = "#cone",
        functionName = "police:client:spawnCone"
    },

    ['objects:tent'] = {
        title = "Tent",
        icon = "#tent",
        functionName = "police:client:spawnTent"
    },

    ['objects:spike'] = {
        title = "Spike",
        icon = "#spike",
        functionName = "police:client:SpawnSpikeStrip"
    },

    ['objects:remove'] = {
        title = "Remove",
        icon = "#removeobject",
        functionName = "police:client:deleteObject"
    },    

    -- EMS --
    ['ems:revive'] = {
        title = "Revive",
        icon = "#ems-revive",
        functionName = "hospital:client:CheckStatus",
    },

    ['ems:status'] = {
        title = "Check status",
        icon = "#ems-revive",
        functionName = "hospital:client:RevivePlayer",
    },

    ['ems:heal'] = {
        title = "Heal",
        icon = "#ems-heal",
        functionName = "hospital:client:TreatWounds",
    },

    ['ems:putinvehicle'] = {
        title = "Seat Vehicle",
        icon = "#general-put-in-veh",
        functionName = "police:client:PutPlayerInVehicle"
    },

    ['ems:unseatvehicle'] = {
        title = "Unseat Nearest",
        icon = "#general-unseat-nearest",
        functionName = "police:client:SetPlayerOutVehicle"
    },

    -- Animations --
    ['animations:brave'] = {
        title = "Brave",
        icon = "#animation-brave",
        functionName = "AnimSet:Brave"
    },

    ['animations:hurry'] = {
        title = "Hurry",
        icon = "#animation-hurry",
        functionName = "AnimSet:Hurry"
    },

    ['animations:business'] = {
        title = "Business",
        icon = "#animation-business",
        functionName = "AnimSet:Business"
    },

    ['animations:tipsy'] = {
        title = "Tipsy",
        icon = "#animation-tipsy",
        functionName = "AnimSet:Tipsy"
    },

    ['animations:injured'] = {
        title = "Injured",
        icon = "#animation-injured",
        functionName = "AnimSet:Injured"
    },

    ['animations:tough'] = {
        title = "Tough",
        icon = "#animation-tough",
        functionName = "AnimSet:ToughGuy"
    },

    ['animations:sassy'] = {
        title = "Sassy",
        icon = "#animation-sassy",
        functionName = "AnimSet:Sassy"
    },

    ['animations:sad'] = {
        title = "Sad",
        icon = "#animation-sad",
        functionName = "AnimSet:Sad"
    },

    ['animations:posh'] = {
        title = "Posh",
        icon = "#animation-posh",
        functionName = "AnimSet:Posh"
    },

    ['animations:alien'] = {
        title = "Alien",
        icon = "#animation-alien",
        functionName = "AnimSet:Alien"
    },

    ['animations:nonchalant'] = {
        title = "Calm",
        icon = "#animation-nonchalant",
        functionName = "AnimSet:NonChalant"
    },

    ['animations:hobo'] = {
        title = "Hobo",
        icon = "#animation-hobo",
        functionName = "AnimSet:Hobo"
    },

    ['animations:money'] = {
        title = "Money",
        icon = "#animation-money",
        functionName = "AnimSet:Money"
    },

    ['animations:swagger'] = {
        title = "Swagger",
        icon = "#animation-swagger",
        functionName = "AnimSet:Swagger"
    },

    ['animations:shady'] = {
        title = "Shady",
        icon = "#animation-shady",
        functionName = "AnimSet:Shady"
    },

    ['animations:maneater'] = {
        title = "Maneater",
        icon = "#animation-maneater",
        functionName = "AnimSet:ManEater"
    },

    ['animations:chichi'] = {
        title = "Chichi",
        icon = "#animation-chichi",
        functionName = "AnimSet:ChiChi"
    },

    ['animations:default'] = {
        title = "Default",
        icon = "#animation-default",
        functionName = "AnimSet:default"
    },

    -- Expressions --
    ["expressions:angry"] = {
        title="Angry",
        icon="#expressions-angry",
        functionName = "expressions",
        functionParameters =  { "mood_angry_1" }
    },

    ["expressions:drunk"] = {
        title="Drunk",
        icon="#expressions-drunk",
        functionName = "expressions",
        functionParameters =  { "mood_drunk_1" }
    },

    ["expressions:dumb"] = {
        title="Dumb",
        icon="#expressions-dumb",
        functionName = "expressions",
        functionParameters =  { "pose_injured_1" }
    },

    ["expressions:electrocuted"] = {
        title="Electrocuted",
        icon="#expressions-electrocuted",
        functionName = "expressions",
        functionParameters =  { "electrocuted_1" }
    },

    ["expressions:grumpy"] = {
        title="Grumpy",
        icon="#expressions-grumpy",
        functionName = "expressions", 
        functionParameters =  { "mood_drivefast_1" }
    },

    ["expressions:happy"] = {
        title="Happy",
        icon="#expressions-happy",
        functionName = "expressions",
        functionParameters =  { "mood_happy_1" }
    },

    ["expressions:injured"] = {
        title="Injured",
        icon="#expressions-injured",
        functionName = "expressions",
        functionParameters =  { "mood_injured_1" }
    },

    ["expressions:joyful"] = {
        title="Joyful",
        icon="#expressions-joyful",
        functionName = "expressions",
        functionParameters =  { "mood_dancing_low_1" }
    },

    ["expressions:mouthbreather"] = {
        title="Mouthbreather",
        icon="#expressions-mouthbreather",
        functionName = "expressions",
        functionParameters = { "smoking_hold_1" }
    },

    ["expressions:normal"]  = {
        title="Normal",
        icon="#expressions-normal",
        functionName = "expressions:clear"
    },

    ["expressions:oneeye"]  = {
        title="Oneeye",
        icon="#expressions-oneeye",
        functionName = "expressions",
        functionParameters = { "pose_aiming_1" }
    },

    ["expressions:shocked"]  = {
        title="Shocked",
        icon="#expressions-shocked",
        functionName = "expressions",
        functionParameters = { "shocked_1" }
    },

    ["expressions:sleeping"]  = {
        title="Sleeping",
        icon="#expressions-sleeping",
        functionName = "expressions",
        functionParameters = { "dead_1" }
    },

    ["expressions:smug"]  = {
        title="Smug",
        icon="#expressions-smug",
        functionName = "expressions",
        functionParameters = { "mood_smug_1" }
    },

    ["expressions:speculative"]  = {
        title="Speculative",
        icon="#expressions-speculative",
        functionName = "expressions",
        functionParameters = { "mood_aiming_1" }
    },

    ["expressions:stressed"]  = {
        title="Stressed",
        icon="#expressions-stressed",
        functionName = "expressions",
        functionParameters = { "mood_stressed_1" }
    },

    ["expressions:sulking"]  = {
        title="Sulking",
        icon="#expressions-sulking",
        functionName = "expressions",
        functionParameters = { "mood_sulk_1" },
    },

    ["expressions:weird"]  = {
        title="Weird",
        icon="#expressions-weird",
        functionName = "expressions",
        functionParameters = { "effort_2" }
    },

    ["expressions:weird2"]  = {
        title="Weird 2",
        icon="#expressions-weird2",
        functionName = "expressions",
        functionParameters = { "effort_3" }
     },    

    -- Jobs --
    ['news:boom'] = {
        title = "Boom Microphone",
        icon = "#news-boom",
        functionName = "Mic:ToggleBMic"
    },

    ['news:cam'] = {
        title = "Camera",
        icon = "#news-cam",
        functionName = "Cam:ToggleCam"
    },

    ['news:mic'] = {
        title = "Microphone",
        icon = "#news-mic",
        functionName = "Mic:ToggleMic"
    },
    
    ["taxi:togglemeter"] = {
        title = "Show/Hide Meter",
        icon = "#taxi-togglemeter",
        functionName = "nc-taxi:client:toggleMeter",
    },

    ["taxi:npcmission"] = {
        title = "Start/Stop Meter",
        icon = "#taxi-power",
        functionName = "nc-taxi:client:enableMeter",
    },

    ["npc_mission"] = {
        title = "NPC Mission",
        icon = "#mechanic-flatbed",
        functionName = "nc-taxi:client:DoTaxiNpc",
    },
    
    ["tow:togglenpc"] = {
        title = "Toggle NPC",
        icon = "#tow-npcmission",
        functionName = "jobs:client:ToggleNpc",
    },
    
    ["tow:towvehicle"] = {
        title = "Hoist Vehicle",
        icon = "#mechanic-flatbed",
        functionName = "nc-tow:client:TowVehicle",
    },

    ["tow:checkstatus"] = {
        title = "Check Status",
        icon = "#tow-status",
        functionName = "nc-tow:client:status",
    },

    ["realestate:houses"] = {
        title = "List of houses",
        icon = "#laptop-house",
        functionName = "qb-realestate:client:OpenHouseListMenu"
    },

    ["mechanic:impound"] = {
        title = "Impound",
        icon = "#police-jail",
        functionName = "nc-tow:client:ImpoundVehicle"
    },

    ["mechanic:flatbed"] = {
        title = "Tow",
        icon = "#mechanic-flatbed",
        functionName = "nc-tow:client:TowVehicle"
    },
    ["mechanic:clean"] = {
        title = "Clean Vehicle",
        icon = "#mechanic-flatbed",
        functionName = "mechanic:client:CleanVehicle"
    },
    ["mechanic:repair"] = {
        title = "Repair Vehicle",
        icon = "#mechanic-flatbed",
        functionName = "mechanic:client:AdvancedRepairVehicle"
    },
    ["mechanic:repairfull"] = {
        title = "Full Repair",
        icon = "#mechanic-flatbed",
        functionName = "nc-tow:client:TowVehicle"
    },
}
for i=1, 10 do
    newSubMenus["radio:"..i] = {
        title = "Radio\n"..i,
        icon = "#radio",
        functionName = "nc-radio:radialmenu",
        functionParameters = i,
    }
end

function isCloseVeh()
    local ped = PlayerPedId()
    coordA = GetEntityCoords(ped, 1)
    coordB = GetOffsetFromEntityInWorldCoords(ped, 0.0, 100.0, 0.0)
    vehicle = getVehicleInDirection(coordA, coordB)
    if DoesEntityExist(vehicle) and NetworkHasControlOfEntity(vehicle) then
        return true
    end
    return false
end

function GetPlayers()
    local players = {}
    
    for i = 0, 128 do
        if NetworkIsPlayerActive(i) then
            players[#players+1]= i
        end
    end

    return players
end

function GetClosestPlayer()
    local players = GetPlayers()
    local closestDistance = -1
    local closestPlayer = -1
    local closestPed = -1
    local ply = PlayerPedId()
    local plyCoords = GetEntityCoords(ply, 0)
    if not IsPedInAnyVehicle(PlayerPedId(), false) then
        for index,value in ipairs(players) do
            local target = GetPlayerPed(value)
            if(target ~= ply) then
                local targetCoords = GetEntityCoords(GetPlayerPed(value), 0)
                local distance = #(vector3(targetCoords["x"], targetCoords["y"], targetCoords["z"]) - vector3(plyCoords["x"], plyCoords["y"], plyCoords["z"]))
                if(closestDistance == -1 or closestDistance > distance) and not IsPedInAnyVehicle(target, false) then
                    closestPlayer = value
                    closestPed = target
                    closestDistance = distance
                end
            end
        end
        return closestPlayer, closestDistance, closestPed
    end
end

Citizen.CreateThread(function()
    for k, v in pairs(Garages) do
        exports["nc-polyzone"]:AddBoxZone("garages", vector3(Garages[k].polyzone.x, Garages[k].polyzone.y, Garages[k].polyzone.z), Garages[k].polyzone1, Garages[k].polyzone2, {
            name="garages",
            heading=Garages[k].heading,
            debugPoly=false
        }) 
    end
    for k, v in pairs(GangGarages) do
        exports["nc-polyzone"]:AddBoxZone("ganggarages", vector3(GangGarages[k].polyzone.x, GangGarages[k].polyzone.y, GangGarages[k].polyzone.z), GangGarages[k].polyzone1, GangGarages[k].polyzone2, {
            name="ganggarages",
            heading=GangGarages[k].heading,
            debugPoly=false
        }) 
    end
    for k, v in pairs(JobGarages) do
        exports["nc-polyzone"]:AddBoxZone("jobgarages", vector3(JobGarages[k].polyzone.x, JobGarages[k].polyzone.y, JobGarages[k].polyzone.z), JobGarages[k].polyzone1, JobGarages[k].polyzone2, {
            name="jobgarages",
            heading=JobGarages[k].heading,
            debugPoly=false
        }) 
    end
    for k, v in pairs(Depots) do
        exports["nc-polyzone"]:AddBoxZone("depots", vector3(Depots[k].polyzone.x, Depots[k].polyzone.y, Depots[k].polyzone.z), Depots[k].polyzone1, Depots[k].polyzone2, {
            name="depots",
            heading=Depots[k].heading,
            debugPoly=false
        }) 
    end
end)

RegisterNetEvent('nc-polyzone:enter')
AddEventHandler('nc-polyzone:enter', function(name)
    local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
    if name == "garages" then
        inGarage = true
    elseif name == "ganggarages" then
        inGarage = true
    elseif name == "jobgarages" then
        inGarage = true
    elseif name == "depots" then
        inDepots = true
    end
end)

RegisterNetEvent('nc-polyzone:exit')
AddEventHandler('nc-polyzone:exit', function(name)
    if name == "garages" then
        inGarage = false
    elseif name == "ganggarages" then
        inGarage = false
    elseif name == "jobgarages" then
        inGarage = false
    elseif name == "depots" then
        inDepots = false
    end
end)

TrunkClasses = {
    [0]  = { allowed = true, x = 0.0, y = -1.5, z = 0.0 }, --Coupes  
    [1]  = { allowed = true, x = 0.0, y = -2.0, z = 0.0 }, --Sedans  
    [2]  = { allowed = true, x = 0.0, y = -1.0, z = 0.25 }, --SUVs  
    [3]  = { allowed = true, x = 0.0, y = -1.5, z = 0.0 }, --Coupes  
    [4]  = { allowed = true, x = 0.0, y = -2.0, z = 0.0 }, --Muscle  
    [5]  = { allowed = true, x = 0.0, y = -2.0, z = 0.0 }, --Sports Classics  
    [6]  = { allowed = true, x = 0.0, y = -2.0, z = 0.0 }, --Sports  
    [7]  = { allowed = true, x = 0.0, y = -2.0, z = 0.0 }, --Super  
    [8]  = { allowed = false, x = 0.0, y = -1.0, z = 0.25 }, --Motorcycles  
    [9]  = { allowed = true, x = 0.0, y = -1.0, z = 0.25 }, --Off-road  
    [10] = { allowed = true, x = 0.0, y = -1.0, z = 0.25 }, --Industrial  
    [11] = { allowed = true, x = 0.0, y = -1.0, z = 0.25 }, --Utility  
    [12] = { allowed = true, x = 0.0, y = -1.0, z = 0.25 }, --Vans  
    [13] = { allowed = true, x = 0.0, y = -1.0, z = 0.25 }, --Cycles  
    [14] = { allowed = true, x = 0.0, y = -1.0, z = 0.25 }, --Boats  
    [15] = { allowed = true, x = 0.0, y = -1.0, z = 0.25 }, --Helicopters  
    [16] = { allowed = true, x = 0.0, y = -1.0, z = 0.25 }, --Planes  
    [17] = { allowed = true, x = 0.0, y = -1.0, z = 0.25 }, --Service  
    [18] = { allowed = true, x = 0.0, y = -1.0, z = 0.25 }, --Emergency  
    [19] = { allowed = true, x = 0.0, y = -1.0, z = 0.25 }, --Military  
    [20] = { allowed = true, x = 0.0, y = -1.0, z = 0.25 }, --Commercial  
    [21] = { allowed = true, x = 0.0, y = -1.0, z = 0.25 }, --Trains  
}