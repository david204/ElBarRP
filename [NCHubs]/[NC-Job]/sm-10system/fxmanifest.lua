fx_version 'cerulean'
game 'gta5'

author 'SM-Scripts'
description 'SM-10System'
version '1.0.1'

shared_scripts {
    'config.lua',
}

client_scripts {
	'client/client.lua',
}

server_scripts {
	'server/server.lua',
    'server/functions.lua'
}

ui_page 'html/index.html'

files {
	'html/index.html',
    'html/js/app.js',
    'html/styles/*',
    'html/sounds/beep.mp3',
}

lua54 'yes'

escrow_ignore {
    'config.lua',
    'server/functions.lua'
}

dependency '/assetpacks'