fx_version 'adamant'
game 'gta5'

author 'Legend'
description 'ESX Box'
lua54 'yes'
version '1.0'
legacyversion '1.9.1'

client_scripts {
    '@es_extended/locale.lua',
    'client.lua'
}

server_scripts {
    '@es_extended/imports.lua',
    'server.lua'
}

shared_scripts {
    '@es_extended/imports.lua',
    'config.lua'
}