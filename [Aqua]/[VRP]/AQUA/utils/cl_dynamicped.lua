local a = {}
local b = 1
function tAQUA.createDynamicPed(c, d, e, f, g, h, i, j, k)
    local c = tAQUA.loadModel(c)
    local l = CreatePed(26, c, d.x, d.y, d.z, e, false, false)
    if not j then
        a[b] = {
            entity = l,
            modelHash = c,
            position = d,
            heading = e,
            static = f,
            animDict = g,
            animName = h,
            minDistance = i,
            distanceToPlayer = 0.0,
            cb = k,
            created = true
        }
        b = b + 1
    else
        a[j].entity = l
    end
    SetModelAsNoLongerNeeded(c)
    if f then
        SetEntityCanBeDamaged(l, 0)
        SetPedAsEnemy(l, 0)
        SetEntityHeading(l, e)
        SetBlockingOfNonTemporaryEvents(l, 1)
        SetPedResetFlag(l, 249, 1)
        SetPedConfigFlag(l, 185, true)
        SetPedConfigFlag(l, 108, true)
        SetPedCanEvasiveDive(l, 0)
        SetPedCanRagdollFromPlayerImpact(l, 0)
        SetPedConfigFlag(l, 208, true)
        SetEntityCollision(l, false)
        FreezeEntityPosition(l, true)
    end
    if g and h then
        tAQUA.loadAnimDict(g)
        TaskPlayAnim(l, g, h, 8.0, 0.0, -1, 1, 0, 0, 0, 0)
    end
    if type(k) == "function" then
        k(l)
    end
    return l
end
Citizen.CreateThread(function()
    Wait(5000)
    while true do
        local m = GetEntityCoords(PlayerPedId())
        for n, o in pairs(a) do
            a[n].distanceToPlayer = #(o.position - m)
            if a[n].distanceToPlayer <= o.minDistance then
                if not o.created then
                    tAQUA.createDynamicPed(
                        o.modelHash,
                        o.position,
                        o.heading,
                        o.static,
                        o.animDict,
                        o.animName,
                        o.minDistance,
                        n,
                        o.cb
                    )
                    a[n].created = true
                end
            else
                if o.created then
                    if DoesEntityExist(o.entity) then
                        DeletePed(o.entity)
                        a[n].created = false
                    end
                end
            end
        end
        Citizen.Wait(1000)
    end
end)
