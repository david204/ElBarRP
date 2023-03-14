fx_version 'cerulean'
games { 'gta5' }

author '# '

client_scripts {  
    '@PolyZone/client.lua',
    '@PolyZone/BoxZone.lua',
    '@PolyZone/EntityZone.lua',
    '@PolyZone/CircleZone.lua',
    '@PolyZone/ComboZone.lua',
    "cl_main.lua"
}

server_scripts {   
    "sv_main.lua"
}

lua54 'yes'