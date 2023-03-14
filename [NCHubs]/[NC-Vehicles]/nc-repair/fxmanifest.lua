fx_version 'cerulean'
game 'gta5'

description 'vehiclemod'

shared_scripts {
	"config.lua"
}

client_scripts {
	'client/C_repair.lua',
	'client/kh-carcontrol.lua',
	'client/mech_client.lua',
}

server_scripts {
	'server/S_repair.lua',
	'server/mech_server.lua',
}

exports {
	'GetVehicleStatusList',
	'GetVehicleStatus',
	'SetVehicleStatus',
}
