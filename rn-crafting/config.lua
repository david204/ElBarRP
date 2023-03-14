Config = {}

Config.Core = "QBCore"
Config.TargetResource = "qb-target"

Config.Coords = vector3(1887.4067, 3913.7685, 33.020595)

Config.Crafting = {
    usb = {
        {
            item = "pistol", -- The name of the weapon category.
            itemlabel = "Pistol", -- The name of the item label.
            itemName = "gold_usb",
            itemImg = "np_pistol-50" -- The name of the image(In the inventory).
        },
        {
            item = "smg", 
            itemlabel = "SMG",
            itemName = "green_usb",
            itemImg = "weapon_microsmg2"
        },
        {
            item = "rifle",
            itemlabel = "Rifle",
            itemName = "blue_usb",
            itemImg = "assaultrifle"
        },
        {
            item = "default",
            itemlabel = "Knife",
            itemImg = "knife"
        },
    },
    --------------------------------------------------------------------------------------------------------------
    default = {
        {
            weaponName = "weapon_shiv",
            weaponLabel = "Shiv",
            weaponResources = {
                item1 = 50,
                item2 =  50,
                item3 =  50,
                item4 =  50
            },
            price = 500
        },
        {
            weaponName = "weapon_switchblade",
            weaponLabel = "Shank",
            weaponResources = {
                item1 = 50,
                item2 =  50,
                item3 =  50,
                item4 =  50
            },
            price = 500
        },
        {
            weaponName = "weapon_katanas",
            weaponLabel = "Katanas",
            weaponResources = {
                item1 = 45,
                item2 =  45,
                item3 =  45,
                item4 =  45
            },
            price = 500
        },
        {
            weaponName = "weapon_machete",
            weaponLabel = "Machete",
            weaponResources = {
                item1 = 55,
                item2 =  55,
                item3 =  55,
                item4 =  55
            },
            price = 1500
        },
        {
            weaponName = "weapon_sledgeham",
            weaponLabel = "Sledge Hammer",
            weaponResources = {
                item1 = 70,
                item2 =  70,
                item3 =  70,
                item4 =  70
            },
            price = 1500
        },
        {
            weaponName = "weapon_katana",
            weaponLabel = "Katana",
            weaponResources = {
                item1 = 45,
                item2 =  45,
                item3 =  45,
                item4 =  45
            },
            price = 500
        },
    },
    pistol = {
        {
            weaponName = "weapon_pistol",
            weaponLabel = "Colt 1911",
            weaponResources = {
                item1 = 250,
                item2 =  250,
                item3 =  250,
                item4 =  250
            },
            price = 1200
        },
        {
            weaponName = "weapon_browning",
            weaponLabel = "Sns Pistol",
            weaponResources = {
                item1 = 250,
                item2 =  250,
                item3 =  250,
                item4 =  250
            },
            price = 1500
        },
        {
            weaponName = "weapon_heavypistol",
            weaponLabel = "Heavy Pistol",
            weaponResources = {
                item1 = 250,
                item2 =  250,
                item3 =  250,
                item4 =  250
            },
            price = 1500
        },
        {
            weaponName = "weapon_combatpistol",
            weaponLabel = "FN FNX-45",
            weaponResources = {
                item1 = 250,
                item2 =  250,
                item3 =  250,
                item4 =  250
            },
            price = 1300
        },
        {
            weaponName = "weapon_pistol50",
            weaponLabel = "Deagle",
            weaponResources = {
                item1 = 350,
                item2 =  350,
                item3 =  350,
                item4 =  350
            },
            price = 2000
        },
    },
    smg = {
        {
            weaponName = "weapon_microsmg",
            weaponLabel = "Micro SMG",
            weaponResources = {
                item1 = 500,
                item2 =  500,
                item3 =  500,
                item4 =  500
            },
            price = 2500
        },
        {
            weaponName = "weapon_minismg",
            weaponLabel = "Skorpion",
            weaponResources = {
                item1 = 450,
                item2 =  450,
                item3 =  450,
                item4 =  450
            },
            price = 2500
        },
        {
            weaponName = "weapon_microsmg2",
            weaponLabel = "Uzi",
            weaponResources = {
                item1 = 550,
                item2 =  550,
                item3 =  550,
                item4 =  550
            },
            price = 2500
    },
    {
        weaponName = "weapon_microsmg3",
        weaponLabel = "Mac-10",
        weaponResources = {
            item1 = 350,
            item2 =  350,
            item3 =  350,
            item4 =  350
        },
        price = 2000
},
{
    weaponName = "weapon_appistol",
    weaponLabel = "Glock-18c",
    weaponResources = {
        item1 = 450,
        item2 =  450,
        item3 =  450,
        item4 =  450
    },
    price = 2500
},
    },
    rifle = {
        {
            weaponName = "weapon_compactrifle",
            weaponLabel = "Draco NAK9",
            weaponResources = {
                item1 = 800,
                item2 = 800,
                item3 = 800,
                item4 = 800,
            },
            price = 9000
        },
        {
            weaponName = "weapon_advancedrifle",
            weaponLabel = "OTs-14 Groza",
            weaponResources = {
                item1 = 950,
                item2 = 950,
                item3 = 950,
                item4 = 950,
            },
            price = 9000
        },
        {
            weaponName = "weapon_assaultrifle",
            weaponLabel = "AK 47",
            weaponResources = {
                item1 = 950,
                item2 = 950,
                item3 = 950,
                item4 = 950,
            },
            price = 9000
        },
        {
            weaponName = "weapon_dragunov",
            weaponLabel = "Dragunov SVD-63",
            weaponResources = {
                item1 = 950,
                item2 = 950,
                item3 = 950,
                item4 = 950,
            },
            price = 9000
        },
        {
            weaponName = "weapon_assaultrifle2",
            weaponLabel = "M70",
            weaponResources = {
                item1 = 950,
                item2 = 950,
                item3 = 950,
                item4 = 950,
            },
            price = 9000
        },
    }
}