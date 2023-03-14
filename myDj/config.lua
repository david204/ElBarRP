Config = {}
Translation = {}

Translation = {
    ['de'] = {
        ['DJ_interact'] = 'Drücke ~g~E~s~, um auf das DJ Pult zuzugreifen',
        ['title_does_not_exist'] = '~r~Dieser Titel existiert nicht!',
    },

    ['en'] = {
        ['DJ_interact'] = 'Press ~g~E~s~, to access the DJ desk',
        ['title_does_not_exist'] = '~r~This title does not exist!',
    }
}

Config.Locale = 'en'

---Config.useESX = false -- can not be disabled without changing the callbacks
Config.enableCommand = false

Config.enableMarker = true -- purple marker at the DJ stations

Config.DJPositions = {
    {
        name = 'records',
        pos = vector3(-841.3546, -717.2817, 28.284891),
        requiredJob = 'records', ---- if you want just for job write 'job name' if  you want use for all people leave nil,
        range = 25.0, 
        volume = 1.0 --[[ do not touch the volume! --]]
    },
   
    {
        name = 'tequila',
        pos = vector3(-550.7106, 284.22848, 82.976501),
        requiredJob = 'tequila', ---- if you want just for job write 'job name' if  you want use for all people leave nil,
        range = 25.0, 
        volume = 1.0 --[[ do not touch the volume! --]]
    },
    {
        name = 'whitewidow',
        --vector3(x, y, z)
        pos = vector3(183.2217, -260.9524, 54.070495),
        requiredJob = 'whitewidow',
        range = 25.0,
        volume = 0.2,
    },
    {
        name = 'mechanic',
        pos = vector3(833.27856, -823.2713, 26.352962),
        requiredJob = 'mechanic',
        range = 25.0,
        volume = 0.2,
    },
    {
        name = 'driftracing',
        pos = vector3(946.62658, -1830.586, 21.035604),
        requiredJob = 'driftracing',
        range = 50.0,
        volume = 1.0,
    },
    {
        name = 'flyingschool',
        pos = vector3(1727.1303, 3325.9279, 41.22364),
        requiredJob = 'flyingschool',
        range = 50.0,
        volume = 1.0,
    },
    {
        name = 'vanilla',
        pos = vector3(120.68328, -1281.595, 29.480401),
        requiredJob = 'vanilla',
        range = 50.0,
        volume = 1.0,
    },
    {
        name = 'pizza',
        pos = vector3(812.08874, -752.2722, 26.78083),
        requiredJob = 'pizza',
        range = 50.0,
        volume = 1.0,
    },
    {
        name = 'beanmachine',
        pos = vector3(122.16849, -1039.034, 29.277912),
        requiredJob = 'beanmachine',
        range = 15.0,
        volume = 0.5,
    },
    {
        name = 'burgershot',
        pos = vector3(-1195.329, -893.6193, 13.98473),
        requiredJob = 'burgershot',
        range = 15.0,
        volume = 0.3,
    },
    {
        name = 'popsdiner',
        pos = vector3(1590.6197, 6457.9267, 26.014005),
        requiredJob = 'popsdiner',
        range = 30.0,
        volume = 0.3,
    },
    {
        name = 'casino',
        pos = vector3(943.0285, 40.596439, 112.52429),
        requiredJob = 'casino',
        range = 30.0,
        volume = 0.3,
    },
    {
        name = 'bahama',
        pos = vector3(-1390.757, -604.961, 31.518409),
        requiredJob = 'bahama',
        range = 50.0,
        volume = 0.3,
    },

    {
        name = 'nikib',
        pos = vector3(-1476.188, -1249.706, 2.9021043),
        requiredJob = 'nikib',
        range = 75.0,
        volume = 0.3,
    },

    {
        name = 'catcafe',
        pos = vector3(-584.7924, -1061.903, 22.344198),
        requiredJob = 'catcafe',
        range = 25.0,
        volume = 0.3,
    },

    {
        name = 'bakery',
        pos = vector3(53.861457, -125.1499, 55.458587),
        requiredJob = 'bakery',
        range = 25.0,
        volume = 0.3,
    },

    {
        name = 'blazeit',
        pos = vector3(360.65695, -1258.145, 36.309436),
        requiredJob = 'blazeit',
        range = 25.0,
        volume = 0.3,
    },

    {
        name = 'henhouse',
        pos = vector3(-312.1039, 6265.1699, 32.061679),
        requiredJob = 'henhouse',
        range = 25.0,
        volume = 0.3,
    },

    {
        name = 'bluffs',
        pos = vector3(-3010.18, 59.606315, 12.599341),
        requiredJob = 'bluffs',
        range = 65.0,
        volume = 0.3,
    },

    {
        name = 'policeranger',
        pos = vector3(381.5827, 799.65631, 190.48497),
        requiredJob = 'police',
        range = 15.0,
        volume = 0.3,
    },
    
    {
        name = 'tuner',
        pos = vector3(147.69293, -3013.333, 10.703438),
        requiredJob = 'tuner',
        range = 35.0,
        volume = 0.3,
    },

    



    --{name = 'bahama', pos = vector3(-1381.01, -616.17, 31.5), requiredJob = 'DJ', range = 25.0}
}