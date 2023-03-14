fx_version 'cerulean'

game 'gta5'

author 'Giana'
description 'g-billing'

shared_script 'config.lua'

client_scripts {
    'client/main.lua',
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/main.lua',
}

dependencies {
    'nchub',
    'qb-input',
    'nc-management',
    'qb-menu'
}

lua54 'yes'