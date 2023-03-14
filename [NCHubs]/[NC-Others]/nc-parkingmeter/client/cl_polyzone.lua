local ParkingMeters = {
    "prop_parknmeter_01",
    "prop_parknmeter_02"
}

exports['qb-target']:AddTargetModel(ParkingMeters, {
    options = {
        {
        type = "client",
        event = "nc-parkingmeter:client:payParking",
        icon = "fas fa-parking",
        label = "Pay Parking ($5)",
        },
        { 	
            type = "client",
            event = "nc-parkingmeter:client:checkParking",
            icon = "fas fa-parking",
            label = "Check payment (Police)",
            job = "police",
        },
    },
    distance = 2.5,
})
