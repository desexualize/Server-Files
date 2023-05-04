local a=false
local b={}
SetNuiFocus(false,false)
local c, d, e, f, g = {}, {}, {}, {}, {}
RegisterNetEvent("ARMA:gotJobTypes",function(nhs, pd, lfb, hmp, cid)
    c = nhs
    d = pd
    e = lfb
    f = hmp
    g = cid
end)

function tARMA.getJobType(i)
    jobGroups = tARMA.getCurrentPlayerInfo('jobs')
    if jobGroups then
        for a,b in pairs(jobGroups) do
            if b.user_id == i then
                for k,v in pairs(b.jobs) do
                    if c[k] and k == "HEMS Clocked" then 
                        return "hems"
                    elseif c[k] then
                        return "nhs"
                    elseif d[k] and k == "NPAS Clocked" then
                        return "npas" 
                    elseif d[k] then
                        return "metpd"
                    elseif e[k] then
                        return "lfb"
                    elseif f[k] then
                        return "hmp"
                    elseif g[k] then
                        return "cid"
                    end 
                end
                return ""
            end
        end
        return ""
    end
end