fx_version 'cerulean'
game 'gta5'

dependencies {'GHMattiMySQL'}

lua54 'yes'

shared_script {'utils/*', 'utils/lib/*'}

client_script {'utils/lib/client/*', 'client/*.lua', 'client/Game/*.lua', 'client/Squad/*.lua'}

server_script {'utils/lib/server/*', 'server/*.lua', 'server/Game/*.lua', 'server/Squad/*.lua'}

