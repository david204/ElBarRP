Config = {}

Config.Invincible = true -- Is the ped going to be invincible?
Config.Frozen = true -- Is the ped frozen in place?
Config.Stoic = true -- Will the ped react to events around them?
Config.FadeIn = true -- Will the ped fade in and out based on the distance. (Looks a lot better.)
Config.DistanceSpawn = 20.0 -- Distance before spawning/despawning the ped. (GTA Units.)

Config.MinusOne = true -- Leave this enabled if your coordinates grabber does not -1 from the player coords.

Config.GenderNumbers = { -- No reason to touch these.
	['male'] = 4,
	['female'] = 5
}

Config.PedList = {

	-- Barber Shops
	{
		model = `s_f_m_fembarber`, -- Model name as a hash.
		coords = vector4(-33.14, -150.45, 57.08, 338.88), -- Hawick Ave (X, Y, Z, Heading)
		gender = 'female' -- The gender of the ped, used for the CreatePed native.
	},

	{
		model = `s_f_m_fembarber`,
		coords = vector4(-280.07, 6228.85, 31.7, 42.17), -- Paleto Bay
		gender = 'female'
	},

	{
		model = `s_f_m_fembarber`,
		coords = vector4(-817.19, -183.30, 37.57, 130.0), -- Mad Wayne Thunder Drive
		gender = 'female'
	},

	{
		model = `s_f_m_fembarber`,
		coords = vector4(-1284.48, -1118.04, 6.99, 88.18), -- Magellan Ave
		gender = 'female'
	},

	{
		model = `s_f_m_fembarber`,
		coords = vector4(136.39, -1709.9, 29.29, 138.8), -- Carson Ave
		gender = 'female'
	},

	-- Tattos Shop

	{
		model = `u_m_y_tattoo_01`,
		coords = vector4(-1151.9, -1426.44, 4.96, 30.36), -- Carson Ave
		gender = 'male'
	},

	{
		model = `u_m_y_tattoo_01`,
		coords = vector4(1325.02, -1652.76, 52.28, 34.55), -- Carson Ave
		gender = 'male'
	},
	
	{
		model = `u_m_y_tattoo_01`,
		coords = vector4(321.69, 182.69, 103.59, 149.74), -- Carson Ave
		gender = 'male'
	},

	{
		model = `u_m_y_tattoo_01`,
		coords = vector4(-3172.13, 1075.04, 20.83, 244.17), -- Carson Ave
		gender = 'male'
	},

	{
		model = `u_m_y_tattoo_01`,
		coords = vector4(1864.45, 3750.07, 33.03, 121.4), -- Carson Ave
		gender = 'male'
	},

	{
		model = `u_m_y_tattoo_01`,
		coords = vector4(-293.45, 6197.67, 31.49, 306.3), -- Carson Ave
		gender = 'male'
	},

	-- BANK PED'S
    -- {
    --     model = `ig_bankman`,
    --     coords = vector4(241.44, 227.19, 106.29, 170.43),
    --     gender = 'male'
    -- },
    -- {
    --     model = `ig_bankman`,
    --     coords = vector4(313.84, -280.58, 54.16, 338.31), 
    --     gender = 'male' 
    -- },
    -- {
    --     model = `ig_bankman`, 
    --     coords = vector4(149.46, -1042.09, 29.37, 335.43), 
    --     gender = 'male'
    -- },
    -- {
    --     model = `ig_bankman`, 
    --     coords = vector4(-351.23, -51.28, 49.04, 341.73), 
    --     gender = 'male' 
    -- },
    -- {
    --     model = `ig_bankman`, 
    --     coords = vector4(-1211.9, -331.9, 37.78, 20.07), 
    --     gender = 'male' 
    -- },
    -- {
    --     model = `ig_bankman`, 
    --     coords = vector4(-2961.14, 483.09, 15.7, 83.84), 
    --     gender = 'male' 
    -- },
    -- {
    --     model = `ig_bankman`, 
    --     coords = vector4(1174.8, 2708.2, 38.09, 178.52), 
    --     gender = 'male' 
    -- },
    -- {
    --     model = `ig_bankman`, 
    --     coords = vector4(-112.22, 6471.01, 31.63, 134.18), 
    --     gender = 'male' 
    -- },
	--------- Dress Shop -----------
	{
		model = `s_f_y_shop_low`,
		coords = vector4(78.71, -1388.84, 29.38, 169.92),
		gender = 'female'
	},
	{
		model = `s_f_y_shop_low`,
		coords = vector4(-1096.12, 2710.75, 19.11, 134.98),
		gender = 'female'
	},
    {
		model = `s_f_y_shop_low`,
		coords = vector4(122.99, -212.67, 54.56, 246.18),
		gender = 'female'
	},
    {
		model = `s_f_y_shop_low`,
		coords = vector4(-166.88, -301.81, 39.73, 249.87),
		gender = 'female'
	},
    {
		model = `s_f_y_shop_low`,
		coords = vector4(422.55, -810.34, 29.49, 1.76),
		gender = 'female'
	},
    {
		model = `s_f_y_shop_low`,
		coords = vector4(-706.88, -150.93, 37.42, 117.1),
		gender = 'female'
	},
    {
		model = `s_f_y_shop_low`,
		coords = vector4(-817.21, -1074.34, 11.33, 118.35),
		gender = 'female'
	},
    {
		model = `s_f_y_shop_low`,
		coords = vector4(-1197.31, -779.08, 17.33, 33.29),
		gender = 'female'
	},
    {
		model = `s_f_y_shop_low`,
		coords = vector4(-1447.49, -239.71, 49.82, 47.68),
		gender = 'female'
	},
    -- {
	-- 	model = `s_f_y_shop_low`,
	-- 	coords = vector4(-708.24, -153.02, 37.42, 117.62),
	-- 	gender = 'female'
	-- },
    {
		model = `s_f_y_shop_low`,
		coords = vector4(-3172.34, 1055.63, 20.86, 245.64),
		gender = 'female'
	},
    {
		model = `s_f_y_shop_low`,
		coords = vector4(621.34, 2753.37, 42.09, 90.22),
		gender = 'female'
	},
    {
		model = `s_f_y_shop_low`,
		coords = vector4(1200.74, 2706.73, 38.22, 90.47),
		gender = 'female'
	},
    {
		model = `s_f_y_shop_low`,
		coords = vector4(1690.51, 4818.23, 42.07, 359.4),
		gender = 'female'
	},
    {
		model = `s_f_y_shop_low`,
		coords = vector4(-1.11, 6512.79, 31.88, 307.75),
		gender = 'female'
	},
	
    --------- Shops -----------
    {
		model = `mp_m_shopkeep_01`,
		coords = vector4(24.75, -1348.48, 29.5, 264.84),
		gender = 'male'
	},

	-- {
	-- 	model = `mp_m_shopkeep_01`,
	-- 	coords = vector4(-2592.77, 1878.57, 175.56, 221.29),
	-- 	gender = 'male'
	-- },
	
	-- {
	-- 	model = `mp_m_shopkeep_01`,
	-- 	coords = vector4(225.65, -909.83, 30.73, 351.32),
	-- 	gender = 'male'
	-- },
	{
		model = `mp_m_shopkeep_01`,
		coords = vector4(-47.4, -1758.65, 29.42, 47.22),
		gender = 'male'
	},
	{
		model = `mp_m_shopkeep_01`,
		coords = vector4(-706.16, -914.51, 19.22, 96.95),
		gender = 'male'
	},
	{
		model = `mp_m_shopkeep_01`,
		coords = vector4(-1221.97, -908.32, 12.33, 32.06),
		gender = 'male'
	},
	{
		model = `mp_m_shopkeep_01`,
		coords = vector4(1134.21, -982.49, 46.42, 277.1),
		gender = 'male'
	},
	{
		model = `mp_m_shopkeep_01`,
		coords = vector4(1164.81, -323.63, 69.21, 97.58),
		gender = 'male'
	},
	{
		model = `a_m_y_hippy_01`,
		coords = vector4(-1486.19, -377.99, 40.16, 128.18),
		gender = 'male'
	},
	{
		model = `mp_m_shopkeep_01`,
		coords = vector4(372.69, 325.21, 103.61, 249.92),
		gender = 'male'
	},
	{
		model = `mp_m_shopkeep_01`,
		coords = vector4(-3241.12, 1000.28, 12.84, 355.12),
		gender = 'male'
	},
	{
		model = `mp_m_shopkeep_01`,
		coords = vector4(2558.32, 381.2, 108.62, 354.01),
		gender = 'male'
	},
	{
		model = `mp_m_shopkeep_01`,
		coords = vector4(548.53, 2672.29, 42.16, 102.04),
		gender = 'male'
	},
	{
		model = `a_m_y_hippy_01`,
		coords = vector4(1165.92, 2710.77, 38.16, 175.89),
		gender = 'male'
	},
	{
		model = `mp_m_shopkeep_01`,
		coords = vector4(1961.01, 3739.28, 32.34, 299.01),
		gender = 'male'
	},
	{
		model = `mp_m_shopkeep_01`,
		coords = vector4(1697.41, 4923.4, 42.06, 325.06),
		gender = 'male'
	},
	{
		model = `mp_m_shopkeep_01`,
		coords = vector4(1727.72, 6414.09, 35.04, 249.1),
		gender = 'male'
	},
	-- {
	-- 	model = `mp_m_shopkeep_01`,
	-- 	coords = vector4(-156.21, 6327.13, 31.58, 317.09),
	-- 	gender = 'male'
	-- },
	{
		model = `mp_m_shopkeep_01`,
		coords = vector4(160.06, 6640.66, 31.7, 230.76),
		gender = 'male'
	},
	{
		model = `mp_m_shopkeep_01`,
		coords = vector4(812.89, -782.56, 26.17, 267.06),
		gender = 'male'
	},
	----------- Smoke on the water --------
	{
		model = `a_f_m_business_02`,
		coords = vector4(-1220.82, -1489.5, 4.37, 36.81),
		gender = 'female'
	},
	----------- Police Garage --------
	{
		model = `u_m_y_smugmech_01`,
		coords = vector4(441.42, -974.68, 25.7, 177.27),
		gender = 'male'
	},
	----------- Sea World --------
	{
		model = `a_m_y_epsilon_01`,
		coords = vector4(-1686.34, -1072.61, 13.15, 50.74),
		gender = 'male'
	},
	----------- PayCheck --------
	{
		model = `a_f_y_femaleagent`,
		coords = vector4(-1310.24, -821.96, 17.15, 220.1),
		gender = 'female'
	},

	----------- Cash In Receipts --------
		{
			model = `cs_molly`,
			coords = vector4(-1311.71, -823.09, 17.15, 216.72),
			gender = 'female'
		},
	
    -- ---------- Garages ----------
	-- ----NCHub Garages
	-- {
	-- 	model = `a_m_o_soucent_03`,
	-- 	coords = vector4(-292.97, -986.47, 31.18, 62.78),
	-- 	gender = 'male'
	-- },
	-- ------Casino Garages
	-- {
	-- 	model = `a_m_o_soucent_03`,
	-- 	coords = vector4(886.76, 0.22, 78.77, 146.4),
	-- 	gender = 'male'
	-- },
	------WhiteWidow
	{ -- Shop
		model = `a_m_m_mexcntry_01`,
		coords = vector4(185.62, -243.14, 54.07, 250.45),
		gender = 'male'
	},
	------Boss Menu
	{ -- MRPD
		model = `a_m_y_business_01`,
		coords = vector4(459.23, -984.67, 30.69, 181.44),
		gender = 'male'
	},
	{ -- EMS
	model = `a_m_y_busicas_01`,
	coords = vector4(310.79, -597.2, 43.28, 337.91),
	gender = 'male'
	},
	{ -- Vanilla
	model = `a_m_y_busicas_01`,
	coords = vector4(95.17, -1295.25, 29.26, 29.59),
	gender = 'male'
	},
	{ -- CatCAFE
	model = `a_m_y_busicas_01`,
	coords = vector4(-576.84, -1068.65, 26.61, 358.88),
	gender = 'male'
	},
	{ -- PizzaThis
	model = `a_m_y_busicas_01`,
	coords = vector4(800.39, -740.37, 27.99, 114.02), --modificado
	gender = 'male'
	},
	{ -- BeanMachine
	model = `a_m_y_busicas_01`,
	coords = vector4(283.89, -978.14, 29.42, 265.64), --modificado
	gender = 'male'
	},
	{ -- PopsDiner
	model = `a_m_y_busicas_01`,
	coords = vector4(1588.41, 6461.46, 25.32, 294.46), --modificado
	gender = 'male'
	},
	{ -- BurgerShot
	model = `a_m_y_busicas_01`,
	coords = vector4(-1177.67, -894.24, 13.97, 122.65),
	gender = 'male'
	},
	{ -- WhtieWidow
	model = `a_m_y_busicas_01`,
	coords = vector4(178.56, -251.79, 54.07, 340.45),
	gender = 'male'
	},

	{ -- Cardealer
	model = `a_m_y_busicas_01`,
	coords = vector4(-32.54, -1106.79, 26.42, 326.36),
	gender = 'male'
	},

	{ -- Bennys
	model = `a_m_y_busicas_01`,
	coords = vector4(-26.23, -1061.27, 32.4, 343.5),
	gender = 'male'
	},

	{ -- Real Estate
	model = `a_m_y_busicas_01`,
	coords = vector4(-716.4, 260.26, 84.14, 5.3), --modificado
	gender = 'male'
	},
	------Arcade
	{
		model = `cs_lifeinvad_01`,
		coords = vector4(-1290.79, -296.97, 36.05, 202.75),
		gender = 'male'
	},
	------Delivery
	{
		model = `a_m_y_business_01`,
		coords = vector4(474.78, -1457.01, 29.29, 6.66),
		gender = 'male'
	},
	---- Camera
	{
		model = `a_m_o_genstreet_01`,
		coords = vector4(531.94, -1663.38, 29.31, 185.29),
		gender = 'male'
	},
	------Rental Place
	-- {
	-- 	model = `a_m_y_business_02`,
	-- 	coords = vector4(339.37, 36.84, 89.57, 64.16),
	-- 	gender = 'male'
	-- },
	-- {
	-- 	model = `a_m_y_business_02`,
	-- 	coords = vector4(-201.68, -974.65, 29.32, 68.71),
	-- 	gender = 'male'
	-- },
	-- {
	-- 	model = `a_m_y_business_02`,
	-- 	coords = vector4(960.21, -1818.97, 31.24, 85.47),
	-- 	gender = 'male'
	-- },
	------Police Place
	{
		model = `cs_fbisuit_01`,
		coords = vector4(482.51, -995.17, 30.69, 178.56),
		gender = 'male'
	},
	{
		model = `cs_fbisuit_01`,
		coords = vector4(442.69, -981.93, 30.69, 79.41),
		gender = 'male'
	},
	{
		model = `cs_fbisuit_01`,
		coords = vector4(461.98, -995.93, 30.69, 183.88),
		gender = 'male'
	},
	-- Davis PD--Editado
	{
		model = `cs_fbisuit_01`,
		coords = vector4(382.49, -1596.79, 30.05, 48.51),
		gender = 'male'
	},
	{
		model = `cs_fbisuit_01`,
		coords = vector4(364.69, -1604.01, 25.45, 49.03),
		gender = 'male'
	},
	{
		model = `cs_fbisuit_01`,
		coords = vector4(366.67, -1592.11, 29.29, 311.28), 
		gender = 'male'
	},
	{
		model = `cs_fbisuit_01`,
		coords = vector4(356.99, -1592.15, 31.05, 316.57),
		gender = 'male'
	},
	{
		model = `cs_fbisuit_01`,
		coords = vector4(381.27, -1609.18, 30.2, 49.0),
		gender = 'male'
	},
	{
		model = `cs_fbisuit_01`,
		coords = vector4(364.14, -1602.12, 30.05, 164.12),
		gender = 'male'
	},
	{
		model = `cs_fbisuit_01`,
		coords = vector4(392.34, -1641.44, 29.25, 267.57),
		gender = 'male'
	},
	-- -----Airport Garage
	-- {
	-- 	model = `a_m_o_soucent_03`,
	-- 	coords = vector4(-794.62, -2024.23, 8.99, 236.79),
	-- 	gender = 'male'
	-- },
	-- -----Sandy Garage
	-- {
	-- 	model = `a_m_o_soucent_03`,
	-- 	coords = vector4(1729.25, 3706.88, 34.13, 19.52),
	-- 	gender = 'male'
	-- },
	-- -----Savar Garage
	-- {
	-- 	model = `a_m_o_soucent_03`,
	-- 	coords = vector4(84.42, 6421.25, 31.58, 322.2),
	-- 	gender = 'male'
	-- },
	 -----------------/ sandysheriff

	 {
	 	model = `s_m_y_sheriff_01`, 
	 	coords = vector4(1876.83, 3691.28, 33.54, 303.21),
	 	gender = 'male', 
	 	animDict = 'abigail_mcs_1_concat-0', 
		anim = 'csb_abigail_dual-0', 
		flag = 1, 
		-- scenario = 'WORLD_HUMAN_AA_COFFEE', 
	 	minusOne = true,
	 	freeze = true,
	 	invincible = true,
	 },
	  ---------- Depot ----------
	 {
		model = `ig_sacha`,
	 	coords = vector4(-193.33, -1162.36, 23.67, 269.45),
	 	gender = 'male'
	 },
	 {
	 	model = `ig_sacha`,
	 	coords = vector4(1894.45, 3715.1, 32.76, 123.05),
	 	gender = 'male'
	 },
	 {
	 	model = `ig_sacha`,
	 	coords = vector4(-220.23, 6197.9, 31.49, 312.97),
		gender = 'male'
	 },
	-- Hackers phone
	{
		model = `a_m_y_genstreet_01`, -- Model name as a hash.
		coords = vector4(1535.73, 2231.96, 77.7, 90.58), -- Hawick Ave (X, Y, Z, Heading)
		gender = 'male' -- The gender of the ped, used for the CreatePed native.
	},
	{
		model = `u_m_m_jesus_01`, -- Model name as a hash.
		coords = vector4(-140.32, 224.7, 94.99, 86.46), -- Hawick Ave (X, Y, Z, Heading)
		gender = 'male' -- The gender of the ped, used for the CreatePed native.
	},
	-- Pokemon Shop
	{
		model = `u_m_m_streetart_01`, -- Model name as a hash.
		coords = vector4(-140.32, 222.99, 94.99, 86.15), -- Hawick Ave (X, Y, Z, Heading)
		gender = 'male' -- The gender of the ped, used for the CreatePed native.
	},
	{
		model = `u_m_m_jesus_01`, -- Model name as a hash.
		coords = vector4(-140.32, 224.7, 94.99, 86.46), -- Hawick Ave (X, Y, Z, Heading)
		gender = 'male' -- The gender of the ped, used for the CreatePed native.
	},
	-- Pet Shop
	{
		model = `a_f_y_eastsa_03`,
		coords = vector4(563.11, 2753.16, 42.88, 182.21),
		gender = 'female'
	},
	-- Mask Shop
	{
		model = `s_m_y_clown_01`,
		coords = vector4(-1262.38, -1424.95, 4.37, 124.06),
		gender = 'female'
	},
	--- Backpack Digital
	{
		model = `a_f_y_business_01`,
		coords = vector4(-1271.57, -1411.61, 4.37, 119.85),
		gender = 'female'
	},
	 ---------- Hospital ----------
	{
		model = `mp_f_meth_01`,
		coords = vector4(311.63, -594.13, 43.28, 344.49),
		gender = 'female'
	},
	---------- car wash ----------
	{
		model = `cs_old_man2`,
		coords = vector4(844.49, -2124.26, 29.86, 106.52), 
		gender = 'male'
	},
	{
		model = `cs_old_man2`,
		coords = vector4(25.24, -1389.36, 29.36, 188.12),
		gender = 'male'
	},
	{
		model = `cs_old_man2`,
		coords = vector4(174.76, -1739.65, 29.29, 10.6),
		gender = 'male'
	},
	{
		model = `cs_old_man2`,
		coords = vector4(-702.39, -933.13, 19.01, 271.23),
		gender = 'male'
	},
	{
		model = `cs_old_man2`,
		coords = vector4(1361.23, 3595.51, 34.91, 203.78),
		gender = 'male'
	},
	{
		model = `cs_old_man2`,
		coords = vector4(-94.67, 6398.68, 31.49, 137.75),
		gender = 'male'
	},

	---------- Gun Shop ---------
	{
			model = `s_m_y_ammucity_01`, 
			coords = vector4(18.7, -1108.13, 29.8, 152.61),
			gender = 'male', 
	},
	{
		model = `s_m_y_ammucity_01`, 
		coords = vector4(246.78, -51.28, 69.94, 340.14),
		gender = 'male', 
    },
	{
		model = `s_m_y_ammucity_01`, 
		coords = vector4(841.09, -1028.66, 28.19, 267.54),
		gender = 'male', 
    },
	{
		model = `s_m_y_ammucity_01`, 
		coords = vector4(-659.09, -939.68, 21.83, 84.17),
		gender = 'male', 
    },
	-- {
	-- 	model = `s_m_y_ammucity_01`, 
	-- 	coords = vector4(-662.56, -933.57, 21.83, 182.83),
	-- 	gender = 'male', 
    -- },
	{
		model = `s_m_y_ammucity_01`, 
		coords = vector4(2564.75, 298.96, 108.73, 272.55),
		gender = 'male', 
    },
	{
		model = `s_m_y_ammucity_01`, 
		coords = vector4(1698.04, 3757.44, 34.71, 129.36),
		gender = 'male', 
    },
	{
		model = `s_m_y_ammucity_01`, 
		coords = vector4(-326.0, 6081.2, 31.45, 135.8),
		gender = 'male', 
    },
	{
		model = `s_m_y_ammucity_01`, 
		coords = vector4(813.34, -2155.24, 29.62, 4.54),
		gender = 'male', 
    },

	---------- Lumber Yard Job ---------
	{
		model = `a_m_m_hasjew_01`, 
		coords = vector4(-552.49, 5348.48, 74.74, 71.22),
		gender = 'male', 
	},

	---------- City Hall ---------
	{
		model = `csb_tomcasino`, 
		coords = vector4(-542.6, -197.12, 38.24, 75.54),
		gender = 'male', 
	},

	{
		model = `csb_tomcasino`, 
		coords = vector4(-552.48, -202.73, 38.24, 342.04),
		gender = 'male', 
	},
	------------- hardwere store ---------
	{
		model = `a_f_y_business_01`, 
		coords = vector4(46.73, -1749.73, 29.63, 52.27),
		gender = 'female', 
    },
	{
		model = `a_f_y_business_01`, 
		coords = vector4(2747.29, 3473.07, 55.67, 250.46),
		gender = 'female', 
    },
	{
		model = `a_f_y_business_01`, 
		coords = vector4(-421.94, 6136.67, 31.88, 176.82),
		gender = 'female', 
    },
	{
		model = `a_f_y_business_01`, 
		coords = vector4(-163.02, -1440.1, 31.42, 48.1),
		gender = 'female', 
    },
	------------- Drug Store ---------
		{
			model = `cs_omega`, 
			coords = vector4(-841.56, -397.18, 31.47, 285.28),
			gender = 'male', 
		},
		------------- mining ---------
		{
			model = `a_m_y_cyclist_01`, 
			coords = vector4(1077.74, -1984.72, 30.9, 233.35),
			gender = 'male', 
		},
		{
			model = `a_m_y_musclbeac_02`, 
			coords = vector4(1110.9, -2007.7, 31.04, 26.61),
			gender = 'male', 
		},
		{
			model = `a_m_y_vinewood_04`, 
			coords = vector4(1108.72, -1993.5, 30.97, 145.75),
			gender = 'male', 
		},
		------------- Black Market Crafting ---------
		{
			model = `mp_m_bogdangoon`, 
			coords = vector4(-534.53, -2216.01, 6.39, 220.99),
			gender = 'male', 
		},
		------------- Illegal Crafting ---------
		{
			model = `s_m_y_dealer_01`, 
			coords = vector4(1821.61, 3506.29, 38.35, 29.85),
			gender = 'male', 
		},
		------------- attachmant Crafting ---------
		{
			model = `s_m_y_dealer_01`, 
			coords = vector4(-1085.11, -935.54, 3.08, 297.88),
			gender = 'male', 
		},
			-- ------------- attachmant Crafting ---------
			-- {
			-- 	model = `csb_mweather`, 
			-- 	coords = vector4(-39.39, -614.43, 35.27, 243.92),
			-- 	gender = 'male', 
			-- },
		------------- Ems Check In ---------
		{
			model = `s_f_y_scrubs_01`, 
			coords = vector4(308.28, -595.48, 43.28, 68.29),
			gender = 'female', 
		},
		------------- Tuner Parts Craft ---------
		{
			model = `s_m_m_gaffer_01`, 
			coords = vector4(-519.01, 57.77, 45.0, 177.81),
			gender = 'male', 
		},
		{
			model = `s_m_m_gaffer_01`, 
			coords = vector4(-500.71, 54.95, 45.07, 181.9),
			gender = 'male', 
		},
		{
			model = `s_m_m_gaffer_01`, 
			coords = vector4(-502.42, 55.03, 45.07, 178.35),
			gender = 'male', 
		},
		{
			model = `s_m_m_gaffer_01`, 
			coords = vector4(-526.77, 63.04, 45.0, 353.39),
			gender = 'male', 
		},
			------------- police benys ---------
			{
				model = `mp_m_counterfeit_01`, 
				coords = vector4(451.77, -974.53, 25.7, 188.26),
				gender = 'male', 
			},
	---------------DigitalDel
	-- {
    --     model = `ig_lifeinvad_01`,
    --     coords = vector4(149.08, -234.68, 54.42, 337.93),
    --     gender = 'male', 
    -- },
	-------------Repair
 {
         model = `a_m_m_hillbilly_01`,
         coords = vector4(-1221.16, -1792.22, 3.91, 73.16),  --  fishing job in city 
         gender = 'male', 
     },
	------------Emnei
	{
        model = `a_c_chimp`,
        coords = vector4(1088.97, -2003.65, 31.14, 326.61),
        gender = 'male', 
    },
}