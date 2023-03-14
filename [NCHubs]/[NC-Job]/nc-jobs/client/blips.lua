-- -- Add blips as per below examples:
-- -- https://docs.fivem.net/docs/game-references/blips/

-- local blips = {
--   {title="Casino", colour=15 , id=680,x = 948.81, y = 34.26, z = 71.83},
--   {title="Callisto Motel", colour=11 , id=475,x = 390.68, y = 0.88, z = 91.94},
--   {title="Metal Detecting Sales", colour=8 , id=256,x = -1343.15, y = -1234.89, z = 5.94},
--   {title="CityBank Paychecks", colour=66 , id=464,x = -1317.46, y = -831.85, z = 16.97},
--   {title="Buy & Sell Diving Stuff", colour=5 , id=186,x = -1684.71, y = -1068.9, z = 13.15},
--   {title="Quick Delivery Work", colour=48 , id=126,x = 474.71, y = -1456.45, z = 29.29},
--   {title="Arcade Bar", colour=35 , id=269,x = -1270.04, y = -305.22, z = 36.99},
--   {title="Vespucci Beach", colour=36 , id=304,x = -1289.34, y = -1415.07, z = 4.84},
--   {title="Vape Shop", colour=13 , id=469,x = -1251.29, y = -1448.46, z = 4.37},
--   {title="Police Station - #3", colour=5 , id=60,x = 375.96, y = -1595.56, z = 30.05},
--   {title="Car Dealership", colour=43 , id=523,x = -920.84, y = -2032.97, z = 9.5},
--   {title="Pokemon Cards Shop", colour=43 , id=368,x =  -143.92, y = 229.75, z = 94.94}, 
--  }
 
 
--  -- To add additional function to the below blip display, you can add natives to change/add/remove various things, just go here (https://docs.fivem.net/natives/) and search 'SetBlip' and it will give you a list. Example: https://docs.fivem.net/natives/?_0xB14552383D39CE3E
 
-- CreateThread(function()

--    for _, info in pairs(blips) do
--      info.blip = AddBlipForCoord(info.x, info.y, info.z)
--      SetBlipSprite(info.blip, info.id)
--      SetBlipDisplay(info.blip, 4)
--      SetBlipScale(info.blip, 0.7) -- This is the size of the blip, 0.65 is fairly good.
--      SetBlipColour(info.blip, info.colour)
--      SetBlipAsShortRange(info.blip, true)
-- 	   BeginTextCommandSetBlipName("STRING")
--      AddTextComponentString(info.title)
--      EndTextCommandSetBlipName(info.blip)
--    end
-- end)
