Config = {}
Config.MaxWidth = 5.0
Config.MaxHeight = 5.0
Config.MaxLength = 5.0
Config.DamageNeeded = 100.0
Config.EnableProne = true
Config.JointEffectTime = 60
Config.RemoveWeaponDrops = true
Config.RemoveWeaponDropsTimer = 25
Config.DefaultPrice = 20 -- carwash
Config.DirtLevel = 0.1 --carwash dirt level

ConsumeablesEat = {
    ["sandwich"] = math.random(35, 54),
    ["burger-moneyshot"] = math.random(35, 54),
    ["burger-meatfree"] = math.random(35, 54),
    ["burger-bleeder"] = math.random(35, 54),
    ["burger-heartstopper"] = math.random(35, 54),
    ["burger-torpedo"] = math.random(35, 54),
    ["tosti"] = math.random(40, 50),
    ["burger-fries"] = math.random(35, 54),
    ["twerks_candy"] = math.random(35, 54),
    ["snikkel_candy"] = math.random(40, 50),
    ["pangash_bhat"] = math.random(35, 54),
    ["morog_polao"] = math.random(40, 50),
    ["dim_polao"] = math.random(40, 50),
    ["kacci"] = math.random(40, 50),
    ["bengali_platter"] = math.random(50, 95),
    ["roshomalai"] = math.random(40, 50),
    ["cha"] = math.random(40, 50),
    ["fuchka"] = math.random(40, 50),
    ["apple"] = math.random(10, 20),
    ["beef"] = math.random(35, 50),
    ["slicedpie"] = math.random(10, 20),
    ["corncob"] = math.random(25, 40),
    ["canofcorn"] = math.random(35, 50),
    ["grapes"] = math.random(10, 20),
    ["greenpepper"] = math.random(10, 20),
    ["chillypepper"] = math.random(10, 20),
    ["tomato"] = math.random(10, 20),
    ["tomatopaste"] = math.random(25, 40),
    ["cooked_bacon"] = math.random(35, 50),
    ["cooked_sausage"] = math.random(35, 50),
    ["cooked_pork"] = math.random(35, 50),
    ["cooked_ham"] = math.random(35, 50),
}

ConsumeablesDrink = {
    ["water_bottle"] = math.random(35, 54),
    ["coke"] = math.random(35, 54),
    ["burger-softdrink"] = math.random(35, 54),
    ["burger-mshake"] = math.random(35, 54),
    ["kurkakola"] = math.random(35, 54),
    ["coffee"] = math.random(40, 50),
    ["cocacola"] = math.random(35, 54),
    ["borhani"] = math.random(40, 50),
    ["zirapani"] = math.random(35, 54),
    ["apple_juice"] = math.random(25, 45),
    ["grapejuice"] = math.random(25, 45),
    ["hotsauce"] = math.random(10, 15),
}

ConsumeablesAlcohol = {
    ["whiskey"] = math.random(20, 30),
    ["beer"] = math.random(30, 40),
    ["vodka"] = math.random(20, 40),
}

Config.BlacklistedScenarios = {
    ['TYPES'] = {
        "WORLD_VEHICLE_MILITARY_PLANES_SMALL",
        "WORLD_VEHICLE_MILITARY_PLANES_BIG",
    },
    ['GROUPS'] = {
        2017590552,
        2141866469,
        1409640232,
        `ng_planes`,
    }
}

Config.BlacklistedVehs = {
    [`SHAMAL`] = false,
    [`LUXOR`] = false,
    [`LUXOR2`] = false,
    [`JET`] = true,
    [`LAZER`] = false,
    [`BUZZARD`] = true,
    [`BUZZARD2`] = true,
    [`ANNIHILATOR`] = true,
    [`SAVAGE`] = true,
    [`TITAN`] = true,
    [`RHINO`] = true,
    [`POLICE`] = false,
    [`POLICE2`] = false,
    [`POLICE3`] = false,
    [`POLICE4`] = false,
    [`POLICEB`] = false,
    [`POLICET`] = false,
    [`SHERIFF`] = false,
    [`SHERIFF2`] = false,
    [`FIRETRUK`] = false,
    [`MULE`] = false,
    [`POLMAV`] = false,
    [`MAVERICK`] = false,
    [`BLIMP`] = false,
    [`AIRTUG`] = true,
    [`CAMPER`] = false, 
}

Config.BlacklistedPeds = {
    [`s_m_y_ranger_01`] = true,
    [`s_m_y_sheriff_01`] = true,
    [`s_m_y_cop_01`] = true,
    [`s_f_y_sheriff_01`] = true,
    [`s_f_y_cop_01`] = true,
    [`s_m_y_hwaycop_01`] = true,
}

Config.CarWash = { -- carwash
    [1] = {
        ["label"] = "Hands Free Carwash",
        ["coords"] = vector3(25.29, -1391.96, 29.33),
    },
    [2] = {
        ["label"] = "Hands Free Carwash",
        ["coords"] = vector3(174.18, -1736.66, 29.35),
    },
    [3] = {
        ["label"] = "Hands Free Carwash",
        ["coords"] = vector3(-74.56, 6427.87, 31.44),
    },
    [5] = {
        ["label"] = "Hands Free Carwash",
        ["coords"] = vector3(1363.22, 3592.7, 34.92),
    },
    [6] = {
        ["label"] = "Hands Free Carwash",
        ["coords"] = vector3(-699.62, -932.7, 19.01),
    }
}
