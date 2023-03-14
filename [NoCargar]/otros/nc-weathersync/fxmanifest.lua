fx_version 'cerulean'
game 'gta5'

description 'vSyncRevamped'
version '1.0.2'

shared_scripts {
	'config.lua',
	'locale.lua',
	'locales/*.lua'
}

server_script {
	'server/*.lua',
}
client_script {
	'client/*.lua',
}

lua54 'yes'