fx_version 'adamant'
game 'gta5'
lua54 'yes'

author 'NoSweear'
description 'ESX IT job '
version  '1.0.0'

shared_script {
    '@es_extended/imports.lua',
    '@ox_lib/init.lua',
    'config.lua',
}

client_scripts {
    'client.lua',
}

server_scripts {
    'server.lua',
}
