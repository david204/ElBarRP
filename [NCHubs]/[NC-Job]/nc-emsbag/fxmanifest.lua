fx_version 'cerulean'
game 'gta5'

shared_scripts {
    "configs/**.lua"
}

server_script {
    "server/**.lua"
}

client_script {
    "client/**.lua"
}

escrow_ignore {
    "configs/**.lua",
    "README.lua"
}

files {
    'stream/prop_cs_shopping_bag.ydr'
}

dependencies {
    'nchub',
    'qb-inventory',
    'qb-target'
}

lua54 'yes'
this_is_a_map 'yes'
