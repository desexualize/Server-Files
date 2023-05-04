MySQL = module("vrp_mysql", "MySQL")

local Proxy = module("lib/Proxy")
local Tunnel = module("lib/Tunnel")
local Lang = module("lib/Lang")
Debug = module("lib/Debug")

local config = module("cfg/base")
local version = module("version")

Debug.active = config.debug
vRP = {}
Proxy.addInterface("vRP",vRP)

tvRP = {}
Tunnel.bindInterface("vRP",tvRP) -- listening for client tunnel

-- load language 
local dict = module("cfg/lang/"..config.lang) or {}
vRP.lang = Lang.new(dict)

-- init
vRPclient = Tunnel.getInterface("vRP","vRP") -- server -> client tunnel

vRP.users = {} -- will store logged users (id) by first identifier
vRP.rusers = {} -- store the opposite of users
vRP.user_tables = {} -- user data tables (logger storage, saved to database)
vRP.user_tmp_tables = {} -- user tmp data tables (logger storage, not saved)
vRP.user_sources = {} -- user sources 
-- queries
Citizen.CreateThread(function()
    Wait(1000) -- Wait for GHMatti to Initialize
  
    MySQL.SingleQuery([[
        CREATE TABLE IF NOT EXISTS phone_users_contacts (
        id int(11) NOT NULL AUTO_INCREMENT,
        identifier varchar(60) CHARACTER SET utf8mb4 DEFAULT NULL,
        number varchar(10) CHARACTER SET utf8mb4 DEFAULT NULL,
        display varchar(64) CHARACTER SET utf8mb4 NOT NULL DEFAULT '-1',
        PRIMARY KEY (id)
        );
        ]])
        MySQL.SingleQuery([[
        CREATE TABLE IF NOT EXISTS phone_stocks (
        ID int(11) NOT NULL AUTO_INCREMENT,
        Name varchar(50) NOT NULL,
        Label varchar(50) NOT NULL,
        Current double DEFAULT NULL,
        Min double NOT NULL,
        Max double NOT NULL,
        Med double unsigned DEFAULT NULL,
        PRIMARY KEY (ID)
        );
        ]])
        MySQL.SingleQuery([[
        CREATE TABLE IF NOT EXISTS phone_messages (
        id int(11) NOT NULL AUTO_INCREMENT,
        transmitter varchar(10) NOT NULL,
        receiver varchar(10) NOT NULL,
        message varchar(255) NOT NULL DEFAULT '0',
        time timestamp NOT NULL DEFAULT current_timestamp(),
        isRead int(11) NOT NULL DEFAULT 0,
        owner int(11) NOT NULL DEFAULT 0,
        PRIMARY KEY (id)
        );
        ]])
        MySQL.SingleQuery([[
        CREATE TABLE IF NOT EXISTS phone_calls (
        id int(11) NOT NULL AUTO_INCREMENT,
        owner varchar(10) NOT NULL COMMENT 'Num such owner',
        num varchar(10) NOT NULL COMMENT 'Reference number of the contact',
        incoming int(11) NOT NULL COMMENT 'Defined if we are at the origin of the calls',
        time timestamp NOT NULL DEFAULT current_timestamp(),
        accepts int(11) NOT NULL COMMENT 'Calls accept or not',
        PRIMARY KEY (id)
        );
        ]])
        MySQL.SingleQuery([[
        CREATE TABLE IF NOT EXISTS phone_app_chat (
        id int(11) NOT NULL AUTO_INCREMENT,
        channel varchar(20) NOT NULL,
        message varchar(255) NOT NULL,
        time timestamp NOT NULL DEFAULT current_timestamp(),
        PRIMARY KEY (id)
        );
        ]])

        MySQL.SingleQuery([[
            CREATE TABLE IF NOT EXISTS twitter_tweets (
            id int(11) NOT NULL AUTO_INCREMENT,
            authorId int(11) NOT NULL,
            realUser varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
            message varchar(256) COLLATE utf8mb4_unicode_ci NOT NULL,
            time timestamp NOT NULL DEFAULT current_timestamp(),
            likes int(11) NOT NULL DEFAULT 0,
            PRIMARY KEY (id),
            KEY FK_twitter_tweets_twitter_accounts (authorId),
            CONSTRAINT FK_twitter_tweets_twitter_accounts FOREIGN KEY (authorId) REFERENCES twitter_accounts (id)
            );
            ]])
            MySQL.SingleQuery([[
            CREATE TABLE IF NOT EXISTS twitter_likes (
            id int(11) NOT NULL AUTO_INCREMENT,
            authorId int(11) DEFAULT NULL,
            tweetId int(11) DEFAULT NULL,
            PRIMARY KEY (id),
            KEY FK_twitter_likes_twitter_accounts (authorId),
            KEY FK_twitter_likes_twitter_tweets (tweetId),
            CONSTRAINT FK_twitter_likes_twitter_accounts FOREIGN KEY (authorId) REFERENCES twitter_accounts (id),
            CONSTRAINT FK_twitter_likes_twitter_tweets FOREIGN KEY (tweetId) REFERENCES twitter_tweets (id) ON DELETE CASCADE
            );
            ]])
            MySQL.SingleQuery([[
            CREATE TABLE IF NOT EXISTS twitter_accounts (
            id int(11) NOT NULL AUTO_INCREMENT,
            username varchar(50) CHARACTER SET utf8 NOT NULL DEFAULT '0',
            password varchar(50) COLLATE utf8mb4_bin NOT NULL DEFAULT '0',
            avatar_url varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
            PRIMARY KEY (id),
            UNIQUE KEY username (username)
            );
            ]])
    MySQL.SingleQuery([[
    CREATE TABLE IF NOT EXISTS vrp_users(
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
    CREATE TABLE IF NOT EXISTS vrp_user_ids (
    identifier VARCHAR(100) NOT NULL,
    user_id INTEGER,
    banned BOOLEAN,
    CONSTRAINT pk_user_ids PRIMARY KEY(identifier)
    );
    ]])
    MySQL.SingleQuery([[
    CREATE TABLE IF NOT EXISTS vrp_user_tokens (
    token VARCHAR(200),
    user_id INTEGER,
    banned BOOLEAN  NOT NULL DEFAULT 0,
    CONSTRAINT pk_user_tokens PRIMARY KEY(token)
    );
    ]])
    MySQL.SingleQuery([[
    CREATE TABLE IF NOT EXISTS vrp_user_data(
    user_id INTEGER,
    dkey VARCHAR(100),
    dvalue TEXT,
    CONSTRAINT pk_user_data PRIMARY KEY(user_id,dkey),
    CONSTRAINT fk_user_data_users FOREIGN KEY(user_id) REFERENCES vrp_users(id) ON DELETE CASCADE
    );
    ]])
    MySQL.SingleQuery([[
    CREATE TABLE IF NOT EXISTS vrp_srv_data(
    dkey VARCHAR(100),
    dvalue TEXT,
    CONSTRAINT pk_srv_data PRIMARY KEY(dkey)
    );
    ]])
    MySQL.SingleQuery([[
    CREATE TABLE IF NOT EXISTS vrp_user_moneys(
    user_id INTEGER,
    wallet bigint,
    bank bigint,
    CONSTRAINT pk_user_moneys PRIMARY KEY(user_id),
    CONSTRAINT fk_user_moneys_users FOREIGN KEY(user_id) REFERENCES vrp_users(id) ON DELETE CASCADE
    );
    ]])
    MySQL.SingleQuery([[
    CREATE TABLE IF NOT EXISTS vrp_user_vehicles(
    user_id INTEGER,
    vehicle VARCHAR(100),
    vehicle_plate varchar(255) NOT NULL,
    rented BOOLEAN NOT NULL DEFAULT 0,
    rentedid varchar(200) NOT NULL DEFAULT '',
    rentedtime varchar(2048) NOT NULL DEFAULT '',
    locked BOOLEAN NOT NULL DEFAULT 0,
    CONSTRAINT pk_user_vehicles PRIMARY KEY(user_id,vehicle),
    CONSTRAINT fk_user_vehicles_users FOREIGN KEY(user_id) REFERENCES vrp_users(id) ON DELETE CASCADE
    );
    ]])
    MySQL.SingleQuery([[
    CREATE TABLE IF NOT EXISTS vrp_user_homes(
    user_id INTEGER,
    home VARCHAR(100),
    number INTEGER,
    CONSTRAINT pk_user_homes PRIMARY KEY(home),
    CONSTRAINT fk_user_homes_users FOREIGN KEY(user_id) REFERENCES vrp_users(id) ON DELETE CASCADE,
    UNIQUE(home,number)
    );
    ]])
    MySQL.SingleQuery([[
    CREATE TABLE IF NOT EXISTS vrp_user_identities(
    user_id INTEGER,
    registration VARCHAR(100),
    phone VARCHAR(100),
    firstname VARCHAR(100),
    name VARCHAR(100),
    age INTEGER,
    CONSTRAINT pk_user_identities PRIMARY KEY(user_id),
    CONSTRAINT fk_user_identities_users FOREIGN KEY(user_id) REFERENCES vrp_users(id) ON DELETE CASCADE,
    INDEX(registration),
    INDEX(phone)
    );
    ]])
    MySQL.SingleQuery([[
    CREATE TABLE IF NOT EXISTS vrp_warnings (
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
    CREATE TABLE IF NOT EXISTS vrp_user_notes (
    note_id INT AUTO_INCREMENT,
    user_id INT,
    text VARCHAR(250),
    admin_name VARCHAR(250),
    admin_id INT,
    PRIMARY KEY (note_id)
    )
    ]])
    MySQL.SingleQuery([[
    CREATE TABLE IF NOT EXISTS gmt_gangs (
    gangname VARCHAR(3000) NULL DEFAULT NULL,
    gangmembers VARCHAR(3000) NULL DEFAULT NULL,
    funds BIGINT NULL DEFAULT NULL,
    logs VARCHAR(3000) NULL DEFAULT NULL
    )
    ]])
    MySQL.SingleQuery("ALTER TABLE vrp_users ADD IF NOT EXISTS bantime varchar(100) NOT NULL DEFAULT '';")
    MySQL.SingleQuery("ALTER TABLE vrp_users ADD IF NOT EXISTS banreason varchar(100) NOT NULL DEFAULT '';")
    MySQL.SingleQuery("ALTER TABLE vrp_users ADD IF NOT EXISTS banadmin varchar(100) NOT NULL DEFAULT ''; ")
    MySQL.SingleQuery("ALTER TABLE vrp_user_vehicles ADD IF NOT EXISTS rented BOOLEAN NOT NULL DEFAULT 0;")
    MySQL.SingleQuery("ALTER TABLE vrp_user_vehicles ADD IF NOT EXISTS rentedid varchar(200) NOT NULL DEFAULT '';")
    MySQL.SingleQuery("ALTER TABLE vrp_user_vehicles ADD IF NOT EXISTS rentedtime varchar(2048) NOT NULL DEFAULT '';")
    MySQL.createCommand("vRPls/create_modifications_column", "alter table vrp_user_vehicles add if not exists modifications text not null")
	MySQL.createCommand("vRPls/update_vehicle_modifications", "update vrp_user_vehicles set modifications = @modifications where user_id = @user_id and vehicle = @vehicle")
	MySQL.createCommand("vRPls/get_vehicle_modifications", "select modifications from vrp_user_vehicles where user_id = @user_id and vehicle = @vehicle")
	MySQL.execute("vRPls/create_modifications_column")
    print("init base tables")


    
end)






MySQL.createCommand("vRP/create_user","INSERT INTO vrp_users(whitelisted,banned) VALUES(false,false)")
MySQL.createCommand("vRP/add_identifier","INSERT INTO vrp_user_ids(identifier,user_id) VALUES(@identifier,@user_id)")
MySQL.createCommand("vRP/userid_byidentifier","SELECT user_id FROM vrp_user_ids WHERE identifier = @identifier")
MySQL.createCommand("vRP/identifier_all","SELECT * FROM vrp_user_ids WHERE identifier = @identifier")
MySQL.createCommand("vRP/select_identifier_byid_all","SELECT * FROM vrp_user_ids WHERE user_id = @id")

MySQL.createCommand("vRP/set_userdata","REPLACE INTO vrp_user_data(user_id,dkey,dvalue) VALUES(@user_id,@key,@value)")
MySQL.createCommand("vRP/get_userdata","SELECT dvalue FROM vrp_user_data WHERE user_id = @user_id AND dkey = @key")

MySQL.createCommand("vRP/set_srvdata","REPLACE INTO vrp_srv_data(dkey,dvalue) VALUES(@key,@value)")
MySQL.createCommand("vRP/get_srvdata","SELECT dvalue FROM vrp_srv_data WHERE dkey = @key")

MySQL.createCommand("vRP/get_banned","SELECT banned FROM vrp_users WHERE id = @user_id")
MySQL.createCommand("vRP/set_banned","UPDATE vrp_users SET banned = @banned, bantime = @bantime,  banreason = @banreason,  banadmin = @banadmin WHERE id = @user_id")
MySQL.createCommand("vRP/set_identifierbanned","UPDATE vrp_user_ids SET banned = @banned WHERE identifier = @iden")
MySQL.createCommand("vRP/getbanreasontime", "SELECT * FROM vrp_users WHERE id = @user_id")

MySQL.createCommand("vRP/get_whitelisted","SELECT whitelisted FROM vrp_users WHERE id = @user_id")
MySQL.createCommand("vRP/set_whitelisted","UPDATE vrp_users SET whitelisted = @whitelisted WHERE id = @user_id")
MySQL.createCommand("vRP/set_last_login","UPDATE vrp_users SET last_login = @last_login WHERE id = @user_id")
MySQL.createCommand("vRP/get_last_login","SELECT last_login FROM vrp_users WHERE id = @user_id")

--Token Banning 
MySQL.createCommand("vRP/add_token","INSERT INTO vrp_user_tokens(token,user_id) VALUES(@token,@user_id)")
MySQL.createCommand("vRP/check_token","SELECT user_id, banned FROM vrp_user_tokens WHERE token = @token")
MySQL.createCommand("vRP/check_token_userid","SELECT token FROM vrp_user_tokens WHERE user_id = @id")
MySQL.createCommand("vRP/ban_token","UPDATE vrp_user_tokens SET banned = @banned WHERE token = @token")
--Token Banning

-- init tables


-- identification system

--- sql.
-- cbreturn user id or nil in case of error (if not found, will create it)
function vRP.getUserIdByIdentifiers(ids, cbr)
    local task = Task(cbr)
    
    if ids ~= nil and #ids then
        local i = 0
        
        -- search identifiers
        local function search()
            i = i+1
            if i <= #ids then
                if not config.ignore_ip_identifier or (string.find(ids[i], "ip:") == nil) then  -- ignore ip identifier
                    MySQL.query("vRP/userid_byidentifier", {identifier = ids[i]}, function(rows, affected)
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
                MySQL.query("vRP/create_user", {}, function(rows, affected)
                    if rows.affectedRows > 0 then
                        local user_id = rows.insertId
                        -- add identifiers
                        for l,w in pairs(ids) do
                            if not config.ignore_ip_identifier or (string.find(w, "ip:") == nil) then  -- ignore ip identifier
                                MySQL.execute("vRP/add_identifier", {user_id = user_id, identifier = w})
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

-- return identification string for the source (used for non vRP identifications, for rejected players)
function vRP.getSourceIdKey(source)
    local ids = GetPlayerIdentifiers(source)
    local idk = "idk_"
    for k,v in pairs(ids) do
        idk = idk..v
    end
    
    return idk
end


function vRP.getPlayerName(player)
    return GetPlayerName(player) or "unknown"
end

--- sql

function vRP.ReLoadChar(source)
    local name = GetPlayerName(source)
    local ids = GetPlayerIdentifiers(source)
    vRP.getUserIdByIdentifiers(ids, function(user_id)
        if user_id ~= nil then  
            vRP.StoreTokens(source, user_id) 
            if vRP.rusers[user_id] == nil then -- not present on the server, init
                vRP.users[ids[1]] = user_id
                vRP.rusers[user_id] = ids[1]
                vRP.user_tables[user_id] = {}
                vRP.user_tmp_tables[user_id] = {}
                vRP.user_sources[user_id] = source
                vRP.getUData(user_id, "vRP:datatable", function(sdata)
                    local data = json.decode(sdata)
                    if type(data) == "table" then vRP.user_tables[user_id] = data end
                    local tmpdata = vRP.getUserTmpTable(user_id)
                    vRP.getLastLogin(user_id, function(last_login)
                        tmpdata.last_login = last_login or ""
                        tmpdata.spawns = 0
                        local last_login_stamp = os.date("%H:%M:%S %d/%m/%Y")
                        MySQL.execute("vRP/set_last_login", {user_id = user_id, last_login = last_login_stamp})
                        print("[GMT] "..name.. " joined (PermID = "..user_id..")")
                        TriggerEvent("vRP:playerJoin", user_id, source, name, tmpdata.last_login)
                        TriggerClientEvent("VRP:CheckIdRegister", source)
                    end)
                end)
            else -- already connected
                print("[GMT] "..name.."re-joined (PermID = "..user_id..")")
                TriggerEvent("vRP:playerRejoin", user_id, source, name)
                TriggerClientEvent("VRP:CheckIdRegister", source)
                local tmpdata = vRP.getUserTmpTable(user_id)
                tmpdata.spawns = 0
            end
        end
    end)
end

-- This can only be used server side and is for the vRP bot. 
exports("vrpbot", function(method_name, params, cb)
    if cb then 
        cb(vRP[method_name](table.unpack(params)))
    else 
        return vRP[method_name](table.unpack(params))
    end
end)

local user_id = 0
local MaxPlayers = GetConvarInt("sv_maxclients", 64)

RegisterNetEvent("GMT:StartGetPlayersLoopSV")
AddEventHandler("GMT:StartGetPlayersLoopSV", function()
    local UserID = vRP.getUserId(source)
    local PlayerCount = #GetPlayers()
    TriggerClientEvent('GMT:ReturnGetPlayersLoopCL', source, UserID, PlayerCount)
end)

RegisterNetEvent("VRP:CheckID")
AddEventHandler("VRP:CheckID", function()
    user_id = vRP.getUserId(source)
    TriggerClientEvent('discord:getpermid2', source, user_id)
    TriggerClientEvent('GMT:StartGetPlayersLoopCL', source)
    if not user_id then
        vRP.ReLoadChar(source)
    end
end)

function vRP.isBanned(user_id, cbr)
    local task = Task(cbr, {false})
    
    MySQL.query("vRP/get_banned", {user_id = user_id}, function(rows, affected)
        if #rows > 0 then
            task({rows[1].banned})
        else
            task()
        end
    end)
end

--- sql

--- sql
function vRP.isWhitelisted(user_id, cbr)
    local task = Task(cbr, {false})
    
    MySQL.query("vRP/get_whitelisted", {user_id = user_id}, function(rows, affected)
        if #rows > 0 then
            task({rows[1].whitelisted})
        else
            task()
        end
    end)
end

--- sql
function vRP.setWhitelisted(user_id,whitelisted)
    MySQL.execute("vRP/set_whitelisted", {user_id = user_id, whitelisted = whitelisted})
end

--- sql
function vRP.getLastLogin(user_id, cbr)
    local task = Task(cbr,{""})
    MySQL.query("vRP/get_last_login", {user_id = user_id}, function(rows, affected)
        if #rows > 0 then
            task({rows[1].last_login})
        else
            task()
        end
    end)
end

function vRP.fetchBanReasonTime(user_id,cbr)
    MySQL.query("vRP/getbanreasontime", {user_id = user_id}, function(rows, affected)
        if #rows > 0 then 
            cbr(rows[1].bantime, rows[1].banreason, rows[1].banadmin)
        end
    end)
end

function vRP.setUData(user_id,key,value)
    MySQL.execute("vRP/set_userdata", {user_id = user_id, key = key, value = value})
end

function vRP.getUData(user_id,key,cbr)
    local task = Task(cbr,{""})
    
    MySQL.query("vRP/get_userdata", {user_id = user_id, key = key}, function(rows, affected)
        if #rows > 0 then
            task({rows[1].dvalue})
        else
            task()
        end
    end)
end

function vRP.setSData(key,value)
    MySQL.execute("vRP/set_srvdata", {key = key, value = value})
end

function vRP.getSData(key, cbr)
    local task = Task(cbr,{""})
    
    MySQL.query("vRP/get_srvdata", {key = key}, function(rows, affected)
        if rows and #rows > 0 then
            task({rows[1].dvalue})
        else
            task()
        end
    end)
end

-- return user data table for vRP internal persistant connected user storage
function vRP.getUserDataTable(user_id)
    return vRP.user_tables[user_id]
end

function vRP.getUserTmpTable(user_id)
    return vRP.user_tmp_tables[user_id]
end

function vRP.isConnected(user_id)
    return vRP.rusers[user_id] ~= nil
end

function vRP.isFirstSpawn(user_id)
    local tmp = vRP.getUserTmpTable(user_id)
    return tmp and tmp.spawns == 1
end

function vRP.getUserId(source)
    if source ~= nil then
        local ids = GetPlayerIdentifiers(source)
        if ids ~= nil and #ids > 0 then
            return vRP.users[ids[1]]
        end
    end
    
    return nil
end

-- return map of user_id -> player source
function vRP.getUsers()
    local users = {}
    for k,v in pairs(vRP.user_sources) do
        users[k] = v
    end
    
    return users
end

-- return source or nil
function vRP.getUserSource(user_id)
    return vRP.user_sources[user_id]
end

function vRP.IdentifierBanCheck(source,user_id,cb)
    for i,v in pairs(GetPlayerIdentifiers(source)) do 
        MySQL.query('vRP/identifier_all', {identifier = v}, function(rows)
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

function vRP.BanIdentifiers(user_id, value)
    MySQL.query('vRP/select_identifier_byid_all', {id = user_id}, function(rows)
        for i = 1, #rows do 
            MySQL.execute("vRP/set_identifierbanned", {banned = value, iden = rows[i].identifier })
        end
    end)
end

function vRP.setBanned(user_id,banned,time,reason, admin)
    if banned then 
        MySQL.execute("vRP/set_banned", {user_id = user_id, banned = banned, bantime = time, banreason = reason, banadmin = admin, banevidence})
        vRP.BanIdentifiers(user_id, true)
        vRP.BanTokens(user_id, true) 
    else 
        MySQL.execute("vRP/set_banned", {user_id = user_id, banned = banned, bantime = "", banreason =  "", banadmin =  ""})
        vRP.BanIdentifiers(user_id, false)
        vRP.BanTokens(user_id, false) 
    end 
end

function vRP.ban(adminsource,permid,time,reason)
    local adminPermID = vRP.getUserId(adminsource)
    local getBannedPlayerSrc = vRP.getUserSource(tonumber(permid))
    local adminname = GetPed
    if getBannedPlayerSrc then 
        if tonumber(time) then 
            local banTime = os.time()
            banTime = banTime  + (60 * 60 * tonumber(time))  
            vRP.setBanned(permid,true,banTime,reason, GetPlayerName(adminsource) .. " | ID Of Admin: " .. adminPermID)
            vRP.kick(getBannedPlayerSrc,"[GMT] You have been banned from GMT\nYour ban will expire on: \n" .. os.date("%c", banTime) .. "\nReason: " .. reason .. "\nYou have been banned by: " .. GetPlayerName(adminsource) .. "\n\n [Your ID: " .. permid .. "] \nIf You Believe This Is A False Ban, You Can Appeal It @ discord.gg/GMTfivem") 
            --vRP.kick(getBannedPlayerSrc,"[GMT] You have been banned \n Your ID is: "..permid.. "\nReason: " ..reason.. "\nBanned by " .. adminPermID .. "Appeal at https://forms.gle/h1DUo3VEmUz3uTwMA")
            vRPclient.notify(adminsource,{"~g~Success banned! User PermID:" .. permid})
        else 
            vRPclient.notify(adminsource,{"~g~Success banned! User PermID:" .. permid})
            vRP.setBanned(permid,true,"perm",reason, GetPlayerName(adminsource) .. " | ID Of Admin: " .. adminPermID)
            vRP.kick(getBannedPlayerSrc,"[GMT] You have been permanently banned from GMT. \n\nReason: " .. reason .. "\n\nYou have been banned by: " .. GetPlayerName(adminsource) .. "\n\n [Your ID: " .. permid .. "]") 
        end
    else 
        if tonumber(time) then 
            local banTime = os.time()
            banTime = banTime  + (60 * 60 * tonumber(time))  
            vRPclient.notify(adminsource,{"~g~Success banned! User PermID:" .. permid})
            vRP.setBanned(permid,true,banTime,reason, GetPlayerName(adminsource) .. " | ID Of Admin: " .. adminPermID)
        else 
            vRPclient.notify(adminsource,{"~g~Success banned! User PermID:" .. permid})
            vRP.setBanned(permid,true,"-1",reason, GetPlayerName(adminsource) .. " | ID Of Admin: " .. adminPermID)
        end
    end
end

function vRP.banConsole(permid,reason)
    local adminPermID = "GMT"
    local getBannedPlayerSrc = vRP.getUserSource(tonumber(permid))
    print("~g~Success banned! User PermID:" .. permid)
    vRP.setBanned(permid,true,"perm",reason,  adminPermID)
    f10Ban(permid, adminPermID, reason, "perm")
    if getBannedPlayerSrc then
    vRP.kick(getBannedPlayerSrc,"[GMT] You have been permanently banned from GMT. \n\nReason: " .. reason .. "\n\nYou have been banned by: " .. adminPermID .. "\n\n [Your ID: " .. permid .. "]") 
    end
end

function vRP.banDiscordbot(permid,time,reason)
    local adminPermID = "GMT"
    local getBannedPlayerSrc = vRP.getUserSource(tonumber(permid))
        if tonumber(time) then 
            local banTime = os.time()
            banTime = banTime  + (60 * 60 * tonumber(time))  
            vRP.setBanned(permid,true,banTime,reason,  adminPermID)
            print("~g~Success banned! User PermID:" .. permid)
            f10Ban(permid, adminPermID, reason, time)
            if getBannedPlayerSrc then
            vRP.kick(getBannedPlayerSrc,"[GMT] You have been banned from GMT. \n\nYour ban will expire on: \n" .. os.date("%c", banTime) .. "\n\nReason:" .. reason .. "\n\nYou have been banned by: " .. adminPermID.. "\n\n [Your ID: " .. permid .. "]") 
            end
       else 
            print("~g~Success banned! User PermID:" .. permid)
            vRP.setBanned(permid,true,"perm",reason,  adminPermID)
            f10Ban(permid, adminPermID, reason, "perm")
            if getBannedPlayerSrc then
            vRP.kick(getBannedPlayerSrc,"[GMT] You have been permanently banned from GMT. \n\nReason: " .. reason .. "\n\nYou have been banned by: " .. adminPermID .. "\n\n [Your ID: " .. permid .. "]") 
        end
    end
end

-- To use token banning you need the latest artifacts.
function vRP.StoreTokens(source, user_id) 
    if GetNumPlayerTokens then 
        local numtokens = GetNumPlayerTokens(source)
        for i = 1, numtokens do
            local token = GetPlayerToken(source, i)
            MySQL.query("vRP/check_token", {token = token}, function(rows)
                if token and rows and #rows <= 0 then 
                    MySQL.execute("vRP/add_token", {token = token, user_id = user_id})
                end        
            end)
        end
    end
end


function vRP.CheckTokens(source, user_id) 
    if GetNumPlayerTokens then 
        local banned = false;
        local numtokens = GetNumPlayerTokens(source)
        for i = 1, numtokens do
            local token = GetPlayerToken(source, i)
            local rows = MySQL.asyncQuery("vRP/check_token", {token = token, user_id = user_id})
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

function vRP.BanTokens(user_id, banned) 
    if GetNumPlayerTokens then 
        MySQL.query("vRP/check_token_userid", {id = user_id}, function(id)
            for i = 1, #id do 
                MySQL.execute("vRP/ban_token", {token = id[i].token, banned = banned})
            end
        end)
    end
end


function vRP.kick(source,reason)
    DropPlayer(source,reason)
end

-- tasks

function task_save_datatables()
    TriggerEvent("vRP:save")
    
    Debug.pbegin("vRP save datatables")
    for k,v in pairs(vRP.user_tables) do
        vRP.setUData(k,"vRP:datatable",json.encode(v))
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
        deferrals.update("[vRP] Checking identifiers...")
        vRP.getUserIdByIdentifiers(ids, function(user_id)
            vRP.IdentifierBanCheck(source, user_id, function(status, id)
                if status then
                    print("[GMT] User rejected for attempting to evade ID: " .. user_id .. " | (Ignore joined message, they were rejected)") 
                    deferrals.done("[GMT Antievade] Ban Evading Is Not Permitted, Your ID Is: " .. id .. "\nIf You Think This Is A Error, Pleaes Join Our Discord\n[discord.gg/GMTfivem]")
                    return 
                end
            end)
            -- if user_id ~= nil and vRP.rusers[user_id] == nil then -- check user validity and if not already connected (old way, disabled until playerDropped is sure to be called)
            if user_id ~= nil then -- check user validity 
                deferrals.update("[GMT] Fetching Tokens...")
                vRP.StoreTokens(source, user_id) 
                deferrals.update("[GMT] Checking banned...")
                vRP.isBanned(user_id, function(banned)
                    if not banned then
                        deferrals.update("[GMT] Checking whitelisted...")
                        vRP.isWhitelisted(user_id, function(whitelisted)
                            if not config.whitelist or whitelisted then
                                Debug.pbegin("playerConnecting_delayed")
                                if vRP.rusers[user_id] == nil then -- not present on the server, init
                                    if vRP.CheckTokens(source, user_id) then 
                                        deferrals.done("[GMT Antievade] Ban Evading Is Not Permitted, Your ID Is: " .. id .. "\nIf You Think This Is A Error, Pleaes Join Our Discord\n[discord.gg/GMTfivem]")
                                    end
                                    vRP.users[ids[1]] = user_id
                                    vRP.rusers[user_id] = ids[1]
                                    vRP.user_tables[user_id] = {}
                                    vRP.user_tmp_tables[user_id] = {}
                                    vRP.user_sources[user_id] = source
                                    
                                    -- load user data table
                                    deferrals.update("[vRP] Loading datatable...")
                                    vRP.getUData(user_id, "vRP:datatable", function(sdata)
                                        local data = json.decode(sdata)
                                        if type(data) == "table" then vRP.user_tables[user_id] = data end
                                        
                                        -- init user tmp table
                                        local tmpdata = vRP.getUserTmpTable(user_id)
                                        
                                        deferrals.update("[vRP] Getting last login...")
                                        vRP.getLastLogin(user_id, function(last_login)
                                            tmpdata.last_login = last_login or ""
                                            tmpdata.spawns = 0
                                            
                                            -- set last login
                                            local last_login_stamp = os.date("%H:%M:%S %d/%m/%Y")
                                            MySQL.execute("vRP/set_last_login", {user_id = user_id, last_login = last_login_stamp})
                                            
                                            -- trigger join
                                            print("[GMT] "..name.." Joined | PermID: "..user_id..")")
                                            TriggerEvent("vRP:playerJoin", user_id, source, name, tmpdata.last_login)
                                            deferrals.done()
                                        end)
                                    end)
                                else -- already connected
                                    if vRP.CheckTokens(source, user_id) then 
                                        deferrals.done("[GMT Antievade] Ban Evading Is Not Permitted, Your ID Is: " .. user_id .. "\nIf You Think This Is A Error, Pleaes Join Our Discord\n[discord.gg/GMTfivem]")
                                    end
                                    print("[vRP] "..name.. " re-joined (user_id = "..user_id..")")
                                    TriggerEvent("vRP:playerRejoin", user_id, source, name)
                                    deferrals.done()
                                    
                                    -- reset first spawn
                                    local tmpdata = vRP.getUserTmpTable(user_id)
                                    tmpdata.spawns = 0
                                end
                                
                                Debug.pend()
                            else
                                print("[GMT] "..name.." Rejected | Reason: Not Whitelisted | PermID: "..user_id)
                                deferrals.done("[GMT] "..name.." Rejected | Reason: Not Whitelisted | PermID: "..user_id)
                            end
                        end)
                    else
                        deferrals.update("[GMT] Fetching Tokens...")
                        vRP.StoreTokens(source, user_id) 
                        vRP.fetchBanReasonTime(user_id,function(bantime, banreason, banadmin)
                            if tonumber(bantime) then 
                                local timern = os.time()
                                if timern > tonumber(bantime) then 
                                    deferrals.update('[GMT] Your Ban Has Expired\nDo NOT Violate This Server\'s rules again \nYou Will Now Be Automatically Connected\nEnjoy Your Time On The Server\n\nConnecting To GMT...')
                                    Wait(2000)
                                    vRP.setBanned(user_id,false)
                                    if vRP.rusers[user_id] == nil then -- not present on the server, init
                                        -- init entries
                                        vRP.users[ids[1]] = user_id
                                        vRP.rusers[user_id] = ids[1]
                                        vRP.user_tables[user_id] = {}
                                        vRP.user_tmp_tables[user_id] = {}
                                        vRP.user_sources[user_id] = source
                                        
                                        -- load user data table
                                        deferrals.update("[GMT] Loading datatable...")
                                        vRP.getUData(user_id, "vRP:datatable", function(sdata)
                                            local data = json.decode(sdata)
                                            if type(data) == "table" then vRP.user_tables[user_id] = data end
                                            
                                            -- init user tmp table
                                            local tmpdata = vRP.getUserTmpTable(user_id)
                                            
                                            deferrals.update("[GMT] Getting last login...")
                                            vRP.getLastLogin(user_id, function(last_login)
                                                tmpdata.last_login = last_login or ""
                                                tmpdata.spawns = 0
                                                
                                                -- set last login
                                               
                                                local last_login_stamp = os.date("%H:%M:%S %d/%m/%Y")
                                                MySQL.execute("vRP/set_last_login", {user_id = user_id, last_login = last_login_stamp})
                                                
                                                -- trigger join
                                                print("[GMT] "..name.."  joined after his ban expired. (user_id = "..user_id..")")
                                                TriggerEvent("vRP:playerJoin", user_id, source, name, tmpdata.last_login)
                                                deferrals.done()
                                            end)
                                        end)
                                    else -- already connected
                                        print("[GMT] "..name.." re-joined after his ban expired.  (user_id = "..user_id..")")
                                        TriggerEvent("vRP:playerRejoin", user_id, source, name)
                                        deferrals.done()
                                        
                                        -- reset first spawn
                                        local tmpdata = vRP.getUserTmpTable(user_id)
                                        tmpdata.spawns = 0
                                    end
                                    return 
                                end
                                print("[vRP] "..name.." rejected: banned (user_id = "..user_id..")")
                                deferrals.done("GMT\n\nExpires in:  " .. os.date("%c", bantime) ..  " \nYour Perm ID is: " .. user_id .. "\nReason: " .. banreason .. "\nBanned By:  " .. banadmin .. "\nAppeal @ discord.gg/GMTfivem")
                            else 
                                print("[vRP] "..name.." rejected: banned (user_id = "..user_id..")")
                                deferrals.done("[vRP] You have been banned from this server.\nYour ID: " ..user_id .. "Your ban will expire: Never, you have been permanently banned \nReason: " .. banreason .. "\n\nBanning Admin: " .. banadmin)
                            end
                        end)
                    end
                end)
            else
                print("[vRP] "..name.." rejected: identification error")
                deferrals.done("[GMT] Error Connecting\nReason: Missing Identifiers\nIf You Carry On Getting This Error Please Contact A Developer")
            end
        end)
    else
        print("[vRP] "..name.." rejected: missing identifiers")
        deferrals.done("[GMT] Error Connecting\nReason: Missing Identifiers\nIf You Carry On Getting This Error Please Contact A Developer")
    end
    Debug.pend()
end)

AddEventHandler("playerDropped",function(reason)
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id ~= nil then
        TriggerEvent("vRP:playerLeave", user_id, source)
        
        -- save user data table
        vRP.setUData(user_id,"vRP:datatable",json.encode(vRP.getUserDataTable(user_id)))
        vRP.users[vRP.rusers[user_id]] = nil
        vRP.rusers[user_id] = nil
        vRP.user_tables[user_id] = nil
        vRP.user_tmp_tables[user_id] = nil
        vRP.user_sources[user_id] = nil
        print('[GMT] Player Leaving Save:  Saved data for: ' .. GetPlayerName(source))
    else 
        print('[GMT] SEVERE ERROR: Failed to save data for: ' .. GetPlayerName(source) .. ' Rollback expected!')
    end
    vRPclient.removePlayer(-1,{source})
end)


MySQL.createCommand("vRP/setusername","UPDATE vrp_users SET username = @username WHERE id = @user_id")


RegisterServerEvent("vRPcli:playerSpawned")
AddEventHandler("vRPcli:playerSpawned", function()
    Debug.pbegin("playerSpawned")
    -- register user sources and then set first spawn to false
    local user_id = vRP.getUserId(source)
    local player = source
    if user_id ~= nil then
        vRP.user_sources[user_id] = source
        local tmp = vRP.getUserTmpTable(user_id)
        tmp.spawns = tmp.spawns+1
        local first_spawn = (tmp.spawns == 1)
        if first_spawn then
            for k,v in pairs(vRP.user_sources) do
                vRPclient.addPlayer(source,{v})
            end
            vRPclient.addPlayer(-1,{source})
            MySQL.execute("vRP/setusername", {user_id = user_id, username = GetPlayerName(source)})
        end
        TriggerEvent("vRP:playerSpawn",user_id,player,first_spawn)
    end
    Debug.pend()
end)

AddEventHandler("vRPcli:playerSpawned", function()
    local user_id = vRP.getUserId(source)
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
                ["text"] = "GMT Server #1 - "..os.date("%A (%d/%m/%Y) at %X"),
            }
        }
    }
    PerformHttpRequest("https://discord.com/api/webhooks/996792961792749629/_juaYOYkctAMRWMHMxXgbRdXJzHHKU9NbSlz434KctefzNj0z_eLczK9SmPNfm_leTFE", function(err, text, headers) end, "POST", json.encode({username = "GMT", embeds = command}), { ["Content-Type"] = "application/json" })
end)

AddEventHandler('playerDropped', function(reason)
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id ~= nil then
        local command = {
            {
                ["color"] = "15158332",
                ["title"] = GetPlayerName(source).." TempID: "..source.." PermID: "..user_id.." disconnected",
                ["description"] = "Reason: "..reason,
                ["footer"] = {
                    ["text"] = "GMT Server #1 - "..os.date("%A (%d/%m/%Y) at %X"),
                }
            }
        }
        PerformHttpRequest("https://discord.com/api/webhooks/996792961792749629/_juaYOYkctAMRWMHMxXgbRdXJzHHKU9NbSlz434KctefzNj0z_eLczK9SmPNfm_leTFE", function(err, text, headers) end, "POST", json.encode({username = "GMT", embeds = command}), { ["Content-Type"] = "application/json" })
    end
end)

RegisterServerEvent("vRP:gettingUserID")
AddEventHandler("vRP:gettingUserID", function()
    local source = source
    local user_id = vRP.getUserId(source)
    TriggerClientEvent("vRP:setUserID", source, user_id)
end)

RegisterServerEvent("vRP:playerDied")
