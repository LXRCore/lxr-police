fx_version 'cerulean'
game 'rdr3'
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

description 'LXR-PoliceJob'
version '1.0.0'

shared_scripts {
	'@lxr-core/shared/locale.lua',
	'locales/en.lua',
	'locales/*.lua',
    'config.lua',
}

client_scripts {
	'client/main.lua',
	--'client/camera.lua',
	'client/interactions.lua',
	'client/job.lua',
	--'client/heli.lua',
	--'client/anpr.lua',
	'client/evidence.lua',
	'client/objects.lua',
	--'client/tracker.lua'
}

server_scripts {
	'@oxmysql/lib/MySQL.lua',
	'server/main.lua'
}

lua54 'yes'