local MySQL = {}
local Queries = {}

-- Modified Version of MySQL - BW

function MySQL.createCommand(queryname, query)
    if not Queries[queryname] then 
        Queries[queryname] = query
    else 
        print('BW_DB_DRIVER: Error query already exists.'..queryname)
    end 
end

function MySQL.execute(queryname, variables)
    if Queries[queryname] then 
        if variables then 
            exports['ghmattimysql']:execute(Queries[queryname], variables)
        else 
            exports['ghmattimysql']:execute(Queries[queryname])
        end 
    else 
        print('BW_DB_DRIVER: Error query does not exist!'..queryname)
    end 
end




function MySQL.asyncQuery(queryname, variables)
    if Queries[queryname] then 
        if variables then 
            local rows = exports['ghmattimysql']:executeSync(Queries[queryname], variables)
            return rows
        end 
    else 
        print('BW_DB_DRIVER: Error query does not exist!'..queryname)
        cb({{},nil})
    end 
end



function MySQL.query(queryname, variables, cb)
    if Queries[queryname] then 
        if variables then 
            exports['ghmattimysql']:execute(Queries[queryname], variables, function(rows, affected)
                if cb then 
                    cb(rows, affected)
                end 
            end)
        end 
    else 
        print('BW_DB_DRIVER: Error query does not exist!'..queryname)
        cb({{},nil})
    end 
end


function MySQL.SingleQuery(query)
    exports['ghmattimysql']:execute(query)
end

return MySQL
