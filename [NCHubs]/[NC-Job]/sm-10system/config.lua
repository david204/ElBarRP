Config = {}
Config.Core = {
    CoreName = "NNCore", -- QBCore in deafult
    CoreType = "trigger", -- export or trigger
    CoreFolder = "nn-core",-- Core's Folder
    ObjectName = "NNCore:GetObject", -- Change This to your object. Deafult: QBCore:GetObject
    Voice = "pma-voice"
    
    
}
Config.AuthorizedChangeColorRanks = {
    "C.O.P",

}
Config.Managment = {
    ["Commands"] = {
        ['Min'] = "200",
        ['Max'] = "215",
        ['Color'] = "#FF0000"
    },
    ["Snr.Officer"] = {
        ['Min'] = "216",
        ['Max'] = "230",
        ['Color'] = "#00CDFF"
    },
    ["Officer"] = {
        ['Min'] = "231",
        ['Max'] = "265",
        ['Color'] = "#00CDFF"
    },
    ["Cadet"] = {
        ['Min'] = "266",
        ['Max'] = "279",
        ['Color'] = "#00CDFF"
    },
    ["Detective"] = {
        ['Min'] = "280",
        ['Max'] = "289",
        ['Color'] = "#737373"
    },
    ["S.W.A.T"] = {
        ['Min'] = "290",
        ['Max'] = "299",
        ['Color'] = "#111111"
    },
    ["SASP"] = {
        ['Min'] = "300",
        ['Max'] = "349",
        ['Color'] = "#001BFF"
    },
    ["SASPR"] = {
        ['Min'] = "350",
        ['Max'] = "399",
        ['Color'] = "#00A708"
    },
    ["BCSO"] = {
        ['Min'] = "400",
        ['Max'] = "449",
        ['Color'] = "#FFA600"
    },
    ["Gang Unit"] = {
        ['Min'] = "500",
        ['Max'] = "549",
        ['Color'] = "#111111"
    },
    ["Wardens"] = {
        ['Min'] = "700",
        ['Max'] = "750",
        ['Color'] = "#C5FF00"
    },
}
Config.Ranks = {
    "C.O.P",
    "Asst C.O.P",
    "Commander",
    "Capitan",
}
Config.Ranks2 = {
    "Corporal",
    "Sergeant",
    "Lieutenant",
    "Undersheriff",
    "Sheriff",
    "Chief",
    "Captain",
    "Asst.Chief",
    "C.O.P"

}
Config.ColorCommand = "SetCallSignColor"
Config.DeafultColor = "#81B3FF"
Config.UnemployedJob = "unemployed"
Config.UnemployedGrade = 1

Config.TalkingColor = {
    [1] = "#4293f5",
    [2] = "#4275f5",
    [3] = "#4260f5",
}

Config.PanicItem = "panicbutton"
function OnPanic()
end