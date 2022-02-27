fx_version 'cerulean'
game 'gta5'

shared_script '@es_extended/imports.lua'

server_scripts {
    '@mysql-async/lib/MySQL.lua',
    'server/server.lua',
    'config.lua'
} 

client_scripts {
    'client/client.lua',
    'config.lua'
}

dependencies {
    'oxmysql',
	'es_extended'
}
