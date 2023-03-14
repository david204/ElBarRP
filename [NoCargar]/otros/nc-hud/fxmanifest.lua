fx_version 'cerulean'
game 'gta5'

description 'nc-hud'
version '2.1.0'

shared_scripts {
	'@nchub/shared/locale.lua',
	'locales/en.lua',
	'config.lua',
	'uiconfig.lua'
}

client_script {
	'client.lua',
	'map.lua',
}

server_script 'server.lua'
lua54 'yes'
use_fxv2_oal 'yes'

ui_page 'html/index.html'

files {
	'html/*',
}
