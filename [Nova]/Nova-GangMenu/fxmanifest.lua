fx_version 'cerulean'
game 'gta5'

dependency 'vrp'

shared_script 'cfg/shared_functions.lua'

server_scripts {
    "@vrp/lib/utils.lua",
    '@oxmysql/lib/MySQL.lua',
    'server/sv_gangmenu.lua',
}

client_scripts {
    "@vrp/rageui/RMenu.lua",
    "@vrp/rageui/menu/RageUI.lua",
    "@vrp/rageui/menu/Menu.lua",
    "@vrp/rageui/menu/MenuController.lua",
    "@vrp/rageui/components/Audio.lua",
    "@vrp/rageui/components/Rectangle.lua",
    "@vrp/rageui/components/Screen.lua",
    "@vrp/rageui/components/Sprite.lua",
    "@vrp/rageui/components/Text.lua",
    "@vrp/rageui/components/Visual.lua",
    "@vrp/rageui/menu/elements/ItemsBadge.lua",
    "@vrp/rageui/menu/elements/ItemsColour.lua",
    "@vrp/rageui/menu/elements/PanelColour.lua",
    "@vrp/rageui/menu/items/UIButton.lua",
    "@vrp/rageui/menu/items/UICheckBox.lua",
    "@vrp/rageui/menu/items/UIList.lua",
    "@vrp/rageui/menu/items/UIProgress.lua",
    "@vrp/rageui/menu/items/UISlider.lua",
    "@vrp/rageui/menu/items/UISliderHeritage.lua",
    "@vrp/rageui/menu/items/UISliderProgress.lua",
    "@vrp/rageui/menu/panels/UIColourPanel.lua",
    "@vrp/rageui/menu/panels/UIGridPanel.lua",
    "@vrp/rageui/menu/panels/UIGridPanelHorizontal.lua",
    "@vrp/rageui/menu/panels/UIPercentagePanel.lua",
    "@vrp/rageui/menu/panels/UIStatisticsPanel.lua",
    "@vrp/rageui/menu/windows/UIHeritage.lua",
    '@vrp/rageui/menu/items/UISeparator.lua',
	"lib/Proxy.lua",
    "lib/Tunnel.lua",
    'client/cl_gangmenu.lua',
}
