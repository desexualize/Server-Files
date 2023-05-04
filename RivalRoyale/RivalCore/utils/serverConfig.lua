if IsDuplicityVersion() then
  SERVER_CONFIG = {}
  SERVER_CONFIG.proxyEndpoint = 'http://localhost:5050/'
  SERVER_CONFIG.numClientCommands = 1263
  SERVER_CONFIG.maxNameLength = 20
  SERVER_CONFIG.chatTags = {['MEMBER'] = '#ebebeb', ['FOUNDER'] = '#ff4545'}

  SERVER_CONFIG.ACTypes = {
    ['Damage Modifications'] = 'D10',
    ['Lua Injection'] = 'L10',
    ['Native Injection'] = 'N8',
    ['Vehicle Modifications'] = 'V10',
    ['Game Modifications'] = 'G9',
  }

  SERVER_CONFIG.rateLimitedEvents = {
    ['RIVAL::cheatingCase'] = {},
    ['RIVAL::exitSquad'] = {},
    ['RIVAL::performAction'] = {},
    ['RIVAL::performAction'] = {},
    ['RIVAL::storeAllWeapons'] = {},
    ['RIVAL::storeWeapon'] = {},
  }

  SERVER_CONFIG.hooks = {
    ['Admin'] = '',
    ['Anticheat'] = '',
    ['Chat'] = '',
    ['Connection'] = '',
    ['Crash'] = '',
    ['Developer'] = '',
    ['Error'] = '',
  }

  SERVER_CONFIG.crateCoords = {
    vector3(4484.26, -4457.33, 3.3),
    vector3(4930.81, -4895.94, 3.69),
    vector3(4949.233, -5319.06, 8.02),
    vector3(5303.701172, -5603.70, 63.34),
    vector3(5486.18, -5847.88, 20.04),
    vector3(4982.33, -5873.64, 19.95),
    vector3(4761.13, -5002.72, 24.78),
  }

  -- chances of it spawning
  SERVER_CONFIG.crateDrops = {
    ['AR Ammo'] = 5,
    ['Glock 22'] = 4,
    ['M203'] = 2,
    ['M700a'] = 1,
    ['M870'] = 4,
    ['Mossberg 590'] = 4,
    ['NSR'] = 2,
    ['Pistol Ammo'] = 7,
    ['SIG 516'] = 2,
    ['SIGMpx'] = 3,
    ['SMG Ammo'] = 6,
    ['Sniper Ammo'] = 3,
    ['SR25'] = 1,
    ['Thompson'] = 4,
  }

  SERVER_CONFIG.gameRoutes = {
    {
      start = vector3(3474.78, -3937.54, 500.0),
      stop = vector3(5802.75, -6383.01, 500.0),
      zone = vector3(5062.72, -5348.13, 10.00),
      heading = 235.0,
    },
    {
      start = vector3(6522.02, -5266.44, 500.0),
      stop = vector3(3570.78, -4627.38, 500.0),
      zone = vector3(5020.69, -4891.01, 17.05),
      heading = 100.0,
    },
    {
      start = vector3(4964.63, -6534.22, 500.0),
      stop = vector3(4754.42, -3863.23, 500.0),
      zone = vector3(4601.43, -4840.02, 14.60),
      heading = 10.0,
    },
  }

  SERVER_CONFIG.vehicleSpawns = {
    Land = {
      vector3(4919.244, -5237.352, 2.53),
      vector3(5186.676, -5133.167, 3.40),
      vector3(5265.987, -5413.466, 65.3),
      vector3(5076.924, -5724.477, 16.0),
      vector3(5586.811, -5236.158, 15.3),
      vector3(5001.021, -4929.330, 8.95),
      vector3(4420.680, -4476.320, 4.40),
      vector3(4356.376, -4587.476, 5.30),
    },
    Water = {
      vector3(4930.625, -5177.290, 0.0),
      vector3(4900.328, -5173.798, 0.0),
      vector3(4884.478, -5164.423, 0.0),
      vector3(4487.542, -4379.840, 0.0),
      vector3(5383.852, -5079.530, 0.0),
      vector3(5574.793, -5766.919, 0.0),
      vector3(5116.590, -5773.000, 0.0),
      vector3(5022.952, -5848.400, 0.0),
    },
  }

  SERVER_CONFIG.blockedExplosions = {
    [0] = {true, 'EXPLOSION_GRENADE'},
    [1] = {true, 'EXPLOSION_GRENADELAUNCHER'},
    [2] = {true, 'EXPLOSION_STICKYBOMB'},
    [3] = {true, 'EXPLOSION_MOLOTOV'},
    [4] = {true, 'EXPLOSION_ROCKET'},
    [5] = {true, 'EXPLOSION_TANKSHELL'},
    [6] = {true, 'EXPLOSION_HI_OCTANE'},
    [7] = {false, 'EXPLOSION_CAR'},
    [8] = {false, 'EXPLOSION_PLANE'},
    [9] = {false, 'EXPLOSION_PETROL_PUMP'},
    [10] = {false, 'EXPLOSION_BIKE'},
    [11] = {false, 'EXPLOSION_DIR_STEAM'},
    [12] = {false, 'EXPLOSION_DIR_FLAME'},
    [13] = {false, 'EXPLOSION_DIR_WATER_HYDRANT'},
    [14] = {false, 'EXPLOSION_DIR_GAS_CANISTER'},
    [15] = {false, 'EXPLOSION_BOAT'},
    [16] = {true, 'EXPLOSION_SHIP_DESTROY'},
    [17] = {false, 'EXPLOSION_TRUCK'},
    [18] = {true, 'EXPLOSION_BULLET'},
    [19] = {true, 'EXPLOSION_SMOKEGRENADELAUNCHER'},
    [20] = {true, 'EXPLOSION_SMOKEGRENADE'},
    [21] = {true, 'EXPLOSION_BZGAS'},
    [22] = {true, 'EXPLOSION_FLARE'},
    [23] = {false, 'EXPLOSION_GAS_CANISTER'},
    [24] = {false, 'EXPLOSION_EXTINGUISHER'},
    [25] = {true, 'EXPLOSION_PROGRAMMABLEAR'},
    [26] = {true, 'EXPLOSION_TRAIN'},
    [27] = {false, 'EXPLOSION_BARREL'},
    [28] = {false, 'EXPLOSION_PROPANE'},
    [29] = {true, 'EXPLOSION_BLIMP'},
    [30] = {false, 'EXPLOSION_DIR_FLAME_EXPLODE'},
    [31] = {false, 'EXPLOSION_TANKER'},
    [32] = {true, 'EXPLOSION_PLANE_ROCKET'},
    [33] = {true, 'EXPLOSION_VEHICLE_BULLET'},
    [34] = {false, 'EXPLOSION_GAS_TANK'},
    [35] = {true, 'EXPLOSION_BIRD_CRAP'},
  }
end
