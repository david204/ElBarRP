fx_version 'cerulean'
game 'gta5'
author 'GreenArrow@Sri Lanka New Life Roleplay'
description 'Art Heist for QBCore Servers'
version '1.0.0'

shared_script 'config.lua'
server_script 'server.lua'
client_script 'client.lua'

files {
    'ui/app.js',
    'ui/index.html',
    'ui/style.css',
    'ui/*.png',
}

ui_page {
    'ui/index.html'
}