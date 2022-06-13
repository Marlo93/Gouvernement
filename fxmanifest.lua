---@author Dylan Malandain.
---@version 1.0
--[[
    File fxmanifest.lua
    Project Gouvernement Job
    Created at 13/06/2022
    Credit : https://github.com/Marlo93
--]]

fx_version('cerulean')
game('gta5')

client_scripts {
    'RageUI//RMenu.lua',
    'RageUI//menu/RageUI.lua',
    'RageUI//menu/Menu.lua',
    'RageUI//menu/MenuController.lua',
    'RageUI//components/*.lua',
    'RageUI//menu/elements/*.lua',
    'RageUI//menu/items/*.lua',
    'RageUI//menu/panels/*.lua',
    'RageUI/menu/windows/*.lua',
    'client/*.lua'
}

server_scripts {
    'server/server.lua'
}

shared_scripts {
    'config.lua'
}