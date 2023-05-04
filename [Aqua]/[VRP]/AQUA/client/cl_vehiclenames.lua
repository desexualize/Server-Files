local a=module("AQUAVehicles", "garages")
g_vehicleHashToVehicleName={}
for b,c in pairs(a.garages)do 
    for d,e in pairs(c)do 
        if d~="_config"then
            AddTextEntryByHash(GetHashKey(d),e[1])
            g_vehicleHashToVehicleName[GetHashKey(d)]=d 
        end 
    end 
end