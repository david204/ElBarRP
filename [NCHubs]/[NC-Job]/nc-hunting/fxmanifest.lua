fx_version "cerulean"
game "gta5"

shared_scripts {
    "config.lua"
}

client_scripts {
    '@PolyZone/CircleZone.lua',
    '@PolyZone/client.lua',
    "settings.lua",
    "cl_hunting.lua"
}
server_script "sv_hunting.lua"
