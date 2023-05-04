local a=true
RegisterCommand("togglecrosshair",function()
    a=not a 
end,false)
local function b()
    if not a then 
        HideHudComponentThisFrame(14)
    end 
end
tARMA.createThreadOnTick(b)