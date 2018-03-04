version '0.7.1'

description 'ESX Anticombatloggin'

client_scripts {
	'@es_extended/locale.lua',
	'locales/fi.lua',
    'config.lua',
    'cl_main.lua'
}

server_scripts {
    'config.lua',
    'sv_main.lua'
}
