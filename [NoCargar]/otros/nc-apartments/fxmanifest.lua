 --this line was automatically written by WaveShield

fx_version 'cerulean'
game 'gta5'

description 'nc-Apartments'
version '2.1.0'

shared_scripts {
    'config.lua',
    '@nchub/shared/locale.lua',
    'locales/en.lua', -- Change to the language you want
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/main.lua'
}

client_scripts {
	'client/main.lua',
	'client/gui.lua',
	'@PolyZone/client.lua',
	'@PolyZone/BoxZone.lua',
	'@PolyZone/CircleZone.lua',
}

dependencies {
	'nchub',
	'nc-interior',
	'nc-clothing',
	'nc-weathersync'
}

lua54 'yes'
server_scripts { '@mysql-async/lib/MySQL.lua' }server_scripts { '@mysql-async/lib/MySQL.lua' }