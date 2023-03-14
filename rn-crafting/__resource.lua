resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

ui_page 'ui/index.html'

server_script {
    'config.lua',
    'server.lua'
}

client_script {
    'config.lua',
    'client.lua'
}

files {
    'ui/index.html',
    'ui/style.css',
    'ui/main.js',
    -- images 
    'ui/images/*.png',
    'ui/images/*.jpg',
    'ui/images/phone-frames/*.png',
}