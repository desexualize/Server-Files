local a=module("cfg/cfg_crosshair")
local b=false
RMenu.Add('crosshair','main',RageUI.CreateMenu("","~b~ARMA Crosshair Customisation ",tARMA.getRageUIMenuWidth(),tARMA.getRageUIMenuHeight(),"banners","crosshair"))
RageUI.CreateWhile(1.0, true, function()
    if RageUI.Visible(RMenu:Get('crosshair', 'main')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = false}, function()
            if not b then 
                b=true 
            end
            RageUI.Checkbox("Use Custom Crosshair","",a.options.enabled==1,{},function()
            end,function()
                a.options.enabled=1
                saveCrosshair()
            end,function()
                a.options.enabled=0
                saveCrosshair()
            end)
            if a.options.enabled==1 then 
                RageUI.List("Center Dot",{"Enabled","Disabled"},a.options.centerDotEnabled,nil,{},true,function(c,d,e,f)
                    if d and a.options.centerDotEnabled~=f then 
                        a.options.centerDotEnabled=f
                        saveCrosshair()
                    end 
                end)
                RageUI.List("Visibility",{"Always","While Aiming"},a.options.visibility,nil,{},true,function(c,d,e,f)
                    if d and a.options.visibility~=f then 
                        a.options.visibility=f
                        saveCrosshair()
                    end 
                end)
                RageUI.List("Length",a.menu.length.labels,a.options.length.index,nil,{},true,function(c,d,e,f)
                    if d and a.options.length.index~=f then 
                        a.options.length.index=f
                        a.options.length.value=0.001+f*0.001
                        saveCrosshair()
                    end 
                end)
                RageUI.List("Thickness",a.menu.thickness.labels,a.options.thickness.index,nil,{},true,function(c,d,e,f)
                    if d and a.options.thickness.index~=f then 
                        a.options.thickness.index=f
                        a.options.thickness.value=0.002*f
                        saveCrosshair()
                    end 
                end)
                RageUI.List("Gap",a.menu.gap.labels,a.options.gap.index,nil,{},true,function(c,d,e,f)
                    if d and a.options.gap.index~=f then 
                        a.options.gap.index=f
                        a.options.gap.value=f*0.0005-0.0005
                        saveCrosshair()
                    end 
                end)
                RageUI.SliderProgress("Red ["..a.options.colour.red.."]",a.options.colour.red,255,"Press ~b~SPACE~w~ to enter RGB Red value",{ProgressBackgroundColor={R=186,G=58,B=48,A=255},ProgressColor={R=212,G=66,B=55,A=255}},true,function(c,e,d,f)
                    if e then 
                        if IsControlJustPressed(0,22)then 
                            local r = getInput("Enter Green Value (0-255)",a.options.colour.red)
                            if r ~= nil then 
                                a.options.colour.red = r
                            end
                            saveCrosshair()
                        else 
                            if f~=a.options.colour.red then 
                                a.options.colour.red=f
                                saveCrosshair()
                            end 
                        end 
                    end 
                end)
                RageUI.SliderProgress("Green ["..a.options.colour.green.."]",a.options.colour.green,255,"Press ~b~SPACE~w~ to enter RGB Green value",{ProgressBackgroundColor={R=48,G=186,B=108,A=255},ProgressColor={R=64,G=230,B=136,A=255}},true,function(c,e,d,f)
                    if e then 
                        if IsControlJustPressed(0,22)then 
                            local g = getInput("Enter Green Value (0-255)",a.options.colour.green)
                            if g ~= nil then 
                                a.options.colour.green = g
                            end
                            saveCrosshair()
                        else 
                            if f~=a.options.colour.green then 
                                a.options.colour.green=f
                                saveCrosshair()
                            end 
                        end 
                    end 
                end)
                RageUI.SliderProgress("Blue ["..a.options.colour.blue.."]",a.options.colour.blue,255,"Press ~b~SPACE~w~ to enter RGB Blue value",{ProgressBackgroundColor={R=48,G=69,B=186,A=255},ProgressColor={R=59,G=86,B=237,A=255}},true,function(c,e,d,f)
                    if e then 
                        if IsControlJustPressed(0,22)then 
                            local b = getInput("Enter Green Value (0-255)",a.options.colour.blue)
                            if b ~= nil then 
                                a.options.colour.blue = b
                            end
                            saveCrosshair()
                        else 
                            if f~=a.options.colour.blue then a.options.colour.blue=f
                                saveCrosshair()
                            end 
                        end 
                    end 
                end)
            end 
       end)
    end
end)

Citizen.CreateThread(function()
    loadCrosshairKvp()
    while true do 
        Wait(0)
        if a.options.enabled==1 then 
            if RageUI.Visible(RMenu:Get('crosshair','main'))or a.options.visibility==1 then 
                if not(IsPlayerFreeAiming(PlayerId())and doesWeaponHaveScope())then 
                    drawCrosshair()
                end 
            else 
                if IsPlayerFreeAiming(PlayerId())then 
                    if not doesWeaponHaveScope()then 
                        drawCrosshair()
                    end 
                end 
            end 
        end 
    end 
end)
function drawCrosshair()
    local g=GetAspectRatio()
    if a.options.centerDotEnabled==1 then 
        DrawRect(0.5,0.5,a.options.thickness.value/2,a.options.thickness.value/2*g,a.options.colour.red,a.options.colour.green,a.options.colour.blue,255)
    end
    DrawRect(0.5-a.options.gap.value-a.options.length.value/2,0.5,a.options.length.value,a.options.thickness.value,a.options.colour.red,a.options.colour.green,a.options.colour.blue,255)
    DrawRect(0.5+a.options.gap.value+a.options.length.value/2,0.5,a.options.length.value,a.options.thickness.value,a.options.colour.red,a.options.colour.green,a.options.colour.blue,255)
    DrawRect(0.5,0.5-a.options.gap.value*g-a.options.length.value*g/2,a.options.thickness.value/g,a.options.length.value*g,a.options.colour.red,a.options.colour.green,a.options.colour.blue,255)
    DrawRect(0.5,0.5+a.options.gap.value*g+a.options.length.value*g/2,a.options.thickness.value/g,a.options.length.value*g,a.options.colour.red,a.options.colour.green,a.options.colour.blue,255)
    HideHudComponentThisFrame(14)
end
RegisterCommand("crosshair",function(h,i,j)
    RageUI.ActuallyCloseAll()
    RageUI.Visible(RMenu:Get('crosshair','main'),true)
end)
function doesWeaponHaveScope()
    local o=GetCurrentPedWeaponEntityIndex(PlayerPedId())
    local p={
        "component_at_scope_large",
        "component_at_scope_large_mk2",
        "component_at_scope_max",
        "component_at_scope_large_fixed_zoom",
        "component_at_scope_large_fixed_zoom_mk2",
        "component_m700_scope_large"
    }
    for q,r in ipairs(p)do 
        if HasWeaponGotWeaponComponent(o,r)then 
            return true 
        end 
    end
    return false 
end