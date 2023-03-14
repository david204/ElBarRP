Config = {}

Config.CommandPermission = 'god' -- permission level for creating new doors
Config.AdminAccess = true -- Enable admins to unlock any door
Config.AdminPermission = 'god' -- The permission needed to get AdminAccess if it is enabled
Config.Warnings = false -- if true it will show warnings in the console when certain requirements aren't met
Config.FallbackDistance = 3.0 -- Distance to fall back on when it is not set
Config.EnableSounds = true -- Enable sounds when unlocking/locking doors (doors triggered by scripts can have the sound manually disabled)
Config.EnableAnimation = true -- Enable the animation when unlocking/locking doors (doors triggered by scripts can have the animation manually disabled)

Config.ChangeColor = true -- Change the color of the box of the popup text based on if it is locked or not
Config.DefaultColor = 'rgb(19, 28, 74)' -- The default color of the box of the popup text if Config.ChangeColor is false
Config.LockedColor = 'rgb(255 44 44)' -- The color of the box of the popup text if Config.ChangeColor is true and the door is locked
Config.UnlockedColor = 'rgb(19 223 135)' -- The color of the box of the popup text if Config.ChangeColor is true and the door is unlocked

Config.Consumables = { ['ticket'] = 1, ['paperclip'] = 1 } -- The items will get removed once used on a door that has the item on it

Config.DoorList = {
	--- door1 for pacific opened with security card B
	{
		objName = 'hei_v_ilev_bk_gate2_pris',
		objCoords  = vec3(261.83, 221.39, 106.41),
		textCoords = vec3(261.83, 221.39, 106.41),
		authorizedJobs = { 'police' },
		objYaw = -110.0,
		locked = true,
		pickable = false,
		distance = 1.5,
	},
	--door2 for pacific opened with thermite right near the vault door
	{
		objName = 'hei_v_ilev_bk_safegate_pris',
		objCoords  = vec3(252.98, 220.65, 101.8),
		textCoords = vec3(252.98, 220.65, 101.8),
		authorizedJobs = { 'police' },
		objYaw = 160.0,
		locked = true,
		pickable = false,
		distance = 1.5
	},
	-- door3 for pacific opened with thermite after passing the door near vault
	{
		objName = 'hei_v_ilev_bk_safegate_pris',
		objCoords  = vec3(261.68, 215.62, 101.81),
		textCoords = vec3(261.68, 215.62, 101.81),
		authorizedJobs = { 'police' },
		objYaw = -110.0,
		locked = true,
		pickable = false,
		distance = 1.5
	},
	-- Paleto Door 1 opened with security card A
	-- {
	-- 	objName = 'v_ilev_cbankvaulgate01',
	-- 	objCoords  = vec3(-105.77, 6472.59, 31.81),
	-- 	textCoords = vec3(-105.77, 6472.59, 31.81),
	-- 	objYaw = 45.0,
	-- 	authorizedJobs = { 'police' },
	-- 	locked = true,
	-- 	pickable = false,
	-- 	distance = 1.5
	-- },
	-- -- Paleto Door 2 opened with thermite
	-- {
	-- 	objName = 'v_ilev_cbankvaulgate02',
	-- 	objCoords  = vec3(-106.26, 6476.01, 31.98),
	-- 	textCoords = vec3(-105.5, 6475.08, 31.99),
	-- 	objYaw = -45.0,
	-- 	authorizedJobs = { 'police' },
	-- 	locked = true,
	-- 	pickable = false,
	-- 	distance = 1.5
	-- },
	-- First Pacific Door opened with lockpick
	{
		objName = 'hei_v_ilev_bk_gate_pris',
		objCoords  = vec3(257.41, 220.25, 106.4),
		textCoords = vec3(257.41, 220.25, 106.4),
		authorizedJobs = { 'police' },
		objYaw = -20.0,
		locked = true,
		pickable = true,
		distance = 1.5
	},
	-- Second Pacific Door opened with lockpick
	{
		objName = 'v_ilev_bk_door',
		objCoords  = vec3(265.19, 217.84, 110.28),
		textCoords = vec3(265.19, 217.84, 110.28),
		authorizedJobs = { 'police' },
		objYaw = -20.0,
		locked = true,
		pickable = true,
		distance = 1.5
	},
	-- Fleeca Door opened with lockpick
	{
		objName = 'v_ilev_gb_vaubar',
		objCoords  = vec3(314.61, -285.82, 54.49),
		textCoords = vec3(313.3, -285.45, 54.49),
		authorizedJobs = { 'police' },
		locked = true,
		pickable = true,
		distance = 1.5
	},
	-- Fleeca Door opened with lockpick
	{
		objName = 'v_ilev_gb_vaubar',
		objCoords  = vec3(148.96, -1047.12, 29.7),
		textCoords = vec3(148.96, -1047.12, 29.7),
		authorizedJobs = { 'police' },
		locked = true,
		pickable = true,
		distance = 1.5
	},
	-- Fleeca Door opened with lockpick
	{
		objName = 'v_ilev_gb_vaubar',
		objCoords  = vec3(-351.7, -56.28, 49.38),
		textCoords = vec3(-351.7, -56.28, 49.38),
		authorizedJobs = { 'police' },
		locked = true,
		pickable = true,
		distance = 1.5
	},
	-- Fleeca Door opened with lockpick
	{
		objName = 'v_ilev_gb_vaubar',
		objCoords  = vec3(-1208.12, -335.586, 37.759),
		textCoords = vec3(-1208.12, -335.586, 37.759),
		authorizedJobs = { 'police' },
		locked = true,
		pickable = true,
		distance = 1.5
	},
	-- Fleeca Door opened with lockpick
	{
		objName = 'v_ilev_gb_vaubar',
		objCoords  = vec3(-2956.18, 483.96, 16.02),
		textCoords = vec3(-2956.18, 483.96, 16.02),
		authorizedJobs = { 'police' },
		locked = true,
		pickable = true,
		distance = 1.5
	},
	-- Police Doorlock
	{ -- DOOR NUM.5
	textCoords = vector3(438.1971, -993.9113, 30.82319),
	authorizedJobs = { 'police' },
	locking = false,
	locked = true,
	pickable = true,
	distance = 2.5,
	doors = {
		{
			objName = "gabz_mrpd_door_01",
			objYaw = 90.0,
			objCoords = vector3(438.1971, -996.3167, 30.82319)
		},

		{
			objName = "gabz_mrpd_door_01",
			objYaw = -90.0,
			objCoords = vector3(438.1971, -993.9113, 30.82319)
		}
	}
},

{ -- DOOR NUM.6
	textCoords = vector3(440.7392, -998.7462, 30.8153),
	authorizedJobs = { 'police' },
	locking = false,
	locked = true,
	pickable = true,
	distance = 2.5,
	doors = {
		{
			objName = "gabz_mrpd_reception_entrancedoor",
			objYaw = 0.0,
			objCoords = vector3(440.7392, -998.7462, 30.8153)
		},

		{
			objName = "gabz_mrpd_reception_entrancedoor",
			objYaw = 180.0,
			objCoords = vector3(443.0618, -998.7462, 30.8153)
		}
	}
},

{
	objName = "gabz_mrpd_door_05",
	objYaw = 135.0,
	objCoords = vector3(452.2663, -995.5254, 30.82319),
	textCoords = vector3(452.2663, -995.5254, 30.82319),
	authorizedJobs = { 'police' },
	locking = false,
	locked = true,
	pickable = true,
	distance = 2.0,
	size = 2
},


{
	objName = "gabz_mrpd_door_02",
	objYaw = 225.0,
	objCoords = vector3(458.0894, -995.5247, 30.82319),
	textCoords = vector3(458.0894, -995.5247, 30.82319),
	authorizedJobs = { 'police' },
	locking = false,
	locked = true,
	pickable = true,
	distance = 2.0,
	size = 2
},

{ -- DOOR 9
	objName = "gabz_mrpd_door_05",
	objYaw = 270.0,
	objCoords = vector3(458.6543, -990.6498, 30.82319),
	textCoords = vector3(458.6543, -990.6498, 30.82319),
	authorizedJobs = { 'police' },
	locking = false,
	locked = true,
	pickable = true,
	distance = 2.0,
	size = 2
},

{
	objName = "gabz_mrpd_door_04",
	objYaw = 270.0,
	objCoords = vector3(458.6543, -976.8864, 30.82319),
	textCoords = vector3(458.6543, -976.8864, 30.82319),
	authorizedJobs = { 'police' },
	locking = false,
	locked = true,
	pickable = true,
	distance = 2.0,
	size = 2
},

{ -- DOOR NUM.11 , Door side station exit.
	textCoords = vector3(455.8862, -972.2543, 30.81531),
	authorizedJobs = { 'police' },
	locking = false,
	locked = true,
	pickable = true,
	distance = 2.5,
	doors = {
		{
			objName = "gabz_mrpd_reception_entrancedoor",
			objYaw = 0.0,
			objCoords = vector3(455.8862, -972.2543, 30.81531)
		},

		{
			objName = "gabz_mrpd_reception_entrancedoor",
			objYaw = 180.0,
			objCoords = vector3(458.2087, -972.2543, 30.81531)
		}
	}
},

{ -- DOOR NUM.12
	textCoords = vector3(469.4406, -987.4377, 30.82319),
	authorizedJobs = { 'police' },
	locking = false,
	locked = true,
	pickable = true,
	distance = 2.5,
	doors = {
		{
			objName = "gabz_mrpd_door_01",
			objYaw = -90.0,
			objCoords = vector3(469.4406, -985.0313, 30.82319)
		},

		{
			objName = "gabz_mrpd_door_01",
			objYaw = 90.0,
			objCoords = vector3(469.4406, -987.4377, 30.82319)
		}
	}
},

{ -- DOOR NUM.13
	textCoords = vector3(475.3837, -984.3722, 30.82319),
	authorizedJobs = { 'police' },
	locking = false,
	locked = false,
	pickable = true,
	distance = 2.5,
	doors = {
		{
			objName = "gabz_mrpd_door_02",
			objYaw = 0.0,
			objCoords = vector3(472.9781, -984.3722, 30.82319)
		},

		{
			objName = "gabz_mrpd_door_02",
			objYaw = 180.0,
			objCoords = vector3(475.3837, -984.3722, 30.82319)
		}
	}
},

{ -- DOOR NUM.13
	textCoords = vector3(441.13891, -986.4613, 30.782758),
	authorizedJobs = { 'police' },
	locking = false,
	locked = true,
	pickable = true,
	distance = 2.5,
	doors = {
		{
			objName = "gabz_mrpd_door_05",
			objYaw = 0.0,
			objCoords = vector3(441.13891, -986.4613, 30.782758)
		},

		{
			objName = "gabz_mrpd_door_05",
			objYaw = 180.0,
			objCoords = vector3(441.13891, -986.4613, 30.782758)
		}
	}
},


-- {  -- DOOR NUM.14 - Ambulance stuff
-- 	textCoords = vector3(479.7534, -988.6204, 30.82319),
-- 	authorizedJobs = { 'police', 'ambulance' },
-- 	locking = false,
-- 	locked = true,
-- 	pickable = true,
-- 	distance = 2.5,
-- 	doors = {
-- 		{
-- 			objName = "gabz_mrpd_door_04",
-- 			objYaw = -14.0,
-- 			objCoords = vector3(479.7534, -986.2151, 30.82319)
-- 		},

-- 		{
-- 			objName = "gabz_mrpd_door_05",
-- 			objYaw = -90.0,
-- 			objCoords = vector3(479.7534, -988.6204, 30.82319)
-- 		}
-- 	}
-- },

-- Door 15:
{ 
	textCoords = vector3(472.9777, -989.8247, 30.82319),
	authorizedJobs = { 'police' },
	locking = false,
	locked = true,
	pickable = true,
	distance = 2.5,
	doors = {
		{
			objName = "gabz_mrpd_door_04",
			objYaw = -180.0,
			objCoords = vector3(475.3837, -989.8247, 30.82319)
		},

		{
			objName = "gabz_mrpd_door_05",
			objYaw = 180.0,
			objCoords = vector3(472.9777, -989.8247, 30.82319)
		}
	}
},

-- 16
{
	objName = "gabz_mrpd_door_03",
	objYaw = 90.0,
	objCoords = vector3(479.7507, -999.629, 30.78917),
	textCoords = vector3(479.7507, -999.629, 30.78917),
	authorizedJobs = { 'police' },
	locking = false,
	locked = true,
	pickable = true,
	distance = 2.0,
	size = 2
},

-- 17
{
	objName = "gabz_mrpd_door_04",
	objYaw = 90.0,
	objCoords = vector3(476.7512, -999.6307, 30.82319),
	textCoords = vector3(476.7512, -999.6307, 30.82319),
	authorizedJobs = { 'police' },
	locking = false,
	locked = true,
	pickable = true,
	distance = 2.0,
	size = 2
},

-- 18
{
	objName = "gabz_mrpd_door_03",
	objYaw = 180.0,
	objCoords = vector3(487.4378, -1000.189, 30.78697),
	textCoords = vector3(487.4378, -1000.189, 30.78697),
	authorizedJobs = { 'police' },
	locking = false,
	locked = true,
	pickable = true,
	distance = 2.0,
	size = 2
},

-- Door 19
{ 
	textCoords = vector3(485.6133, -1002.902, 30.78697),
	authorizedJobs = { 'police' },
	locking = false,
	locked = true,
	pickable = true,
	distance = 2.5,
	doors = {
		{
			objName = "gabz_mrpd_door_03",
			objYaw = -180.0,
			objCoords = vector3(488.0184, -1002.902, 30.78697)
		},

		{
			objName = "gabz_mrpd_door_03",
			objYaw = 0.0,
			objCoords = vector3(485.6133, -1002.902, 30.78697)
		}
	}
},

-- FLOOR 2

-- Door 2
{
	objName = "gabz_mrpd_door_04",
	objYaw = 180.0,
	objCoords = vector3(459.9454, -981.0742, 35.10398),
	textCoords = vector3(459.9454, -981.0742, 35.10398),
	authorizedJobs = { 'police' },
	locking = false,
	locked = true,
	pickable = true,
	distance = 2.0,
	size = 2
},

-- Door 3
{
	objName = "gabz_mrpd_door_05",
	objYaw = 0.0,
	objCoords = vector3(459.9454, -990.7053, 35.10398),
	textCoords = vector3(459.9454, -990.7053, 35.10398),
	authorizedJobs = { 'police' },
	locking = false,
	locked = true,
	pickable = true,
	distance = 2.0,
	size = 2
},

-- Door 4
{
	objName = "gabz_mrpd_door_05",
	objYaw = 135.0,
	objCoords = vector3(448.9868, -981.5785, 35.10376),
	textCoords = vector3(448.9868, -981.5785, 35.10376),
	authorizedJobs = { 'police' },
	locking = false,
	locked = true,
	pickable = true,
	distance = 2.0,
	size = 2
},

-- Door 5
{
	objName = "gabz_mrpd_door_04",
	objYaw = 45.0,
	objCoords = vector3(448.9868, -990.2007, 35.10376),
	textCoords = vector3(448.9868, -990.2007, 35.10376),
	authorizedJobs = { 'police' },
	locking = false,
	locked = true,
	pickable = true,
	distance = 2.0,
	size = 2
},

-- Door 6
{
	objName = "gabz_mrpd_door_05",
	objYaw = 135.0,
	objCoords = vector3(448.9846, -995.5264, 35.10376),
	textCoords = vector3(448.9846, -995.5264, 35.10376),
	authorizedJobs = { 'police' },
	locking = false,
	locked = true,
	pickable = true,
	distance = 2.0,
	size = 2
},

-- NO Door 1

-- FLOOR 0

-- Door 3
{
	objName = "gabz_mrpd_room13_parkingdoor",
	objYaw = -90.0,
	objCoords = vector3(464.1591, -974.6656, 26.3707),
	textCoords = vector3(464.1591, -974.6656, 26.3707),
	authorizedJobs = { 'police' },
	locking = false,
	locked = true,
	pickable = true,
	distance = 2.0,
	size = 2
},

-- Door 4
{
	objName = "gabz_mrpd_room13_parkingdoor",
	objYaw = 90.0,
	objCoords = vector3(464.1566, -997.5093, 26.3707),
	textCoords = vector3(464.1566, -997.5093, 26.3707),
	authorizedJobs = { 'police' },
	locking = false,
	locked = true,
	pickable = true,
	distance = 2.0,
	size = 2
},

-- Door 5:
{ 
	textCoords = vector3(471.3753, -987.4374, 26.40548),
	authorizedJobs = { 'police' },
	locking = false,
	locked = true,
	pickable = true,
	distance = 2.5,
	doors = {
		{
			objName = "gabz_mrpd_door_04",
			objYaw = -90.0,
			objCoords = vector3(471.3753, -985.0319, 26.40548)
		},

		{
			objName = "gabz_mrpd_door_05",
			objYaw = -90.0,
			objCoords = vector3(471.3753, -987.4374, 26.40548)
		}
	}
},

-- Door 10:
{ 
	textCoords = vector3(479.0624, -987.4376, 26.40548),
	authorizedJobs = { 'police' },
	locking = false,
	locked = true,
	pickable = true,
	distance = 2.5,
	doors = {
		{
			objName = "gabz_mrpd_door_02",
			objYaw = -90.0,
			objCoords = vector3(479.0624, -985.0323, 26.40548)
		},

		{
			objName = "gabz_mrpd_door_02",
			objYaw = 90.0,
			objCoords = vector3(479.0624, -987.4376, 26.40548)
		}
	}
},

-- Door 11
{
	objName = "gabz_mrpd_door_04",
	objYaw = -90.0,
	objCoords = vector3(482.6694, -983.9868, 26.40548),
	textCoords = vector3(482.6694, -983.9868, 26.40548),
	authorizedJobs = { 'police' },
	locking = false,
	locked = true,
	pickable = true,
	distance = 2.0,
	size = 2
},

-- Door 12


-- Door 13
{
	objName = "gabz_mrpd_door_04",
	objYaw = -90.0,
	objCoords = vector3(482.6699, -992.2991, 26.40548),
	textCoords = vector3(482.6699, -992.2991, 26.40548),
	authorizedJobs = { 'police' },
	locking = false,
	locked = true,
	pickable = true,
	distance = 2.0,
	size = 2
},

-- Door 14
{
	objName = "gabz_mrpd_door_04",
	objYaw = -90.0,
	objCoords = vector3(482.6703, -995.7285, 26.40548),
	textCoords = vector3(482.6703, -995.7285, 26.40548),
	authorizedJobs = { 'police' },
	locking = false,
	locked = true,
	pickable = true,
	distance = 2.0,
	size = 2
},

-- Door 15:
{ 
	textCoords = vector3(479.6638, -997.91, 26.4065),
	authorizedJobs = { 'police' },
	locking = false,
	locked = true,
	pickable = true,
	distance = 2.5,
	doors = {
		{
			objName = "gabz_mrpd_door_02",
			objYaw = 180.0,
			objCoords = vector3(482.0686, -997.91, 26.4065)
		},

		{
			objName = "gabz_mrpd_door_02",
			objYaw = 0.0,
			objCoords = vector3(479.6638, -997.91, 26.4065)
		}
	}
},

-- Door 16
{
	objName = "gabz_mrpd_door_02",
	objYaw = 180.0,
	objCoords = vector3(478.2892, -997.9101, 26.40548),
	textCoords = vector3(478.2892, -997.9101, 26.40548),
	authorizedJobs = { 'police' },
	locking = false,
	locked = true,
	pickable = true,
	distance = 2.0,
	size = 2
},

-- Door 17
{
	objName = "gabz_mrpd_door_01",
	objYaw = 90.28,
	objCoords = vector3(479.06, -1003.173, 26.4065),
	textCoords = vector3(479.06, -1003.173, 26.4065),
	authorizedJobs = { 'police' },
	locking = false,
	locked = true,
	pickable = true,
	distance = 2.0,
	size = 2
},

-- Door 18
{
	objName = "gabz_mrpd_cells_door",
	objYaw = 180.0,
	objCoords = vector3(481.0084, -1004.118, 26.48005),
	textCoords = vector3(481.0084, -1004.118, 26.48005),
	authorizedJobs = { 'police' },
	locking = false,
	locked = true,
	pickable = true,
	distance = 2.0,
	size = 2
},

-- Door 19
{
	objName = "gabz_mrpd_cells_door",
	objYaw = 180.0,
	objCoords = vector3(484.1764, -1007.734, 26.48005),
	textCoords = vector3(484.1764, -1007.734, 26.48005),
	authorizedJobs = { 'police' },
	locking = false,
	locked = true,
	pickable = true,
	distance = 2.0,
	size = 2
},

-- Door 20
{
	objName = "gabz_mrpd_cells_door",
	objYaw = 0.0,
	objCoords = vector3(486.9131, -1012.189, 26.48005),
	textCoords = vector3(486.9131, -1012.189, 26.48005),
	authorizedJobs = { 'police' },
	locking = false,
	locked = true,
	pickable = true,
	distance = 2.0,
	size = 2
},

-- Door 21
{
	objName = "gabz_mrpd_cells_door",
	objYaw = 0.0,
	objCoords = vector3(483.9127, -1012.189, 26.48005),
	textCoords = vector3(483.9127, -1012.189, 26.48005),
	authorizedJobs = { 'police' },
	locking = false,
	locked = true,
	pickable = true,
	distance = 2.0,
	size = 2
},

-- Door 22
{
	objName = "gabz_mrpd_cells_door",
	objYaw = 0.0,
	objCoords = vector3(480.9128, -1012.189, 26.48005),
	textCoords = vector3(480.9128, -1012.189, 26.48005),
	authorizedJobs = { 'police' },
	locking = false,
	locked = true,
	pickable = true,
	distance = 2.0,
	size = 2
},

-- Door 23
{
	objName = "gabz_mrpd_cells_door",
	objYaw = 0.0,
	objCoords = vector3(477.9126, -1012.189, 26.48005),
	textCoords = vector3(477.9126, -1012.189, 26.48005),
	authorizedJobs = { 'police' },
	locking = false,
	locked = true,
	pickable = true,
	distance = 2.0,
	size = 2
},

-- Door 24
{
	objName = "gabz_mrpd_cells_door",
	objYaw = -90.0,
	objCoords = vector3(476.6157, -1008.875, 26.48005),
	textCoords = vector3(476.6157, -1008.875, 26.48005),
	authorizedJobs = { 'police' },
	locking = false,
	locked = true,
	pickable = true,
	distance = 2.0,
	size = 2
},

-- Door 25
{
	objName = "gabz_mrpd_door_01",
	objYaw = 180.0,
	objCoords = vector3(475.9539, -1006.938, 26.40639),
	textCoords = vector3(475.9539, -1006.938, 26.40639),
	authorizedJobs = { 'police' },
	locking = false,
	locked = true,
	pickable = true,
	distance = 2.0,
	size = 2
},

-- Door 26 missing.

-- Door 7
{ 
	textCoords = vector3(471.3758, -1010.198, 26.40548),
	authorizedJobs = { 'police' },
	locking = false,
	locked = true,
	pickable = true,
	distance = 2.5,
	doors = {
		{
			objName = "gabz_mrpd_door_02",
			objYaw = -90.0,
			objCoords = vector3(471.3679, -1007.793, 26.40548)
		},

		{
			objName = "gabz_mrpd_door_02",
			objYaw = 90.0,
			objCoords = vector3(471.3758, -1010.198, 26.40548)
		}
	}
},

-- Door 8
{ 
	textCoords = vector3(467.3686, -1014.406, 26.48382),
	authorizedJobs = { 'police' },
	locking = false,
	locked = true,
	pickable = true,
	distance = 2.5,
	doors = {
		{
			objName = "gabz_mrpd_door_03",
			objYaw = 180.0,
			objCoords = vector3(469.7743, -1014.406, 26.48382)
		},

		{
			objName = "gabz_mrpd_door_03",
			objYaw = 0.0,
			objCoords = vector3(467.3686, -1014.406, 26.48382)
		}
	}
},

-- Door 9
{ 
	textCoords = vector3(467.5222, -1000.544, 26.40548),
	authorizedJobs = { 'police' },
	locking = false,
	locked = true,
	pickable = true,
	distance = 2.5,
	doors = {
		{ -- BROKEN
			objName = "gabz_mrpd_door_01",
			objYaw = 180.0,
			objCoords = vector3(469.9274, -1000.544, 26.40548)
		},

		{
			objName = "gabz_mrpd_door_01",
			objYaw = 0.0,
			objCoords = vector3(467.5222, -1000.544, 26.40548)
		}
	}
},	---
	-- PillBox Hospital
	-- Pillbox Medical Center
	{
		textCoords = vector3(348.56, -587.38, 44.28),
		authorizedJobs = { 'police', 'ambulance'},
		locking = false,
		locked = true,
		pickable = true,
		distance = 2.0,
		size = 2,
		doors = {
			{
				objName = 'gabz_pillbox_doubledoor_l',
				objYaw = 250.0,
				objCoords  = vector3(349.134, -586.8831, 43.28402)
			},

			{
				objName = 'gabz_pillbox_doubledoor_r',
				objYaw = -110.0,
				objCoords  = vector3(348.6142, -588.1655, 43.28402)
			}
		}
	},

	{
		objName = 'gabz_pillbox_singledoor',
		objCoords = vector3(308.5733, -597.5756, 43.28403),
		textCoords = vector3(308.5733, -597.5756, 43.28403),
		authorizedJobs = { 'police', 'ambulance'},
		locking = false,
		locked = true,
		pickable = true,
		distance = 2.0,
		size = 2
	},

	{
		objName = 'gabz_pillbox_singledoor',
		objCoords = vector3(340.1134, -586.6057, 44.28398),
		textCoords = vector3(340.1134, -586.6057, 44.28398),
		authorizedJobs = { 'police', 'ambulance'},
		locking = false,
		locked = true,
		pickable = true,
		distance = 2.0,
		size = 2
	},
	
	{
		objName = 'gabz_pillbox_singledoor',
		objCoords = vector3(347.45, -584.61, 43.28),
		textCoords = vector3(347.45, -584.61, 43.28),
		authorizedJobs = { 'police', 'ambulance'},
		locking = false,
		locked = true,
		pickable = true,
		distance = 2.0,
		size = 2
	},
	
	{
		objName = 'gabz_pillbox_singledoor',
		objCoords = vector3(341.49, -582.27, 43.28),
		textCoords = vector3(341.49, -582.27, 43.28),
		authorizedJobs = { 'police', 'ambulance'},
		locking = false,
		locked = true,
		pickable = true,
		distance = 2.0,
		size = 2
	},
	
	{
		objName = 'gabz_pillbox_singledoor',
		objCoords = vector3(336.85, -580.26, 43.28),
		textCoords = vector3(336.85, -580.26, 43.28),
		authorizedJobs = { 'police', 'ambulance'},
		locking = false,
		locked = true,
		pickable = true,
		distance = 2.0,
		size = 2
	},
	
	--[[Pillbox Entrance 
	{
		textCoords = vector3(303.91, -581.80, 43.28),
		authorizedJobs = { 'police', 'ambulance'},
		locking = false,
		locked = true,
		pickable = true,
		distance = 2.0,
		size = 2,
		doors = {
			{
				objName = 'gabz_pillbox_doubledoor_l',
				objYaw = -20.0,
				objCoords  = vector3(303.51, -581.64, 43.28)
			},

			{
				objName = 'gabz_pillbox_doubledoor_r',
				objYaw = -20.0,
				objCoords  = vector3(304.46, -582.26, 43.28)
			}
		}
	},]]--

	     -- BeanMachine
		 {
			textCoords = vector3(313.35, -571.63, 44.29),
			authorizedJobs = { 'beanmachine'},
			locking = false,
			locked = true,
			pickable = true,
			distance = 2.0,
			size = 2,
			doors = {
				{
					objName = -747011272,
					objYaw = 69.99999,
					objCoords  = vector3(115.3757, -1037.655, 29.348),
				},
	
				{
					objName = -1182160879,
					objYaw = 250.00,
					objCoords  = vector3(114.5629, -1039.888, 29.34832)
				}
			}
		},
		     -- Pizzathis
			 {
				textCoords = vector3(313.35, -571.63, 44.29),
				authorizedJobs = { 'pizzathis'},
				locking = false,
				locked = true,
				pickable = true,
				distance = 2.0,
				size = 2,
				doors = {
					{
						objName = 95403626,
						objYaw = 180.00,
						objCoords  = vector3(805.658, -747.9282, 27.02702),
					},
		
					{
						objName = -49173194,
						objYaw = 180.00,
						objCoords  = vector3(803.2782, -747.9282, 27.02702)
					}
				}
			},
			    -- Pizzathis
				{
					textCoords = vector3(313.35, -571.63, 44.29),
					authorizedJobs = { 'pizzathis'},
					locking = false,
					locked = true,
					pickable = true,
					distance = 2.0,
					size = 2,
					doors = {
						{
							objName = 95403626,
							objYaw = 270.00,
							objCoords  = vector3(794.2512, -757.0618, 27.02702),
						},
			
						{
							objName = -49173194,
							objYaw = 270.00,
							objCoords  = vector3(794.2512, -759.4415, 27.02702)
						}
					}
				},
				    -- whitewidow
					{
						textCoords = vector3(313.35, -571.63, 44.29),
						authorizedJobs = { 'whitewidow'},
						locking = false,
						locked = true,
						pickable = true,
						distance = 2.0,
						size = 2,
						doors = {
							{
								objName = -1226987899,
								objYaw = 114.99,
								objCoords  = vector3(201.688, -240.6687, 54.23559),
							},
				
							{
								objName = -1226987899,
								objYaw = 295.0,
								objCoords  = vector3(200.585, -238.3152, 54.23559)
							}
						}
					},
					   -- burgershot
					   {
						textCoords = vector3(313.35, -571.63, 44.29),
						authorizedJobs = { 'burgershot'},
						locking = false,
						locked = true,
						pickable = true,
						distance = 2.0,
						size = 2,
						doors = {
							{
								objName = -806752263,
								objYaw = 304.51,
								objCoords  = vector3(-1184.722, -883.4993, 14.1698),
							},
				
							{
								objName = 386432549,
								objYaw = 304.80,
								objCoords  = vector3(-1183.275, -885.6295, 14.1698)
							}
						}
					},
					-- burgershot
					{
						textCoords = vector3(313.35, -571.63, 44.29),
						authorizedJobs = { 'burgershot'},
						locking = false,
						locked = true,
						pickable = true,
						distance = 2.0,
						size = 2,
						doors = {
							{
								objName = 386432549,
								objYaw = 34.199,
								objCoords  = vector3(-1196.755, -883.577, 14.1698),
							},
				
							{
								objName = -806752263,
								objYaw = 34.199,
								objCoords  = vector3(-1198.885, -885.024, 14.1698)
							}
						}
					},
					-- burgershot
					{
						textCoords = vector3(313.35, -571.63, 44.29),
						authorizedJobs = { 'burgershot'},
						locking = false,
						locked = true,
						pickable = true,
						distance = 2.0,
						size = 2,
						doors = {
							{
								objName = 1980817304,
								objYaw = 34.054,
								objCoords  = vector3(-1202.487, -896.6489, 14.12363),
							},
				
							{
								objName = 1980817304,
								objYaw = 214.41,
								objCoords  = vector3(-1204.188, -897.8046, 14.12363)
							}
						}
					},
					-- CatCafe
					{
						textCoords = vector3(313.35, -571.63, 44.29),
						authorizedJobs = { 'catcafe'},
						locking = false,
						locked = true,
						pickable = true,
						distance = 2.0,
						size = 2,
						doors = {
							{
								objName = -69331849,
								objYaw = 0.27,
								objCoords  = vector3(-580.3611, -1069.627, 22.48975),
							},
				
							{
								objName = 526179188,
								objYaw = 359.82,
								objCoords  = vector3(-581.6678, -1069.627, 22.48975)
							}
						}
					},
					-- -- Casino
					-- {
					-- 	textCoords = vector3(313.35, -571.63, 44.29),
					-- 	authorizedJobs = { 'none'},
					-- 	locking = true,
					-- 	locked = true,
					-- 	pickable = true,
					-- 	distance = 2.0,
					-- 	size = 2,
					-- 	doors = {
					-- 		{
					-- 			objName = 21324050,
					-- 			objYaw = 58.11,
					-- 			objCoords  = vector3(923.4505, 42.69615, 81.53419),
					-- 		},
				
					-- 		{
					-- 			objName = 21324050,
					-- 			objYaw = 237.91,
					-- 			objCoords  = vector3(924.7853, 44.82212, 81.53419)
					-- 		}
					-- 	}
					-- },
					-- -- Casino
					-- {
					-- 	textCoords = vector3(313.35, -571.63, 44.29),
					-- 	authorizedJobs = { 'none'},
					-- 	locking = false,
					-- 	locked = true,
					-- 	pickable = true,
					-- 	distance = 2.0,
					-- 	size = 2,
					-- 	doors = {
					-- 		{
					-- 			objName = 21324050,
					-- 			objYaw = 57.65,
					-- 			objCoords  = vector3(924.9374, 45.08024, 81.53419),
					-- 		},
				
					-- 		{
					-- 			objName = 21324050,
					-- 			objYaw = 237.90,
					-- 			objCoords  = vector3(926.2712, 47.2067, 81.53419)
					-- 		}
					-- 	}
					-- },
					-- -- Casino
					-- {
					-- 	textCoords = vector3(313.35, -571.63, 44.29),
					-- 	authorizedJobs = { 'none'},
					-- 	locking = false,
					-- 	locked = true,
					-- 	pickable = true,
					-- 	distance = 2.0,
					-- 	size = 2,
					-- 	doors = {
					-- 		{
					-- 			objName = 21324050,
					-- 			objYaw = 57.99,
					-- 			objCoords  = vector3(926.4382, 47.46822, 81.53419),
					-- 		},
				
					-- 		{
					-- 			objName = 21324050,
					-- 			objYaw = 238.00,
					-- 			objCoords  = vector3(927.7739, 49.59499, 81.53419)
					-- 		}
					-- 	}
					-- },
						-- Police
						{
							textCoords = vector3(313.35, -571.63, 44.29),
							authorizedJobs = { 'police'},
							locking = false,
							locked = true,
							pickable = true,
							distance = 2.0,
							size = 2,
							doors = {
								{
									objName = -1406685646,
									objYaw = 270.00,
									objCoords  = vector3(479.7534, -986.2151, 30.82319),
								},
					
								{
									objName = -1406685646,
									objYaw = 90.16,
									objCoords  = vector3(479.7534, -988.6204, 30.82319)
								}
							}
						},
	-- Pillbox Surgery #1
	{
		textCoords = vector3(313.35, -571.63, 44.29),
		authorizedJobs = { 'police', 'ambulance'},
		locking = false,
		locked = true,
		pickable = true,
		distance = 2.0,
		size = 2,
		doors = {
			{
				objName = 'gabz_pillbox_doubledoor_l',
				objYaw = -20.0,
				objCoords  = vector3(312.7201, -571.6296, 43.28402)
			},

			{
				objName = 'gabz_pillbox_doubledoor_r',
				objYaw = -20.0,
				objCoords  = vector3(313.8816, -571.9534, 43.28402)
			}
		}
	},

	{
		textCoords = vector3(326.55, -579.42, 43.28),
		authorizedJobs = { 'police', 'ambulance'},
		locking = false,
		locked = true,
		pickable = true,
		distance = 2.0,
		size = 2,
		doors = {
			{
				objName = 'gabz_pillbox_doubledoor_l',
				objYaw = 250.0,
				objCoords  = vector3(326.54, -578.91, 43.28402)
			},

			{
				objName = 'gabz_pillbox_doubledoor_r',
				objYaw = 250.0,
				objCoords  = vector3(326.54, -580.04, 43.28402)
			}
		}
	},

	{
		textCoords = vector3(325.55, -589.02, 43.28),
		authorizedJobs = { 'police', 'ambulance'},
		locking = false,
		locked = true,
		pickable = true,
		distance = 2.0,
		size = 2,
		doors = {
			{
				objName = 'gabz_pillbox_doubledoor_l',
				objYaw = -20.0,
				objCoords  = vector3(324.91, -589.02, 43.28)
			},

			{
				objName = 'gabz_pillbox_doubledoor_r',
				objYaw = -20.0,
				objCoords  = vector3(326.16, -589.02, 43.28)
			}
		}
	},

	-- Pillbox Surgery #2

	{
		textCoords = vector3(319.2, -573.24, 44.29),
		authorizedJobs = { 'police', 'ambulance'},
		locking = false,
		locked = true,
		pickable = true,
		distance = 2.0,
		size = 2,
		doors = {
			{
				objName = 'gabz_pillbox_doubledoor_l',
				objYaw = -20.0,
				objCoords  = vector3(318.4946, -573.7322, 43.28399)
			},

			{
				objName = 'gabz_pillbox_doubledoor_r',
				objYaw = -20.0,
				objCoords  = vector3(319.6151, -574.2166, 43.28405)
			}
		}
	},

	{
		textCoords = vector3(324.44, -575.64, 44.29),
		authorizedJobs = { 'police', 'ambulance'},
		locking = false,
		locked = true,
		pickable = true,
		distance = 2.0,
		size = 2,
		doors = {
			{
				objName = 'gabz_pillbox_doubledoor_l',
				objYaw = -20.0,
				objCoords  = vector3(323.8446, -575.741, 43.284)
			},

			{
				objName = 'gabz_pillbox_doubledoor_r',
				objYaw = -20.0,
				objCoords  = vector3(325.0642, -576.1204, 43.284)
			}
		}
	},
}


--casino
-- StairsLowerDoor created by #
Config.DoorList['StairsLowerDoor'] = {
    maxDistance = 2.0,
    lockpick = false,
    garage = false,
    objHash = 270965283,
    audioRemote = false,
    locked = true,
    authorizedJobs = { ['admin']=0 },
    fixText = false,
    objCoords = vector3(961.5505, 16.87, 59.98977),
    objHeading = 148.05874633789,
    slides = false,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000,
    --doorRate = 1.0,
    --showNUI = true
}

-- Jewelery Store
Config.DoorList['vangelicodoor'] = {
	authorizedJobs = { ['police']=0 }, -- ['ambulance']=0, ['bcso']=0
	lockpick = false,
	doors = {
		{objHash = 1425919976, objHeading = 306.00003051758, objCoords = vec3(-631.955384, -236.333268, 38.206532)},
		{objHash = 9467943, objHeading = 306.00003051758, objCoords = vec3(-630.426514, -238.437546, 38.206532)}
    },
	audioRemote = false,
	locked = true,
	slides = false,
	maxDistance = 2.5,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000
}

-- Main1 created by #
Config.DoorList['Main1'] = {
    maxDistance = 2.0,
    lockpick = false,
    garage = false,
    objHash = 1266543998,
    audioRemote = false,
    locked = true,
    authorizedJobs = { ['admin']=0 },
    fixText = false,
    objCoords = vector3(951.0956, 27.26886, 71.98338),
    objHeading = 238.00001525879,
    slides = false,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000,
    --doorRate = 1.0,
    --showNUI = true
}

-- -- Jewelery Store
-- Config.DoorList['vangelicodoor'] = {
-- 	authorizedJobs = { ['police']=0 }, -- ['ambulance']=0, ['bcso']=0
-- 	lockpick = false,
-- 	doors = {
-- 		{objHash = 1425919976, objHeading = 306.00003051758, objCoords = vec3(-631.955384, -236.333268, 38.206532)},
-- 		{objHash = 9467943, objHeading = 306.00003051758, objCoords = vec3(-630.426514, -238.437546, 38.206532)}
--     },
-- 	audioRemote = false,
-- 	locked = true,
-- 	slides = false,
-- 	maxDistance = 2.5,
--     --oldMethod = true,
--     --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
--     --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
--     --autoLock = 1000
-- }

-- LoadingBayVault created by #
Config.DoorList['LoadingBayVault'] = {
    maxDistance = 2.0,
    lockpick = false,
    garage = false,
    objHash = 270965283,
    audioRemote = false,
    locked = true,
    authorizedJobs = { ['admin']=0 },
    fixText = false,
    objCoords = vector3(961.5505, 16.87005, 71.98978),
    objHeading = 148.05874633789,
    slides = false,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000,
    --doorRate = 1.0,
    --showNUI = true
}
