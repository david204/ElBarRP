name "nc-Notepad"
version "v1.0.1"
fx_version "cerulean"
game "gta5"

dependencies { 'qb-input', 'qb-menu', 'qb-target', }

shared_scripts { 'config.lua', 'locales/*.lua', 'shared/*.lua' }

client_scripts { 'client/*.lua', }

server_script { 'server/*.lua' }

lua54 'yes'

escrow_ignore {
	'*.lua*',
	'client/*.lua*',
	'server/*.lua*',
	'locales/*.lua',
    'shared/*.lua'
}
