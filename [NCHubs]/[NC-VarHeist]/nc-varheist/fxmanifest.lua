fx_version 'cerulean'

game 'gta5'
lua54 'yes'

author 'NCTest#4305'
description 'Doomsday DLC Server Room Heist for QBCore'
version '1.0'

client_scripts {
    '@PolyZone/client.lua',
    'client/cl_*.lua',
}

shared_script {
    'shared/sh_*.lua',
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/sv_*.lua',
}