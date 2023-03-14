fx_version 'cerulean'
game 'gta5'

description 'nchub'
version '1.0.0'

shared_scripts {
	'shared/locale.lua',
	'locale/es.lua', -- replace with desired language
	'config.lua',
	'shared/main.lua',
	'shared/items.lua',
	'shared/jobs.lua',
	'shared/vehicles.lua',
	'shared/gangs.lua',
	'shared/weapons.lua'
}

client_scripts {
	'client/main.lua',
	'client/functions.lua',
	'client/loops.lua',
	'client/events.lua',
	'client/drawtext.lua',
	'client/spawnmanager'
}

server_scripts {
	'@oxmysql/lib/MySQL.lua',
	'server/main.lua',
	'server/functions.lua',
	'server/player.lua',
	'server/events.lua',
	'server/commands.lua',
	'server/debug.lua',
	'server/exports.lua'

}

ui_page 'html/index.html'

files {
	'html/index.html',
	'html/style.css',
	'html/css/drawtext.css',
	'html/*.js'
}

dependencies {
	'oxmysql'
	-- 'Progress'
}


lua54 'yes'
