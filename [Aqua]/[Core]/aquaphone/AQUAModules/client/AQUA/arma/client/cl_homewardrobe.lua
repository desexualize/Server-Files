local a = nil
local b = {}
local c = ""
local function checkOutfits()
    if next(b) then
        return true
    end
    return false
end
RMenu.Add("armawardrobe","mainmenu",RageUI.CreateMenu("", "", tARMA.getRageUIMenuWidth(), tARMA.getRageUIMenuHeight(), "banners", "cstore"))
RMenu:Get("armawardrobe", "mainmenu"):SetSubtitle("~b~HOME")
RMenu.Add("armawardrobe","listoutfits",RageUI.CreateSubMenu(RMenu:Get("armawardrobe", "mainmenu"),"","~b~Wardrobe",tARMA.getRageUIMenuWidth(),tARMA.getRageUIMenuHeight()))
RMenu.Add("armawardrobe","equip",RageUI.CreateSubMenu(RMenu:Get("armawardrobe", "listoutfits"),"","~b~Wardrobe",tARMA.getRageUIMenuWidth(),tARMA.getRageUIMenuHeight()))

RageUI.CreateWhile(1.0, true, function()
    if RageUI.Visible(RMenu:Get('armawardrobe', 'mainmenu')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = true}, function()
            RageUI.Button("List Outfits","",{RightLabel = "→→→"},checkOutfits(),function(d, e, f)
            end,RMenu:Get("armawardrobe", "listoutfits"))
            RageUI.Button("Save Outfit","",{RightLabel = "→→→"},true,function(d, e, f)
                if f then
                    c = getGenericTextInput("outfit name:")
                    if c then
                        if not tARMA.isPlayerInAnimalForm() then
                            TriggerServerEvent("ARMA:saveWardrobeOutfit", c)
                        else
                            tARMA.notify("~r~Cannot save animal in wardrobe.")
                        end
                    else
                        tARMA.notify("~r~Invalid outfit name")
                    end
                end
            end)
            RageUI.Button("Get Outfit Code","Gets a code for your current outfit which can be shared with other players.",{RightLabel = "→→→"},true,function(d, e, f)
                if f then
                    if tARMA.isPlusClub() or tARMA.isPlatClub() then
                        TriggerServerEvent("ARMA:getCurrentOutfitCode")
                    else
                        tARMA.notify("~y~You need to be a subscriber of ARMA Plus or ARMA Platinum to use this feature.")
                        tARMA.notify("~y~Available @ store.armarp.co.uk")
                    end
                end
            end,nil)
        end, function()
        end)
    end
    if RageUI.Visible(RMenu:Get('armawardrobe', 'listoutfits')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = true}, function()
            if b ~= {} then
                for g, h in pairs(b) do
                    RageUI.Button(g,"",{RightLabel = "→→→"},true,function(d, e, f)
                        if f then
                            c = g
                        end
                    end,RMenu:Get("armawardrobe", "equip"))
                end
            else
                RageUI.Button("~r~No outfits saved","",{RightLabel = "→→→"},true,function(d, e, f)
                end,RMenu:Get("armawardrobe", "mainmenu"))
            end
        end, function()
        end)
    end
    if RageUI.Visible(RMenu:Get('armawardrobe', 'equip')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = true}, function()
            RageUI.Button("Equip Outfit","",{RightLabel = "→→→"},true,function(d, e, f)
                if f then
                    TriggerServerEvent("ARMA:equipWardrobeOutfit", c)
                end
            end,RMenu:Get("armawardrobe", "listoutfits"))
            RageUI.Button("Delete Outfit","",{RightLabel = "→→→"},true,function(d, e, f)
                if f then
                    TriggerServerEvent("ARMA:deleteWardrobeOutfit", c)
                end
            end,RMenu:Get("armawardrobe", "listoutfits"))
        end, function()
        end)
    end
end)

local function i()
    RageUI.ActuallyCloseAll()
    RageUI.Visible(RMenu:Get('armawardrobe', 'mainmenu'), true)
end
local function j()
    RageUI.ActuallyCloseAll()
    RageUI.Visible(RMenu:Get("armawardrobe", "mainmenu"), false)
end
RegisterNetEvent("ARMA:openOutfitMenu",function(k)
    if k then
        b = k
    else
        TriggerServerEvent("ARMA:initWardrobe")
    end
    i()
end)
RegisterNetEvent("ARMA:refreshOutfitMenu",function(k)
    b = k
end)
RegisterNetEvent("ARMA:closeOutfitMenu",function()
    j()
end)