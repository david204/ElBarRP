Config = {
    JobCenter = vector3(-552.28, 5348.47, 63.48),
    ReAdd = 1, -- seconds after a job is finished until its shown again
    Job = {
        ['jobRequired'] = false, -- if true: only players with the specified job can work, false everyone can work
        ['jobName'] = 'trucker',
    },
    Jobs = {
        -- {title = 'title', payment = reward, vehicles = {'truck', 'trailer'}, start = {vector3(x, y, z), heading}, trailer = {vector3(x, y, z), heading}, arrive = vector3(x, y, z)}
        {title = 'Bring wood to IKEA', payment = 350, vehicles = {'phantom', 'trailerlogs'}, start = {vector3(-566.59, 5353.52, 70.24), 344.31}, trailer = {vector3(-513.17, 5257.65, 80.74), 162.58}, arrive = vector3(2671.0, 3530.35, 51.26)},
        {title = 'Take wood to the supermarket', payment = 500, vehicles = {'phantom', 'trailerlogs'}, start = {vector3(-566.59, 5353.52, 70.24), 344.31}, trailer = {vector3(-513.17, 5257.65, 80.74), 162.58}, arrive = vector3(103.57, -1819.37, 25.56)},
        {title = 'bring wood to the shop 1', payment = 500, vehicles = {'phantom', 'trailerlogs'}, start = {vector3(-566.59, 5353.52, 70.24), 344.31}, trailer = {vector3(-513.17, 5257.65, 80.74), 162.58}, arrive = vector3(-1292.01, -807.06, 19)},
        {title = 'bring wood to the shop 2', payment = 500, vehicles = {'phantom', 'trailerlogs'}, start = {vector3(-566.59, 5353.52, 70.24), 344.31}, trailer = {vector3(-513.17, 5257.65, 80.74), 162.58}, arrive = vector3(-384.46, 1220.5, 327)},
    },
}

Strings = {
    ['not_job'] = "You don't have a trucking job!",
    ['somebody_doing'] = 'Someone is already doing this job, please select another!',
    ['menu_title'] = 'Truck driver',
    ['e_browse_jobs'] = 'press ~INPUT_CONTEXT~ to search for available jobs',
    ['start_job'] = 'Lumber Yard delivery',
    ['truck'] = 'Truck',
    ['trailer'] = 'trailerlogs',
    ['get_to_truck'] = 'take the ~y~truck~w~!',
    ['get_to_trailer'] = 'drive to the ~y~trailerlogs~w~ y Enganchalo!',
    ['destination'] = 'Destino',
    ['get_out'] = 'get out of the ~y~truck~w~!',
    ['park'] = 'park the  ~y~trailerlogs~w~ in the destiny.',
    ['park_truck'] = 'park the  ~y~truck~w~ en el destination',
    ['drive_destination'] = 'drive to the  ~b~destination~w~.',
    ['reward'] = 'Well done! You received $%s',
    ['paid_damages'] = 'Drive better next time! you paid $%s for the damage caused!',
    ['drive_back'] = 'Drive the truck back to where you took it off.', 
    ['detach'] = 'Press ~y~[H] ~w~ to Unhook the trailerlogs.'
}