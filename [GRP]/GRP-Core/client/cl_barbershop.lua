cfg = {}
cfg.blipsenabled = true
cfg.perm = "player.phone" -- player.phone is default for everyone
cfg.currency = "£"
local t = 0
local continue = true
local ped =PlayerPedId()
local Camera = false
local sittingCam = false
local cuttingHair = false
local finishCut = false
h = 0


local barbershops = {
    [0] = {
        barbermarker = {-33.243190765381, -151.39093017578, 56.076549530029},
    },
    [1] = {
        barbermarker = { 1932.1030273438, 3726.6960449219, 31.844417572021},
    },
    [2] = {
        barbermarker = {-279.57229614258, 6231.5063476563, 30.695512771606},
    },
    [3] = {
        barbermarker = {-821.74450683594, -185.11827087402, 36.578939208984},
    },
    [4] = {
        barbermarker = {-1285.9599609375, -1115.5983886719, 6.9901185035706},
    },
    [5] = {
        barbermarker = {133.74227905273, -1709.6291503906, 28.291627883911},
    },
}

local barbershopsenterence = {
    {x = -30.551294326782, y =-149.95950317383, z = 57.076503753662}
}

function addBlips()
    local blip1 = AddBlipForCoord(-33.243190765381, -151.39093017578, 56.076549530029)
    SetBlipSprite(blip1, 71)
end

RMenu.Add('barbershop', 'main', RageUI.CreateMenu("Barber Shop", "~b~Barber Shop", nil, nil, "root_cause", "shopui_title_warstock"))
RMenu.Add('barbershop', 'Hair', RageUI.CreateSubMenu(RMenu:Get('barbershop', 'main'), "Hair", "~b~Hair", nil, nil, "root_cause", "shopui_title_warstock"))
RMenu.Add('barbershop', 'SkinColour', RageUI.CreateSubMenu(RMenu:Get('barbershop', 'main'), "Skin Colour", "~b~Skin Colour", nil, nil, "root_cause", "shopui_title_warstock"))
RMenu.Add('barbershop', 'Eyebrows', RageUI.CreateSubMenu(RMenu:Get('barbershop', 'main'), "Eyebrows", "~b~Eyebrows", nil, nil, "root_cause", "shopui_title_warstock"))
RMenu.Add('barbershop', 'Beards', RageUI.CreateSubMenu(RMenu:Get('barbershop', 'main'), "Beards", "~b~Beards", nil, nil, "root_cause", "shopui_title_warstock"))
RMenu.Add('barbershop', 'Blush', RageUI.CreateSubMenu(RMenu:Get('barbershop', 'main'), "Blush", "~b~Blush", nil, nil, "root_cause", "shopui_title_warstock"))
RMenu.Add('barbershop', 'ChestHair', RageUI.CreateSubMenu(RMenu:Get('barbershop', 'main'), "Chest Hair", "~b~Chest Hair", nil, nil, "root_cause", "shopui_title_warstock"))
RMenu.Add('barbershop', 'Blemishes', RageUI.CreateSubMenu(RMenu:Get('barbershop', 'main'), "Blemishes", "~b~Blemishes", nil, nil, "root_cause", "shopui_title_warstock"))
RMenu.Add('barbershop', 'Ageing', RageUI.CreateSubMenu(RMenu:Get('barbershop', 'main'), "Ageing", "~b~Ageing", nil, nil, "root_cause", "shopui_title_warstock"))
RMenu.Add('barbershop', 'Make-up', RageUI.CreateSubMenu(RMenu:Get('barbershop', 'main'), "Make-up", "~b~Make-up", nil, nil, "root_cause", "shopui_title_warstock"))
RMenu.Add('barbershop', 'Finish', RageUI.CreateSubMenu(RMenu:Get('barbershop', 'main'), "Finish", "~b~Finish", nil, nil, "root_cause", "shopui_title_warstock"))
RMenu.Add('barbershop', 'Lipstick', RageUI.CreateSubMenu(RMenu:Get('barbershop', 'main'), "Lipstick", "~b~Lipstick", nil, nil, "root_cause", "shopui_title_warstock"))
RMenu.Add('barbershop', 'Complexion', RageUI.CreateSubMenu(RMenu:Get('barbershop', 'main'), "Complexion", "~b~Complexion", nil, nil, "root_cause", "shopui_title_warstock"))
RMenu.Add('barbershop', 'BodyBlem', RageUI.CreateSubMenu(RMenu:Get('barbershop', 'main'), "Body Blemishes", "~b~Body Blemishes", nil, nil, "root_cause", "shopui_title_warstock"))
RMenu.Add('barbershop', 'SunDamage', RageUI.CreateSubMenu(RMenu:Get('barbershop', 'main'), "Sun Damage", "~b~Body Sun Damage", nil, nil, "root_cause", "shopui_title_warstock"))
RMenu.Add('barbershop', 'Moles', RageUI.CreateSubMenu(RMenu:Get('barbershop', 'main'), "Moles & Freckles", "~b~Body Moles & Freckles", nil, nil, "root_cause", "shopui_title_warstock"))
RMenu:Get('barbershop', 'main'):SetPosition(1350, 10)
RMenu:Get('barbershop', 'Hair'):SetPosition(1350, 10)
RMenu:Get('barbershop', 'Eyebrows'):SetPosition(1350, 10)
RMenu:Get('barbershop', 'Beards'):SetPosition(1350, 10)
RMenu:Get('barbershop', 'Blush'):SetPosition(1350, 10)
RMenu:Get('barbershop', 'ChestHair'):SetPosition(1350, 10)
RMenu:Get('barbershop', 'Blemishes'):SetPosition(1350, 10)
RMenu:Get('barbershop', 'Ageing'):SetPosition(1350, 10)
RMenu:Get('barbershop', 'Make-up'):SetPosition(1350, 10)
RMenu:Get('barbershop', 'Lipstick'):SetPosition(1350, 10)
RMenu:Get('barbershop', 'Complexion'):SetPosition(1350, 10)
RMenu:Get('barbershop', 'BodyBlem'):SetPosition(1350, 10)
RMenu:Get('barbershop', 'SunDamage'):SetPosition(1350, 10)
RMenu:Get('barbershop', 'Moles'):SetPosition(1350, 10)
RMenu:Get('barbershop', 'SkinColour'):SetPosition(1350, 10)
RMenu:Get('barbershop', 'Finish'):SetPosition(1350, 10)

-- RageUI.CreateWhile(wait, menu, key, closure)
RageUI.CreateWhile(1.0, RMenu:Get('barbershop', 'main'), nil, function()

 -- RageUI.IsVisible(menu, header, glare, instructional, items, panels)
    RageUI.IsVisible(RMenu:Get('barbershop', 'main'), true, false, true, function()
    hairBtn()
    BeardBtn()  
    lipstickBtn()
    eyebrowsBtn()
    blushBtn()
    chesthairBtn()
    ageingBtn()
    compBtn()
    makeupBtn()
    blemBtn()
    bodyBlemBtn()
    molesBtn()
    skinBtn()
    finishBtn()
    end, function()
        ---Panels
    end)
    hairSM()
    beardSM()
    lipstickSM()
    eyebrowsSM()
    blushSM()
    chesthairSM()
    ageingSM()
    compSM()
    makeupSM()
    blemSM()  
    bodyBlemSM()
    molesSM()
    skinSM()
end)

RegisterNetEvent('VRPGUNSHOPS:menu')
AddEventHandler('VRPGUNSHOPS:menu', function()
    RageUI.Visible(RMenu:Get("barbershop", "main"))
    alert('Insufficent funds')
end)



function BeardBtn() 
    RageUI.Button("Beard" , nil, {RightLabel = "→→→",}, true, function(Hovered, Active, Selected)
        if Selected then
            sittingCam = true
            -- My action the button is selected
        end
    end, RMenu:Get('barbershop', 'Beards'))
end

function skinBtn() 
    RageUI.Button("Skin Colour" , nil, {RightLabel = "→→→",}, true, function(Hovered, Active, Selected)
        if Selected then
            sittingCam = true
            -- My action the button is selected
        end
    end, RMenu:Get('barbershop', 'SkinColour'))
end

function molesBtn() 
    RageUI.Button("Moles & Freckles" , nil, {RightLabel = "→→→",}, true, function(Hovered, Active, Selected)
        if Selected then
            sittingCam = true
            -- My action the button is selected
        end
    end, RMenu:Get('barbershop', 'Moles'))
end

function bodyBlemBtn() 
    RageUI.Button("Body Blemishes" , nil, {RightLabel = "→→→",}, true, function(Hovered, Active, Selected)
        if Selected then
            sittingCam = true
            -- My action the button is selected
        end
    end, RMenu:Get('barbershop', 'BodyBlem'))
end

function makeupBtn() 
    RageUI.Button("Make-up" , nil, {RightLabel = "→→→",}, true, function(Hovered, Active, Selected)
        if Selected then
            sittingCam = true
            -- My action the button is selected
        end
    end, RMenu:Get('barbershop', 'Make-up'))
end

function blemBtn() 
    RageUI.Button("Blemishes" , nil, {RightLabel = "→→→",}, true, function(Hovered, Active, Selected)
        if Selected then
            sittingCam = true
            -- My action the button is selected
        end
    end, RMenu:Get('barbershop', 'Blemishes'))
end
function finishBtn() 
    RageUI.Button("Finish" , nil, {RightLabel = "→→→",}, true, function(Hovered, Active, Selected)
        if Selected then
            TriggerEvent('Galaxy:finishCut')
           
        end
    end, RMenu:Get('barbershop', 'Finish'))
end

function ageingBtn() 
    RageUI.Button("Ageing" , nil, {RightLabel = "→→→",}, true, function(Hovered, Active, Selected)
        if Selected then
            sittingCam = true
            -- My action the button is selected
        end
    end, RMenu:Get('barbershop', 'Ageing'))
end

function hairBtn()
    RageUI.Button("Hair" , nil, {RightLabel = "→→→",}, true, function(Hovered, Active, Selected)
        if Selected then
            sittingCam = true
            -- My action the button is selected
        end
    end, RMenu:Get('barbershop', 'Hair'))
end

function compBtn() 
    RageUI.Button("Complexion" , nil, {RightLabel = "→→→",}, true, function(Hovered, Active, Selected)
        if Selected then
            sittingCam = true
            -- My action the button is selected
        end
    end, RMenu:Get('barbershop', 'Complexion'))
end

function chesthairBtn() 
    RageUI.Button("Chest Hair" , nil, {RightLabel = "→→→",}, true, function(Hovered, Active, Selected)
        if Selected then
            sittingCam = true
            -- My action the button is selected
        end
    end, RMenu:Get('barbershop', 'ChestHair'))
end

function blushBtn() 
    RageUI.Button("Blush" , nil, {RightLabel = "→→→",}, true, function(Hovered, Active, Selected)
        if Selected then
            sittingCam = true
            -- My action the button is selected
        end
    end, RMenu:Get('barbershop', 'Blush'))
end

function lipstickBtn() 
    RageUI.Button("Lipstick" , nil, {RightLabel = "→→→",}, true, function(Hovered, Active, Selected)
        if Selected then
            sittingCam = true
            -- My action the button is selected
        end
    end, RMenu:Get('barbershop', 'Lipstick'))
end

function eyebrowsBtn() 
    RageUI.Button("Eyebrows" , nil, {RightLabel = "→→→",}, true, function(Hovered, Active, Selected)
        if Selected then
            sittingCam = true
            -- My action the button is selected
        end
    end, RMenu:Get('barbershop', 'Eyebrows'))
end

local h = 0
local colour = 0
function hairSM() 
    RageUI.IsVisible(RMenu:Get('barbershop', 'Hair'), true, false, true, function()
        for i=0, GetNumberOfPedDrawableVariations(GetPlayerPed(-1), 2) do
            RageUI.Button(tostring(i) , nil, {RightLabel = "→→→",}, true, function(Hovered, Active, Selected)
              
                if Active then
                   
                    print(GetNumberOfPedTextureVariations(GetPlayerPed(-1), 2, i))
                    SetPedComponentVariation(GetPlayerPed(-1), 2, i, h, 0)
                    if continue == true then                        
                        if Selected then
                            if GetNumberOfPedTextureVariations(GetPlayerPed(-1), 2, i) -2 < h then
                                
                                
                                h=0
                                return
                            end
                            h = h+1
                            if GetNumHairColors() < colour then
                                colour = 0
                                return
                            end
                            SetPedHairColor(GetPlayerPed(-1), colour, colour)
                            colour = colour+1
                          
                            continue = true
                        
                        end
                    end
                   -- 
                   
                end
            end)
        end
        end, function()
    end)
end


-- GetNumHairColors()

local b = 0
function beardSM()
    RageUI.IsVisible(RMenu:Get('barbershop', 'Beards'), true, false, true, function()
        sittingCam = true
        for i=0, 255 do 
            if i == 255 then
                RageUI.Button("Remove" , nil, {RightLabel = "→→→",}, true, function(Hovered, Active, Selected) 
                    if Selected then
                        SetPedHeadOverlay(GetPlayerPed(-1), 1, 34, 1.0)
                        SetPedHeadOverlayColor(GetPlayerPed(-1), 1, 34, 2, 2)
                    end
                end)
                return  
            end 
             
            RageUI.Button(tostring(i) , nil, {RightLabel = "→→→",}, true, function(Hovered, Active, Selected) 
                    if Selected then
                        --TriggerEvent('Galaxy:cutHair')
                        SetPedHeadOverlay(GetPlayerPed(-1), 1, i, 1.0)
                        SetPedHeadOverlayColor(GetPlayerPed(-1), 1, b, 2, 2) 
                        if b == 28 then
                            b = 0
                            return
                        end
                        b = b+1
                        print(b) 
                    end
                end)
            end
        end, function()
    end)
end

local lc = 0
function lipstickSM() 
    RageUI.IsVisible(RMenu:Get('barbershop', 'Lipstick'), true, false, true, function()
        sittingCam = true
        for i=0, 255 do 
            if i == 255 then
                RageUI.Button("Remove" , nil, {RightLabel = "→→→",}, true, function(Hovered, Active, Selected) 
                    if Selected then
                        SetPedHeadOverlay(GetPlayerPed(-1), 8, 34, 1.0)
                        SetPedHeadOverlayColor(GetPlayerPed(-1), 8, 34, 2, 2)
                    end
                end)
                return  
            end 
             
            RageUI.Button(tostring(i) , nil, {RightLabel = "→→→",}, true, function(Hovered, Active, Selected) 
                    if Selected then
                        ----TriggerEvent('Galaxy:cutHair')
                        SetPedHeadOverlay(GetPlayerPed(-1), 8, i, 1.0)
                        SetPedHeadOverlayColor(GetPlayerPed(-1), 8, lc, 2, 2) 
                        --SetPedHeadOverlayColor(GetPlayerPed(-1), 8, 1, 2, 2)
                        if lc == 9 then
                            lc = 0
                            return
                        end
                        lc = lc+1
                        --SetPedHeadOverlayColor(ped, overlayID, colorType, colorID, secondColorID)
                        --SetPedHeadOverlay(ped, overlayID, index, opacity)   
                    end
                end)
            end
        end, function()
    end)
end

local ebc = 0
function eyebrowsSM() 
    RageUI.IsVisible(RMenu:Get('barbershop', 'Eyebrows'), true, false, true, function()
        sittingCam = true
        for i=0, 255 do 
            if i == 255 then
                RageUI.Button("Remove" , nil, {RightLabel = "→→→",}, true, function(Hovered, Active, Selected) 
                    if Selected then
                        SetPedHeadOverlay(GetPlayerPed(-1), 2, 34, 1.0)
                        SetPedHeadOverlayColor(GetPlayerPed(-1), 2, 34, 2, 2)
                    end
                end)
                return  
            end 
            RageUI.Button(tostring(i) , nil, {RightLabel = "→→→",}, true, function(Hovered, Active, Selected) 
                    if Selected then
                        --TriggerEvent('Galaxy:cutHair')
                        SetPedHeadOverlay(GetPlayerPed(-1), 2, i, 1.0)
                        SetPedHeadOverlayColor(GetPlayerPed(-1), 2, ebc, 2, 2) 
                        if ebc == 33 then
                            ebc = 0
                            return
                        end
                        ebc = ebc+1  
                    end
                end)
            end
        end, function()
    end)
end

local bc = 0
function blushSM() 
    RageUI.IsVisible(RMenu:Get('barbershop', 'Blush'), true, false, true, function()
        sittingCam = true
        for i=0, 255 do 
            if i == 255 then
                RageUI.Button("Remove" , nil, {RightLabel = "→→→",}, true, function(Hovered, Active, Selected) 
                    if Selected then
                        SetPedHeadOverlay(GetPlayerPed(-1), 5, 33, 1.0)
                        SetPedHeadOverlayColor(GetPlayerPed(-1), 5, 33, 2, 2)
                    end
                end)
                return  
            end
            
            RageUI.Button(tostring(i) , nil, {RightLabel = "→→→",}, true, function(Hovered, Active, Selected) 
                    if Selected then
                        --TriggerEvent('Galaxy:cutHair')
                        SetPedHeadOverlay(GetPlayerPed(-1), 5, i, 1.0)
                        SetPedHeadOverlayColor(GetPlayerPed(-1), 5, bc, 2, 2) 
                        if bc == 6 then
                            bc = 0
                            return
                        end
                        bc = bc+1   
                    end
                end)
            end
        end, function()
    end)
end

local chc = 0
function chesthairSM() 
    RageUI.IsVisible(RMenu:Get('barbershop', 'ChestHair'), true, false, true, function()
        sittingCam = true
        for i=0, 255 do 
            if i == 255 then
                RageUI.Button("Remove" , nil, {RightLabel = "→→→",}, true, function(Hovered, Active, Selected) 
                    if Selected then
                        SetPedHeadOverlay(GetPlayerPed(-1), 10, 33, 1.0)
                        SetPedHeadOverlayColor(GetPlayerPed(-1), 10, 33, 2, 2)
                    end
                end)
                return  
            end
            
            RageUI.Button(tostring(i) , nil, {RightLabel = "→→→",}, true, function(Hovered, Active, Selected) 
                    if Selected then
                        --TriggerEvent('Galaxy:cutHair')
                        SetPedHeadOverlay(GetPlayerPed(-1), 10, i, 1.0)
                        SetPedHeadOverlayColor(GetPlayerPed(-1), 10, chc, 2, 2) 
                        --SetPedHeadOverlayColor(GetPlayerPed(-1), 8, 1, 2, 2)
                        if chc == 6 then
                            chc = 0
                            return
                        end
                        chc = chc+1  
                    end
                end)
            end
        end, function()
    end)
end

local agc = 0
function ageingSM() 
    RageUI.IsVisible(RMenu:Get('barbershop', 'Ageing'), true, false, true, function()
        sittingCam = true
        for i=0, 255 do 
            if i == 255 then
                RageUI.Button("Remove" , nil, {RightLabel = "→→→",}, true, function(Hovered, Active, Selected) 
                    if Selected then
                        SetPedHeadOverlay(GetPlayerPed(-1), 3, 33, 1.0)
                        SetPedHeadOverlayColor(GetPlayerPed(-1), 3, 33, 2, 2)
                    end
                end)
                return  
            end
            
            RageUI.Button(tostring(i) , nil, {RightLabel = "→→→",}, true, function(Hovered, Active, Selected) 
                    if Selected then
                        SetPedHeadOverlay(GetPlayerPed(-1), 3, i, 1.0)
                        --TriggerEvent('Galaxy:cutHair')
                        SetPedHeadOverlayColor(GetPlayerPed(-1), 3, agc, 2, 2) 
                        if agc == 6 then
                            agc = 0
                            return
                        end
                        agc = agc+1
                    end
                end)
            end
        end, function()
    end)
end

local comc = 0
function compSM() 
    RageUI.IsVisible(RMenu:Get('barbershop', 'Complexion'), true, false, true, function()
        sittingCam = true
        for i=0, 255 do 
            if i == 255 then
                RageUI.Button("Remove" , nil, {RightLabel = "→→→",}, true, function(Hovered, Active, Selected) 
                    if Selected then
                        SetPedHeadOverlay(GetPlayerPed(-1), 6, 33, 1.0)
                        SetPedHeadOverlayColor(GetPlayerPed(-1), 6, 33, 2, 2)
                    end
                end)
                return  
            end
            
            RageUI.Button(tostring(i) , nil, {RightLabel = "→→→",}, true, function(Hovered, Active, Selected) 
                    if Selected then
                        --TriggerEvent('Galaxy:cutHair')
                        SetPedHeadOverlay(GetPlayerPed(-1), 6, i, 1.0)
                        SetPedHeadOverlayColor(GetPlayerPed(-1), 6, comc, 2, 2) 
                        --SetPedHeadOverlayColor(GetPlayerPed(-1), 8, 1, 2, 2)
                        if comc == 6 then
                            comc = 0
                            return
                        end
                        comc = comc+1
                        --SetPedHeadOverlayColor(ped, overlayID, colorType, colorID, secondColorID)
                        --SetPedHeadOverlay(ped, overlayID, index, opacity)   
                    end
                end)
            end
        end, function()
    end)
end

local molesc = 0
function molesSM() 
    RageUI.IsVisible(RMenu:Get('barbershop', 'Moles'), true, false, true, function()
        sittingCam = true
        for i=0, 255 do 
            if i == 255 then
                RageUI.Button("Remove" , nil, {RightLabel = "→→→",}, true, function(Hovered, Active, Selected) 
                    if Selected then
                        SetPedHeadOverlay(GetPlayerPed(-1), 9, 33, 1.0)
                        SetPedHeadOverlayColor(GetPlayerPed(-1), 9, 33, 2, 2)
                    end
                end)
                return  
            end
            
            RageUI.Button(tostring(i) , nil, {RightLabel = "→→→",}, true, function(Hovered, Active, Selected) 
                    if Selected then
                        --TriggerEvent('Galaxy:cutHair')
                        SetPedHeadOverlay(GetPlayerPed(-1), 9, i, 1.0)
                        SetPedHeadOverlayColor(GetPlayerPed(-1), 9, molesc, 2, 2) 
                        if molesc == 6 then
                            molesc = 0
                            return
                        end
                        molesc = molesc+1 
                    end
                end)
            end
        end, function()
    end)
end

local belmc = 0
function blemSM() 
    RageUI.IsVisible(RMenu:Get('barbershop', 'Blemishes'), true, false, true, function()
        sittingCam = true
        for i=0, 255 do 
            if i == 255 then
                RageUI.Button("Remove" , nil, {RightLabel = "→→→",}, true, function(Hovered, Active, Selected) 
                    if Selected then
                        SetPedHeadOverlay(GetPlayerPed(-1), 0, 33, 1.0)
                        SetPedHeadOverlayColor(GetPlayerPed(-1), 0, 33, 2, 2)
                    end
                end)
                return  
            end
            
            RageUI.Button(tostring(i) , nil, {RightLabel = "→→→",}, true, function(Hovered, Active, Selected) 
                    if Selected then
                        --TriggerEvent('Galaxy:cutHair')
                        SetPedHeadOverlay(GetPlayerPed(-1), 0, i, 1.0)
                        SetPedHeadOverlayColor(GetPlayerPed(-1), 0, belmc, 2, 2) 
                        if belmc == 6 then
                            belmc = 0
                            return
                        end
                        belmc = belmc+1   
                    end
                end)
            end
        end, function()
    end)
end

local skinc = 0
function skinSM() 
    RageUI.IsVisible(RMenu:Get('barbershop', 'SkinColour'), true, false, true, function()
        sittingCam = true
        for i=0, 255 do 
            RageUI.Button(tostring(i) , nil, {RightLabel = "→→→",}, true, function(Hovered, Active, Selected) 
                    if Selected then
                        SetPedHeadBlendData(GetPlayerPed(-1), i, i, i, i, i, i, i, i, i, false)
                        if skinc == 6 then
                            skinc = 0
                            return
                        end
                        skinc = skinc+1 
                    end
                end)
            end
        end, function()
    end)
end

local makec = 0
function makeupSM() 
    RageUI.IsVisible(RMenu:Get('barbershop', 'Make-up'), true, false, true, function()
        sittingCam = true
        for i=0, 255 do 
            if i == 255 then
                RageUI.Button("Remove" , nil, {RightLabel = "→→→",}, true, function(Hovered, Active, Selected) 
                    if Selected then
                        SetPedHeadOverlay(GetPlayerPed(-1), 4, 100, 1.0)
                        SetPedHeadOverlayColor(GetPlayerPed(-1), 4, 100, 2, 2)
                    end
                end)
                return  
            end
            
            RageUI.Button(tostring(i) , nil, {RightLabel = "→→→",}, true, function(Hovered, Active, Selected) 
                    if Selected then
                        -- --TriggerEvent('Galaxy:cutHair')
                        SetPedHeadOverlay(GetPlayerPed(-1), 4, i, 1.0)
                        SetPedHeadOverlayColor(GetPlayerPed(-1), 4, makec, 2, 2) 
                        if makec == 6 then
                            makec = 0
                            return
                        end
                        makec = makec+1
                    end
                end)
            end
        end, function()
    end)
end

local bblemc = 0
function bodyBlemSM() 
    RageUI.IsVisible(RMenu:Get('barbershop', 'BodyBlem'), true, false, true, function()
        sittingCam = true
        for i=0, 255 do 
            if i == 255 then
                RageUI.Button("Remove" , nil, {RightLabel = "→→→",}, true, function(Hovered, Active, Selected) 
                    if Selected then
                        SetPedHeadOverlay(GetPlayerPed(-1), 11, 100, 1.0)
                        SetPedHeadOverlayColor(GetPlayerPed(-1), 11, 100, 2, 2)
                    end
                end)
                return  
            end
            RageUI.Button(tostring(i) , nil, {RightLabel = "→→→",}, true, function(Hovered, Active, Selected) 
                    if Selected then
                        -- --TriggerEvent('Galaxy:cutHair')
                        -- print("Beard Selected")
                        SetPedHeadOverlay(GetPlayerPed(-1), 11, i, 1.0)
                        -- print(i)
                        SetPedHeadOverlayColor(GetPlayerPed(-1), 11, bblemc, 2, 2) 
                        if bblemc == 6 then
                            bblemc = 0
                            return
                        end
                        bblemc = bblemc+1  
                    end
                end)
            end
        end, function()
    end)
end

-- local isInMenu = false
-- currentAmmunition = nil
-- Citizen.CreateThread(function() 
--     while true do
--         for k, v in pairs(barbershops) do 
--             local v1 = vector3(v.x,v.y,v.z)
--             if isInArea(v1, 100.0) then 
--                 DrawMarker(25, v1.x,v1.y,v1.z, 0, 0, 0, 0, 0, 0, 1.100, 1.100, 1.100, 255, 0, 0, 255, false, false, false, false)
--             end
--             if sittingCam == true and isInMenu == false then
--                 if isInArea(v1, 5.0) then
--                     print("Hell")
--                     isInMenu = true
--                     Citizen.Wait(3500)
--                     RageUI.Visible(RMenu:Get("barbershop", "main"), true)
--                 end
--             end
--         end
--         Citizen.Wait(0)
--     end
-- end)

-- function SetupInsideCam()
--     cam = CreateCam("DEFAULT_SCRIPTED_CAMERA",true,2)
--     if finishCut == true then
--         DestroyCam(cam, true)
--         SetCamActive(cam, false)
--     end
--     SetCamCoord(cam, -33.088680267334,-156.56790161133,57.076503753662 + 1.0)
-- 	PointCamAtCoord(cam, -33.369274139404,-149.50477600098,57.083950042725)
-- 	--PointCamAtEntity(cam, GetVehiclePedIsUsing(ped), p2, p3, p4, 1)
-- 	SetCamActive(cam, true)
--     RenderScriptCams( 1, 0, cam, 0, 0)
-- end

-- function SetupInsideCam2()
--     cam2 = CreateCam("DEFAULT_SCRIPTED_CAMERA",true,2)
--     if finishCut == true then
--         DestroyCam(cam2, true)
--         SetCamActive(cam2, false)
--     end
--     SetCamCoord(cam2, -36.07,-151.25,57.86)
--     PointCamAtCoord(cam2, -34.63,-151.77,57.8)
--     SetCamActive(cam2, true)
--     RenderScriptCams( 1, 0, cam2, 0, 0)
-- end

-- function destorycam()
--     RenderScriptCams(false, false, 0, 1, 0)
--     DestroyCam(cam, false)
-- end

-- function destorycam2()
--     RenderScriptCams(false, false, 0, 1, 0)
--     DestroyCam(cam2, false)
-- end

-- function PlayAnim(entity, dict, anim)
--     RequestAnimDict(dict)
--     while not HasAnimDictLoaded(dict) do
--         Citizen.Wait(0)
--     end

--     TaskPlayAnim(entity, dict, anim, 4.0, -4.0, -1, 2, 0.0, 0, 0, 0)
-- end
barberIsInMenu = false
currentAmmunition = nil
Citizen.CreateThread(function() 
    while true do
        for k, brber in pairs(barbershops) do
            local x,y,z = table.unpack(brber.barbermarker)
            local v1 = vector3(x,y,z)
            --print(tostring(v1))
        
            
            --local v1 = vector3(72.55005645752,-1399.3771972656,29.376125335693)
            if isInArea(v1, 100.0) then 
                DrawMarker(27, v1.x,v1.y,v1.z - 0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 2.5, 0, 0, 255, 150, 0, 0, 2, 0, 0, 0, false, true, true)
            end
        
            if barberIsInMenu == false then
            if isInArea(v1, 1.4) then
                print("Should open clothing menu")
                barberIsInMenu = true
                TriggerEvent("GalaxyRPINV:UINotify","~r~Make sure to change your skin colour first to ensure the rest of the features work.")
                RageUI.Visible(RMenu:Get("barbershop", "main"), true)
                currentAmmunition = k
                currentAmmunition = k 
            end
            end
            if isInArea(v1, 1.4) == false and barberIsInMenu == true and k == currentAmmunition then
                RageUI.Visible(RMenu:Get("barbershop", "main"), false)
                RageUI.Visible(RMenu:Get("barbershop", "Hair"), false)
                RageUI.Visible(RMenu:Get("barbershop", "Eyebrows"), false)
                RageUI.Visible(RMenu:Get("barbershop", "Beards"), false)
                RageUI.Visible(RMenu:Get("barbershop", "ChestHair"), false)
                RageUI.Visible(RMenu:Get("barbershop", "Blemishes"), false)
                RageUI.Visible(RMenu:Get("barbershop", "Ageing"), false)
                RageUI.Visible(RMenu:Get("barbershop", "Make-up"), false)
                RageUI.Visible(RMenu:Get("barbershop", "Lipstick"), false)
                RageUI.Visible(RMenu:Get("barbershop", "Complexion"), false)
                RageUI.Visible(RMenu:Get("barbershop", "BodyBlem"), false)
                RageUI.Visible(RMenu:Get("barbershop", "Moles"), false)
                RageUI.Visible(RMenu:Get("barbershop", "SkinColour"), false)
                RageUI.Visible(RMenu:Get("barbershop", "Blush"), false)
                getPlayer()
                barberIsInMenu = false
                currentAmmunition = nil
            end
        end
        Wait(1)
    end
end)

local function isInArea(v, dis) 
if #(GetEntityCoords(PlayerPedId(-1)) - v) < dis then  
    return true
else 
    return false
end
end

function getPlayer(part)
    if part == 2 then
      return tonumber(GetNumberOfPedDrawableVariations(GetPlayerPed(-1),2))
    elseif part == -1 then
      return tonumber(GetNumberOfPedDrawableVariations(GetPlayerPed(-1),0))
    else
      return tonumber(GetNumHeadOverlayValues(part))
    end
end

-- Citizen.CreateThread(function()
--     local chair1 = 139522
--     local chair2 = 139778
--     local chair3 = 140034
--     local chair4 = 140290
--     while true do 
--         Citizen.Wait(1)
--         FreezeEntityPosition(chair1, true)
--         FreezeEntityPosition(chair2, true)
--         FreezeEntityPosition(chair3, true)
--     end
-- end)

-- function animations()
--     if Camera == true then
        
--         local player = GetPlayerPed(PlayerPedId(-1))
--         local playerLoc = GetEntityCoords(player)
--         print(playerLoc)
--         TaskStartScenarioInPlace(pid, 'WORLD_HUMAN_CLIPBOARD', false, true)
--         GetEntityRotation(pid)
--         print(tonumber(GetEntityRotation(pid)))
--     end
-- end

-- function spawnHairDresser()
--     local modelName = 's_f_m_fembarber'
--     local modelHash = GetHashKey(modelName)
--     local scissors = 423426
--     RequestModel(modelHash)
--     while not HasModelLoaded(modelHash) do
--         RequestModel(modelHash)
--         Citizen.Wait(0)
--     end
--     HairDresser = CreatePed(4, modelHash , -36.17,-155.48,57.08, rotation, true, true)
--     local vcoords = GetEntityCoords(HairDresser)
--     --AttachEntityToEntity(HairDresser, scissors, 'SKEL_L_Finger01', vcoords.x, vcoords.y, vcoords.z, 0.0, 0.0, 0.0, 0.0, false, false, true, false, false)
--     TaskGoStraightToCoord(HairDresser, -33.686470031738,-154.79438781738,57.076522827148, 0.5, -1, 68.61, 0)
--     Citizen.Wait(1000)
--     TaskGoStraightToCoord(HairDresser, -34.780952453613,-152.44378662109,57.086505889893, 0.5, -1, 68.61, 0)
--     Citizen.Wait(3500)
--     PlayAmbientSpeech1(HairDresser, 'SHOP_HAIR_WHAT_WANT', 'SPEECH_PARAMS_STANDARD')
-- end

-- RegisterNetEvent('Galaxy:cutHair')
-- AddEventHandler('Galaxy:cutHair', function()
--     cuttingHair = true
--     if cuttingHair == true then
--         RageUI.Visible(RMenu:Get("barbershop", "Hair"), false)
--         RageUI.Visible(RMenu:Get("barbershop", "Eyebrows"), false)
--         RageUI.Visible(RMenu:Get("barbershop", "Beards"), false)
--         RageUI.Visible(RMenu:Get("barbershop", "ChestHair"), false)
--         RageUI.Visible(RMenu:Get("barbershop", "Blemishes"), false)
--         RageUI.Visible(RMenu:Get("barbershop", "Ageing"), false)
--         RageUI.Visible(RMenu:Get("barbershop", "Make-up"), false)
--         RageUI.Visible(RMenu:Get("barbershop", "Lipstick"), false)
--         RageUI.Visible(RMenu:Get("barbershop", "Complexion"), false)
--         RageUI.Visible(RMenu:Get("barbershop", "BodyBlem"), false)
--         RageUI.Visible(RMenu:Get("barbershop", "Moles"), false)
--         RageUI.Visible(RMenu:Get("barbershop", "SkinColour"), false)
--         RageUI.Visible(RMenu:Get("barbershop", "Blush"), false)
--         end
--         local dict = "misshair_shop@barbers"
--         local anim = "keeper_idle_b"
--         --ClearPedTasksImmediately(HairDresser)
--         RequestAnimDict("misshair_shop@barbers")
--         while not HasAnimDictLoaded("misshair_shop@barbers") do
--             print("Anim Not Loading")
--             Citizen.Wait(0)
--         end
--         Citizen.Wait(100)
--         TaskPlayAnim(HairDresser,"misshair_shop@barbers","keeper_idle_a",1.0,1.0, 5000, 0, 1, true, true, true)
--         Citizen.Wait(5000)
--         TaskGoStraightToCoord(HairDresser, -34.780952453613,-152.44378662109,57.086505889893, 0.5, -1, 68.61, 0)
--         Wait(500)
--         PlayAmbientSpeech1(HairDresser, 'SHOP_CUTTING_HAIR', 'SPEECH_PARAMS_STANDARD')
--         cuttingHair = false
--         RageUI.Visible(RMenu:Get("barbershop", "main"), true)
--         -- RageUI.Visible(RMenu:Get("barbershop", "main"), true)
--         -- RageUI.Visible(RMenu:Get("barbershop", "Hair"), true)
--         -- RageUI.Visible(RMenu:Get("barbershop", "Eyebrows"), true)
--         -- RageUI.Visible(RMenu:Get("barbershop", "Beards"), true)
--         -- RageUI.Visible(RMenu:Get("barbershop", "ChestHair"), true)
--         -- RageUI.Visible(RMenu:Get("barbershop", "Blemishes"), true)
--         -- RageUI.Visible(RMenu:Get("barbershop", "Ageing"), true)
--         -- RageUI.Visible(RMenu:Get("barbershop", "Make-up"), true)
--         -- RageUI.Visible(RMenu:Get("barbershop", "Lipstick"), true)
--         -- RageUI.Visible(RMenu:Get("barbershop", "Complexion"), true)
--         -- RageUI.Visible(RMenu:Get("barbershop", "BodyBlem"), true)
--         -- RageUI.Visible(RMenu:Get("barbershop", "Moles"), true)
--         -- RageUI.Visible(RMenu:Get("barbershop", "SkinColour"), true)
--         --aRageUI.Visible(RMenu:Get("barbershop", "Blush"), true)
-- end)

-- function hdanim()
--     local dict = "misshair_shop@barbers"
--     local anim = "keeper_idle_b"
--     RequestAnimDict("misshair_shop@barbers")
--     while not HasAnimDictLoaded("misshair_shop@barbers") do
--         Citizen.Wait(0)
--     end
--     Citizen.Wait(100)
--     PlayAnimation(HairDresser,dict,anim)
-- end

-- function PlayAnimation(entity, dict, anim)
--     RequestAnimDict(dict)
--     while not HasAnimDictLoaded(dict) do
--         Citizen.Wait(0)
--     end
--     TaskPlayAnim(entity, dict, anim, 4.0, -4.0, -1, 2, 0.0, 0, 0, 0)
-- end

-- RegisterNetEvent('Galaxy:finishCut')
-- AddEventHandler('Galaxy:finishCut', function()
--     finishCut = true
--     local pedd =PlayerPedId()
--     DoScreenFadeOut(4000)
--     Citizen.Wait(4000)
--     ClearPedTasksImmediately(pedd)
--     SetEntityCoords(pedd, -34.332633972168,-151.11772155762,57.086505889893, 0.0,0.0,0.0, false)
--     TriggerEvent('Galaxy:removeHairdresser')
--     destorycam()
--     destorycam2()
--     Citizen.Wait(4000)
--     DoScreenFadeIn(4000)
--     Citizen.Wait(4000)
-- end)

-- RegisterNetEvent('Galaxy:removeHairdresser')
-- AddEventHandler('Galaxy:removeHairdresser', function()
--     ClearPedTasksImmediately(HairDresser)
--     TaskGoToCoordAnyMeans(HairDresser, -36.586673736572,-156.18775939941,57.076545715332, 1.5, 0, 0, 0, 0)
--     Citizen.Wait(4000)
--     DeleteEntity(HairDresser)
-- end)

-- function gotoChair()
--     if Camera == true then
--         TaskGoToCoordAnyMeans(GetPlayerPed(-1), -31.26,-153.71,56.576538085938, 0.5, 0, 0, 786603, 1.0)
--     end
-- end



function alert(msg) 
    SetTextComponentFormat("STRING")
    AddTextComponentString(msg)
    DisplayHelpTextFromStringLabel(0,0,1,-1)
end

function DrawTxt(text, x, y)
	SetTextFont(0)
	SetTextProportional(1)
	SetTextScale(0.0, 0.4)
	SetTextDropshadow(1, 0, 0, 0, 255)
	SetTextEdge(1, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextOutline()
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x, y)
end