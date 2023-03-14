Config = {}
-------------------------------vendings-------------------------------
Config = Config or {}
Config.VendingMachines = {
    ['drinks'] = {
        ['Label'] = 'Drinks',
        ['Items'] = {
            [1] = {
                ['name'] = "kurkakola",
                ['price'] = 4,
                ['amount'] = 50,
                ['info'] = {},
                ['type'] = "item",
                ['slot'] = 1,
            },
            [2] = {
                ['name'] = "water_bottle",
                ['price'] = 4,
                ['amount'] = 50,
                ['info'] = {},
                ['type'] = "item",
                ['slot'] = 2,
            },
        }
    },
    ['vending'] = {
        ['Label'] = 'Food Vending',
        ['Items'] = {
            [1] = {
                ['name'] = "sandwich",
                ['price'] = 4,
                ['amount'] = 50,
                ['info'] = {},
                ['type'] = "item",
                ['slot'] = 1,
            },
        }
    },
    ['coffee'] = {
        ['Label'] = 'Coffee',
        ['Items'] = {
            [1] = {
                ['name'] = "coffee",
                ['price'] = 4,
                ['amount'] = 50,
                ['info'] = {},
                ['type'] = "item",
                ['slot'] = 1,
            },
        }
    },
    ['water'] = {
        ['Label'] = 'Water',
        ['Items'] = {
            [1] = {
                ['name'] = "water_bottle",
                ['price'] = 4,
                ['amount'] = 50,
                ['info'] = {},
                ['type'] = "item",
                ['slot'] = 1,
            },
        }
    },
}

Config.Vendings = {
    [1] = {
        ['Model'] = 'prop_vend_coffe_01', -- Model name of prop
        ['Category'] = 'coffee', -- Category from list above
        ['Label'] = 'Coffee', -- Name of vending
        ['Icon'] = 'fas fa-coffee' -- Fontawesome icon
    },
    [2] = {
        ['Model'] = 'prop_vend_water_01',
        ['Category'] = 'water',
        ['Label'] = 'Water Dispenser',
        ['Icon'] = 'fas fa-tint'
    },
    [3] = {
        ['Model'] = 'prop_watercooler',
        ['Category'] = 'water',
        ['Label'] = 'Water Dispenser',
        ['Icon'] = 'fas fa-tint'
    },
    [4] = {
        ['Model'] = 'prop_watercooler_Dark',
        ['Category'] = 'water',
        ['Label'] = 'Water Dispenser',
        ['Icon'] = 'fas fa-tint'
    },
    [5] = {
        ['Model'] = 'prop_vend_snak_01',
        ['Category'] = 'vending',
        ['Label'] = 'Food Vending',
        ['Icon'] = 'fas fa-shopping-basket' -- <i class="fas fa-shopping-basket"></i>
    },
    [6] = {
        ['Model'] = 'prop_vend_snak_01_tu',
        ['Category'] = 'vending',
        ['Label'] = 'Food Vending',
        ['Icon'] = 'fas fa-shopping-basket'
    },
    [7] = {
        ['Model'] = 'prop_vend_fridge01',
        ['Category'] = 'drinks',
        ['Label'] = 'Drinks Vending',
        ['Icon'] = 'fas fa-glass-whiskey'
    },
    [8] = {
        ['Model'] = 'prop_vend_soda_01',
        ['Category'] = 'drinks',
        ['Label'] = 'Drinks Vending',
        ['Icon'] = 'fas fa-glass-whiskey'
    },
    [9] = {
        ['Model'] = 'prop_vend_soda_02',
        ['Category'] = 'drinks',
        ['Label'] = 'Drinks Vending',
        ['Icon'] = 'fas fa-glass-whiskey'
    },
}

----------------Blips
Config.Framework = 'QBCORE' -- 'ESX' or 'QBCORE'
Config.Blips = {
	[1] = {
		Coords = { x = 48.95, y = -1000.29, z = 29.36 },
		Blip = { name = 'Hotdog', sprite = 605, size = 0.68, color = 0 },
		AllowedJobs = {'hotdog'},
	},
    [2] = {
		Coords = { x = -552.25, y = 5348.45, z = 74.74 },
		Blip = { name = 'Lumber Yard Delivery', sprite = 545, size = 0.68, color = 1 },
		AllowedJobs = {'trucker'},
	},
}