Config = {}

Config.Location = vector3(-920.38, -2033.11, 9.5) -- The location of the vehicleshop.

Config.BoughtVehicleSpawnLocation = {coords= vector3(-907.84, -2044.89, 8.91),heading = 224.64} -- The location where the purchased/testdrive vehicle will be spawned.

Config.Blip = {
  id = 326,
  color = 3,
  scale = 0.8,
  label = "Vehicle Shop",
  showBlip = false
}

------------------------------------------------------------------------------------------------------------------------
-- Vehicle Stock
------------------------------------------------------------------------------------------------------------------------

Config.Hour = 20 -- The time when new vehicles will be added to the stock.
Config.NumOfVehicles = 5 -- The amount of vehicles that will be added to the stock.

-- Every day the stock renewing itself with 5 (Config.NumOfVehicles = 5) new vehicles at 12:00 p.m. (Config.Hour = 12).
-- In order for the stock to work you need to call the Config.SetDefaultStockEvent function, Otherwise the stock will be UNLIMITED. 

------------------------------------------------------------------------------------------------------------------------
-- Test Drive
------------------------------------------------------------------------------------------------------------------------

Config.TestDrive = {
    testDriveTimer = 60, -- Duration of the test drive (seconds).
    testDriveCost = 350, -- The price of the test drive.
}

------------------------------------------------------------------------------------------------------------------------
-- Categories And Vehicles
------------------------------------------------------------------------------------------------------------------------

Config.Vehicles = {
    -- { -- A category that shows the vehicles that added into stock today. DONT TOUCH IF YOU WANT THIS OPTION/CATEGORY.
    --   title = "daily vehicles", -- Title of category.
    --   buttons = {} -- DONT TOUCH!
    -- },

    -- Examples:

    {
      title = "Custom Cars -#1-", -- Title of category.
      buttons = {
        {name = "Ferrari 488", costs = 5000, model = "488misha"},
        {name = "Toyota GT 86", costs = 55000, model = "gt86"},
        {name = "Lexus LC500", costs = 60000, model = "lc500"},
        {name = "Toyota Supra 2020", costs = 95000, model = "tsgr20"},
        {name = "Audi R8", costs = 50000, model = "r8h"},
        {name = "Mercedes G63", costs = 150000, model = "22g63"},
        {name = "Penumbra Sport", costs = 30000, model = "penumbra3"},
        {name = "HONDA filthy nsx", costs = 50000, model = "filthynsx"},
        {name = "Aston Martin Vulcan", costs = 50000, model = "vulcan"},
        {name = "Jeep Trackhawk", costs = 50000, model = "srt8b"},
        {name = "BMW M2", costs = 50000, model = "m2f22"},
        {name = "Honda Odyssey", costs = 50000, model = "honody"},
        {name = "Hyundai VelosterN", costs = 50000, model = "veln"},
        {name = "KIA Stinger", costs = 50000, model = "kiagt"},
        {name = "AMC aamx", costs = 50000, model = "aamx"},
        {name = "ASTON MARTIN V877", costs = 50000, model = "v877"},
        {name = "BMW M3 E30", costs = 50000, model = "m3e30"},
        {name = "Mazda FC35", costs = 50000, model = "mfc"},
      }
    },
    {
      title = "Custom Cars -#2-", -- Title of category.
      buttons = {
        {name = "PORSCHE por930", costs = 50000, model = "por930"},
        {name = "Honda Na1", costs = 50000, model = "na1"},
        {name = "MERCEDES Gtr", costs = 50000, model = "gtrc"},
        {name = "mitsubishi cp9a", costs = 50000, model = "cp9a"},
        {name = "BMW e36 prb", costs = 50000, model = "e36prb"},
        {name = "PAGANI", costs = 50000, model = "bc"},
        {name = "PORSCHE GT322", costs = 50000, model = "pgt322"},
        {name = "DODGE charger 69", costs = 50000, model = "69charger"},
        {name = "Corvette c7", costs = 50000, model = "c7"},
        {name = "Dodge Demon", costs = 50000, model = "demon"},
        {name = "Ford Mustang 19", costs = 50000, model = "mustang19"},
        {name = "Mazda Na6", costs = 50000, model = "na6"},
        {name = "Yamaha R1", costs = 50000, model = "r1"},
        {name = "audi rs6", costs = 50000, model = "audirs6tk"},
        {name = "LEXUS rcf", costs = 50000, model = "rcf"},
        {name = "Mercedes-AMG GT63", costs = 50000, model = "gt63"},
        {name = "Honda Civic FK8", costs = 50000, model = "FK8"},
        {name = "Camaro Zl1 exor", costs = 50000, model = "exor"},
      }
    },
    {
      title = "Custom Cars -#3-", -- Title of category.
      buttons = {
        {name = "LAMBORGHINI lp670", costs = 50000, model = "lp670"},
        {name = "Honda fnf rx7", costs = 50000, model = "fnfrx7"},
        {name = "Ford Raptor f150", costs = 50000, model = "f150"},
        {name = "PORSCHE PANAMERA TURBO 17", costs = 50000, model = "panamera17turbo"},
        {name = "nissan s15rb", costs = 50000, model = "s15rb"},
        {name = "Camaro Z28", costs = 50000, model = "z2879"},
        {name = "Bentley dragon", costs = 50000, model = "bdragon"},
        {name = "Honda Civic EG VTI 94", costs = 50000, model = "delsoleg"},
        {name = "Toyota Supra A80", costs = 50000, model = "a80"},
        {name = "Subaru impreza wrs sti", costs = 50000, model = "subwrx"},
        {name = "Ford Mustang", costs = 50000, model = "rmodmustang"},
        {name = "Honda S2000", costs = 50000, model = "ap2"},
        {name = "Ford fastback 66", costs = 50000, model = "66fastback"},
        {name = "BMW I8", costs = 50000, model = "acs8"},
        {name = "Nissan SkyLine r34", costs = 50000, model = "fnf4r34"},
        {name = "Ferrari LaFerrari 17", costs = 50000, model = "laferrari17"},
        {name = "Bravado Gauntlet 6str", costs = 50000, model = "gauntlet6str"},
        {name = "ladybird 6str", costs = 50000, model = "ladybird6str"},
        {name = "Sentinel 6str", costs = 50000, model = "sentinel6str2"},
        {name = "dilettante Abdul Taxi", costs = 50000, model = "dilettante3"},
        {name = "granger", costs = 50000, model = "mwgranger"},
        {name = "sultan rs v8", costs = 50000, model = "sultanrsv8"},
        {name = "hellion 6str'", costs = 50000, model = "hellion6str"},
      }
    },
    {
      title = "Custom Cars -#4-", -- Title of category.
      buttons = {
        {name = "Brabham bt62r", costs = 50000, model = "bt62r"},
        {name = "POLESTAR one", costs = 50000, model = "starone"},
        {name = "lamborghini lp700", costs = 50000, model = "lp700"},
        {name = "FORD GT 17", costs = 50000, model = "gt17"},
        {name = "Nissan SkyLine r32", costs = 50000, model = "r32"},
        {name = "BMW M4", costs = 50000, model = "m4"},
        {name = "Lexus lfa", costs = 50000, model = "lfa"},
        {name = "Aston Martin db11", costs = 50000, model = "db11"},
        {name = "deluxo 2", costs = 50000, model = "deluxo2"},
        {name = "deluxo 6str", costs = 50000, model = "deluxo6str"},
        {name = "mclaren senna", costs = 50000, model = "senna"},
        {name = "Audi r8 v10", costs = 50000, model = "r8v10"},
        {name = "MCLAREN 720s", costs = 50000, model = "720s"},
        {name = "harley davidson", costs = 50000, model = "rudiharley"},
        {name = "kawasaki zx10", costs = 50000, model = "zx10"},
        {name = "NAGASAKI bmw", costs = 50000, model = "bmwr"},
        {name = "BMW M5 E60", costs = 50000, model = "m5e60"},
        {name = "LAMBORGHINI diablo gtr", costs = 50000, model = "500gtrlam"},
        {name = "MITSUBISHI evo9", costs = 50000, model = "evo9"},
        {name = "cadillac esv", costs = 50000, model = "esv"},
        {name = "honda dc5", costs = 50000, model = "DC5"},
        {name = "maserati gran lb", costs = 50000, model = "granlb"},
        {name = "Nissan GTR R35", costs = 50000, model = "r35"},
        {name = "Nissan GTR", costs = 50000, model = "gtr"},
        {name = "lamborghini tempesta 2", costs = 50000, model = "tempesta2"},
      }
    },
    {
      title = "Custom Cars -#5-", -- Title of category.
      buttons = {
        {name = "NISSAN z33", costs = 50000, model = "maj350z"},
        {name = "NISSAN s30", costs = 50000, model = "s30"},
        {name = "NISSAN s14", costs = 50000, model = "s14"},
        {name = "SUBARU 22b", costs = 50000, model = "22b"},
        {name = "MAZDA rx811", costs = 50000, model = "rx811"},
        {name = "bmw M5CS", costs = 50000, model = "22m5"},
        {name = "lexus gs", costs = 50000, model = "gs350"},
        {name = "renault clio", costs = 50000, model = "cliors"},
        {name = "FORD focus rs", costs = 50000, model = "ffrs"},
        {name = "Mercedes A45 amg", costs = 50000, model = "a45amg"},
        {name = "PORSCHE CARRERAGT", costs = 50000, model = "CGT"},
        {name = "DODGE 68 dart", costs = 50000, model = "68dart"},
        {name = "MercedesBenz c63", costs = 50000, model = "mbc63"},
        {name = "NISSAN 180sx", costs = 50000, model = "nis180"},
        {name = "Range Rover rr14", costs = 50000, model = "rr14'"},
        {name = "toyota land cruiser", costs = 50000, model = "lc100"},
        {name = "Aston Martin victor", costs = 50000, model = "victor"},
        {name = "McLaren 675lt sp", costs = 50000, model = "675ltsp"},
        {name = "BUGATTI bolide", costs = 50000, model = "bolide"},
      }
    },
    {
      title = "Compacts", -- Title of category.
      buttons = {
        {name = "Panto", costs = 5000, model = "panto"},
        {name = "Serrano", costs = 55000, model = "serrano"},
        {name = "Dubsta", costs = 60000, model = "dubsta"},
        {name = "Baller LE", costs = 95000, model = "baller4"},
        {name = "Hammer", costs = 50000, model = "patriot"},
        {name = "Toros", costs = 150000, model = "toros"},
        {name = "Bravado Gresley", costs = 30000, model = "gresley"},
        {name = "Mesa", costs = 50000, model = "mesa"},
      }
    },
    {
      title = "Muscle", -- Title of category.
      buttons = {
        {name = "Dukes", costs = 34000, model = "dukes"},
        {name = "Faction", costs = 48000, model = "faction"},
        {name = "Picador", costs = 24000, model = "picador"},
        {name = "Buffalo", costs = 30000, model = "Buffalo"},
        {name = "Vamos", costs = 44000, model = "vamos"},
        {name = "Slam Van 3", costs = 35000, model = "slamvan3"},
        {name = "Virgo 3", costs = 45000, model = "virgo3"},
        {name = "Chino 2", costs = 35000, model = "Chino2"},
        {name = "Futo", costs = 30000, model = "futo"},
        {name = "Sentinel3", costs = 60000, model = "sentinel3"},
        {name = "Sultan RS", costs = 65000, model = "sultanrs"},
      }
    },
    {
      title = "Sedans", -- Title of category.
      buttons = {
        {name = "Super Diamond", costs = 75000, model = "superd"},
        {name = "Surge (Auto-Pilot)", costs = 34000, model = "surge"},
        {name = "Primo Custom", costs = 37000, model = "primo2"},
        {name = "Progen Itali GTB Custom", costs = 195000, model = "italigtb2"},
      }
    },
    {
      title = "Offroad", -- Title of category.
      buttons = {
        {name = "Brawler", costs = 57000, model = "brawler"},
        {name = "Kamacho", costs = 78000, model = "kamacho"}, -- doomsday Heist , handling done
        {name = "Lifted Mesa", costs = 65000, model = "mesa3"},
        {name = "Kalahari", costs = 16000, model = "kalahari"},
        {name = "Guardian", costs = 70000, model = "guardian"},
        {name = "Hellion", costs = 70000, model = "hellion6str"},
      }
    },
    {
      title = "Sports", -- Title of category.
      buttons = {
        {name = "Carbonizzare", costs = 57000, model = "carbonizzare", maxStock = 10},
        {name = "Feltzer", costs = 88000, model = "feltzer2"},
        {name = "Specter", costs = 93000, model = "specter"},
        {name = "Cheetah", costs = 225000, model = "Cheetah"},
        {name = "Pfister Neon", costs = 250000, model = "neon"},
        {name = "Infernus Classic", costs = 78000, model = "Infernus2"},
        {name = "Khamelion", costs = 92000, model = "Khamelion"},
        {name = "Ruston", costs = 63000, model = "Ruston"},
        {name = "Comet Retro", costs = 156000, model = "comet3"},
        {name = "Pfister Comet", costs = 100000, model = "comet2"},
        {name = "LG", costs = 75000, model = "elegy"},
        {name = "Sultan", costs = 80000, model = "sultan"},
      }
    },
    {
      title = "Sports Classics", -- Title of category.
      buttons = {
        {name = "Stinger GT", costs = 70000, model = "stingergt"},
        {name = "190z", costs = 58000, model = "z190"}, -- doomsday Heist , handling done
        {name = "Stirling GT", costs = 26000, model = "feltzer3"},
        {name = "Lampadati Casco", costs = 26000, model = "casco"},
      }
    },
    {
      title = "Vans", -- Title of category.
      buttons = {
        {name = "Bobcat XL", costs = 27000, model = "bobcatxl"},
        {name = "Vapid Minivan Custom", costs = 23000, model = "minivan"},
        {name = "Gang Burrito", costs = 22000, model = "gburrito"},
        {name = "Pony 2", costs = 15000, model = "pony2"}
      }
    },
    {
      title = "MotorCycles", -- Title of category.
      buttons = {
        {name = "Akuma", costs = 15000, model = "akuma", maxStock = 15},
        {name = "BATI", costs = 180000, model = "bati"},
        {name = "Daemon", costs = 23000, model = "daemon"},
        {name = "Nemesis", costs = 16000, model = "nemesis"},
        {name = "Ruffian", costs = 15500, model = "ruffian"},
        {name = "Vader", costs = 16000, model = "vader"},
        {name = "Hakuchou", costs = 19000, model = "hakuchou"},
        {name = "Sanchez 2", costs = 16000, model = "sanchez2"},
        {name = "BF 400", costs = 7500, model = "bf400"},
        {name = "Harley Davidson", costs = 7500, model = "rudiharley"},
      }
    }
}
-- Explanation of the buttons:
--[[
    name = vehicle's label (The name which is displayed in the vehicle menu).
    costs = vehicle's price.
    model = vehicle's model.
    stock = The maximum stock a vehicle can reach (Explanation from above).
]]

------------------------------------------------------------------------------------------------------------------------
-- Color selection:
------------------------------------------------------------------------------------------------------------------------

-- Full list of colors - https://wiki.rage.mp/index.php?title=Vehicle_Colors
Config.Colors = {
  {r = 255, g = 255, b = 246, colorName = "white", gtaColor = 111},
  {r = 13, g = 17, b = 22, colorName = "black", gtaColor = 0},
  {r = 194, g = 196, b = 198, colorName = "grey", gtaColor = 5},
  {r = 255, g = 207, b = 32, colorName = "yellow", gtaColor = 88},
  {r = 18, g = 56, b = 60, colorName = "green", gtaColor = 51},
  {r = 207, g = 31, b = 33, colorName = "red", gtaColor = 39},
  {r = 71, g = 87, b = 143, colorName = "blue", gtaColor = 64},
  {r = 242, g = 31, b = 153, colorName = "pink", gtaColor = 135},
  {r = 102, g = 184, b = 31, colorName = "limegreen", gtaColor = 55},
  {r = 110, g = 163, b = 198, colorName = "lightblue", gtaColor = 74},
}
-- Explanation of color selection:
--[[
    r,g,b = (The color rgb values according to your gta color).
    colorName = color's name (put whatever you want).
    gtaColor = the color number from gta list.
]]

------------------------------------------------------------------------------------------------------------------------
-- Functions:
------------------------------------------------------------------------------------------------------------------------

-- Client:
Config.BuyVehicleFunc = function(Core,vehicleEntity,vehicleName)
  --[[
    This function is called when the purchased vehicle's entity is created and after the player has paid for the vehicle. 
    Parameters:
      @Core: The current core object.
      @vehicleEntity: The purchased vehicle's entity after it's been created.
      @vehicleName: The model listed in Config.Vehicles.
    
    Example for implementation:
    ]]
    local vehicleProps = Core.Functions.GetVehicleProperties(vehicleEntity)
    local model = GetEntityModel(vehicleEntity)
    vehicleProps.displayName = vehicleName
    TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(vehicleEntity), vehicleEntity)
    TriggerServerEvent('nc-vehicleshopui:setVehicleOwned', vehicleProps)
end

Config.TestDriveFunc = function(Core,vehicleEntity)
  --[[
    This function is called when the test drive vehicle's entity is created and after the player has paid for the test drive. 
    Parameters:
      @Core: The current core object.
      @vehicleEntity: The purchased vehicle's entity after it's been created.
    
    Example for implementation (Probably for hotwire add keys event/export):
    ]]
    TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(vehicleEntity), vehicleEntity)
end

-- Server:
Config.GetPlayerMoney = function(playerId,Core)
  --[[
    This function is used for getting the player's money.
    Parameters:
      @playerId: The player server id/source.
      @Core: The current core object.
    
    Example for Qbus implementation is down below.
    ]]
    if type(playerId) == "number" then
        local player = Core.Functions.GetPlayer(playerId)
        if player then
            return player.PlayerData.money["cash"]
        end
    end
end

Config.RemovePlayerMoney = function(playerId, amount, Core)
  --[[
    This function is used for paying for the vehicle/testdrive.
    Parameters:
      @playerId: The player server id/source.
      @amount: the amount to pay.
      @Core: The current core object.
    
    Example for Qbus implementation is down below.
    ]]
    local player = Core.Functions.GetPlayer(playerId)
    if player then
        player.Functions.RemoveMoney("cash", amount)
    end
end

Config.GetPlayerNameFunc = function(playerId,Core)
  --[[
    This function is used for getting the character's name.
    Parameters:
      @playerId: The player server id/source.
      @Core: The current core object.
    
    Example for Qbus implementation is down below.
    ]]
    local player = Core.Functions.GetPlayer(playerId)
    return player.PlayerData.charinfo.firstname .. " " .. player.PlayerData.charinfo.lastname 
end

Config.ResetStockEvent = {
    name = "nc-vehicleshopui:resetstock", -- This event resets the vehicles' stock. [*Server Side*],
    safe_for_net = false --[[
        true = allows you to trigger the event from a client side script and from a server side script.
        false =  allows you to trigger the event from a server side script only.
    ]]
}
   
Config.SetDefaultStockEvent = {
  name = "nc-vehicleshopui:setDefaultStock", -- This event generates the stock.json file with values from the config.lua [*It is recommended to do it on first launch.]
  safe_for_net = true --[[
    true = allows you to trigger the event from a client side script and from a server side script.
    false =  allows you to trigger the event from a server side script only.
  ]]
}