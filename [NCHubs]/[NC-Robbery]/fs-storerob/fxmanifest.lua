fx_version 'cerulean'
game 'gta5'

version '1.0.0'

ui_page 'html/index.html'

server_scripts {
	'server.lua',
	'config.lua'
}

shared_script 'config.lua'

files {
    'html/*.js',
    'html/*.html',
    'html/*.css'
}

client_scripts {
	'client.lua',
}
