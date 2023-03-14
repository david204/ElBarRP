Config = {}

Config.Inventory = 'qb-inventory' -- Change this to your inventory resource name

Config.UsingSkills = false -- Using mz-skills

Config.Debug = false -- Shows Zone debug and other debug related items

Config.DiscordLog = {
    active = true,
    webhook = '',
    username = 'nc-script logs',
    image = 'https://cdn.discordapp.com/attachments/1038991411967688774/1039391680564035684/Untitled-1.png',
    color = 1957995
}

Config.CraftingLocations = {
    ['attachments'] = {
        location = vector3(-1085.1, -935.53, 3.08), 
        items = {
            ['pistol_extendedclip'] = { -- Name of Item to Craft
            amount = 1, -- Amount of Item to Give to the Player
            name = 'Pistol Extendedclip', -- Name of Item to Display on the UI
            skillRequired = 0, -- Skill Required to Craft Item 
            materialsNeeded = { -- Materials Needed to Craft Item
                [1] = {
                    item = 'metalscrap', -- Name of Item Needed
                    amount = 125, -- Amount of Item Needed
                },
                [2] = {
                    item = 'plastic',
                    amount = 105,
                },
                [3] = {
                    item = 'aluminum',
                    amount = 110,
                },
                [4] = {
                    item = 'steel',
                    amount = 125,
                },
            },
        },
        ['pistol_flashlight'] = { -- Name of Item to Craft
        amount = 1, -- Amount of Item to Give to the Player
        name = 'Pistol Flashlight', -- Name of Item to Display on the UI
        skillRequired = 0, -- Skill Required to Craft Item 
        materialsNeeded = { -- Materials Needed to Craft Item
            [1] = {
                item = 'metalscrap', -- Name of Item Needed
                amount = 125, -- Amount of Item Needed
            },
            [2] = {
                item = 'plastic',
                amount = 105,
            },
            [3] = {
                item = 'aluminum',
                amount = 110,
            },
            [4] = {
                item = 'steel',
                amount = 125,
            },
        },
    },
    ['pistol_suppressor'] = { -- Name of Item to Craft
    amount = 1, -- Amount of Item to Give to the Player
    name = 'Pistol Suppressor', -- Name of Item to Display on the UI
    skillRequired = 0, -- Skill Required to Craft Item 
    materialsNeeded = { -- Materials Needed to Craft Item
        [1] = {
            item = 'metalscrap', -- Name of Item Needed
            amount = 125, -- Amount of Item Needed
        },
        [2] = {
            item = 'plastic',
            amount = 105,
        },
        [3] = {
            item = 'aluminum',
            amount = 110,
        },
        [4] = {
            item = 'steel',
            amount = 125,
        },
    },
},
['smg_extendedclip'] = { -- Name of Item to Craft
amount = 1, -- Amount of Item to Give to the Player
name = 'Smg Extendedclip', -- Name of Item to Display on the UI
skillRequired = 0, -- Skill Required to Craft Item 
materialsNeeded = { -- Materials Needed to Craft Item
    [1] = {
        item = 'metalscrap', -- Name of Item Needed
        amount = 125, -- Amount of Item Needed
    },
    [2] = {
        item = 'plastic',
        amount = 105,
    },
    [3] = {
        item = 'aluminum',
        amount = 110,
    },
    [4] = {
        item = 'steel',
        amount = 125,
    },
},
},
['smg_drum'] = { -- Name of Item to Craft
amount = 1, -- Amount of Item to Give to the Player
name = 'Smg Drum', -- Name of Item to Display on the UI
skillRequired = 0, -- Skill Required to Craft Item 
materialsNeeded = { -- Materials Needed to Craft Item
    [1] = {
        item = 'metalscrap', -- Name of Item Needed
        amount = 125, -- Amount of Item Needed
    },
    [2] = {
        item = 'plastic',
        amount = 105,
    },
    [3] = {
        item = 'aluminum',
        amount = 110,
    },
    [4] = {
        item = 'steel',
        amount = 125,
    },
},
},
['smg_scope'] = { -- Name of Item to Craft
amount = 1, -- Amount of Item to Give to the Player
name = 'Smg Scope', -- Name of Item to Display on the UI
skillRequired = 0, -- Skill Required to Craft Item 
materialsNeeded = { -- Materials Needed to Craft Item
    [1] = {
        item = 'metalscrap', -- Name of Item Needed
        amount = 125, -- Amount of Item Needed
    },
    [2] = {
        item = 'plastic',
        amount = 105,
    },
    [3] = {
        item = 'aluminum',
        amount = 110,
    },
    [4] = {
        item = 'steel',
        amount = 125,
    },
},
},
['smg_suppresor'] = { -- Name of Item to Craft
amount = 1, -- Amount of Item to Give to the Player
name = 'Smg Suppresor', -- Name of Item to Display on the UI
skillRequired = 0, -- Skill Required to Craft Item 
materialsNeeded = { -- Materials Needed to Craft Item
    [1] = {
        item = 'metalscrap', -- Name of Item Needed
        amount = 125, -- Amount of Item Needed
    },
    [2] = {
        item = 'plastic',
        amount = 105,
    },
    [3] = {
        item = 'aluminum',
        amount = 110,
    },
    [4] = {
        item = 'steel',
        amount = 125,
    },
},
},
['smg_flashlight'] = { -- Name of Item to Craft
amount = 1, -- Amount of Item to Give to the Player
name = 'Smg Flashlight', -- Name of Item to Display on the UI
skillRequired = 0, -- Skill Required to Craft Item 
materialsNeeded = { -- Materials Needed to Craft Item
    [1] = {
        item = 'metalscrap', -- Name of Item Needed
        amount = 125, -- Amount of Item Needed
    },
    [2] = {
        item = 'plastic',
        amount = 105,
    },
    [3] = {
        item = 'aluminum',
        amount = 110,
    },
    [4] = {
        item = 'steel',
        amount = 125,
    },
},
},
['rifle_flashlight'] = { -- Name of Item to Craft
amount = 1, -- Amount of Item to Give to the Player
name = 'Rifle Flashlight', -- Name of Item to Display on the UI
skillRequired = 0, -- Skill Required to Craft Item 
materialsNeeded = { -- Materials Needed to Craft Item
    [1] = {
        item = 'metalscrap', -- Name of Item Needed
        amount = 125, -- Amount of Item Needed
    },
    [2] = {
        item = 'plastic',
        amount = 105,
    },
    [3] = {
        item = 'aluminum',
        amount = 110,
    },
    [4] = {
        item = 'steel',
        amount = 125,
    },
},
},
['rifle_extendedclip'] = { -- Name of Item to Craft
amount = 1, -- Amount of Item to Give to the Player
name = 'Rifle Extendedclip', -- Name of Item to Display on the UI
skillRequired = 0, -- Skill Required to Craft Item 
materialsNeeded = { -- Materials Needed to Craft Item
    [1] = {
        item = 'metalscrap', -- Name of Item Needed
        amount = 125, -- Amount of Item Needed
    },
    [2] = {
        item = 'plastic',
        amount = 105,
    },
    [3] = {
        item = 'aluminum',
        amount = 110,
    },
    [4] = {
        item = 'steel',
        amount = 125,
    },
},
},
['rifle_suppressor'] = { -- Name of Item to Craft
amount = 1, -- Amount of Item to Give to the Player
name = 'Rifle Suppressor', -- Name of Item to Display on the UI
skillRequired = 0, -- Skill Required to Craft Item 
materialsNeeded = { -- Materials Needed to Craft Item
    [1] = {
        item = 'metalscrap', -- Name of Item Needed
        amount = 125, -- Amount of Item Needed
    },
    [2] = {
        item = 'plastic',
        amount = 105,
    },
    [3] = {
        item = 'aluminum',
        amount = 110,
    },
    [4] = {
        item = 'steel',
        amount = 125,
    },
},
},
['rifle_drummag'] = { -- Name of Item to Craft
amount = 1, -- Amount of Item to Give to the Player
name = 'Rifle Drummag', -- Name of Item to Display on the UI
skillRequired = 0, -- Skill Required to Craft Item 
materialsNeeded = { -- Materials Needed to Craft Item
    [1] = {
        item = 'metalscrap', -- Name of Item Needed
        amount = 125, -- Amount of Item Needed
    },
    [2] = {
        item = 'plastic',
        amount = 105,
    },
    [3] = {
        item = 'aluminum',
        amount = 110,
    },
    [4] = {
        item = 'steel',
        amount = 125,
    },
},
},
['rifle_scope'] = { -- Name of Item to Craft
amount = 1, -- Amount of Item to Give to the Player
name = 'Rifle Scope', -- Name of Item to Display on the UI
skillRequired = 0, -- Skill Required to Craft Item 
materialsNeeded = { -- Materials Needed to Craft Item
    [1] = {
        item = 'metalscrap', -- Name of Item Needed
        amount = 125, -- Amount of Item Needed
    },
    [2] = {
        item = 'plastic',
        amount = 105,
    },
    [3] = {
        item = 'aluminum',
        amount = 110,
    },
    [4] = {
        item = 'steel',
        amount = 125,
    },
},
},
        }
      }, 
    ['Illegalstuff'] = {
        location = vector3(1821.61, 3506.29, 38.35), -- Location to Craft the CircleZone for qb-target
        items = {
            ['lockpick'] = { -- Name of Item to Craft
                amount = 1, -- Amount of Item to Give to the Player
                name = 'Lockpick', -- Name of Item to Display on the UI
                skillRequired = 0, -- Skill Required to Craft Item 
                materialsNeeded = { -- Materials Needed to Craft Item
                    [1] = {
                        item = 'metalscrap', -- Name of Item Needed
                        amount = 125, -- Amount of Item Needed
                    },
                    [2] = {
                        item = 'plastic',
                        amount = 145,
                    },
                    [3] = {
                        item = 'aluminum',
                        amount = 100,
                    },
                },
            },
            ['advancedlockpick'] = { -- Name of Item to Craft
                amount = 1, -- Amount of Item to Give to the Player
                name = 'Advance LockPick', -- Name of Item to Display on the UI
                skillRequired = 0, -- Skill Required to Craft Item 
                materialsNeeded = { -- Materials Needed to Craft Item
                    [1] = {
                        item = 'metalscrap', -- Name of Item Needed
                        amount = 195, -- Amount of Item Needed
                    },
                    [2] = {
                        item = 'plastic',
                        amount = 220,
                    },
                    [3] = {
                        item = 'aluminum',
                        amount = 100,
                    },
                },
            },
            ['bag'] = { -- Name of Item to Craft
                amount = 1, -- Amount of Item to Give to the Player
                name = 'Bag', -- Name of Item to Display on the UI
                skillRequired = 0, -- Skill Required to Craft Item 
                materialsNeeded = { -- Materials Needed to Craft Item
                    [1] = {
                        item = 'metalscrap', -- Name of Item Needed
                        amount = 35, -- Amount of Item Needed
                    },
                    [2] = {
                        item = 'plastic',
                        amount = 115,
                    },
                    [3] = {
                        item = 'aluminum',
                        amount = 25,
                    },
                },
            },
            ['drill'] = { -- Name of Item to Craft
                amount = 1, -- Amount of Item to Give to the Player
                name = 'Drill', -- Name of Item to Display on the UI
                skillRequired = 0, -- Skill Required to Craft Item 
                materialsNeeded = { -- Materials Needed to Craft Item
                    [1] = {
                        item = 'metalscrap', -- Name of Item Needed
                        amount = 230, -- Amount of Item Needed
                    },
                    [2] = {
                        item = 'steel',
                        amount = 145,
                    },
                    [3] = {
                        item = 'aluminum',
                        amount = 228,
                    },
                },
            },
            ['big_drill'] = { -- Name of Item to Craft
                amount = 1, -- Amount of Item to Give to the Player
                name = 'Big Drill', -- Name of Item to Display on the UI
                skillRequired = 0, -- Skill Required to Craft Item 
                materialsNeeded = { -- Materials Needed to Craft Item
                    [1] = {
                        item = 'metalscrap', -- Name of Item Needed
                        amount = 30, -- Amount of Item Needed
                    },
                    [2] = {
                        item = 'steel',
                        amount = 45,
                    },
                    [3] = {
                        item = 'plastic',
                        amount = 28,
                    },
                },
            },
            ['trojan_usb'] = { -- Name of Item to Craft
                amount = 1, -- Amount of Item to Give to the Player
                name = 'Trojan USB', -- Name of Item to Display on the UI
                skillRequired = 0, -- Skill Required to Craft Item 
                materialsNeeded = { -- Materials Needed to Craft Item
                    [1] = {
                        item = 'metalscrap', -- Name of Item Needed
                        amount = 230, -- Amount of Item Needed
                    },
                    [2] = {
                        item = 'steel',
                        amount = 145,
                    },
                    [3] = {
                        item = 'plastic',
                        amount = 228,
                    },
                    [4] = {
                        item = 'iron',
                        amount = 215,
                    },
                },
            },
            ['electronickit'] = { -- Name of Item to Craft
                amount = 1, -- Amount of Item to Give to the Player
                name = 'Electronic Kit', -- Name of Item to Display on the UI
                skillRequired = 0, -- Skill Required to Craft Item 
                materialsNeeded = { -- Materials Needed to Craft Item
                    [1] = {
                        item = 'metalscrap', -- Name of Item Needed
                        amount = 230, -- Amount of Item Needed
                    },
                    [2] = {
                        item = 'steel',
                        amount = 245,
                    },
                    [3] = {
                        item = 'plastic',
                        amount = 128,
                    },
                    [4] = {
                        item = 'iron',
                        amount = 280,
                    },
                },
            },
            ['vpn'] = { -- Name of Item to Craft
                amount = 1, -- Amount of Item to Give to the Player
                name = 'VPN', -- Name of Item to Display on the UI
                skillRequired = 0, -- Skill Required to Craft Item 
                materialsNeeded = { -- Materials Needed to Craft Item
                    [1] = {
                        item = 'iron',
                        amount = 155,
                    },
                    [2] = {
                        item = 'glass',
                        amount = 320,
                    },
                },
            },
            ['c4_bomb'] = { -- Name of Item to Craft
                amount = 1, -- Amount of Item to Give to the Player
                name = 'C4 Bomb (Blackout)', -- Name of Item to Display on the UI
                skillRequired = 0, -- Skill Required to Craft Item 
                materialsNeeded = { -- Materials Needed to Craft Item
                    [1] = {
                        item = 'aluminum',
                        amount = 350,
                    },
                    [2] = {
                        item = 'glass',
                        amount = 290,
                    },
                },
            },
            ['laptop'] = { -- Name of Item to Craft
                amount = 1, -- Amount of Item to Give to the Player
                name = 'Laptop', -- Name of Item to Display on the UI
                skillRequired = 0, -- Skill Required to Craft Item 
                materialsNeeded = { -- Materials Needed to Craft Item
                    [1] = {
                        item = 'metalscrap',
                        amount = 225,
                    },
                    [2] = {
                        item = 'steel',
                        amount = 128,
                    },
                    [3] = {
                        item = 'copper',
                        amount = 226,
                    },
                },
            },
            ['thermite'] = { -- Name of Item to Craft
            amount = 1, -- Amount of Item to Give to the Player
            name = 'Thermite', -- Name of Item to Display on the UI
            skillRequired = 0, -- Skill Required to Craft Item 
            materialsNeeded = { -- Materials Needed to Craft Item
                [1] = {
                    item = 'metalscrap',
                    amount = 425,
                },
                [2] = {
                    item = 'steel',
                    amount = 138,
                },
                [3] = {
                    item = 'copper',
                    amount = 326,
                },
            },
        },
        ['cutter'] = { -- Name of Item to Craft
        amount = 1, -- Amount of Item to Give to the Player
        name = 'Cutter', -- Name of Item to Display on the UI
        skillRequired = 0, -- Skill Required to Craft Item 
        materialsNeeded = { -- Materials Needed to Craft Item
            [1] = {
                item = 'metalscrap',
                amount = 225,
            },
            [2] = {
                item = 'steel',
                amount = 438,
            },
            [3] = {
                item = 'copper',
                amount = 126,
            },
        },
    },
    ['gatecrack'] = { -- Name of Item to Craft
    amount = 1, -- Amount of Item to Give to the Player
    name = 'Gate Crack', -- Name of Item to Display on the UI
    skillRequired = 0, -- Skill Required to Craft Item 
    materialsNeeded = { -- Materials Needed to Craft Item
        [1] = {
            item = 'metalscrap',
            amount = 125,
        },
        [2] = {
            item = 'steel',
            amount = 138,
        },
        [3] = {
            item = 'copper',
            amount = 326,
        },
    },
},
['blowtorch'] = { -- Name of Item to Craft
amount = 1, -- Amount of Item to Give to the Player
name = 'Blow Torch', -- Name of Item to Display on the UI
skillRequired = 0, -- Skill Required to Craft Item 
materialsNeeded = { -- Materials Needed to Craft Item
    [1] = {
        item = 'metalscrap',
        amount = 225,
    },
    [2] = {
        item = 'steel',
        amount = 238,
    },
    [3] = {
        item = 'copper',
        amount = 326,
    },
},
},
['screwdriverset'] = { -- Name of Item to Craft
amount = 1, -- Amount of Item to Give to the Player
name = 'Screwdriverset', -- Name of Item to Display on the UI
skillRequired = 0, -- Skill Required to Craft Item 
materialsNeeded = { -- Materials Needed to Craft Item
    [1] = {
        item = 'metalscrap',
        amount = 125,
    },
    [2] = {
        item = 'steel',
        amount = 138,
    },
    [3] = {
        item = 'copper',
        amount = 126,
    },
},
},
['hack_usb'] = { -- Name of Item to Craft
amount = 1, -- Amount of Item to Give to the Player
name = 'Hack Usb', -- Name of Item to Display on the UI
skillRequired = 0, -- Skill Required to Craft Item 
materialsNeeded = { -- Materials Needed to Craft Item
    [1] = {
        item = 'metalscrap',
        amount = 225,
    },
    [2] = {
        item = 'steel',
        amount = 238,
    },
    [3] = {
        item = 'copper',
        amount = 326,
    },
},
},
['hack_usb'] = { -- Name of Item to Craft
amount = 1, -- Amount of Item to Give to the Player
name = 'Hack Usb', -- Name of Item to Display on the UI
skillRequired = 0, -- Skill Required to Craft Item 
materialsNeeded = { -- Materials Needed to Craft Item
    [1] = {
        item = 'metalscrap',
        amount = 225,
    },
    [2] = {
        item = 'steel',
        amount = 238,
    },
    [3] = {
        item = 'copper',
        amount = 326,
    },
},
},
['cg_chain'] = { -- Name of Item to Craft
amount = 1, -- Amount of Item to Give to the Player
name = 'Cg Chain', -- Name of Item to Display on the UI
skillRequired = 0, -- Skill Required to Craft Item 
materialsNeeded = { -- Materials Needed to Craft Item
    [1] = {
        item = 'metalscrap',
        amount = 125,
    },
    [2] = {
        item = 'steel',
        amount = 138,
    },
    [3] = {
        item = 'copper',
        amount = 126,
    },
},
},
['cerberus_chain'] = { -- Name of Item to Craft
amount = 1, -- Amount of Item to Give to the Player
name = 'Cerberus chain', -- Name of Item to Display on the UI
skillRequired = 0, -- Skill Required to Craft Item 
materialsNeeded = { -- Materials Needed to Craft Item
    [1] = {
        item = 'metalscrap',
        amount = 125,
    },
    [2] = {
        item = 'steel',
        amount = 138,
    },
    [3] = {
        item = 'copper',
        amount = 126,
    },
},
},
['mdm_chain'] = { -- Name of Item to Craft
amount = 1, -- Amount of Item to Give to the Player
name = 'Mdm Chain', -- Name of Item to Display on the UI
skillRequired = 0, -- Skill Required to Craft Item 
materialsNeeded = { -- Materials Needed to Craft Item
    [1] = {
        item = 'metalscrap',
        amount = 125,
    },
    [2] = {
        item = 'steel',
        amount = 138,
    },
    [3] = {
        item = 'copper',
        amount = 126,
    },
},
},
['esv_chain'] = { -- Name of Item to Craft
amount = 1, -- Amount of Item to Give to the Player
name = 'Esv Chain', -- Name of Item to Display on the UI
skillRequired = 0, -- Skill Required to Craft Item 
materialsNeeded = { -- Materials Needed to Craft Item
    [1] = {
        item = 'metalscrap',
        amount = 125,
    },
    [2] = {
        item = 'steel',
        amount = 138,
    },
    [3] = {
        item = 'copper',
        amount = 126,
    },
},
},
['koil_chain'] = { -- Name of Item to Craft
amount = 1, -- Amount of Item to Give to the Player
name = 'Koil Chain', -- Name of Item to Display on the UI
skillRequired = 0, -- Skill Required to Craft Item 
materialsNeeded = { -- Materials Needed to Craft Item
    [1] = {
        item = 'metalscrap',
        amount = 125,
    },
    [2] = {
        item = 'steel',
        amount = 138,
    },
    [3] = {
        item = 'copper',
        amount = 126,
    },
},
},
['gsf_chain'] = { -- Name of Item to Craft
amount = 1, -- Amount of Item to Give to the Player
name = 'Gsf Chain', -- Name of Item to Display on the UI
skillRequired = 0, -- Skill Required to Craft Item 
materialsNeeded = { -- Materials Needed to Craft Item
    [1] = {
        item = 'metalscrap',
        amount = 125,
    },
    [2] = {
        item = 'steel',
        amount = 138,
    },
    [3] = {
        item = 'copper',
        amount = 126,
    },
},
},
['methkey'] = { -- Name of Item to Craft
amount = 1, -- Amount of Item to Give to the Player
name = 'MethLab Key (A)', -- Name of Item to Display on the UI
skillRequired = 0, -- Skill Required to Craft Item 
materialsNeeded = { -- Materials Needed to Craft Item
    [1] = {
        item = 'metalscrap',
        amount = 125,
    },
    [2] = {
        item = 'steel',
        amount = 138,
    },
    [3] = {
        item = 'copper',
        amount = 226,
    },
},
},
['cocainekey'] = { -- Name of Item to Craft
amount = 1, -- Amount of Item to Give to the Player
name = 'CocaineLab Key (B)', -- Name of Item to Display on the UI
skillRequired = 0, -- Skill Required to Craft Item 
materialsNeeded = { -- Materials Needed to Craft Item
    [1] = {
        item = 'metalscrap',
        amount = 125,
    },
    [2] = {
        item = 'steel',
        amount = 138,
    },
    [3] = {
        item = 'copper',
        amount = 226,
    },
},
},
['black_usb'] = { -- Name of Item to Craft
amount = 1, -- Amount of Item to Give to the Player
name = 'Black Usb', -- Name of Item to Display on the UI
skillRequired = 0, -- Skill Required to Craft Item 
materialsNeeded = { -- Materials Needed to Craft Item
    [1] = {
        item = 'metalscrap',
        amount = 325,
    },
    [2] = {
        item = 'steel',
        amount = 238,
    },
    [3] = {
        item = 'copper',
        amount = 326,
    },
},
},
        }
    }
}
