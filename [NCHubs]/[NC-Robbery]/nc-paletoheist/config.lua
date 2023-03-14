--https://discord.gg/nchub
Config = {}

Config['PaletoHeist'] = {
    ['framework'] = {
        name = 'QB', -- Only ESX or QB.
        scriptName = 'nchub', -- Only for QB users.
        eventName = 'esx:getSharedObject' -- Only for ESX users.
    },
    ['setjobForPolice'] = 'police', -- Setjob for check police count and police alert.
    ['requiredPoliceCount'] = 0, -- Required police count for start heist.
    ['nextRob'] = 7200, -- Seconds for next heist.
    ['requiredItems'] = { -- Add this items to database or shared. Don't change the order, you can change the item names.
        'bag',
        'drill',
        'c4_bomb',
        'blowtorch',
        'hack_usb'
    },
    ['rewardItems'] = { -- Add this items to database or shared. Don't change the order, you can change the item names. You can add more items for lockboxes.
        {itemName = 'goldbar', count = 1, sellPrice = 100}, -- For trollys/lockboxes.
        {itemName = 'diamond_ring', count = 1, sellPrice = 100}, -- For trollys/lockboxes.
        {itemName = 'rolex', count = 1, sellPrice = 100}, -- For trollys/lockboxes.
    },
    ['rewardMoneys'] = {
        ['trollys'] = function()
            return math.random(5000, 10000) -- Per grab in trolly, one trolly give you (45 * this price) money.
        end,
        ['stacks'] = function()
            return math.random(5000, 10000) -- Per grab in stacks.
        end,
    },
    ['rewardLockbox'] = function()
        local random = math.random(#Config['PaletoHeist']['rewardItems'])
        local lockboxBag = {
            item = Config['PaletoHeist']['rewardItems'][random]['itemName'],
            count = math.random(1, 5), -- For lockbox reward items count
        }
        return lockboxBag
    end,
    ['rewardGoldStacks'] = 25, --For gold stacks
    ['moneyItem'] = { -- If your server have money item, you can set it here.
        status = false,
        itemName = 'cash'
    },
    ['black_money'] = {  -- If change true, all moneys will convert to black. QBCore players can change itemName.
        status = false,
        itemName = 'black_money'
    },
    ['finishHeist'] = { -- Heist finish coords.
        buyerPos = vector3(100.328, -2706.3, 5.00362)
    },
}

Config.CorrectBlocks = 14
Config.IncorrectBlocks = 3 
Config.TimeToShow = 6 
Config.TimeToLose = 30

Config.VangelicoTime = 15
Config.VangelicoBlocks = 4
Config.VangelicoRepeat = 1

Config['PaletoSetup'] = {
    ['lockboxSetup'] = { -- Dont change.
        {model = 'ch_prop_ch_sec_cabinet_01g', coords = vector3(-107.30, 6475.87, 30.6267), heading = 45.0},
        {model = 'ch_prop_ch_sec_cabinet_01a', coords = vector3(-107.00, 6473.51, 30.6267), heading = 135.0},
        {model = 'ch_prop_ch_sec_cabinet_01j', coords = vector3(-108.292, 6474.41, 30.6267), heading = 135.0},
        {model = 'ch_prop_ch_sec_cabinet_01d', coords = vector3(-102.80, 6475.62, 30.6267), heading = 225.0},
        {model = 'ch_prop_ch_sec_cabinet_01j', coords = vector3(-108.292, 6474.41, 30.6267), heading = 225.0},
        {model = 'ch_prop_ch_sec_cabinet_01a', coords = vector3(-105.99, 6478.48, 30.6267), heading = 45.0},
        {model = 'ch_prop_ch_sec_cabinet_01j', coords = vector3(-108.292, 6474.41, 30.6267), heading = 45.0},
        {model = 'ch_prop_ch_sec_cabinet_01d', coords = vector3(-103.71, 6478.52, 30.6267), heading = 315.0},
        {model = 'ch_prop_ch_sec_cabinet_01g', coords = vector3(-102.30, 6477.11, 30.6267), heading = 315.0},

        --For K4MB1 Extended
        {model = -2109233454, coords = vector3(-100.31, 6459.37, 30.6267), heading = -45.0},
        {model = 1034526103, coords = vector3(-100.44, 6457.63, 30.6267), heading = 225.0},
        {model = 1227076747, coords = vector3(-101.87, 6456.20, 30.6267), heading = 225.0},
        {model = 376131363, coords = vector3(-103.04, 6456.04, 30.6267), heading = 135.0},
    },
    ['tables'] = { -- You can add new table with money/gold stacks.
        {coords = vector3(-104.80, 6458.00, 30.6267), heading = 225.0, type = 'money'},
        {coords = vector3(-107.86, 6461.50, 30.6267), heading = 45.0, type = 'money'},
    },
    ['trollys'] = { -- You can add new trollys. Money/Gold/Diamond
        {coords = vector3(-106.80, 6457.82, 30.6267), heading = 315.0, type = 'diamond'},
        {coords = vector3(-107.60, 6458.63, 30.6267), heading = 315.0, type = 'gold'},
    },
    ['mainStack'] = {coords = vector3(-104.42, 6476.94, 31.4817), heading = 315.0},
    ['cellPlant'] = vector3(-105.68, 6461.18, 31.6267),
    ['doors'] = { -- Dont change.
        {model = -1185205679, coords = vector3(-104.47, 6472.69, 31.6267), heading = 45.0, locked = true},
        {model = 1622278560,  coords = vector3(-104.47, 6472.69, 31.6267), heading = 45.0, locked = true},
        {model = -1528546233,  coords = vector3(-102.07, 6459.53, 31.6267), heading = 225.0, locked = true},
    },
    ['blowtorch'] = vector3(-105.44, 6472.58, 31.6267),
    ['breakDoor'] = vector3(-103.84, 6471.73, 31.6267),
    ['enter'] = vector3(-111.92, 6460.86, 31.4684),
    ['storm'] = vector3(-111.92, 6460.86, 31.4684),
    ['getKeyCard'] = vector3(-108.09, 6467.07, 31.6267),
    ['cardSwipe'] = vector3(-102.60, 6471.97, 31.6267),
    ['keypad'] = {coords = vector3(-102.4655, 6472.343, 31.9267), heading = 315.0},
    ['extendedKeypad'] = {coords = vector3(-102.98, 6459.29, 31.6267)},
    ['enterPeds'] = { -- Dont change. Fixed with animations.
        {model = 's_f_y_airhostess_01', coords = vector3(-109.622, 6467.932, 30.712)},
        {model = 'a_m_m_business_01',   coords = vector3(-109.622, 6467.932, 30.712)},
        {model = 'a_m_m_business_01',   coords = vector3(-109.622, 6467.932, 30.712)},
        {model = 'a_m_m_business_01',   coords = vector3(-109.622, 6467.932, 30.712)},
        {model = 'a_m_m_business_01',   coords = vector3(-109.622, 6467.932, 30.712)},
    }
}

Strings = {
    ['grab_stack'] = 'Press ~INPUT_CONTEXT~ to grab stack',
    ['grab_trolly'] = 'Press ~INPUT_CONTEXT~ to grab trolly',
    ['plant_bomb'] = 'Press ~INPUT_CONTEXT~ to plant C4',
    ['detonate_bombs'] = 'Press ~INPUT_CONTEXT~ to detonate bomb',
    ['drill'] = 'Press ~INPUT_CONTEXT~ to drill the boxes',
    ['hack'] = 'Press ~INPUT_CONTEXT~ to start hack',
    ['open_vault'] = 'Press ~INPUT_CONTEXT~ to access vault',
    ['take_keycard'] = 'Press ~INPUT_CONTEXT~ to take keycard',
    ['no_keycard'] = 'You dont have keycard.',
    ['blowtorch'] = 'Press ~INPUT_CONTEXT~ to use blowtorch',
    ['break_door'] = 'Press ~INPUT_CONTEXT~ to break the door',
    ['storm_bank'] = 'Press ~INPUT_CONTEXT~ to storm the bank',
    ['wait_nextrob'] = 'You have to wait this long to undress again',
    ['minute'] = 'minute.',
    ['need_this'] = 'You need this: ',
    ['need_police'] = 'Not enough police in the city.',
    ['total_money'] = 'You got this: ',
    ['police_alert'] = 'Paleto bank robbery alert! Check your gps.',
    ['not_cop'] = 'You are not cop!',
    ['buyer_blip'] = 'Buyer',
    ['deliver_to_buyer'] = 'Deliver the loot to the buyer. Check gps.',

    --For minigame
    ['confirm'] = 'Confirm',
    ['change'] = 'Change vertical',
    ['change_slice'] = 'Change slice',
    ['exit'] = 'Exit',
}