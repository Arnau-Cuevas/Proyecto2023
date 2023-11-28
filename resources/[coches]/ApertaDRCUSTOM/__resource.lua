resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

files {

	'data/**/carcols.meta',
	'data/**/carvariations.meta',
	'data/**/handling.meta',
	'data/**/vehiclelayouts.meta',
	'data/**/vehicles.meta',

 

	
	'audioconfig/avesvv12_game.dat151.rel',
	'audioconfig/avesvv12_sounds.dat54.rel',
	
	'sfx/dlc_avesvv12/avesvv12.awc',
	'sfx/dlc_avesvv12/avesvv12_npc.awc',
	


}

	data_file 'VEHICLE_LAYOUTS_FILE'	'data/**/vehiclelayouts.meta'
	data_file 'HANDLING_FILE'			'data/**/handling.meta'
	data_file 'VEHICLE_METADATA_FILE'	'data/**/vehicles.meta'
	data_file 'CARCOLS_FILE'			'data/**/carcols.meta'
	data_file 'VEHICLE_VARIATION_FILE'	'data/**/carvariations.meta'


	
	data_file 'AUDIO_GAMEDATA' 'audioconfig/avesvv12_game.dat151'
	data_file 'AUDIO_SOUNDDATA' 'audioconfig/avesvv12_sounds.dat54'
	data_file 'AUDIO_WAVEPACK' 'sfx/dlc_avesvv12'
	


	client_script 'veh_label.lua'
