fx_version 'adamant'
game 'gta5'

lua54 'yes'

escrow_ignore {
	'config.lua'
}

ui_page 'web/ui.html'

files {
	'web/*.*',
	'web/icons/*.png'
}

shared_script 'config.lua'

client_scripts {
	'client.lua',
}

server_scripts {
	'server.lua'
}