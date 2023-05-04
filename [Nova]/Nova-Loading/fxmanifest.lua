----------------------------------
--<!>-- BOII | DEVELOPMENT --<!>--
----------------------------------

fx_version 'cerulean'

game 'gta5'

author 'case#1993'

description 'BOII | Development - Load Screen Alpha'

version '1.0'

loadscreen_manual_shutdown "yes"
loadscreen 'html/loadscreen.html'

files {
    "html/**/*"
}
dependency '/assetpacks'
client_script 'cl_loading.lua'