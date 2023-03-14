-- Leaked by Suck Leaks
-- https://discord.gg/suckleaks
-- https://discord.gg/WVMhNBvUbm

Config = {}
Config.RefreshTime = 200
Config.InCarRefreshTime = 200

Config.RefreshPlayersCountTime = 5 * 1000

-- Changing these keybindings will take effect on the first player to enter the server. 
-- The old keybind will remain saved for players who have already entered the server, 
-- because the player can customize these keybinds by finding them in settings -> keybind -> fivem.

Config.Sealtbelt = "b"
Config.SpeedLimiter = "z"
Config.SettingsMenu = "j"
Config.SpeedLimitCommand = "limit"

Config.ClockType = "24" 
-- PM = 12 hour clock 9.30 PM
-- 24 = 24 hour clock 21.30

Config.KeyBindList = {
    {name = "Telefono",  key = "M"},
    {name = "Inventario",  key = "Tab"},
    {name = "Hud Menu", key = "J"},
    -- {name = "Chat", key = "T"},
    -- {name = "Kemer bağlandı", key = "B"},
    -- {name = "Tốc Độ Tối Đa", key = "Z"},
    -- {name = "Chỉnh Sửa Hud", key = "Q"},
}

Config.Langs = {
    ["belt-plug"]   = "Cinturón abrochado.",
    ["belt-out"]    = "Cinturón desabrochado.",
    ["limiter-on"]  = "Límite de velocidad en",
    ["limiter-off"] = "Límite de velocidad desactivado",
    ["dont-set-limit"] = "Límite de velocidad /"..Config.SpeedLimitCommand.." establecer desde.",
    ["dont-enter-speed"] = "No ingresó un límite. Ejemplo: /limit 100",
    ["limiter-error"] = "No se"
}

Config.CashItem = false
Config.CashItemName = "olta"

Config.SaltyChat = true
Config.SaltychatRange = { --Look and write the distances here in the satychat config file. The default is as follows. 
    ["1.0"] = { "Whisper",  4},
    ["3.0"] = { "Normal",   8},
    ["5.0"] = { "Shouting", 16},
}

Config.PmaRange = {
    { "Whisper",  35},
    { "Normal",   65}, 
    { "Shouting", 100}
}

Config.BlackListVehicle = {
    "bmx",
    "cruiser",
    "fixter",
    "scorcher",
    "tribike",
    "tribike2",
    "tribike3",
    "polmav",
    "maverick",
    "dodo",
    "seasparrow",
    "shamal",
    "tula",
    "velum",
    "velum2",
    "volatus",
    "annihilator",
    "buzzard",
    "buzzard2",
    "cargobob",
    "cargobob2",
    "cargobob3",
    "cargobob4",
    "frogger",
    "frogger2",
    "maverick",
    "polmav",
    "supervolito",
    "supervolito2",
    "swift",
    "swift2",
    "valkyrie",
    "valkyrie2",
    "volatus",
    "akula",
    "avenger",
    "avenger2",
    "besra",
    "blimp",
    "blimp2",
    "blimp3",
    "bombushka",
    "cargoplane",
    "cuban800",
    "dodo",
    "duster",
    "howard",
    "jet",
    "lazer",
    "luxor",
    "luxor2",
    "mammatus",
    "microlight",
    "miljet",
    "mogul",
    "molotok",
    "nimbus",
    "nokota",
    "pyro",
    "rogue",
    "seabreeze",
    "shamal",
    "starling",
    "strikeforce",
    "stunt",
    "titan",
    "tula",
    "velum",
    "velum2",
    "vestra",
    "volatol",
    "alphaz1",
    "avenger",
    "avenger2",
}