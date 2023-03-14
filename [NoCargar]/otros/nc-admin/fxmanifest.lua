fx_version 'cerulean'
game 'gta5'

description 'QB-AdminMenu'
version '1.0.0'

ui_page 'html/index.html'

client_scripts {
    '@menuv/menuv.lua',
    'client/noclip.lua',
    'client/blipsnames.lua',
    'client/client.lua',
    'client/events.lua'
}

server_script 'server/server.lua'
server_script 'config.lua'


files {
    'html/index.html',
    'html/index.js'
}

dependency 'menuv'

lua54 'yes'