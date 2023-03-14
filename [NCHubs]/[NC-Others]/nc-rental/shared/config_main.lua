Config = {}

Config.QBMenuName = 'qb-menu'
Config.QBCoreName = 'nchub'
Config.QBTargetName = 'qb-target'
Config.InventoryName = 'qb-inventory'
Config.QBInputName = 'qb-input'
Config.QBPhoneName = 'qb-phone'
Config.PhoneName = 'qb-phone' -- Can be qb-phone or gksphone (Maybe later can i'll update to use qs-smartphone)
Config.DebugPoly = false
Config.BillingAfterMailTime = 1 -- Time to receive bill after receive mail to take vehicle back (in minutes)
Config.PriceMultiplier = 10 -- The fees price multiplier (It multipliers vehicle price)

Config.RentalSpots = {
    ["Rental1"] = {
        ["SpotName"] = "Rental1",
        ["LabelSpotName"] = "Vehicle rental",
        ["PedCoords"] = vector3(339.37, 36.84, 88.57),
        ["PedHeading"] = 64.16,
        ["MapBlipSprite"] = 326,
        ["MapBlipColour"] = 8,
        ["TargetIcon"] = "fas fa-car",
        ["PedModel"] = "csb_anita",
        ["PedModelHash"] = 0x0703F106,
        ["VehicleSpawnLocation"] = vector4(340.19, 31.23, 88.22, 66.29),
        ["AvailableVehicles"] = {
            [1] = { VehicleSpawnName = "neon", VehicleLableName = "Pfister Neon", RentPrice = 10, MenuIcon = "fas fa-car" },
            [2] = { VehicleSpawnName = "blista", VehicleLableName = "Blista", RentPrice = 100, MenuIcon = "fas fa-car" },
            [3] = { VehicleSpawnName = "sultan", VehicleLableName = "Karin Sultan", RentPrice = 200, MenuIcon = "fas fa-car" },
            [4] = { VehicleSpawnName = "shinobi", VehicleLableName = "Nagasaki Shinobi", RentPrice = 300, MenuIcon = "fas fa-motorcycle" },
            [5] = { VehicleSpawnName = "panto", VehicleLableName = "Panto", RentPrice = 50, MenuIcon = "fas fa-car" },
        },
    },
    ["Rental2"] = {
        ["SpotName"] = "Rental2",
        ["LabelSpotName"] = "Vehicle rental",
        ["PedCoords"] = vector3(-201.68, -974.65, 28.32),
        ["PedHeading"] = 68.71,
        ["MapBlipSprite"] = 326,
        ["MapBlipColour"] = 8,
        ["TargetIcon"] = "fas fa-car",
        ["PedModel"] = "csb_anita",
        ["PedModelHash"] = 0x0703F106,
        ["VehicleSpawnLocation"] = vector4(-200.73, -967.31, 28.99, 339.3),
        ["AvailableVehicles"] = {
            [1] = { VehicleSpawnName = "neon", VehicleLableName = "Pfister Neon", RentPrice = 10, MenuIcon = "fas fa-car" },
            [2] = { VehicleSpawnName = "blista", VehicleLableName = "Blista", RentPrice = 100, MenuIcon = "fas fa-car" },
            [3] = { VehicleSpawnName = "sultan", VehicleLableName = "Karin Sultan", RentPrice = 200, MenuIcon = "fas fa-car" },
            [4] = { VehicleSpawnName = "shinobi", VehicleLableName = "Nagasaki Shinobi", RentPrice = 300, MenuIcon = "fas fa-motorcycle" },
            [5] = { VehicleSpawnName = "panto", VehicleLableName = "Panto", RentPrice = 50, MenuIcon = "fas fa-car" },
        },
    },
    ["Rental3"] = {
        ["SpotName"] = "Rental3",
        ["LabelSpotName"] = "Vehicle rental",
        ["PedCoords"] = vector3(960.21, -1818.97, 30.24),
        ["PedHeading"] = 85.47,
        ["MapBlipSprite"] = 326,
        ["MapBlipColour"] = 8,
        ["TargetIcon"] = "fas fa-car",
        ["PedModel"] = "csb_anita",
        ["PedModelHash"] = 0x0703F106,
        ["VehicleSpawnLocation"] = vector4(965.83, -1815.77, 30.9, 84.72),
        ["AvailableVehicles"] = {
            [1] = { VehicleSpawnName = "neon", VehicleLableName = "Pfister Neon", RentPrice = 10, MenuIcon = "fas fa-car" },
            [2] = { VehicleSpawnName = "blista", VehicleLableName = "Blista", RentPrice = 100, MenuIcon = "fas fa-car" },
            [3] = { VehicleSpawnName = "sultan", VehicleLableName = "Karin Sultan", RentPrice = 200, MenuIcon = "fas fa-car" },
            [4] = { VehicleSpawnName = "shinobi", VehicleLableName = "Nagasaki Shinobi", RentPrice = 300, MenuIcon = "fas fa-motorcycle" },
            [5] = { VehicleSpawnName = "panto", VehicleLableName = "Panto", RentPrice = 50, MenuIcon = "fas fa-car" },
        },
    },
}

Lang = {
    ["MenuHeader"] = "Renting Menu",
    ["CloseMenu"] = "Close menu",
    ["InputHeader"] = "How many time you want to rent the vehicle?",
    ["Submit"] = "Submit",
    ["InputText"] = "Time (In minutes)",
    ["AlreadyRenting"] = "You are already renting an vehicle...",
    ["NoMoney"] = "You dont have money for this...",
    ["CancelCurrentRenting"] = "Cancel current renting",
    ["ConfirmMenuHeader"] = "You are sure you want to rent this vehicle?",
    ["Yes"] = "Yes",
    ["No"] = "No",
    ["MailSender"] = "Rent a car department",
    ["MailSubject"] = "Vehicle renting",
    ["MailMessage"] = "Your renting time as been ended. <br> You have 5 minutes to take the vehicle back to our department or you will need to pay more for renting! <br> Bes regards Rent a car department",
    ["MailMessage2"] = "Like i said, you dont put vehicle at rent department at time and need to pay more... Let's go take that to here...",
    ["PerMinute"] = " per minute",
}