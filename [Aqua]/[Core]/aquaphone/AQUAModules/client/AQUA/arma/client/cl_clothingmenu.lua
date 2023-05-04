RMenu.Add('ARMAclothing','mainMenu',RageUI.CreateMenu("","Clothing Store",tARMA.getRageUIMenuWidth(),tARMA.getRageUIMenuHeight(),"banners","cstore"))
RMenu.Add('ARMAclothing','changePed',RageUI.CreateSubMenu(RMenu:Get('ARMAclothing','mainMenu'),"","Change Gender"))
RMenu.Add('ARMAclothing','changeClothing',RageUI.CreateSubMenu(RMenu:Get('ARMAclothing','mainMenu'),"","Change your Clothes"))
RMenu.Add('ARMAclothing','clearProps',RageUI.CreateSubMenu(RMenu:Get('ARMAclothing','mainMenu'),"","Clear Props"))
local a={{name="Hats / Helmets",index=0,listIndex=1,type="prop",currentListIndex=1,textureN=0},{name="Glasses",index=1,listIndex=1,type="prop",currentListIndex=1,textureN=0},{name="Ear Accessories",index=2,listIndex=1,type="prop",currentListIndex=1,textureN=0},{name="Face",index=0,listIndex=1,type="drawable",currentListIndex=1,textureN=0},{name="Mask",index=1,listIndex=1,type="drawable",currentListIndex=1,textureN=0},{name="Hair",index=2,listIndex=1,type="drawable",currentListIndex=1,textureN=0},{name="Shirts / Jackets",index=11,listIndex=1,type="drawable",currentListIndex=1,textureN=0},{name="Arms / Torso",index=3,listIndex=1,type="drawable",currentListIndex=1,textureN=0},{name="Watches",index=6,listIndex=1,type="prop",currentListIndex=1,textureN=0},{name="Bracelets",index=7,listIndex=1,type="prop",currentListIndex=1,textureN=0},{name="Undershirt",index=8,listIndex=1,type="drawable",currentListIndex=1,textureN=0},{name="Legs",index=4,listIndex=1,type="drawable",currentListIndex=1,textureN=0},{name="Shoes",index=6,listIndex=1,type="drawable",currentListIndex=1,textureN=0},{name="Bags",index=5,listIndex=1,type="drawable",currentListIndex=1,textureN=0},{name="Vests",index=9,listIndex=1,type="drawable",currentListIndex=1,textureN=0},{name="Accessories",index=7,listIndex=1,type="drawable",currentListIndex=1,textureN=0},{name="Badges",index=10,listIndex=1,type="drawable",currentListIndex=1,textureN=0}}
local b
local c=1
local d
local e=0
local f={}
local g={}
local h=false
local i=1
local j=0
local k={}
local l=false
local m=false
local n=false
local o={}
local p=tARMA.getPlayerPed()
local q=false
local r = {
    vector3(72.2545394897461, -1399.10229492188, 29.3761386871338),
    vector3(449.81854248047, -993.30865478516, 30.689584732056),
    vector3(-703.77685546875, -152.258544921875, 37.4151458740234),
    vector3(-167.863754272461, -298.969482421875, 39.7332878112793),
    vector3(428.694885253906, -800.1064453125, 29.4911422729492),
    vector3(-829.413269042969, -1073.71032714844, 11.3281078338623),
    vector3(-1193.42956542969, -772.262329101563, 17.3244285583496),
    vector3(-1447.7978515625, -242.461242675781, 49.8207931518555),
    vector3(11.6323690414429, 6514.224609375, 31.8778476715088),
    vector3(1696.29187011719, 4829.3125, 42.0631141662598),
    vector3(123.64656829834, -219.440338134766, 54.5578384399414),
    vector3(618.093444824219, 2759.62939453125, 42.0881042480469),
    vector3(1190.55017089844, 2713.44189453125, 38.2226257324219),
    vector3(-3172.49682617188, 1048.13330078125, 20.8632030487061),
    vector3(-1108.44177246094, 2708.92358398438, 19.1078643798828),
    vector3(127.57326507568, -1038.4321289063, 29.555480957031),
    vector3(-2152.7907714844, 5231.9516601563, 18.788805007935),
    vector3(1213.8666992188, -1474.5180664063, 35.073650360107),
    vector3(-455.61834716797, 6012.7348632813, 31.7164478302),
    vector3(1439.3804931641, 6331.80078125, 23.954704284668),
    vector3(-1098.4307861328, -831.42083740234, 14.282784461975),
    vector3(243.71351623535, -1370.1625976563, 39.534339904785),
    vector3(1103.0277099609, 197.00813293457, -49.440055847168),
    vector3(298.98516845703, -598.02362060547, 43.284023284912),
    vector3(1839.0124511719, 3689.259765625, 34.270027160645),
    vector3(-253.41467285156, 6309.4458007813, 32.427234649658),
    vector3(902.40808105469, -2115.2661132813, 30.771173477173),
    vector3(-565.46356201172, 287.12573242188, 91.797775268555),
    vector3(1780.2961425781, 2547.8825683594, 45.797790527344),
    vector3(4489.6123046875, -4452.7778320312, 4.366425037384),
    vector3(-443.05731201172, -311.21786499023, 34.910472869873),
    vector3(277.69772338867, -1335.5568847656, 24.537786483765)
}
local s=1
local t=false
local u=false
local v={
    ["Hats / Helmets"]={offset=vector3(0.0,0.5,0.8),point=vector3(0.0,0.0,0.7),fov=60.0},
    ["Glasses"]={offset=vector3(0.0,0.5,0.68),point=vector3(0.0,0.0,0.68),fov=50.0},
    ["Ear Accessories"]={offset=vector3(0.0,0.5,0.68),point=vector3(0.0,0.0,0.68),fov=50.0},
    ["Face"]={offset=vector3(0.0,0.5,0.68),point=vector3(0.0,0.0,0.68),fov=50.0},
    ["Mask"]={offset=vector3(0.0,0.5,0.8),point=vector3(0.0,0.0,0.7),fov=60.0},
    ["Hair"]={offset=vector3(0.0,0.5,0.8),point=vector3(0.0,0.0,0.7),fov=60.0},
    ["Shirts / Jackets"]={offset=vector3(0.0,1.0,0.3),point=vector3(0.0,0.0,0.3),fov=70.0},
    ["Arms / Torso"]={offset=vector3(0.0,1.0,0.3),point=vector3(0.0,0.0,0.3),fov=70.0},
    ["Watches"]={offset=vector3(0.0,0.8,0.0),point=vector3(0.0,0.0,0.0),fov=60.0},
    ["Bracelets"]={offset=vector3(0.0,0.8,0.0),point=vector3(0.0,0.0,0.0),fov=60.0},
    ["Undershirt"]={offset=vector3(0.0,1.0,0.3),point=vector3(0.0,0.0,0.3),fov=70.0},
    ["Legs"]={offset=vector3(0.0,1.0,-0.4),point=vector3(0.0,0.0,-0.4),fov=70.0},
    ["Shoes"]={offset=vector3(0.0,0.6,-0.5),point=vector3(0.0,0.0,-0.9),fov=60.0},
    ["Bags"]={offset=vector3(0.0,1.0,0.3),point=vector3(0.0,0.0,0.3),fov=70.0},
    ["Vests"]={offset=vector3(0.0,1.0,0.3),point=vector3(0.0,0.0,0.3),fov=70.0},
    ["Accessories"]={offset=vector3(0.0,1.2,0.3),point=vector3(0.0,0.0,0.2),fov=80.0},
    ["Badges"]={offset=vector3(0.0,1.2,0.3),point=vector3(0.0,0.0,0.2),fov=80.0}
}
local w=nil
local x=nil
local y=nil
local z=nil
local function A()
    if k.name~=z then 
        if v[k.name]then 
            local B=v[k.name]
            local C=GetEntityCoords(PlayerPedId(),true)+x*B.offset.y+vector3(0.0,0.0,B.offset.z)
            SetCamParams(w,C.x,C.y,C.z,0.0,0.0,0.0)
            SetCamFov(w,B.fov)
            PointCamAtEntity(w,PlayerPedId(),B.point.x,B.point.y,B.point.z)
        else 
        end
        z=k.name 
    end
    if not IsPauseMenuActive()then 
        DisableAllControlActions(0)
        EnableControlAction(0,0,true)
        EnableControlAction(0,1,true)
        EnableControlAction(0,2,true)
        EnableControlAction(0,3,true)
        EnableControlAction(0,4,true)
        EnableControlAction(0,5,true)
        EnableControlAction(0,6,true)
        EnableControlAction(0,30,true)
        EnableControlAction(0,31,true)
        EnableControlAction(0,32,true)
        EnableControlAction(0,33,true)
        EnableControlAction(0,34,true)
        EnableControlAction(0,35,true)
        EnableControlAction(0,249,true)
        EnableControlAction(0,289,true)
    end
    DisableControlAction(0,32,true)
    if IsDisabledControlJustPressed(0,32)then 
        TaskAchieveHeading(PlayerPedId(),y+180.0,-1)
    end
    DisableControlAction(0,34,true)
    if IsDisabledControlJustPressed(0,34)then 
        TaskAchieveHeading(PlayerPedId(),y-90.0,-1)
    end
    DisableControlAction(0,33,true)
    if IsDisabledControlJustPressed(0,33)then 
        TaskAchieveHeading(PlayerPedId(),y,-1)
    end
    DisableControlAction(0,35,true)
    if IsDisabledControlJustPressed(0,35)then 
        TaskAchieveHeading(PlayerPedId(),y+90.0,-1)
    end 
end
local function D()
    local E=PlayerPedId()
    ClearPedTasksImmediately(E)
    x=GetEntityForwardVector(E)
    y=GetEntityHeading(E)
    TaskAchieveHeading(E,y,-1)
    w=CreateCam("DEFAULT_SCRIPTED_CAMERA",false)
    SetCamActive(w,true)
    RenderScriptCams(true,false,0,false,false)
    A()
end
local function F()
    if not w then 
        return 
    end
    ClearPedTasksImmediately(PlayerPedId())
    RenderScriptCams(false,false,0,false,false)
    SetCamActive(w,false)
    DestroyCam(w,true)
    w=nil
    x=nil
    y=nil
    z=nil 
end

Citizen.CreateThread(function()
    while true do 
        local G=GetEntityCoords(tARMA.getPlayerPed())
        for H=1,#r do 
            if#(G-r[H])<=2.5 and not t then 
                s=H
                t=true
                for H=1,#a,1 do 
                    a[H].currentListIndex=current_clothing(a[H].type,a[H].index,false)
                    a[H].textureN=current_clothing(a[H].type,a[H].index,true)
                end
                h=true
                RageUI.Visible(RMenu:Get('ARMAclothing','mainMenu'),true)
            elseif s==H then 
                if#(G-r[H])>2.5 and t then 
                    t=false
                    m=false
                    RageUI.ActuallyCloseAll()
                end
                if not RageUI.Visible(RMenu:Get('ARMAclothing','changeClothing'))then 
                    F()
                end 
            end 
        end
        Wait(150)
    end 
end)
local I,J,K=0,0,0

RageUI.CreateWhile(1.0, true, function()
    if not n then
        if RageUI.Visible(RMenu:Get('ARMAclothing', 'mainMenu')) then
            RageUI.DrawContent({ header = true, glare = false, instructionalButton = false}, function()
                RageUI.Button('Clothes',nil,{RightLabel=">>>"},true,function(L,M,N)
                    if N then 
                        D()
                    end 
                end,RMenu:Get('ARMAclothing','changeClothing'))
                if not inOrganHeist then
                    RageUI.Button('Change Gender',nil,{RightLabel=">>>"},true,function(L,M,N)
                    end,RMenu:Get('ARMAclothing','changePed'))
                end
                RageUI.Button('~y~Wardrobe',nil,{RightLabel=">>>"},true,function(L,M,N)
                    if N then 
                        if tARMA.isPlusClub()or tARMA.isPlatClub()then
                            TriggerEvent("ARMA:openOutfitMenu")
                        else 
                            tARMA.notify("~y~You need to be a subscriber of ARMA Plus or ARMA Platinum to use this feature.")
                            tARMA.notify("~y~Available @ store.armarp.co.uk")
                        end 
                    end 
                end)
                RageUI.Button('Apply Outfit Code','Applys an outfit code given by a player with ~y~ARMA Plus~w~ or ~y~ARMA Platinum~w~.',{RightLabel=">>>"},true,function(L,M,N)
                    if N then 
                        tARMA.clientPrompt("Outfit Code:","",function(Q)
                            local R = string.gsub(Q, "%s+", "")
                            if #R == 5 then
                                TriggerServerEvent("ARMA:applyOutfitCode", string.upper(R))
                            else
                                notify("~r~Outfit code is not in a valid format.")
                            end
                        end)
                    end 
                end)
                RageUI.Button('Remove Props',nil,{RightLabel=">>>"},true,function(L,M,N)
                end,RMenu:Get('ARMAclothing','clearProps'))
            end)
        end
        if RageUI.Visible(RMenu:Get('ARMAclothing', 'changePed')) then
            RageUI.DrawContent({ header = true, glare = false, instructionalButton = false}, function()
                RageUI.Button('MP Male','WARNING: Resets all your Body Options',{},true,function(L,M,N)
                    if N then 
                        if GetEntityHealth(PlayerPedId()) > 102 then
                            tARMA.loadCustomisationPreset("DefaultMale")
                        else
                            tARMA.notify("~r~Cannot change gender, you're dead.")
                        end
                    end 
                end,function()
                end)
                RageUI.Button('MP Female','WARNING: Resets all your Body Options',{},true,function(L,M,N)
                    if N then 
                        if GetEntityHealth(PlayerPedId()) > 102 then
                            tARMA.loadCustomisationPreset("DefaultFemale")
                        else
                            tARMA.notify("~r~Cannot change gender, you're dead.")
                        end
                    end 
                end,function()
                end)
            end)
        end
        if RageUI.Visible(RMenu:Get('ARMAclothing', 'changeClothing')) then
            RageUI.DrawContent({ header = true, glare = false, instructionalButton = false}, function()
                m=true
                if h then 
                    for H=1,#a,1 do 
                        local P=a[H]k=P
                        k.textureN=current_clothing(P.type,P.index,true)
                        if k.textureN==-1 then 
                            k.textureN=0 
                        end
                        RageUI.List(P.name,get_drawables(P.type,P.index),a[H].currentListIndex,"Current Texture Index: "..k.textureN.."/"..j-1,{},true,function(L,M,N,Q)
                            if M then 
                                a[H].currentListIndex=current_clothing(P.type,P.index,false)
                                if IsControlJustPressed(0,172)or IsControlJustPressed(0,241)or IsControlJustPressed(0,173)or IsControlJustPressed(0,242)then 
                                    if P.index~=k.index then 
                                        k=P 
                                    end 
                                end
                                if P.name==k.name then 
                                    local p=tARMA.getPlayerPed()
                                    if l then 
                                        if o~=nil and o["id"]<=#get_drawables(P.type,P.index)and o["id"]>=0 then 
                                            Q=o["id"]
                                            k.textureN=0
                                            l=false 
                                        else 
                                            l=false 
                                        end 
                                    else 
                                        if k.textureN>=get_textures(k.type,k.index,Q)then 
                                            k.textureN=0 
                                        end
                                        if I~=k.index or J~=Q or K~=k.textureN then 
                                            I=k.index
                                            J=Q
                                            K=k.textureN
                                            set_clothing(k.type,k.index,Q,k.textureN)
                                        end 
                                    end
                                    a[H].currentListIndex=Q 
                                end
                                A()
                            end
                            if N then 
                                k.textureN=k.textureN+1
                                if k.textureN>=get_textures(k.type,k.index,Q)then 
                                    k.textureN=0 
                                end
                                if k.index==2 then 
                                    I=k.index
                                    J=Q
                                    K=k.textureN
                                    SetPedHairColor(PlayerPedId(),k.textureN,k.textureN)
                                    TriggerServerEvent("ARMA:saveClothingHairData",GetPedDrawableVariation(tARMA.getPlayerPed(),2),GetPedHairColor(tARMA.getPlayerPed()))
                                elseif I~=k.index or J~=Q or K~=k.textureN then 
                                    I=k.index
                                    J=Q
                                    K=k.textureN
                                    set_clothing(k.type,k.index,Q,k.textureN)
                                end 
                            end 
                        end,function()
                        end,nil)
                    end 
                end 
            end)
        end
        if RageUI.Visible(RMenu:Get('ARMAclothing', 'clearProps')) then
            RageUI.DrawContent({ header = true, glare = false, instructionalButton = false}, function()
                RageUI.Button('Remove Hat',nil,{},true,function(L,M,N)
                    if N then 
                        ClearPedProp(tARMA.getPlayerPed(),0)
                    end 
                end,function()
                end,nil)
                RageUI.Button('Remove Glasses',nil,{},true,function(L,M,N)
                    if N then 
                        ClearPedProp(tARMA.getPlayerPed(),1)
                    end 
                end,function()
                end,nil)
                RageUI.Button('Remove Ear Accessory',nil,{},true,function(L,M,N)
                    if N then 
                        ClearPedProp(tARMA.getPlayerPed(),2)
                    end 
                end,function()
                end,nil)
                RageUI.Button('Remove Watch',nil,{},true,function(L,M,N)
                    if N then 
                        ClearPedProp(tARMA.getPlayerPed(),6)
                    end 
                end,function()
                end,nil)
                RageUI.Button('Remove Bracelet',nil,{},true,function(L,M,N)
                    if N then 
                        ClearPedProp(tARMA.getPlayerPed(),7)
                    end 
                end,function()
                end,nil)
            end)
        end
    end
end)
function current_clothing(R,i,S)
    if R=="prop"then 
        if S then 
            if GetPedPropTextureIndex(tARMA.getPlayerPed(),i)~=nil then 
                return GetPedPropTextureIndex(tARMA.getPlayerPed(),i)
            else 
                return 0 
            end 
        else 
            if GetPedPropIndex(tARMA.getPlayerPed(),i)~=nil then 
                if GetPedPropIndex(tARMA.getPlayerPed(),i)==-1 then 
                    return GetPedPropIndex(tARMA.getPlayerPed(),i)+2 
                else 
                    return GetPedPropIndex(tARMA.getPlayerPed(),i)+1 
                end 
            else 
                return 0 
            end 
        end 
    elseif R=="drawable"then 
        if i==2 and S then 
            return GetPedHairColor(PlayerPedId())
        elseif S then 
            if GetPedTextureVariation(tARMA.getPlayerPed(),i)~=nil then 
                return GetPedTextureVariation(tARMA.getPlayerPed(),i)
            else 
                return 0 
            end 
        else 
            if GetPedDrawableVariation(tARMA.getPlayerPed(),i)~=nil then 
                return GetPedDrawableVariation(tARMA.getPlayerPed(),i)+1 
            else 
                return 0 
            end 
        end 
    end 
end
function set_clothing(T,U,i,V)
    local p=tARMA.getPlayerPed()
    if T=="drawable"then 
        if U==2 then 
            V=0 
        end
        SetPedComponentVariation(p,U,i-1,V,0)
        if U==2 then 
            TriggerServerEvent("ARMA:saveClothingHairData",GetPedDrawableVariation(tARMA.getPlayerPed(),2),GetPedHairColor(tARMA.getPlayerPed()))
        end 
    elseif T=="prop"then 
        if i-1==0 then 
            if GetPedPropIndex(p,U)==0 then 
                ClearPedProp(p,i-1)
            end 
        else SetPedPropIndex(p,U,i-1,V,0)
        end 
    end 
end
function get_drawables(T,R)
    local p=tARMA.getPlayerPed()
    local W=GetNumberOfPedDrawableVariations(p,R)
    local X=GetNumberOfPedPropDrawableVariations(p,R)
    if T=="drawable"then 
        local d={"0/"..W}
        for H=1,GetNumberOfPedDrawableVariations(p,R),1 do 
            d[#d+1]=H.."/"..W 
        end
        return d 
    else 
        local d={"0/"..X}
        for H=1,GetNumberOfPedPropDrawableVariations(p,R),1 do 
            d[#d+1]=H.."/"..X 
        end
        return d 
    end 
end
function get_facial_features(R)
    numberOfOverlays={}
    for H=1,GetPedHeadOverlayNum(R),1 do 
        table.insert(numberOfOverlays,H)
    end
    return numberOfOverlays 
end
function get_textures(T,R,i)
    if T=="drawable"then 
        if R==2 then 
            j=GetNumHairColors()
            return j 
        end
        j=GetNumberOfPedTextureVariations(tARMA.getPlayerPed(),R,i-1)
        return j 
    else 
        j=GetNumberOfPedPropTextureVariations(tARMA.getPlayerPed(),R,i-1)
        return j 
    end 
end
local function Y()
    AddTextEntry('FMMC_MPM_NA',"Enter clothing ID you want to wear")
    DisplayOnscreenKeyboard(1,"FMMC_MPM_NA","Enter clothing ID you want to wear","","","","",30)
    while UpdateOnscreenKeyboard()==0 do 
        Wait(0)
    end
    if GetOnscreenKeyboardResult()then 
        local Z=GetOnscreenKeyboardResult()
        if Z then 
            n=false
            local _=tonumber(Z)
            local p=tARMA.getPlayerPed()
            if _~=nil then 
                o["id"]=_+1 
            else 
                o["id"]=k.index 
            end
            l=true
            return Z 
        end 
    end
    n=false 
end
Citizen.CreateThread(function()
    while true do 
        if k.index~=nil and RageUI.Visible(RMenu:Get('ARMAclothing','changeClothing'))then 
            if IsDisabledControlJustPressed(0,179)and not n then 
                n=true
                Y()
            end 
        end
        Citizen.Wait(0)
    end 
end)
local function a0()
    local a1={
        {
            ["label"]="Enter Clothing ID ",
            ["button"]="~INPUT_CELLPHONE_EXTRA_OPTION~"
        },
        {
            ["label"]="Change Texture ",
            ["button"]="~INPUT_CELLPHONE_SELECT~"
        },
        {
            ["label"]="Next Index ",
            ["button"]="~INPUT_CELLPHONE_RIGHT~"
        },
        {
            ["label"]="Previous Index ",
            ["button"]="~INPUT_CELLPHONE_LEFT~"
        },
        {
            ["label"]="Face Right",
            ["button"]="~INPUT_MOVE_RIGHT_ONLY~"
        },
        {
            ["label"]="Face Left",
            ["button"]="~INPUT_MOVE_LEFT_ONLY~"
        },
        {
            ["label"]="Face Forward",
            ["button"]="~INPUT_MOVE_DOWN_ONLY~"
        },
        {
            ["label"]="Face Backward",
            ["button"]="~INPUT_MOVE_UP_ONLY~"
        }
    }
    Citizen.CreateThread(function()
        Wait(0)
        local a2=RequestScaleformMovie("instructional_buttons")
        while not HasScaleformMovieLoaded(a2)do 
            Wait(0)
        end
        PushScaleformMovieFunction(a2,"CLEAR_ALL")
        PushScaleformMovieFunction(a2,"TOGGLE_MOUSE_BUTTONS")
        PushScaleformMovieFunctionParameterBool(0)
        PopScaleformMovieFunctionVoid()
        for a3,a4 in ipairs(a1)do 
            PushScaleformMovieFunction(a2,"SET_DATA_SLOT")
            PushScaleformMovieFunctionParameterInt(a3-1)
            PushScaleformMovieMethodParameterButtonName(a4["button"])
            PushScaleformMovieFunctionParameterString(a4["label"])
            PopScaleformMovieFunctionVoid()
        end
        PushScaleformMovieFunction(a2,"DRAW_INSTRUCTIONAL_BUTTONS")
        PushScaleformMovieFunctionParameterInt(-1)
        PopScaleformMovieFunctionVoid()
        while m do 
            Wait(0)
            DrawScaleformMovieFullscreen(a2,255,255,255,255)
        end
        u=false 
    end)
end
Citizen.CreateThread(function()
    while true do 
        if m and not u then 
            a0()
            u=true 
        end
        Wait(0)
    end 
end)

AddEventHandler("ARMA:onClientSpawn",function(D, E)
    if E then
		for a7,a8 in pairs(r)do 
            tARMA.addBlip(a8.x,a8.y,a8.z,73,3,"Clothing Store",0.7)
            tARMA.addMarker(a8.x,a8.y,a8.z,0.6,0.6,0.6,10,255,81,170,50,9,false,false,true,"dp_clothing","top",90.0,90.0,0.0)
        end 
	end
end)
