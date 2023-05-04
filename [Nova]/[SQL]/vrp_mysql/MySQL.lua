local MySQL = {}
local Queries = {}

-- Modified Version of MySQL - JamesUK
function MySQL.Create_Command(queryname, query)
    if not Queries[queryname] then 
        Queries[queryname] = query
    else 
        print('VRP_DB_DRIVER: Error query already exists.')
    end 
end

function MySQL.Execute_Command(queryname, variables)
    if Queries[queryname] then 
        if variables then 
            exports['oxmysql']:query(Queries[queryname], variables)
        else 
            exports['oxmysql']:query(Queries[queryname])
        end 
    else 
        print('VRP_DB_DRIVER: Error query does not exist!')
    end 
end

function MySQL.Async_Query(queryname, variables)
    if Queries[queryname] then 
        if variables then 
            local rows = exports['oxmysql']:query_async(Queries[queryname], variables)
            return rows
        end 
    else 
        print('VRP_DB_DRIVER: Error query does not exist!')
        cb({{},nil})
    end 
end

function MySQL.Sync_Query(queryname, variables, cb)
    if Queries[queryname] then 
        if variables then 
            exports['oxmysql']:query(Queries[queryname], variables, function(rows, affected)
                if cb then 
                    cb(rows, affected)
                end 
            end)
        end 
    else 
        print('VRP_DB_DRIVER: Error query does not exist!')
        cb({{},nil})
    end 
end

function MySQL.Single_Query(query)
    exports['oxmysql']:single(query)
end

return MySQL