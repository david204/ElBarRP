Config = {}
Config.Debug = false -- True / False for Debug System
Config.Dispatch = "nc-dispatch" -- Default / nc-dispatch / cd-dispatch
Config.Jobs = {"police"} -- PD Job Name

Config.Locations = {
    ["police"] = {
        [1] = { name = "MRPD-FrontDesk", coords = vector3(441.29, -981.87, 30.69), length = 2.8, width = 2.6, heading = 335, minZ = 30.49, maxZ = 31.49
        },
    }
}

