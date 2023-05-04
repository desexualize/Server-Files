local a = {
    {type = "bartender", model = "s_f_y_bartender_01", position = vector4(128.900, -1283.211, 29.273, 123.98)},
    {type = "stripper", model = "mp_f_stripperlite", position = vector4(112.159, -1287.326, 28.459, 265.902)},
    {type = "stripper", model = "mp_f_stripperlite", position = vector4(108.440, -1289.298, 28.859, 338.700)},
    {type = "stripper", model = "mp_f_stripperlite", position = vector4(108.181, -1304.807, 28.769, 186.893)},
    {type = "stripper", model = "mp_f_stripperlite", position = vector4(118.125, -1283.357, 28.277, 124.466)},
    {type = "boucer", model = "s_m_m_bouncer_01", position = vector4(130.328, -1298.409, 29.233, 211.486)},
    {type = "boucer", model = "s_m_m_bouncer_01", position = vector4(127.404, -1300.126, 29.23, 211.587)},
    {type = "boucer", model = "s_m_m_bouncer_01", position = vector4(111.088, -1304.371, 29.020, 296.699)}
}
local b = {
    ["stripper"] = {dict = "mini@strip_club@private_dance@part2", name = "priv_dance_p2"},
    ["bouncer"] = {dict = "mini@strip_club@idles@bouncer@base", name = "base"}
}
local c = nil
local function d()
    c = {}
    for e, f in pairs(a) do
        tARMA.loadModel(f.model)
        local g = f.position
        local h = CreatePed(5, f.model, g.x, g.y, g.z, g.w, false, true)
        SetModelAsNoLongerNeeded(f.model)
        SetBlockingOfNonTemporaryEvents(h, true)
        SetPedCombatAttributes(h, 292, true)
        SetPedDiesWhenInjured(h, false)
        SetPedRelationshipGroupHash(h, "CIVMALE")
        local i = b[f.type]
        if i then
            tARMA.loadAnimDict(i.dict)
            TaskPlayAnim(h, i.dict, i.name, 8.0, 0.0, -1, 1, 0, 0, 0, 0)
            RemoveAnimDict(i.dict)
        end
        table.insert(c, h)
    end
end
local j = vector3(123.43956756592, -1288.5036621094, 29.674297332764)
AddEventHandler("ARMA:onClientSpawn",function(D, E)
    if E then
        local m = function()
            if not c then
                d()
            end
        end
        local n = function()
            if c then
                for e, h in pairs(c) do
                    DeleteEntity(h)
                end
                c = nil
            end
        end
        tARMA.createArea("stripclub", j, 100.0, 6, m, n, nil, {})
    end
end)
