MySQL = module("aqua_mysql", "MySQL")

local Proxy = module("lib/Proxy")
local Tunnel = module("lib/Tunnel")
local Lang = module("lib/Lang")
Debug = module("lib/Debug")

local config = module("cfg/base")
local version = module("version")

Debug.active = config.debug
AQUA = {}
Proxy.addInterface("AQUA",AQUA)

tAQUA = {}
Tunnel.bindInterface("AQUA",tAQUA) -- listening for client tunnel

-- load language 
local dict = module("cfg/lang/"..config.lang) or {}
AQUA.lang = Lang.new(dict)

-- init
AQUAclient = Tunnel.getInterface("AQUA","AQUA") -- server -> client tunnel

AQUA.users = {} -- will store logged users (id) by first identifier
AQUA.rusers = {} -- store the opposite of users
AQUA.user_tables = {} -- user data tables (logger storage, saved to database)
AQUA.user_tmp_tables = {} -- user tmp data tables (logger storage, not saved)
AQUA.user_sources = {} -- user sources 
-- queries
Citizen.CreateThread(function()
    Wait(1000) -- Wait for GHMatti to Initialize
    MySQL.SingleQuery([[
    CREATE TABLE IF NOT EXISTS aqua_users(
    id INTEGER AUTO_INCREMENT,
    last_login VARCHAR(100),
    username VARCHAR(100),
    whitelisted BOOLEAN,
    banned BOOLEAN,
    bantime VARCHAR(100) NOT NULL DEFAULT "",
    banreason VARCHAR(1000) NOT NULL DEFAULT "",
    banadmin VARCHAR(100) NOT NULL DEFAULT "",
    CONSTRAINT pk_user PRIMARY KEY(id)
    );
    ]])
    MySQL.SingleQuery([[
    CREATE TABLE IF NOT EXISTS aqua_user_ids (
    identifier VARCHAR(100) NOT NULL,
    user_id INTEGER,
    banned BOOLEAN,
    CONSTRAINT pk_user_ids PRIMARY KEY(identifier)
    );
    ]])
    MySQL.SingleQuery([[
    CREATE TABLE IF NOT EXISTS aqua_user_tokens (
    token VARCHAR(200),
    user_id INTEGER,
    banned BOOLEAN  NOT NULL DEFAULT 0,
    CONSTRAINT pk_user_tokens PRIMARY KEY(token)
    );
    ]])
    MySQL.SingleQuery([[
    CREATE TABLE IF NOT EXISTS aqua_user_data(
    user_id INTEGER,
    dkey VARCHAR(100),
    dvalue TEXT,
    CONSTRAINT pk_user_data PRIMARY KEY(user_id,dkey),
    CONSTRAINT fk_user_data_users FOREIGN KEY(user_id) REFERENCES aqua_users(id) ON DELETE CASCADE
    );
    ]])
    MySQL.SingleQuery([[
    CREATE TABLE IF NOT EXISTS aqua_srv_data(
    dkey VARCHAR(100),
    dvalue TEXT,
    CONSTRAINT pk_srv_data PRIMARY KEY(dkey)
    );
    ]])
    MySQL.SingleQuery([[
    CREATE TABLE IF NOT EXISTS aqua_user_moneys(
    user_id INTEGER,
    wallet bigint,
    bank bigint,
    CONSTRAINT pk_user_moneys PRIMARY KEY(user_id),
    CONSTRAINT fk_user_moneys_users FOREIGN KEY(user_id) REFERENCES aqua_users(id) ON DELETE CASCADE
    );
    ]])
    MySQL.SingleQuery([[
    CREATE TABLE IF NOT EXISTS aqua_user_vehicles(
    user_id INTEGER,
    vehicle VARCHAR(100),
    vehicle_plate varchar(255) NOT NULL,
    rented BOOLEAN NOT NULL DEFAULT 0,
    rentedid varchar(200) NOT NULL DEFAULT '',
    rentedtime varchar(2048) NOT NULL DEFAULT '',
    locked BOOLEAN NOT NULL DEFAULT 0,
    CONSTRAINT pk_user_vehicles PRIMARY KEY(user_id,vehicle),
    CONSTRAINT fk_user_vehicles_users FOREIGN KEY(user_id) REFERENCES aqua_users(id) ON DELETE CASCADE
    );
    ]])
    MySQL.SingleQuery([[
    CREATE TABLE IF NOT EXISTS aqua_user_homes(
    user_id INTEGER,
    home VARCHAR(100),
    number INTEGER,
    CONSTRAINT pk_user_homes PRIMARY KEY(home),
    CONSTRAINT fk_user_homes_users FOREIGN KEY(user_id) REFERENCES aqua_users(id) ON DELETE CASCADE,
    UNIQUE(home,number)
    );
    ]])
    MySQL.SingleQuery([[
    CREATE TABLE IF NOT EXISTS aqua_user_identities(
    user_id INTEGER,
    registration VARCHAR(100),
    phone VARCHAR(100),
    firstname VARCHAR(100),
    name VARCHAR(100),
    age INTEGER,
    CONSTRAINT pk_user_identities PRIMARY KEY(user_id),
    CONSTRAINT fk_user_identities_users FOREIGN KEY(user_id) REFERENCES aqua_users(id) ON DELETE CASCADE,
    INDEX(registration),
    INDEX(phone)
    );
    ]])
    MySQL.SingleQuery([[
    CREATE TABLE IF NOT EXISTS aqua_warnings (
    warning_id INT AUTO_INCREMENT,
    user_id INT,
    warning_type VARCHAR(25),
    duration INT,
    admin VARCHAR(100),
    warning_date DATE,
    reason VARCHAR(2000),
    PRIMARY KEY (warning_id)
    )
    ]])
    MySQL.SingleQuery([[
    CREATE TABLE IF NOT EXISTS aqua_user_notes (
    note_id INT AUTO_INCREMENT,
    user_id INT,
    text VARCHAR(250),
    admin_name VARCHAR(250),
    admin_id INT,
    PRIMARY KEY (note_id)
    )
    ]])
    MySQL.SingleQuery([[
    CREATE TABLE IF NOT EXISTS AQUA_gangs (
    gangname VARCHAR(3000) NULL DEFAULT NULL,
    gangmembers VARCHAR(3000) NULL DEFAULT NULL,
    funds BIGINT NULL DEFAULT NULL,
    logs VARCHAR(3000) NULL DEFAULT NULL
    )
    ]])
    MySQL.SingleQuery("ALTER TABLE aqua_users ADD IF NOT EXISTS bantime varchar(100) NOT NULL DEFAULT '';")
    MySQL.SingleQuery("ALTER TABLE aqua_users ADD IF NOT EXISTS banreason varchar(100) NOT NULL DEFAULT '';")
    MySQL.SingleQuery("ALTER TABLE aqua_users ADD IF NOT EXISTS banadmin varchar(100) NOT NULL DEFAULT ''; ")
    MySQL.SingleQuery("ALTER TABLE aqua_user_vehicles ADD IF NOT EXISTS rented BOOLEAN NOT NULL DEFAULT 0;")
    MySQL.SingleQuery("ALTER TABLE aqua_user_vehicles ADD IF NOT EXISTS rentedid varchar(200) NOT NULL DEFAULT '';")
    MySQL.SingleQuery("ALTER TABLE aqua_user_vehicles ADD IF NOT EXISTS rentedtime varchar(2048) NOT NULL DEFAULT '';")
    MySQL.createCommand("AQUAls/create_modifications_column", "alter table aqua_user_vehicles add if not exists modifications text not null")
	MySQL.createCommand("AQUAls/update_vehicle_modifications", "update aqua_user_vehicles set modifications = @modifications where user_id = @user_id and vehicle = @vehicle")
	MySQL.createCommand("AQUAls/get_vehicle_modifications", "select modifications from aqua_user_vehicles where user_id = @user_id and vehicle = @vehicle")
	MySQL.execute("AQUAls/create_modifications_column")
    print("AQUA Tables Finished")
end)






MySQL.createCommand("AQUA/create_user","INSERT INTO aqua_users(whitelisted,banned) VALUES(false,false)")
MySQL.createCommand("AQUA/add_identifier","INSERT INTO aqua_user_ids(identifier,user_id) VALUES(@identifier,@user_id)")
MySQL.createCommand("AQUA/userid_byidentifier","SELECT user_id FROM aqua_user_ids WHERE identifier = @identifier")
MySQL.createCommand("AQUA/identifier_all","SELECT * FROM aqua_user_ids WHERE identifier = @identifier")
MySQL.createCommand("AQUA/select_identifier_byid_all","SELECT * FROM aqua_user_ids WHERE user_id = @id")

MySQL.createCommand("AQUA/set_userdata","REPLACE INTO aqua_user_data(user_id,dkey,dvalue) VALUES(@user_id,@key,@value)")
MySQL.createCommand("AQUA/get_userdata","SELECT dvalue FROM aqua_user_data WHERE user_id = @user_id AND dkey = @key")

MySQL.createCommand("AQUA/set_srvdata","REPLACE INTO aqua_srv_data(dkey,dvalue) VALUES(@key,@value)")
MySQL.createCommand("AQUA/get_srvdata","SELECT dvalue FROM aqua_srv_data WHERE dkey = @key")

MySQL.createCommand("AQUA/get_banned","SELECT banned FROM aqua_users WHERE id = @user_id")
MySQL.createCommand("AQUA/set_banned","UPDATE aqua_users SET banned = @banned, bantime = @bantime,  banreason = @banreason,  banadmin = @banadmin WHERE id = @user_id")
MySQL.createCommand("AQUA/set_identifierbanned","UPDATE aqua_user_ids SET banned = @banned WHERE identifier = @iden")
MySQL.createCommand("AQUA/getbanreasontime", "SELECT * FROM aqua_users WHERE id = @user_id")

MySQL.createCommand("AQUA/get_whitelisted","SELECT whitelisted FROM aqua_users WHERE id = @user_id")
MySQL.createCommand("AQUA/set_whitelisted","UPDATE aqua_users SET whitelisted = @whitelisted WHERE id = @user_id")
MySQL.createCommand("AQUA/set_last_login","UPDATE aqua_users SET last_login = @last_login WHERE id = @user_id")
MySQL.createCommand("AQUA/get_last_login","SELECT last_login FROM aqua_users WHERE id = @user_id")

--Token Banning 
MySQL.createCommand("AQUA/add_token","INSERT INTO aqua_user_tokens(token,user_id) VALUES(@token,@user_id)")
MySQL.createCommand("AQUA/check_token","SELECT user_id, banned FROM aqua_user_tokens WHERE token = @token")
MySQL.createCommand("AQUA/check_token_userid","SELECT token FROM aqua_user_tokens WHERE user_id = @id")
MySQL.createCommand("AQUA/ban_token","UPDATE aqua_user_tokens SET banned = @banned WHERE token = @token")
--Token Banning

-- init tables


-- identification system

--- sql.
-- cbreturn user id or nil in case of error (if not found, will create it)
function AQUA.getUserIdByIdentifiers(ids, cbr)
    local task = Task(cbr)
    
    if ids ~= nil and #ids then
        local i = 0
        
        -- search identifiers
        local function search()
            i = i+1
            if i <= #ids then
                if not config.ignore_ip_identifier or (string.find(ids[i], "ip:") == nil) then  -- ignore ip identifier
                    MySQL.query("AQUA/userid_byidentifier", {identifier = ids[i]}, function(rows, affected)
                        if #rows > 0 then  -- found
                            task({rows[1].user_id})
                        else -- not found
                            search()
                        end
                    end)
                else
                    search()
                end
            else -- no ids found, create user
                MySQL.query("AQUA/create_user", {}, function(rows, affected)
                    if rows.affectedRows > 0 then
                        local user_id = rows.insertId
                        -- add identifiers
                        for l,w in pairs(ids) do
                            if not config.ignore_ip_identifier or (string.find(w, "ip:") == nil) then  -- ignore ip identifier
                                MySQL.execute("AQUA/add_identifier", {user_id = user_id, identifier = w})
                            end
                        end
                        
                        task({user_id})
                    else
                        task()
                    end
                end)
            end
        end
        
        search()
    else
        task()
    end
end

-- return identification string for the source (used for non AQUA identifications, for rejected players)
function AQUA.getSourceIdKey(source)
    local ids = GetPlayerIdentifiers(source)
    local idk = "idk_"
    for k,v in pairs(ids) do
        idk = idk..v
    end
    
    return idk
end


function AQUA.getPlayerName(player)
    return GetPlayerName(player) or "unknown"
end

--- sql

function AQUA.ReLoadChar(source)
    local name = GetPlayerName(source)
    local ids = GetPlayerIdentifiers(source)
    AQUA.getUserIdByIdentifiers(ids, function(user_id)
        if user_id ~= nil then  
            AQUA.StoreTokens(source, user_id) 
            if AQUA.rusers[user_id] == nil then -- not present on the server, init
                AQUA.users[ids[1]] = user_id
                AQUA.rusers[user_id] = ids[1]
                AQUA.user_tables[user_id] = {}
                AQUA.user_tmp_tables[user_id] = {}
                AQUA.user_sources[user_id] = source
                AQUA.getUData(user_id, "AQUA:datatable", function(sdata)
                    local data = json.decode(sdata)
                    if type(data) == "table" then AQUA.user_tables[user_id] = data end
                    local tmpdata = AQUA.getUserTmpTable(user_id)
                    AQUA.getLastLogin(user_id, function(last_login)
                        tmpdata.last_login = last_login or ""
                        tmpdata.spawns = 0
                        local last_login_stamp = os.date("%H:%M:%S %d/%m/%Y")
                        MySQL.execute("AQUA/set_last_login", {user_id = user_id, last_login = last_login_stamp})
                        print("[AQUA] "..name.. " joined (PermID = "..user_id..")")
                        TriggerEvent("AQUA:playerJoin", user_id, source, name, tmpdata.last_login)
                        TriggerClientEvent("AQUA:CheckIdRegister", source)
                    end)
                end)
            else -- already connected
                print("[AQUA] "..name.."re-joined (PermID = "..user_id..")")
                TriggerEvent("AQUA:playerRejoin", user_id, source, name)
                TriggerClientEvent("AQUA:CheckIdRegister", source)
                local tmpdata = AQUA.getUserTmpTable(user_id)
                tmpdata.spawns = 0
            end
        end
    end)
end

-- This can only be used server side and is for the AQUA bot. 
exports("AQUAbot", function(method_name, params, cb)
    if cb then 
        cb(AQUA[method_name](table.unpack(params)))
    else 
        return AQUA[method_name](table.unpack(params))
    end
end)

local user_id = 0
local MaxPlayers = GetConvarInt("sv_maxclients", 64)

RegisterNetEvent("AQUA:StartGetPlayersLoopSV")
AddEventHandler("AQUA:StartGetPlayersLoopSV", function()
    local UserID = AQUA.getUserId(source)
    local PlayerCount = #GetPlayers()
    TriggerClientEvent('AQUA:ReturnGetPlayersLoopCL', source, UserID, PlayerCount)
end)

RegisterNetEvent("AQUA:CheckID")
AddEventHandler("AQUA:CheckID", function()
    user_id = AQUA.getUserId(source)
    TriggerClientEvent('discord:getpermid2', source, user_id)
    TriggerClientEvent('AQUA:StartGetPlayersLoopCL', source)
    if not user_id then
        AQUA.ReLoadChar(source)
    end
end)

function AQUA.isBanned(user_id, cbr)
    local task = Task(cbr, {false})
    
    MySQL.query("AQUA/get_banned", {user_id = user_id}, function(rows, affected)
        if #rows > 0 then
            task({rows[1].banned})
        else
            task()
        end
    end)
end

--- sql

--- sql
function AQUA.isWhitelisted(user_id, cbr)
    local task = Task(cbr, {false})
    
    MySQL.query("AQUA/get_whitelisted", {user_id = user_id}, function(rows, affected)
        if #rows > 0 then
            task({rows[1].whitelisted})
        else
            task()
        end
    end)
end

--- sql
function AQUA.setWhitelisted(user_id,whitelisted)
    MySQL.execute("AQUA/set_whitelisted", {user_id = user_id, whitelisted = whitelisted})
end

--- sql
function AQUA.getLastLogin(user_id, cbr)
    local task = Task(cbr,{""})
    MySQL.query("AQUA/get_last_login", {user_id = user_id}, function(rows, affected)
        if #rows > 0 then
            task({rows[1].last_login})
        else
            task()
        end
    end)
end

function AQUA.fetchBanReasonTime(user_id,cbr)
    MySQL.query("AQUA/getbanreasontime", {user_id = user_id}, function(rows, affected)
        if #rows > 0 then 
            cbr(rows[1].bantime, rows[1].banreason, rows[1].banadmin)
        end
    end)
end

function AQUA.setUData(user_id,key,value)
    MySQL.execute("AQUA/set_userdata", {user_id = user_id, key = key, value = value})
end

function AQUA.getUData(user_id,key,cbr)
    local task = Task(cbr,{""})
    
    MySQL.query("AQUA/get_userdata", {user_id = user_id, key = key}, function(rows, affected)
        if #rows > 0 then
            task({rows[1].dvalue})
        else
            task()
        end
    end)
end

function AQUA.setSData(key,value)
    MySQL.execute("AQUA/set_srvdata", {key = key, value = value})
end

function AQUA.getSData(key, cbr)
    local task = Task(cbr,{""})
    
    MySQL.query("AQUA/get_srvdata", {key = key}, function(rows, affected)
        if rows and #rows > 0 then
            task({rows[1].dvalue})
        else
            task()
        end
    end)
end

-- return user data table for AQUA internal persistant connected user storage
function AQUA.getUserDataTable(user_id)
    return AQUA.user_tables[user_id]
end

function AQUA.getUserTmpTable(user_id)
    return AQUA.user_tmp_tables[user_id]
end

function AQUA.isConnected(user_id)
    return AQUA.rusers[user_id] ~= nil
end

function AQUA.isFirstSpawn(user_id)
    local tmp = AQUA.getUserTmpTable(user_id)
    return tmp and tmp.spawns == 1
end

function AQUA.getUserId(source)
    if source ~= nil then
        local ids = GetPlayerIdentifiers(source)
        if ids ~= nil and #ids > 0 then
            return AQUA.users[ids[1]]
        end
    end
    
    return nil
end

-- return map of user_id -> player source
function AQUA.getUsers()
    local users = {}
    for k,v in pairs(AQUA.user_sources) do
        users[k] = v
    end
    
    return users
end

-- return source or nil
function AQUA.getUserSource(user_id)
    return AQUA.user_sources[user_id]
end

function AQUA.IdentifierBanCheck(source,user_id,cb)
    for i,v in pairs(GetPlayerIdentifiers(source)) do 
        MySQL.query('AQUA/identifier_all', {identifier = v}, function(rows)
            for i = 1,#rows do 
                if rows[i].banned then 
                    if user_id ~= rows[i].user_id then 
                        cb(true, rows[i].user_id)
                    end 
                end
            end
        end)
    end
end

function AQUA.BanIdentifiers(user_id, value)
    MySQL.query('AQUA/select_identifier_byid_all', {id = user_id}, function(rows)
        for i = 1, #rows do 
            MySQL.execute("AQUA/set_identifierbanned", {banned = value, iden = rows[i].identifier })
        end
    end)
end

function AQUA.setBanned(user_id,banned,time,reason, admin)
    if banned then 
        MySQL.execute("AQUA/set_banned", {user_id = user_id, banned = banned, bantime = time, banreason = reason, banadmin = admin, banevidence})
        AQUA.BanIdentifiers(user_id, true)
        AQUA.BanTokens(user_id, true) 
    else 
        MySQL.execute("AQUA/set_banned", {user_id = user_id, banned = banned, bantime = "", banreason =  "", banadmin =  ""})
        AQUA.BanIdentifiers(user_id, false)
        AQUA.BanTokens(user_id, false) 
    end 
end

function AQUA.ban(adminsource,permid,time,reason)
    local adminPermID = AQUA.getUserId(adminsource)
    local getBannedPlayerSrc = AQUA.getUserSource(tonumber(permid))
    local adminname = GetPed
    if getBannedPlayerSrc then 
        if tonumber(time) then 
            local banTime = os.time()
            banTime = banTime  + (60 * 60 * tonumber(time))  
            AQUA.setBanned(permid,true,banTime,reason, GetPlayerName(adminsource) .. " | ID Of Admin: " .. adminPermID)
            AQUA.kick(getBannedPlayerSrc,"[AQUA] You have been banned from AQUA\nYour ban will expire on: \n" .. os.date("%c", banTime) .. "\nReason: " .. reason .. "\nYou have been banned by: " .. GetPlayerName(adminsource) .. "\n\n [Your ID: " .. permid .. "] \nIf You Believe This Is A False Ban, You Can Appeal It @ https://dsc.gg/AQUA")
            AQUAclient.notify(adminsource,{"~g~Success banned! User PermID:" .. permid})
        else 
            AQUAclient.notify(adminsource,{"~g~Success banned! User PermID:" .. permid})
            AQUA.setBanned(permid,true,"perm",reason, GetPlayerName(adminsource) .. " | ID Of Admin: " .. adminPermID)
            AQUA.kick(getBannedPlayerSrc,"[AQUA] You have been permanently banned from AQUA. \n\nReason: " .. reason .. "\n\nYou have been banned by: " .. GetPlayerName(adminsource) .. "\n\n [Your ID: " .. permid .. "]") 
        end
    else 
        if tonumber(time) then 
            local banTime = os.time()
            banTime = banTime  + (60 * 60 * tonumber(time))  
            AQUAclient.notify(adminsource,{"~g~Success banned! User PermID:" .. permid})
            AQUA.setBanned(permid,true,banTime,reason, GetPlayerName(adminsource) .. " | ID Of Admin: " .. adminPermID)
        else 
            AQUAclient.notify(adminsource,{"~g~Success banned! User PermID:" .. permid})
            AQUA.setBanned(permid,true,"-1",reason, GetPlayerName(adminsource) .. " | ID Of Admin: " .. adminPermID)
        end
    end
end

function AQUA.banConsole(permid,reason)
    local adminPermID = "AQUA"
    local getBannedPlayerSrc = AQUA.getUserSource(tonumber(permid))
    print("~g~Success banned! User PermID:" .. permid)
    AQUA.setBanned(permid,true,"perm",reason,  adminPermID)
    f10Ban(permid, adminPermID, reason, "perm")
    if getBannedPlayerSrc then
    AQUA.kick(getBannedPlayerSrc,"[AQUA] You have been permanently banned from AQUA. \n\nReason: " .. reason .. "\n\nYou have been banned by: " .. adminPermID .. "\n\n [Your ID: " .. permid .. "]") 
    end
end

function AQUA.banDiscordbot(permid,time,reason)
    local adminPermID = "AQUA"
    local getBannedPlayerSrc = AQUA.getUserSource(tonumber(permid))
        if tonumber(time) then 
            local banTime = os.time()
            banTime = banTime  + (60 * 60 * tonumber(time))  
            AQUA.setBanned(permid,true,banTime,reason,  adminPermID)
            print("~g~Success banned! User PermID:" .. permid)
            f10Ban(permid, adminPermID, reason, time)
            if getBannedPlayerSrc then
            AQUA.kick(getBannedPlayerSrc,"[AQUA] You have been banned from AQUA. \n\nYour ban will expire on: \n" .. os.date("%c", banTime) .. "\n\nReason:" .. reason .. "\n\nYou have been banned by: " .. adminPermID.. "\n\n [Your ID: " .. permid .. "]") 
            end
       else 
            print("~g~Success banned! User PermID:" .. permid)
            AQUA.setBanned(permid,true,"perm",reason,  adminPermID)
            f10Ban(permid, adminPermID, reason, "perm")
            if getBannedPlayerSrc then
            AQUA.kick(getBannedPlayerSrc,"[AQUA] You have been permanently banned from AQUA. \n\nReason: " .. reason .. "\n\nYou have been banned by: " .. adminPermID .. "\n\n [Your ID: " .. permid .. "]") 
        end
    end
end

-- To use token banning you need the latest artifacts.
function AQUA.StoreTokens(source, user_id) 
    if GetNumPlayerTokens then 
        local numtokens = GetNumPlayerTokens(source)
        for i = 1, numtokens do
            local token = GetPlayerToken(source, i)
            MySQL.query("AQUA/check_token", {token = token}, function(rows)
                if token and rows and #rows <= 0 then 
                    MySQL.execute("AQUA/add_token", {token = token, user_id = user_id})
                end        
            end)
        end
    end
end


function AQUA.CheckTokens(source, user_id) 
    if GetNumPlayerTokens then 
        local banned = false;
        local numtokens = GetNumPlayerTokens(source)
        for i = 1, numtokens do
            local token = GetPlayerToken(source, i)
            local rows = MySQL.asyncQuery("AQUA/check_token", {token = token, user_id = user_id})
                if #rows > 0 then 
                if rows[1].banned then 
                    return rows[1].banned, rows[1].user_id
                end
            end
        end
    else 
        return false; 
    end
end

function AQUA.BanTokens(user_id, banned) 
    if GetNumPlayerTokens then 
        MySQL.query("AQUA/check_token_userid", {id = user_id}, function(id)
            for i = 1, #id do 
                MySQL.execute("AQUA/ban_token", {token = id[i].token, banned = banned})
            end
        end)
    end
end


function AQUA.kick(source,reason)
    DropPlayer(source,reason)
end

-- tasks

function task_save_datatables()
    TriggerEvent("AQUA:save")
    
    Debug.pbegin("AQUA save datatables")
    for k,v in pairs(AQUA.user_tables) do
        AQUA.setUData(k,"AQUA:datatable",json.encode(v))
    end
    
    Debug.pend()
    SetTimeout(config.save_interval*1000, task_save_datatables)
end
task_save_datatables()

-- handlers

AddEventHandler("playerConnecting",function(name,setMessage, deferrals)
    deferrals.defer()
    local source = source
    Debug.pbegin("playerConnecting")
    local ids = GetPlayerIdentifiers(source)
    if ids ~= nil and #ids > 0 then
        deferrals.update("[AQUA] Checking identifiers...")
        AQUA.getUserIdByIdentifiers(ids, function(user_id)
            AQUA.IdentifierBanCheck(source, user_id, function(status, id)
                if status then
                    print("[AQUA] User rejected for attempting to evade ID: " .. user_id .. " | (Ignore joined message, they were rejected)") 
                    deferrals.done("[ Antievade] Ban Evading Is Not Permitted, Your ID Is: " .. id .. "\nIf You Think This Is A Error, Pleaese Join Our Discord\n[https://dsc.gg/AQUA]")
                    return 
                end
            end)
            -- if user_id ~= nil and AQUA.rusers[user_id] == nil then -- check user validity and if not already connected (old way, disabled until playerDropped is sure to be called)
            if user_id ~= nil then -- check user validity 
                deferrals.update("[AQUA] Fetching Tokens...")
                AQUA.StoreTokens(source, user_id) 
                deferrals.update("[AQUA] Checking banned...")
                AQUA.isBanned(user_id, function(banned)
                    if not banned then
                        deferrals.update("[AQUA] Checking whitelisted...")
                        AQUA.isWhitelisted(user_id, function(whitelisted)
                            if not config.whitelist or whitelisted then
                                Debug.pbegin("playerConnecting_delayed")
                                if AQUA.rusers[user_id] == nil then -- not present on the server, init
                                    if AQUA.CheckTokens(source, user_id) then 
                                        deferrals.done("[ Antievade] Ban Evading Is Not Permitted, Your ID Is: " .. id .. "\nIf You Think This Is A Error, Pleaes Join Our Discord\n[https://dsc.gg/AQUA]")
                                    end
                                    AQUA.users[ids[1]] = user_id
                                    AQUA.rusers[user_id] = ids[1]
                                    AQUA.user_tables[user_id] = {}
                                    AQUA.user_tmp_tables[user_id] = {}
                                    AQUA.user_sources[user_id] = source
                                    
                                    -- load user data table
                                    deferrals.update("[AQUA] Loading datatable...")
                                    AQUA.getUData(user_id, "AQUA:datatable", function(sdata)
                                        local data = json.decode(sdata)
                                        if type(data) == "table" then AQUA.user_tables[user_id] = data end
                                        
                                        -- init user tmp table
                                        local tmpdata = AQUA.getUserTmpTable(user_id)
                                        
                                        deferrals.update("[AQUA] Getting last login...")
                                        AQUA.getLastLogin(user_id, function(last_login)
                                            tmpdata.last_login = last_login or ""
                                            tmpdata.spawns = 0
                                            
                                            -- set last login
                                            local last_login_stamp = os.date("%H:%M:%S %d/%m/%Y")
                                            MySQL.execute("AQUA/set_last_login", {user_id = user_id, last_login = last_login_stamp})
                                            
                                            -- trigger join
                                            print("[AQUA] "..name.." Joined | PermID: "..user_id..")")
                                            TriggerEvent("AQUA:playerJoin", user_id, source, name, tmpdata.last_login)
                                            deferrals.done()
                                        end)
                                    end)
                                else -- already connected
                                    if AQUA.CheckTokens(source, user_id) then 
                                        deferrals.done("[ Antievade] Ban Evading Is Not Permitted, Your ID Is: " .. user_id .. "\nIf You Think This Is A Error, Pleaes Join Our Discord\n[https://dsc.gg/AQUA]")
                                    end
                                    print("[AQUA] "..name.. " re-joined (user_id = "..user_id..")")
                                    TriggerEvent("AQUA:playerRejoin", user_id, source, name)
                                    deferrals.done()
                                    
                                    -- reset first spawn
                                    local tmpdata = AQUA.getUserTmpTable(user_id)
                                    tmpdata.spawns = 0
                                end
                                
                                Debug.pend()
                            else
                                print("[AQUA] "..name.." Rejected | Reason: Not Whitelisted | PermID: "..user_id)
                                deferrals.done("[AQUA] "..name.." Rejected | Reason: Not Whitelisted | PermID: "..user_id)
                            end
                        end)
                    else
                        deferrals.update("[AQUA] Fetching Tokens...")
                        AQUA.StoreTokens(source, user_id) 
                        AQUA.fetchBanReasonTime(user_id,function(bantime, banreason, banadmin)
                            if tonumber(bantime) then 
                                local timern = os.time()
                                if timern > tonumber(bantime) then 
                                    deferrals.update('[AQUA] Your Ban Has Expired\nDo NOT Violate This Server\'s rules again \nYou Will Now Be Automatically Connected\nEnjoy Your Time On The Server\n\nConnecting To AQUA...')
                                    Wait(2000)
                                    AQUA.setBanned(user_id,false)
                                    if AQUA.rusers[user_id] == nil then -- not present on the server, init
                                        -- init entries
                                        AQUA.users[ids[1]] = user_id
                                        AQUA.rusers[user_id] = ids[1]
                                        AQUA.user_tables[user_id] = {}
                                        AQUA.user_tmp_tables[user_id] = {}
                                        AQUA.user_sources[user_id] = source
                                        
                                        -- load user data table
                                        deferrals.update("[AQUA] Loading datatable...")
                                        AQUA.getUData(user_id, "AQUA:datatable", function(sdata)
                                            local data = json.decode(sdata)
                                            if type(data) == "table" then AQUA.user_tables[user_id] = data end
                                            
                                            -- init user tmp table
                                            local tmpdata = AQUA.getUserTmpTable(user_id)
                                            
                                            deferrals.update("[AQUA] Getting last login...")
                                            AQUA.getLastLogin(user_id, function(last_login)
                                                tmpdata.last_login = last_login or ""
                                                tmpdata.spawns = 0
                                                
                                                -- set last login
                                               
                                                local last_login_stamp = os.date("%H:%M:%S %d/%m/%Y")
                                                MySQL.execute("AQUA/set_last_login", {user_id = user_id, last_login = last_login_stamp})
                                                
                                                -- trigger join
                                                print("[AQUA] "..name.."  joined after his ban expired. (user_id = "..user_id..")")
                                                TriggerEvent("AQUA:playerJoin", user_id, source, name, tmpdata.last_login)
                                                deferrals.done()
                                            end)
                                        end)
                                    else -- already connected
                                        print("[AQUA] "..name.." re-joined after his ban expired.  (user_id = "..user_id..")")
                                        TriggerEvent("AQUA:playerRejoin", user_id, source, name)
                                        deferrals.done()
                                        
                                        -- reset first spawn
                                        local tmpdata = AQUA.getUserTmpTable(user_id)
                                        tmpdata.spawns = 0
                                    end
                                    return 
                                end
                                print("[AQUA] "..name.." rejected: banned (user_id = "..user_id..")")
                                deferrals.done("AQUA\n\nExpires in:  " .. os.date("%c", bantime) ..  " \nYour Perm ID is: " .. user_id .. "\nReason: " .. banreason .. "\nBanned By:  " .. banadmin .. "\nAppeal @ https://dsc.gg/AQUA")
                            else 
                                print("[AQUA] "..name.." rejected: banned (user_id = "..user_id..")")
                                deferrals.done("\n[AQUA] Permanently Banned\nID: " ..user_id .. "\nReason: " .. banreason .. "\nBanning Admin: " .. banadmin)
                            end
                        end)
                    end
                end)
            else
                print("[AQUA] "..name.." rejected: identification error")
                deferrals.done("[AQUA] Error Connecting\nReason: Missing Identifiers\nIf You Carry On Getting This Error Please Contact A Developer")
            end
        end)
    else
        print("[AQUA] "..name.." rejected: missing identifiers")
        deferrals.done("[AQUA] Error Connecting\nReason: Missing Identifiers\nIf You Carry On Getting This Error Please Contact A Developer")
    end
    Debug.pend()
end)

AddEventHandler("playerDropped",function(reason)
    local source = source
    local user_id = AQUA.getUserId(source)
    if user_id ~= nil then
        TriggerEvent("AQUA:playerLeave", user_id, source)
        
        -- save user data table
        AQUA.setUData(user_id,"AQUA:datatable",json.encode(AQUA.getUserDataTable(user_id)))
        AQUA.users[AQUA.rusers[user_id]] = nil
        AQUA.rusers[user_id] = nil
        AQUA.user_tables[user_id] = nil
        AQUA.user_tmp_tables[user_id] = nil
        AQUA.user_sources[user_id] = nil
        print('[AQUA] Player Leaving Save:  Saved data for: ' .. GetPlayerName(source))
    else 
        print('[AQUA] SEVERE ERROR: Failed to save data for: ' .. GetPlayerName(source) .. ' Rollback expected!')
    end
    AQUAclient.removePlayer(-1,{source})
end)


MySQL.createCommand("AQUA/setusername","UPDATE aqua_users SET username = @username WHERE id = @user_id")


RegisterServerEvent("AQUAcli:playerSpawned")
AddEventHandler("AQUAcli:playerSpawned", function()
    Debug.pbegin("playerSpawned")
    -- register user sources and then set first spawn to false
    local user_id = AQUA.getUserId(source)
    local player = source
    if user_id ~= nil then
        AQUA.user_sources[user_id] = source
        local tmp = AQUA.getUserTmpTable(user_id)
        tmp.spawns = tmp.spawns+1
        local first_spawn = (tmp.spawns == 1)
        if first_spawn then
            for k,v in pairs(AQUA.user_sources) do
                AQUAclient.addPlayer(source,{v})
            end
            AQUAclient.addPlayer(-1,{source})
            MySQL.execute("AQUA/setusername", {user_id = user_id, username = GetPlayerName(source)})
        end
        TriggerEvent("AQUA:playerSpawn",user_id,player,first_spawn)
    end
    Debug.pend()
end)

AddEventHandler("AQUAcli:playerSpawned", function()
    local user_id = AQUA.getUserId(source)
    local steam64 = "N/A"
    steam64 = GetPlayerGuid(source)
    local discord  = "N/A"
    for k,v in pairs(GetPlayerIdentifiers(source))do
        if string.sub(v, 1, string.len("discord:")) == "discord:" then
            discord = v
        end 
    end
    local command = {
        {
            ["color"] = "33069",
            ["title"] = GetPlayerName(source).." TempID: "..source.." PermID: "..user_id.." connected",
            ["description"] = "```"..discord.."\nsteam64:"..steam64.."```",
            ["footer"] = {
                ["text"] = " Server #1 - "..os.date("%A (%d/%m/%Y) at %X"),
            }
        }
    }
    PerformHttpRequest("https://discord.com/api/webhooks/1059085358777766018/-2855Pukh1QTHgsPtjn1yNoudEcQYpnIvYXdv0K9LkltmwWCGE5sQQCLElFlCVFrsa7k", function(err, text, headers) end, "POST", json.encode({username = "AQUA", embeds = command}), { ["Content-Type"] = "application/json" })
end)

AddEventHandler('playerDropped', function(reason)
    local source = source
    local user_id = AQUA.getUserId(source)
    if user_id ~= nil then
        local command = {
            {
                ["color"] = "15158332",
                ["title"] = GetPlayerName(source).." TempID: "..source.." PermID: "..user_id.." disconnected",
                ["description"] = "Reason: "..reason,
                ["footer"] = {
                    ["text"] = " Server #1 - "..os.date("%A (%d/%m/%Y) at %X"),
                }
            }
        }
        PerformHttpRequest("https://discord.com/api/webhooks/1059085358777766018/-2855Pukh1QTHgsPtjn1yNoudEcQYpnIvYXdv0K9LkltmwWCGE5sQQCLElFlCVFrsa7k", function(err, text, headers) end, "POST", json.encode({username = "AQUA", embeds = command}), { ["Content-Type"] = "application/json" })
    end
end)

RegisterServerEvent("AQUA:gettingUserID")
AddEventHandler("AQUA:gettingUserID", function()
    local source = source
    local user_id = AQUA.getUserId(source)
    TriggerClientEvent("AQUA:setUserID", source, user_id)
end)

RegisterServerEvent("AQUA:playerDied")

function AQUA.banDiscord(permid,time,reason,adminPermID)
    local getBannedPlayerSrc = AQUA.getUserSource(tonumber(permid))
    if getBannedPlayerSrc then 
        if tonumber(time) then 
            local banTime = os.time()
            banTime = banTime  + (60 * 60 * tonumber(time))  
            AQUA.setBanned(permid,true,banTime,reason, adminPermID)
            AQUA.kick(getBannedPlayerSrc,"[GDM] You have been banned from GDM. 🤬\n\nYour ban will expire on: \n" .. os.date("%c", banTime) .. "\n\nReason: " .. reason .. "\n\nYou have been banned by: " .. adminPermID.. "\n\n [Your ID: " .. permid .. "]\n\n\n\n This ban in unappealable, if you think it was a mistake make a support ticket") 
            print("~g~Success banned! User PermID:" .. permid)
            f10Ban(permid, adminPermID, reason, time)
        else 
            print("~g~Success banned! User PermID:" .. permid)
            AQUA.setBanned(permid,true,"perm",reason,  adminPermID)
            f10Ban(permid, adminPermID, reason, "perm")
            AQUA.kick(getBannedPlayerSrc,"[GDM] You have been permanently banned from GDM. 🤬\n\nReason: " .. reason .. "\n\nYou have been banned by: " .. adminPermID .. "\n\n [Your ID: " .. permid .. "]") 
        end
    end
end
