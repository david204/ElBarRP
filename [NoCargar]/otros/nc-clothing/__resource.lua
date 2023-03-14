resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

shared_script "settings.lua"
server_script 'server.lua'
client_script "interact/*.lua"
client_script{
    'client/tattooshop.lua',
    'client/skins.lua',
    'client/client.lua'
}

ui_page 'html/index.html'

files {
    'html/*',
    'html/webfonts/*',
    'html/css/*.css',
}

exports {
    "GetTatCategs",
    "GetCustomSkins",
    "isCustomSkin"
}

export 'SetPedMetadata'

