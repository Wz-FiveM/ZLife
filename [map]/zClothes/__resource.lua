resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'
this_is_a_map 'yes'

files {
    'vehicles.meta',
    'carvariations.meta',
    'carcols.meta',
    'gabz_timecycle_mods_1.xml',
    'handling.meta',
    'lspdpack_game.dat151.rel',
    'lspdpack_sounds.dat54.rel'
}

data_file 'HANDLING_FILE' 'handling.meta'
data_file 'VEHICLE_METADATA_FILE' 'vehicles.meta'
data_file 'CARCOLS_FILE' 'carcols.meta'
data_file 'VEHICLE_VARIATION_FILE' 'carvariations.meta'
data_file 'AUDIO_GAMEDATA' 'lspdpack_game.dat'
data_file 'AUDIO_SOUNDDATA' 'lspdpack_sounds.dat'
data_file 'TIMECYCLEMOD_FILE' 'gabz_timecycle_mods_1.xml'

client_script {
  "main.lua"
}