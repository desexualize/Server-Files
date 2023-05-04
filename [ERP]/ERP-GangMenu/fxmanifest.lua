fx_version 'adamant'
games { 'gta5' }

dependencies {
  'vrp'
}

client_scripts {
    "@RageUI2/src/RMenu.lua",
    "@RageUI2/src/menu/RageUI.lua",
    "@RageUI2/src/menu/Menu.lua",
    "@RageUI2/src/menu/MenuController.lua",
    "@RageUI2/src/components/Audio.lua",
    "@RageUI2/src/components/Rectangle.lua",
    "@RageUI2/src/components/Screen.lua",
    "@RageUI2/src/components/Sprite.lua",
    "@RageUI2/src/components/Text.lua",
    "@RageUI2/src/components/Visual.lua",
    "@RageUI2/src/menu/elements/ItemsBadge.lua",
    "@RageUI2/src/menu/elements/ItemsColour.lua",
    "@RageUI2/src/menu/elements/PanelColour.lua",
    "@RageUI2/src/menu/items/UIButton.lua",
    "@RageUI2/src/menu/items/UICheckBox.lua",
    "@RageUI2/src/menu/items/UIList.lua",
    "@RageUI2/src/menu/items/UIProgress.lua",
    "@RageUI2/src/menu/items/UISlider.lua",
    "@RageUI2/src/menu/items/UISliderHeritage.lua",
    "@RageUI2/src/menu/items/UISeparator.lua",
    "@RageUI2/src/menu/items/UISliderProgress.lua",
    "@RageUI2/src/menu/panels/UIColourPanel.lua",
    "@RageUI2/src/menu/panels/UIGridPanel.lua",
    "@RageUI2/src/menu/panels/UIGridPanelHorizontal.lua",
    "@RageUI2/src/menu/panels/UIPercentagePanel.lua",
    "@RageUI2/src/menu/panels/UIStatisticsPanel.lua",
    "@RageUI2/src/menu/windows/UIHeritage.lua",
	"lib/Proxy.lua",
    "lib/Tunnel.lua",
    "client/cl_*.lua",
}

server_scripts {
    "@vrp/lib/utils.lua",
    "server/sv_*.lua"
}

shared_scripts {
    "cfgs/cfg_*.lua"
}
  