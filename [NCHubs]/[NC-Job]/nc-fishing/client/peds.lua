-- --============================================================== Exports
exports[Config.targetExport]:AddTargetModel(`a_f_y_fitness_01`, {
    options = {
        {
            event = "nc:client:BoatMenu",
            icon = "fas fa-anchor",
            label = "Boat Rental",
            location = 1 --LaPuerta
        },
		{
            event = "nc:client:buyFishingGear",
            icon = "fas fa-fish",
            label = "Fishing Gear",
        },
    },
    distance = 10.0
})

exports[Config.targetExport]:AddTargetModel(`u_m_m_filmdirector`, {
    options = {
        {
            event = "nc:client:BoatMenu",
            icon = "fas fa-anchor",
            label = "Boat Rental",
            location = 2 --PaletoCove
        },
		{
            event = "nc:client:buyFishingGear",
            icon = "fas fa-fish",
            label = "Fishing Gear",
        },
    },
    distance = 10.0
})

exports[Config.targetExport]:AddTargetModel(`s_m_o_busker_01`, {
    options = {
        {
            event = "nc:client:BoatMenu",
            icon = "fas fa-anchor",
            label = "Boat Rental",
            location = 3 --ElGordo
        },
		{
            event = "nc:client:buyFishingGear",
            icon = "fas fa-fish",
            label = "Fishing Gear",
        },
    },
    distance = 10.0
})

exports[Config.targetExport]:AddTargetModel(`ig_cletus`, {
    options = {
        {
            event = "nc:client:BoatMenu",
            icon = "fas fa-anchor",
            label = "Boat Rental",
            location = 4 --ActDam
        },
		{
            event = "nc:client:buyFishingGear",
            icon = "fas fa-fish",
            label = "Fishing Gear",
        },
    },
    distance = 10.0
})

exports[Config.targetExport]:AddTargetModel(`a_f_y_yoga_01`, {
    options = {
        {
            event = "nc:client:BoatMenu",
            icon = "fas fa-anchor",
            label = "Boat Rental",
            location = 5 --AlamoSea
        },
		{
            event = "nc:client:buyFishingGear",
            icon = "fas fa-fish",
            label = "Fishing Gear",
        },
    },
    distance = 10.0
})

exports[Config.targetExport]:AddTargetModel(`s_m_y_busboy_01`, {
    options = {
        {
            event = "nc:client:SellLegalFish",
            icon = "fa fa-fish",
            label = "Sell Fish",
        },
		{
            event = "nc:client:SellillegalFish",
            icon = "fa fa-fish",
            label = "Sell Exotic Fish",
        },
    },
    distance = 10.0
})
