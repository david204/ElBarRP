
-- Target

Citizen.CreateThread(function()
	exports['qb-target']:AddBoxZone("SmokingDuty", vector3(-1249.39, -1449.04, 4.27), 0.5, 0.5, {
		name = "SmokingDuty",
		heading = 0,
		debugPoly = false,
		minZ=3.30,
		maxZ=5.38,
	}, {
		options = {
		    {  
			event = "nc-vapejob:Duty",
			icon = "far fa-clipboard",
			label = "Clock On/Off",
			job = "smoking",
		    },
		},
		distance = 1.5
	})

		exports['qb-target']:AddBoxZone("Counter 1", vector3(-1248.01, -1447.28, 4.37), 3, 1, {
			name = "Counter 1",
			heading = 0,
			debugPoly = false,
			minZ=3.34,
			maxZ=5.37,
		}, {
			options = {
			    {
				event = "nc-vapejob:Tray1",
				icon = "far fa-clipboard",
				label = "Counter 1",
			    },
			},
			distance = 1.5
		})

	exports['qb-target']:AddBoxZone("Counter 2", vector3(-480.4, 284.85, 83.34), 3, 1, {
		name="Counter 2",
		heading=0,
		debugPoly=false,
		minZ=82.34,
		maxZ=84,
	}, {
		options = {
		    {
			event = "nc-vapejob:Tray2",
			icon = "far fa-clipboard",
			label = "Counter 2",
		    },
		},
		distance = 1.5
	})

	exports['qb-target']:AddBoxZone("vapeunboxing", vector3(-483.346, 289.4, 83.453), 2, 1, {
		name="vapeunboxing",
		heading=0,
		debugPoly=false,
		minZ=83.490,
		maxZ=84,
	}, {
		options = {
			{
				event = "nc-vapejob:TakeVape",
				icon = "fas fa-smoking",
				label = "Unbox Vape",
				job = "smoking",
			},
			{
				event = "nc-vapejob:VapeJuice1",
				icon = "fas fa-wine-bottle",
				label = "Juice Station",
				job = "smoking",
			},
		},
		distance = 1.5
	})

	exports['qb-target']:AddBoxZone("vapeunboxing2", vector3(-1248.12, -1450.23, 5.4), 2, 1, {
		name="vapeunboxing",
		heading=0,
		debugPoly=false,
		minZ=3.8,
		maxZ=6.8,
	}, {
		options = {
			{
				event = "nc-vapejob:TakeVape",
				icon = "fas fa-smoking",
				label = "Unbox Vape",
				job = "smoking",
			},
			{
				event = "nc-vapejob:VapeJuice1",
				icon = "fas fa-wine-bottle",
				label = "Juice Station",
				job = "smoking",
			},
		},
		distance = 1.5
	})

        exports['qb-target']:AddBoxZone("vapestore", vector3(-1249.35, -1450.85, 5.06), 0.7, 0.7, {
            name="vapestore",
            heading=0,
            debugPoly=false,
            minZ=3.30,
            maxZ=7.20,
        }, {
                options = {
                    {
                        event = "nc-vapejob:shop",
                        icon = "fas fa-laptop",
                        label = "Order Ingredients!",
                        job = "smoking",
                    },
                },
                distance = 1.5
            })

        exports['qb-target']:AddBoxZone("smokingstorage1", vector3(-483.03, 289.37, 83.34), 2, 1.2, {
            name="smokingstorage1",
            heading=0,
            debugPoly=false,
            minZ=82.34,
            maxZ=83.440,
        }, {
                options = {
                    {
                        event = "nc-vapejob:Storage",
                        icon = "fas fa-box",
                        label = "Storage",
                        job = "smoking",
                    },
                },
                distance = 1.5
            })

			
			exports['qb-target']:AddBoxZone("smokingstorage2", vector3(-1244.17, -1446.61, 4.37), 2, 1.1, {
				name="smokingstorage1",
				heading=0,
				debugPoly=false,
				minZ=3.37,
				maxZ=5.27,
			}, {
					options = {
						{
							event = "nc-vapejob:Storage",
							icon = "fas fa-box",
							label = "Storage",
							job = "smoking",
						},
					},
					distance = 1.5
				})

        exports['qb-target']:AddBoxZone("smokingregister1", vector3(-1250.62, -1449.43, 4.29), 0.6, 0.6, {
            name="smokingregister1",
            debugPoly=false,
            heading=0,
            minZ=3.30,
            maxZ=5.30,
        }, {
                options = {
                    {
                        event = "nc-vapejob:bill",
                        parms = "1",
                        icon = "fas fa-credit-card",
                        label = "Charge Customer",
                        job = "smoking",
                    },
                },
                distance = 1.5
            })

        exports['qb-target']:AddBoxZone("smokingregister2", vector3(-480.2, 286.73, 83.34), 0.6, 0.6, {
            name="smokingregister2",
            debugPoly=false,
            heading=0,
            minZ=82.60,
            maxZ=85,
            }, {
                    options = {
                        {
                            event = "nc-vapejob:bill",
                            parms = "2",
                            icon = "fas fa-credit-card",
                            label = "Charge Customer",
                            job = "smoking",
                        },
                    },
                    distance = 1.5
                })  
			end)

-- Billing

RegisterNetEvent("nc-vapejob:bill")
AddEventHandler("nc-vapejob:bill", function()
    local bill = exports['qb-input']:ShowInput({
        header = "Create Receipt",
		submitText = "Bill",
        inputs = {
            {
                text = "ID (#)",
				name = "citizenid", -- name of the input should be unique otherwise it might override
                type = "text", -- type of the input
                isRequired = false -- Optional [accepted values: false | false] but will submit the form if no value is inputted
            },
            {
                text = "Bill Price ($)", -- text you want to be displayed as a place holder
                name = "billprice", -- name of the input should be unique otherwise it might override
                type = "number", -- type of the input - number will not allow non-number characters in the field so only accepts 0-9
                isRequired = false -- Optional [accepted values: false | false] but will submit the form if no value is inputted
            }
			
        }
    })
    if bill ~= nil then
        if bill.citizenid == nil or bill.billprice == nil then 
            return 
        end
        TriggerServerEvent("nc-vapejob:bill:player", bill.citizenid, bill.billprice)
    end
end)
