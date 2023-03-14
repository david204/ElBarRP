Config = Config or {}

Config.CompanyPrice = 25000

Config.Cityhall = {
    coords = vector3(-542.6, -197.12, 38.24)
}

-- THE ARRAY NAME MUST BE THE SAME AS THE JOB IN nchub/SHARED/JOBS.LUA
Config.AvaiableJobs = {
    ["trucker"] = {
        title = "Lumber Yard Delivery",
        salary = 1200,
        description = "Start working now on our best truck and get a handsome salary in relation to work.",
        gpsCoords = vector3(-554.21, 5349.18, 74.75),
    },
    ["garbage"] = {
        title = "Garbage Collector",
        salary = 1500,
        description = "Rent a garbage truck and collect the garbage at the indicated points throughout the city.",
        gpsCoords = vector3(-349.05, -1569.45, 25.23),
    },
    ["planepilot"] = {
        title = "Plane Pilot",
        salary = 1000,
        description = "Start taking packages with our transport plane. It is important to us that only quality pilots join us.",
        gpsCoords = vector3(2134.42, 4779.82, 40.97),
    },
    ["hotdog"] = {
        title = "Hotdog",
        salary = 425,
        description = "Take the sausage cart and start making and selling to people walking down the street. Believe us, there are so many hungry people.",
        gpsCoords = vector3(49.26, -1000.44, 29.36),
    },
    ["telco"] = {
        title = "Communications Technician",
        salary = 750,
        description = "Do electrical work, make electrical repairs in different places in the world and get amazing payments for it.",
        gpsCoords = vector3(525.14, -1600.89, 29.21),
    },
    ["taxi"] = {
        title = "Taxi Driver",
        salary = 500,
        description = "Start take people in the city and make money on it, we believe in you as a professional driver.",
        gpsCoords = vector3(909.46, -177.3, 74.22),
    },
    ["miner"] = {
        title = "Miner",
        salary = 1125,
        description = "Start making mine now and earn diamonds, gold and other things that you can sell for a lot of money.",
        gpsCoords = vector3(-595.86, 2091.58, 131.57),
    },
    -- ["miner"] = {
    --     title = "Miner",
    --     salary = 500,
    --     description = "Rent a garbage truck and collect the garbage at the indicated points throughout the city.",
    --     gpsCoords = vector3(-68.01, -942.47, 29.34),
    -- },
    -- ["bus"] = {
    --     title = "Bus Driver",
    --     salary = 600,
    --     description = "Soon!",
    --     gpsCoords = vector3(-68.55, -1037.28, 28.26),
    -- },
}
