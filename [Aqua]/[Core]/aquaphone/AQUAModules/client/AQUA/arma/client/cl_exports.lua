local a
local P=false
local function b(c,d,e,f)
    if f==nil then 
        f=function()
        end 
    end
    if a then 
        SendNUIMessage({act="close_prompt"})
        while a do 
            Wait(0)
        end 
    end
    SendNUIMessage({act="open_prompt",type=e,title=c,text=tostring(d)})
    SetNuiFocus(true)
    a=f
    P=true
end
RegisterNUICallback("prompt",function(g,f)
    if g.act=="close"then 
        if a then 
            a(g.result)
            a=nil 
        end 
    end 
end)
function tARMA.clientPrompt(c,d,f)
    b(c,d,"client",f)
end
function tARMA.prompt(c,d)
    b(c,d,"server",nil)
end
RegisterNUICallback("prompt",function(g,f)
    if g.act=="close" and P then 
        SetNuiFocus(false)
        P=false
        if g.type~="client"then 
            ARMAserver.promptResult({g.result})
        end 
    end 
end)

function tARMA.CopyToClipBoard(text)
    SendNUIMessage({copytoboard = text})
end
function tARMA.OpenUrl(link)
    SendNUIMessage({act="openurl", url = link})
end

RegisterNUICallback("ClosePrompt",function()
    if P then 
        SendNUIMessage({act="close_prompt"})
        SetNuiFocus(false)
        a=nil
        P=false
    end 
end)

exports("prompt",tARMA.clientPrompt)
exports("copytoboard",tARMA.CopyToClipBoard)
exports("playSound",function(h)
    SendNUIMessage({transactionType=h})
end)