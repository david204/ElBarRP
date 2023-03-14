local i = 0;

local function AddBoxZone(name, center, length, width, options)
    i = i + 1;
    exports['qb-target']:AddBoxZone(("%s-%s"):format(name, i), center, length, width, options, {
        options = {
            {
                ['icon'] = "fas fa-tshirt",
                ['label'] = "Buy Clothes",
                ['event'] = 'clothing:interact',
                ['arg'] = 'clothesmenu'
            },
        --[[]    {
                ['icon'] = "fas fa-list-alt",
                ['label'] = "Manage Outfits",
                ['event'] = 'nc-outfits:server:openUI',
                ['type'] = "server",
                ['arg'] = 'clothesmenu'
            },]]
        },
        job = {"all"},
        distance = 10.0
    });
end

local function Interact()
    -- AddBoxZone("clothing_shop", vector3(1098.07, 203.27, -49.44), 1.8, 2.4, {
	-- 	heading=315,
	-- 	minZ=-50.44,
	-- 	maxZ=-48.04
  	-- })

	-- AddBoxZone("clothing_shop", vector3(1692.16, 4822.06, 42.06), 5.2, 4.4, {
	-- 	heading=8,
	-- 	minZ=41.09,
	-- 	maxZ=43.69
	-- })
	
	-- AddBoxZone("clothing_shop", vector3(-1177.32, -1780.57, 3.91), 2.4, 2.6, {
	-- 	heading=34,
	-- 	minZ=2.09,
	-- 	maxZ=5.69
	-- })
	
	-- AddBoxZone("clothing_shop", vector3(198.53, -1647.11, 29.8), 3.2, 2, {
	-- 	heading=50,
	-- 	minZ=28.8,
	-- 	maxZ=31.4
	-- })
	
	-- AddBoxZone("clothing_shop", vector3(-710.38, -153.34, 37.42), 3.6, 2, {
	-- 	heading=30,
	-- 	minZ=36.37,
	-- 	maxZ=38.77
	-- })
	
	-- AddBoxZone("clothing_shop", vector3(-1191.46, -770.67, 17.32), 6.8, 6.0, {
	-- 	heading=35,
	-- 	minZ=16.32,
	-- 	maxZ=18.52
	-- })

	-- AddBoxZone("clothing_shop", vector3(423.71, -807.34, 29.49), 4.6, 4.4, {
	-- 	heading=0,
	-- 	minZ=28.49,
	-- 	maxZ=31.09
	-- })
	
	-- AddBoxZone("clothing_shop", vector3(-162.12, -303.49, 39.73), 4.8, 3.4, {
	-- 	heading=340,
	-- 	minZ=38.73,
	-- 	maxZ=41.13
	-- })
	
	-- AddBoxZone("clothing_shop", vector3(77.17, -1391.83, 29.38), 4.6, 4.2, {
	-- 	heading=0,
	-- 	minZ=28.38,
	-- 	maxZ=31.18
	-- })
	
	-- AddBoxZone("clothing_shop", vector3(-820.24, -1074.56, 11.33), 4.6, 5.2, {
	-- 	heading=30,
	-- 	minZ=10.33,
	-- 	maxZ=12.73
	-- })
	
	-- AddBoxZone("clothing_shop", vector3(-1451.41, -236.7, 49.8), 5.6, 3.4, {
	-- 	heading=319,
	-- 	minZ=48.09,
	-- 	maxZ=51.69
	-- })
	
	-- AddBoxZone("clothing_shop", vector3(2.7, 6512.82, 31.88), 5.0, 4.2, {
	-- 	heading=315,
	-- 	minZ=30.09,
	-- 	maxZ=31.69
	-- })
	
	-- AddBoxZone("clothing_shop", vector3(617.2, 2762.5, 42.09), 5.6, 8.4, {
	-- 	heading=3,
	-- 	minZ=41.09,
	-- 	maxZ=43.69
	-- })
	
	-- AddBoxZone("clothing_shop", vector3(1197.9, 2708.73, 38.22), 4.0, 5.0, {
	-- 	heading=0,
	-- 	minZ=37.22,
	-- 	maxZ=39.82
	-- })
	
	-- AddBoxZone("clothing_shop", vector3(-3173.26, 1045.35, 20.86), 5.2, 7.0, {
	-- 	heading=335,
	-- 	minZ=19.66,
	-- 	maxZ=22.26
	-- })
	
	-- AddBoxZone("clothing_shop", vector3(-1099.3, 2709.9, 19.12), 4.6, 4.6, {
	-- 	heading=43,
	-- 	minZ=17.92,
	-- 	maxZ=21.12
	-- })
	
	-- AddBoxZone("clothing_shop", vector3(122.81, -222.09, 54.56), 5.4, 8.0, {
	-- 	heading=340,
	-- 	minZ=53.36,
	-- 	maxZ=56.36
	-- })
	
	-- AddBoxZone("clothing_shop", vector3(1783.96, 2492.59, 45.82), 3.4, 2.0, {
	-- 	heading=300,
	-- 	minZ=44.82,
	-- 	maxZ=47.62,
	-- 	data = { 
	-- 		isFree = true -- Prison
	-- 	}
	-- })

	-- AddBoxZone("clothing_shop", vector3(-824.44, -1237.3, 7.34), 5.0, 3.8, {
	-- 	heading=320,
	-- 	minZ=6.34,
	-- 	maxZ=9.34
	-- })

	-- AddBoxZone("clothing_shop", vector3(-1086.98, -831.58, 19.3), 9.2, 5.4, {
	-- 	heading=38,
	-- 	minZ=18.3,
	-- 	maxZ=21.7
	-- })
	
	-- AddBoxZone("clothing_shop", vector3(107.71, -1305.32, 28.77), 3.0, 4.2, {
	-- 	heading=35,
	-- 	minZ=27.77,
	-- 	maxZ=31.17
	-- })
	
	-- AddBoxZone("clothing_shop", vector3(100.39, 3615.53, 40.91), 1.2, 1.6, {
	-- 	heading=0,
	-- 	minZ=39.57,
	-- 	maxZ=41.70
  	-- })

	-- AddBoxZone("clothing_shop", vector3(299.99, -598.91, 43.28), 2.8, 5.2, {
	-- 	heading = 340,
	-- 	minZ = 42.28,
	-- 	maxZ = 44.28
	-- })

	-- AddBoxZone("clothing_shop", vector3(4496.9052, -4455.127, 4.3664603), 2.8, 5.2, {
	-- 	heading = 340,
	-- 	minZ = 4.3664603,
	-- 	maxZ = 4.3664603
	-- })
	
	-- AddBoxZone("clothing_shop", vector3(-567.8201, -584.8669, 34.860923), 2.8, 5.2, {
	-- 	heading = 65,
	-- 	minZ = 33.860923,
	-- 	maxZ = 35.860923
	-- })
	
	AddBoxZone("clothing_shop", vector3(-568.341, -588.1475, 34.557365), 2.8, 5.2, {
		heading = 65,
		minZ = 33.557365,
		maxZ = 35.557365
	})

	AddBoxZone("clothing_shop", vector3(-525.432, -595.3646, 41.177284), 2.8, 5.2, {
		heading = 350,
		minZ = 40.177284,
		maxZ = 42.177284
	})

	AddBoxZone("clothing_shop", vector3(1197.7382, 2710.8942, 37.96746), 2.8, 5.2, {
		heading = 354,
		minZ = 36.96746,
		maxZ = 38.96746
	})


end

-- CreateThread(Interact);
-- RegisterNetEvent("nc-interact:ready", Interact);

