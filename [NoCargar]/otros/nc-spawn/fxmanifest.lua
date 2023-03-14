fx_version 'cerulean'
game 'gta5'

description 'nc-Spawn'
version '1.0.0'

shared_scripts {
	'config.lua',
	'@nc-houses/config.lua',
	'@nc-apartments/config.lua'
}

client_script 'client.lua'
server_script 'server.lua'

ui_page 'html/index.html'

files {
	'html/index.html',
	'html/style.css',
	'html/script.js',
	'html/reset.css'
}

dependencies {
	'nchub',
	'nc-houses',
	'nc-interior',
	'nc-apartments'
}
