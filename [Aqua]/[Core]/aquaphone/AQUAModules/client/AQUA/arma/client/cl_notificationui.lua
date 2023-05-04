local a = {
    ["top-left"] = {top = 10, right = 1450},
    ["bottom-left"] = {top = 1000, right = 1450},
    ["top-right"] = {top = 10, right = 10},
    ["bottom-right"] = {top = 1000, right = 10}
}
local b={
    ["success"]="fas fa-check",
    ["bad"]="fas fa-times"
}
local function c(d, e)
    SendNUIMessage({show = true, options = d, pos = a[d.pos], icon = b[d.icon] or ""})
    Citizen.Wait(e or 15000)
    SendNUIMessage({show = false, options = d})
end
RegisterNetEvent("ARMA:showNotification",function(d, e)
    c(d, e)
end)
