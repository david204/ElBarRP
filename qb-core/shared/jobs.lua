QBShared = QBShared or {}
-- Jobs
QBShared.ForceJobDefaultDutyAtLogin = true -- true: Force duty state to jobdefaultDuty | false: set duty state from database last saved
QBShared.Jobs = {
    ['admin'] = {
		label = 'NCHub',
		defaultDuty = true,
		grades = {
            ['0'] = {
                name = 'Gov',
                payment = 0
            },
        },
	},

	['unemployed'] = {
		label = 'Civilian',
		defaultDuty = true,
		grades = {
            ['0'] = {
                name = 'Freelancer',
                payment = 10
            },
        },
	},

    -- Postal Job
    ['gopostal'] = {
        label = 'GoPostal',
        defaultDuty = true,
        offDutyPay = false,
        grades = {
            ['0'] = {
                name = 'Package Delivery Driver',
                payment = 250
            },
        },
    },

    -- Vape Shop
    ["smoking"] = {
		label = "Smo-King Employee",
		defaultDuty = true,
		grades = {
            ['0'] = {
                name = "Trainee",
                payment = 300
            },
			['1'] = {
                name = "Employee",
                payment = 400
            },
			['2'] = {
                name = "Manager",
                payment = 600
            },
			['4'] = {
                name = "Owner",
				isboss = true,
                payment = 850
            },
        },
	},

    --Vanilla
    ['vanilla'] = {
		label = 'Vanilla Unicorn',
		defaultDuty = true,
		grades = {
            ['0'] = { name = 'Recruit', payment = 50 },
			['1'] = { name = 'Novice', payment = 75 },
			['2'] = { name = 'Experienced', payment = 100 },
			['3'] = { name = 'Advanced', payment = 125 },
			['4'] = { name = 'Manager', bankAuth = true, isboss = true,  payment = 150 },
        },
	},

    --Popsinder Job
    ['popsdiner'] = {
		label = 'Pops Diner',
		defaultDuty = true,
		grades = {
            ['0'] = { name = 'Recruit', payment = 50 },
			['1'] = { name = 'Novice', payment = 75 },
			['2'] = { name = 'Experienced', payment = 100 },
			['3'] = { name = 'Advanced', payment = 125 },
			['4'] = { name = 'Manager', bankAuth = true, isboss = true,  payment = 150 },
        },
	},

    -- BeanMachine Job
    ['beanmachine'] = {
		label = 'Bean Machine',
		defaultDuty = true,
		grades = {
            ['0'] = { name = 'Recruit', payment = 50 },
			['1'] = { name = 'Novice', payment = 75 },
			['2'] = { name = 'Experienced', payment = 100 },
			['3'] = { name = 'Advanced', payment = 125 },
			['4'] = { name = 'Manager', bankAuth = true, isboss = true,  payment = 150 },
        },
	},

    -- Catcafe Job
    ['catcafe'] = {
		label = 'Cat Cafe',
		defaultDuty = true,
		grades = {
            ['0'] = { name = 'Recruit', payment = 50 },
			['1'] = { name = 'Novice', payment = 75 },
			['2'] = { name = 'Experienced', payment = 100 },
			['3'] = { name = 'Advanced', payment = 125 },
			['4'] = { name = 'Manager', bankAuth = true, isboss = true,  payment = 150 },
        },
	},

    -- Piza This job
    ['pizzathis'] = {
		label = 'Pizza This',
		defaultDuty = true,
		grades = {
            ['0'] = { name = 'Recruit', payment = 50 },
			['1'] = { name = 'Novice', payment = 75 },
			['2'] = { name = 'Experienced', payment = 100 },
			['3'] = { name = 'Advanced', payment = 125 },
			['4'] = { name = 'Manager', bankAuth = true, isboss = true,  payment = 150 },
        },
	},

    -- WhiteWidow Job
    ['whitewidow'] = {
        label = 'Whitewidow',
        defaultDuty = false,
        grades = {
            ['0'] = { name = 'Worker', payment = 100 },
            ['1'] = { name = 'Vice Manager', payment = 125 },
            ['2'] = { name = 'Manager', bankAuth = true, isboss = true, payment = 175 },
        },
    },    

    -- Communications Technician job

    ["telco"] = {
		label = "Technician",
		defaultDuty = true,
		grades = {
            ['0'] = {
                name = "Communications",
                payment = 50
            },
        },
    },
    
	-- Police Job
	['police'] = {
		label = 'Police',
		defaultDuty = true,
		grades = {
			['0'] = {name = "Cadet",						                    payment = 120},
			['1'] = {name = "Officer",				                            payment = 180},
            ['2'] = {name = "Ranger",				                            payment = 220},
			['3'] = {name = "Deputy",										    payment = 220},
			['4'] = {name = "Sr.Officer",										payment = 280},
            ['5'] = {name = "Sr.Ranger",										payment = 280},
			['6'] = {name = "Sr.Deputy",									    payment = 280},
			['7'] = {name = "Corporal",									        payment = 340},
			['8'] = {name = "Sergeant",	                       	                payment = 380},
            ['9'] = {name = "Lieutenant",	                       	            payment = 440},
            ['10'] = {name = "Captain",	                       	                payment = 520},
            ['11'] = {name = "Commander",	                       	            payment = 580},
            ['12'] = {name = "Asst C.O.P",				                    	payment = 650},
		    ['13'] = {name = "C.O.P",				            bankAuth = true, isboss = true, 	payment = 800},
        },
	},
	-------------- / EMS
	['ambulance'] = {
		label = 'EMS',
		defaultDuty = true,
		grades = {
            ['0'] = {name = 'Rookie',							            payment = 1500},
            ['1'] = {name = 'Doctor',									    payment = 1500},
			['2'] = {name = 'Senior Doctor',								payment = 1500},
			['3'] = {name = 'Medicine Specialist',							payment = 1500},
			['4'] = {name = 'Assistant Surgeon',						    payment = 1500},
			['5'] = {name = 'Surgeon',						                payment = 1500},
			['6'] = {name = 'Medical Professor',							payment = 1500},
			['7'] = {name = 'Advisor',							            payment = 1500},
			['8'] = {name = 'Civil Surgeon',								payment = 1500},
			['9'] = {name = 'Deputy Chief',				                    payment = 1500},
           ['10'] = {name = 'Chief',	            bankAuth = true, isboss = true, 		    payment = 1500},
        },
	},
	['realestate'] = {
		label = 'Real Estate',
		defaultDuty = true,
		grades = {
            ['0'] = {
                name = 'Recruit',
                payment = 50
            },
			['1'] = {
                name = 'House Sales',
                payment = 75
            },
			['2'] = {
                name = 'Business Sales',
                payment = 100
            },
			['3'] = {
                name = 'Broker',
                payment = 125
            },
			['4'] = {
                name = 'Manager',
				bankAuth = true, isboss = true, 
                payment = 150
            },
        },
	},
     ['bus'] = {
		label = 'Bus',
		defaultDuty = true,
		grades = {
            ['0'] = {
                name = 'Driver',
                payment = 50
            },
		},
	},
    ['taxi'] = {
		label = 'Taxi',
		defaultDuty = true,
		grades = {
            ['0'] = {
                name = 'Driver',
                payment = 50
            },
		},
	},
	['cardealer'] = {label = 'Car Dealer',
		defaultDuty = true,
		grades = {
            ['0'] = {name = "PDM Trainer",									payment = 1100},
			['1'] = {name = "PDM Employee",							        payment = 1100},
			['2'] = {name = "PDM Worker",								    payment = 1100},
			['3'] = {name = "PDM Finance",                                  payment = 1100},
			['4'] = {name = "PDM Manager",                                  payment = 1100},
			['5'] = {name = "PDM Boss",		bankAuth = true, isboss = true, 			        payment = 1100},
        },
	},
	['luxury'] = {label = 'luxury Dealer',
		defaultDuty = true,
		grades = {
            ['0'] = {name = "luxury Trainer",									payment = 1100},
			['1'] = {name = "luxury Employee",							        payment = 1100},
			['2'] = {name = "luxury Worker",								    payment = 1100},
			['3'] = {name = "luxury Finance",                                   payment = 1100},
			['4'] = {name = "luxury Manager",                                   payment = 1100},
			['5'] = {name = "luxury Boss",		bankAuth = true, isboss = true, 			        payment = 1100},
        },
	},
	['edm'] = {label = 'Real Cars',
		defaultDuty = true,
		grades = {
			['0'] = {name = "Admin Boss",		bankAuth = true, isboss = true, 			        payment = 1100},
        },
	},
	['mechanic'] = {
		label = 'Tuner',
		defaultDuty = false,
		grades = {
			['0'] = {name = "Tuner Trainee",								        payment = 1200},
			['1'] = {name = "Tuner Employee",									payment = 1200},
			['2'] = {name = "Tuner Worker",										payment = 1200},
			['3'] = {name = "Tuner Manager",				 			payment = 1200},
			['4'] = {name = "Tuner Boss",				bankAuth = true, isboss = true, 		    payment = 1200},
        },
	},
	['judge'] = {
		label = 'Judge',
		defaultDuty = true,
		grades = {
            ['0'] = {
                name = 'Judge',
                payment = 100
            },
        },
	},
	['lawyer'] = {
		label = 'Lawyer',
		defaultDuty = true,
		grades = {
            ['0'] = {
                name = 'Associate',
                payment = 50
            },
        },
	},
	['reporter'] = {
		label = 'Reporter',
		defaultDuty = true,
		grades = {
            ['0'] = {
                name = 'Journalist',
                payment = 50
            },
        },
	},
	['trucker'] = {
		label = 'Trucker',
		defaultDuty = true,
		grades = {
            ['0'] = {
                name = 'Rookie',
                payment = 50
            },
        },
	},
	['garbage'] = {
		label = 'Garbage',
		defaultDuty = true,
		grades = {
            ['0'] = {
                name = 'Collector',
                payment = 50
            },
        },
	},
    ['miner'] = {
        label = 'Miner',
        defaultDuty = true,
        grades = {
            ['0'] = {
                name = 'Collector',
                payment = 50
            },
        },
    },
	['vineyard'] = {
		label = 'Vineyard',
		defaultDuty = true,
		grades = {
            ['0'] = {
                name = 'Picker',
                payment = 50
            },
        },
	},
	['hotdog'] = {
		label = 'Hotdog',
		defaultDuty = true,
		grades = {
            ['0'] = {
                name = 'Sales',
                payment = 50
            },
        },
	},
	["tequilala"] = {
        label = "Tequi-la-la",
        defaultDuty = true,
        grades = {
            ['0'] = {
                name = "DJ",
                payment = 50
            },
            ['1'] = {
                name = "Bartender",
                payment = 75
            },
            ['2'] = {
                name = "Bouncer",
                payment = 100
            },
            ['3'] = {
                name = "Manager",
                payment = 125
            },
            ['4'] = {
                name = "Owner",
                bankAuth = true, isboss = true, 
                payment = 150
            },
        },
    },
	["burgershot"] = {
        label = "Burgershot",
        defaultDuty = true,
        grades = {
            ['0'] = {
                name = "Employee",
                payment = 50
            },
            ['1'] = {
                name = "Waiter",
                payment = 75
            },
            ['2'] = {
                name = "Cooker",
                payment = 100
            },
            ['3'] = {
                name = "Manager",
                payment = 125
            },
            ['4'] = {
                name = "Owner",
                bankAuth = true, isboss = true, 
                payment = 150
            },
        },
    },

    --  EDITADO
    --[['planepilot'] = {
        label = 'Delivery',
        defaultDuty = true,
        grades = {
            ['0'] = {
                name = 'Pilot',
                payment = 250
            },
        },
    },]]
}
