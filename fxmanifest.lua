fx_version 'bodacious'
games { "rdr3", "gta5" }
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

author 'Rayaan Uddin'
description 'A Life Style Script For RedM'
version '1.0'


client_scripts {
    'client.lua'
}

shared_scripts {
    'config.lua',
}

server_scripts {
   '@oxmysql/lib/MySQL.lua',
    'server.lua'
}

ui_page 'html/index.html'

files {
    'html/*.html',
    'html/css/*.css',
    'html/js/*.js',
	'html/fonts/*.*',
    'html/img/*.png',
}
