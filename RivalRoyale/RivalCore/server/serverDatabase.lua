DATABASE = {}

function DATABASE:initialize()
  exports['GHMattiMySQL']:QueryAsync([[  
    CREATE TABLE IF NOT EXISTS `rival_stats` (
      `UID` int(11) DEFAULT 0,
      `Kills` mediumint(9) DEFAULT 0,
      `Deaths` mediumint(9) DEFAULT 0,
      `Damage` bigint(20) DEFAULT 0,
      `Playtime` mediumint(9) DEFAULT 0,
      `XP` bigint(9) DEFAULT 0,
      `First-Join` varchar(255) DEFAULT NULL,
      `Last-Join` varchar(255) DEFAULT NULL,
      `Matches-Won` smallint(6) DEFAULT 0,
      `Matches-Lost` smallint(6) DEFAULT 0,
      KEY `UID` (`UID`)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

    CREATE TABLE IF NOT EXISTS `rival_userdata` (
      `UID` int(11) NOT NULL AUTO_INCREMENT,
      `Admin` tinyint(4) DEFAULT 0,
      `BanTime` varchar(255) DEFAULT 0,
      `BanDate` varchar(255) DEFAULT NULL,
      `BanReason` varchar(155) DEFAULT NULL,
      `BannedBy` varchar(155) DEFAULT NULL,
      `ChatTag` varchar(50) DEFAULT 'MEMBER',
      `Friends` text DEFAULT NULL,
      `OwnedWeapons` text DEFAULT NULL,
      `OwnedClothing` text DEFAULT '{"Mask":[0,16,17,31,28,41],"Helmet":[0],"Hair":[0,7,14,20,41,49],"Torso":[0,7,14,20,41,49],"Pants":[0,15,25,26,41,43],"Parachute":[0,1,2,3,4,5],"Shoes":[0,4,7,17,24,31],"Undershirt":[0,4,9,15,41]}',
      KEY `UID` (`UID`)
    ) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4;
    
    CREATE TABLE IF NOT EXISTS `rival_warnings` (
      `UID` int(11) DEFAULT 0,
      `WarningId` int(11) NOT NULL AUTO_INCREMENT,
      `WarningType` varchar(25) DEFAULT NULL,
      `WarningAdmin` varchar(50) DEFAULT NULL,
      `WarningDate` varchar(255) DEFAULT NULL,
      `WarningReason` varchar(150) DEFAULT NULL,
      PRIMARY KEY (`warningId`),
      KEY `UID` (`UID`)
    ) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4;

    CREATE TABLE IF NOT EXISTS `rival_cases` (
      `UID` int(11) DEFAULT 0,
      `id` varchar(255) DEFAULT NULL,
      `Name` varchar(255) DEFAULT NULL,
      `Reason` varchar(255) DEFAULT NULL,
      `ReportedBy` varchar(255) DEFAULT NULL,
      PRIMARY KEY (`UID`),
      KEY `UID` (`UID`)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

    CREATE TABLE IF NOT EXISTS `rival_ids` (
      `UID` int(11) DEFAULT 0,
      `Token` varchar(255) DEFAULT NULL,
      KEY `Token` (`Token`)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
]])
end

function DATABASE:queryResult(query, data) -- SELECT
  local p = promise.new()
  if not query then
    return
  end

  exports['GHMattiMySQL']:QueryResultAsync(query, data or {}, function(...)
    p:resolve(...)
  end)

  return Citizen.Await(p)
end

function DATABASE:queryAsync(query, data) -- INSERT, UPDATE, DELETE
  local p = promise.new()
  if not query then
    return
  end

  exports['GHMattiMySQL']:QueryAsync(query, data or {}, function(...)
    p:resolve(...)
  end)

  return Citizen.Await(p)
end

Citizen.CreateThreadNow(function()
  DATABASE:initialize()
end)
