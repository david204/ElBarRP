fx_version 'cerulean'
game 'gta5'

description 'nc-Printer'
version '1.0.0'

ui_page 'html/index.html'
client_script 'client/main.lua'
server_script 'server/main.lua'

files {
    '*.lua',
    'html/*.html',
    'html/*.js',
    'html/*.css',
    'html/*.png',
}

dependencies { 'qb-target' }
  

lua54 'yes'
