-- Leaked By: Leaking Hub | J. Snow | leakinghub.com
AxRadialMenu = {
    KeepInput = false,
    Menus = {
        [1] = {
            shoudclose = false,
            label = "Citizen",
            icon = "fas fa-user",
            submenu = {
                {
                    shoudclose = false,
                    label = "Share Contact",
                    submenu = false,
                    icon = "fas fa-user",
                    type = "client",
                    event = "qb-phone_new:client:GiveContactDetails"
                },
                {
                    shoudclose = false,
                    label = "Cuff",
                    submenu = false,
                    type = "client",
                    event = "police:client:CuffPlayerSoft",
                    icon = "fas fa-handshake-slash"
                },
                {
                    shoudclose = false,
                    label = "Escort",
                    submenu = false,
                    type = "client",
                    event = "police:client:KidnapPlayer",
                    icon = "fas fa-running"
                },
                {
                    shoudclose = false,
                    label = "Rob",
                    submenu = false,
                    type = "client",
                    event = "police:client:RobPlayer",
                    icon = "fas fa-wallet"
                },
                {
                    shoudclose = false,
                    label = "Put in vehicle",
                    submenu = false,
                    type = "client",
                    event = "police:client:PutPlayerInVehicle",
                    icon = "fas fa-car"
                },
                {
                    shoudclose = false,
                    label = "Take Out Of Veh",
                    submenu = false,
                    type = "client",
                    event = "police:client:SetPlayerOutVehicle",
                    icon = "fas fa-car"
                }
            }
        },
        [2] = {
            shoudclose = false,
            label = "House",
            icon = "fas fa-home",
            submenu = {
                {
                    shoudclose = false,
                    label = "Give Keys",
                    submenu = false,
                    type = "client",
                    event = "qb-houses:client:giveHouseKey",
                    icon = "fas fa-key"
                },
                {
                    shoudclose = false,
                    label = "Remove Key",
                    submenu = false,
                    type = "client",
                    event = "qb-houses:client:removeHouseKey",
                    icon = "fas fa-key"
                },
                {
                    shoudclose = false,
                    label = "Toggle Lock",
                    submenu = false,
                    type = "client",
                    event = "qb-houses:client:toggleDoorlock",
                    icon = "fas fa-key"
                },
                {
                    shoudclose = true,
                    label = "Decorate House",
                    submenu = false,
                    type = "client",
                    event = "qb-houses:client:decorate",
                    icon = "fas fa-wallet"
                },
                {
                    shoudclose = false,
                    label = "House Options",
                    icon = "fas fa-wallet",
                    submenu = {
                        {
                            shoudclose = false,
                            label = "Set Stash",
                            submenu = false,
                            type = "client",
                            event = "qb-houses:client:setLocation",
                            icon = "fas fa-wallet",
                            parameter = {id = "setstash"}
                        },
                        {
                            shoudclose = false,
                            label = "Set Wardrobe",
                            submenu = false,
                            type = "client",
                            event = "qb-houses:client:setLocation",
                            icon = "fas fa-wallet",
                            parameter = {id = "setoutift"}
                        },
                        {
                            shoudclose = false,
                            label = "Set Logout",
                            submenu = false,
                            type = "client",
                            event = "qb-houses:client:setLocation",
                            icon = "fas fa-wallet",
                            parameter = {id = "setlogout"}
                        }
                    }
                }
            }
        },
        [3] = {
            shoudclose = false,
            label = "Work",
            submenu = {},
            icon = "fas fa-briefcase"
        },
        [4] = {
            shoudclose = false,
            label = "Vehicle",
            icon = "fas fa-car",
            submenu = {
                {
                    shoudclose = false,
                    label = "Front Left",
                    submenu = false,
                    event = "Ax-Radial:Doors",
                    type = "client",
                    parameter = "f_l_doors",
                    icon = "fas fa-door-open"
                },
                {
                    shoudclose = false,
                    label = "Front Right",
                    submenu = false,
                    event = "Ax-Radial:Doors",
                    type = "client",
                    parameter = "f_r_doors",
                    icon = "fas fa-door-open"
                },
                {
                    shoudclose = false,
                    label = "Rear Left",
                    submenu = false,
                    event = "Ax-Radial:Doors",
                    type = "client",
                    parameter = "r_l_doors",
                    icon = "fas fa-door-open"
                },
                {
                    shoudclose = false,
                    label = "Rear Right",
                    submenu = false,
                    event = "Ax-Radial:Doors",
                    type = "client",
                    parameter = "r_r_doors",
                    icon = "fas fa-door-open"
                },
                {
                    shoudclose = false,
                    label = "Hood",
                    submenu = false,
                    event = "Ax-Radial:Doors",
                    type = "client",
                    parameter = "hood",
                    icon = "fas fa-car"
                },
                {
                    shoudclose = false,
                    label = "Trunk",
                    submenu = false,
                    event = "Ax-Radial:Doors",
                    type = "client",
                    parameter = "trunk",
                    icon = "fas fa-truck-loading"
                }
            }
        },
        [5] = {
            shoudclose = false,
            icon = "fas fa-walking",
            label = "Walk Styles",
            submenu = {
                {
                    shoudclose = false,
                    label = "Normal",
                    submenu = false,
                    icon = "fas fa-walking",
                    event = "Ax-Radial:Walkstyle",
                    parameter = "reset",
                    type = "client"
                },
                {
                    shoudclose = false,
                    label = "Lester",
                    submenu = false,
                    icon = "fas fa-walking",
                    event = "Ax-Radial:Walkstyle",
                    parameter = "lester",
                    type = "client"
                },
                {
                    shoudclose = false,
                    label = "Casual",
                    submenu = false,
                    icon = "fas fa-walking",
                    event = "Ax-Radial:Walkstyle",
                    parameter = "casual",
                    type = "client"
                },
                {
                    shoudclose = false,
                    label = "Alien",
                    submenu = false,
                    icon = "fab fa-reddit-alien",
                    event = "Ax-Radial:Walkstyle",
                    parameter = "alien",
                    type = "client"
                },
                {
                    shoudclose = false,
                    label = "Sexy",
                    submenu = false,
                    icon = "fas fa-walking",
                    event = "Ax-Radial:Walkstyle",
                    parameter = "sexy",
                    type = "client"
                },
                {
                    shoudclose = false,
                    label = "Tough",
                    submenu = false,
                    icon = "fas fa-walking",
                    event = "Ax-Radial:Walkstyle",
                    parameter = "tough",
                    type = "client"
                }
            }
        },
        [6] = {
            shoudclose = false,
            label = "Emotes",
            icon = "fas fa-theater-masks",
            submenu = {
                {
                    shoudclose = true,
                    label = "Dance",
                    submenu = false,
                    event = "Ax-Radial:Emote",
                    parameter = "dance",
                    type = "client",
                    icon = "fas fa-theater-masks"
                },
                {
                    shoudclose = true,
                    label = "Fold Arms",
                    submenu = false,
                    event = "Ax-Radial:Emote",
                    parameter = "foldarms",
                    type = "client",
                    icon = "fas fa-theater-masks"
                },
                {
                    shoudclose = true,
                    label = "Yoga",
                    submenu = false,
                    event = "Ax-Radial:Emote",
                    parameter = "yoga",
                    type = "client",
                    icon = "fas fa-theater-masks"
                },
                {
                    shoudclose = true,
                    label = "Air Hump",
                    submenu = false,
                    event = "Ax-Radial:Emote",
                    parameter = "yeah",
                    type = "client",
                    icon = "fas fa-theater-masks"
                },
                {
                    shoudclose = true,
                    label = "Dance Sily",
                    submenu = false,
                    event = "Ax-Radial:Emote",
                    parameter = "dance sily",
                    type = "client",
                    icon = "fas fa-theater-masks"
                },
                {
                    shoudclose = true,
                    label = "Flip Off",
                    submenu = false,
                    event = "Ax-Radial:Emote",
                    parameter = "flipoff",
                    type = "client",
                    icon = "fas fa-theater-masks"
                }
            }
        }
    },
    WorkMenu = {
        ["police"] = {
            {
                shoudclose = false,
                label = "EM Button",
                submenu = false,
                type = "client",
                event = "police:client:SendPoliceEmergencyAlert",
                icon = "fas fa-globe"
            },
            {
                shoudclose = false,
                label = "Tune Status",
                submenu = false,
                type = "client",
                event = "qb-tunerchip:server:TuneStatus",
                icon = "fas fa-key"
            },
            {
                shoudclose = false,
                label = "Reset house lock",
                submenu = false,
                type = "client",
                event = "qb-houses:client:ResetHouse",
                icon = "fas fa-key"
            },
            {
                shoudclose = false,
                label = "Drive License",
                submenu = false,
                type = "client",
                event = "police:client:SeizeDriverLicense",
                icon = "fas fa-car"
            },
            {
                shoudclose = false,
                label = "Police Interaction",
                icon = "fas fa-car",
                submenu = {
                    {
                        shoudclose = false,
                        label = "Soft Cuff",
                        submenu = false,
                        type = "client",
                        event = "police:client:CuffPlayerSoft",
                        icon = "fas fa-handshake-slash"
                    },
                    {
                        shoudclose = false,
                        label = "Hard Cuff",
                        submenu = false,
                        type = "client",
                        event = "police:client:CuffPlayer",
                        icon = "fas fa-handshake-slash"
                    },
                    {
                        shoudclose = false,
                        label = "Escort",
                        submenu = false,
                        type = "client",
                        event = "police:client:EscortPlayer",
                        icon = "fas fa-running"
                    },
                    {
                        shoudclose = false,
                        label = "Search",
                        submenu = false,
                        type = "client",
                        event = "police:client:SearchPlayer",
                        icon = "fas fa-globe"
                    },
                    {
                        shoudclose = false,
                        label = "Jail",
                        submenu = false,
                        type = "client",
                        event = "police:client:JailPlayer",
                        icon = "fas fa-globe"
                    }
                }
            },
            {
                shoudclose = false,
                label = "Objects",
                icon = "fas fa-globe",
                submenu = {
                    {
                        shoudclose = false,
                        label = "Cone",
                        submenu = false,
                        type = "client",
                        event = "police:client:spawnConer",
                        icon = "fas fa-key"
                    },
                    {
                        shoudclose = false,
                        label = "Gate",
                        submenu = false,
                        type = "client",
                        event = "police:client:spawnBarier",
                        icon = "fas fa-key"
                    },
                    {
                        shoudclose = false,
                        label = "Tent",
                        submenu = false,
                        type = "client",
                        event = "police:client:spawnTent",
                        icon = "fas fa-key"
                    },
                    {
                        shoudclose = false,
                        label = "Spike",
                        submenu = false,
                        type = "client",
                        event = "police:client:SpawnSpikeStrip",
                        icon = "fas fa-key"
                    },
                    {
                        shoudclose = false,
                        label = "Remove",
                        submenu = false,
                        type = "client",
                        event = "police:client:deleteObject",
                        icon = "fas fa-key"
                    }
                }
            }
        },
        ["ems"] = {
            {
                shoudclose = false,
                label = "Check Person",
                submenu = false,
                type = "client",
                event = "hospital:client:CheckStatus",
                icon = "fas fa-globe"
            },
            {
                shoudclose = false,
                label = "Heal Wounds",
                submenu = false,
                type = "client",
                event = "hospital:client:TreatWounds",
                icon = "fas fa-globe"
            },
            {
                shoudclose = false,
                label = "Revive",
                submenu = false,
                type = "client",
                event = "hospital:client:RevivePlayer",
                icon = "fas fa-globe"
            },
            {
                shoudclose = false,
                label = "EM Button",
                submenu = false,
                type = "client",
                event = "police:client:SendPoliceEmergencyAlert",
                icon = "fas fa-globe"
            },
            {
                shoudclose = false,
                label = "Escort",
                submenu = false,
                type = "client",
                event = "police:client:EscortPlayer",
                icon = "fas fa-globe"
            }
        }
    }
}