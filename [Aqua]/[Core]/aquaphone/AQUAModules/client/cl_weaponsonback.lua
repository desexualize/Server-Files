 -- Love me plz lemme be dev, plz ill send newds

 local orientation = false -- False = Vertical | True = Horizontal

function notify(msg)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(msg)
    DrawNotification(true, false)
end

RegisterNetEvent("weaponsonback:trigger")
AddEventHandler("weaponsonback:trigger", function()
    orientation = not orientation
    if orientation then
        RemoveGears()
    	notify("~g~Weapon Orientation set to Horizontal.")
    end
    if not orientation then
        RemoveGears()
    	notify("~g~Weapon Orientation set to Vertical.")
    end
end)

 WeaponsOnBackConfig = {}
 -- bone = 24818, x = -0.35,    y = -0.10, 	z = 0.13,     xRot = 190.0, yRot = 180.0, zRot = 105.0,
 -- 'bone' use bonetag https://pastebin.com/D7JMnX1g
 -- x,y,z are offsets
 WeaponsOnBackConfig.RealWeapons = {
   -- Melees + smg keep these here till i think of a different way
   
   {
    name = "WEAPON_MP5",
    bone = 58271,
    x = -0.01,
    y = 0.1,
    z = -0.07,
    xRot = -55.0,
    yRot = 0.10,
    zRot = 0.0,
    category = "assault",
    model = "w_sb_mp5"
},
{
    name = "WEAPON_cq300",
    bone = 58271,
    x = -0.01,
    y = 0.1,
    z = -0.07,
    xRot = -55.0,
    yRot = 0.10,
    zRot = 0.0,
    category = "assault",
    model = "w_sb_cq300"
},
{
    name = "WEAPON_MP9PD",
    bone = 58271,
    x = -0.01,
    y = 0.1,
    z = -0.07,
    xRot = -55.0,
    yRot = 0.10,
    zRot = 0.0,
    category = "assault",
    model = "w_sb_mp9"
},


{
    name = "WEAPON_PDHK416",
    bone = 24818,
    x = -0.04,
    y = 0.25,
    z = 0.05,
    xRot = -2.0,
    yRot = 324.50,
    zRot = 185.75,
    category = "assault",
    model = "w_ar_pdhk416"
},
{
    name = "WEAPON_PDMCX",
    bone = 24818,
    x = -0.04,
    y = 0.25,
    z = 0.05,
    xRot = -2.0,
    yRot = 324.50,
    zRot = 185.75,
    category = "assault",
    model = "w_ar_PDMCX"
},
{
    name = "WEAPON_spar17",
    bone = 24818,
    x = -0.04,
    y = 0.25,
    z = 0.05,
    xRot = -2.0,
    yRot = 324.50,
    zRot = 185.75,
    category = "assault",
    model = "w_ar_spar17"
},
{
    name = "WEAPON_M16A1PD",
    bone = 24818,
    x = -0.04,
    y = 0.25,
    z = 0.05,
    xRot = -2.0,
    yRot = 324.50,
    zRot = 185.75,
    category = "assault",
    model = "w_ar_m16a1pd"
},
{
    name = "WEAPON_SA80",
    bone = 24818,
    x = -0.04,
    y = 0.25,
    z = 0.05,
    xRot = -2.0,
    yRot = 324.50,
    zRot = 185.75,
    category = "assault",
    model = "w_ar_sa80"
},
{
    name = "WEAPON_M4SANDSTORM",
    bone = 24818,
    x = -0.12,
    y = -0.13,
    z = -0.13,
    xRot = 100.0,
    yRot = -3.0,
    zRot = 5.0,
    category = "assault",
    model = "w_ar_m4sandstorm"
},
{
    name = "WEAPON_MP40",
    bone = 58271,
    x = -0.01,
    y = 0.1,
    z = -0.07,
    xRot = -55.0,
    yRot = 0.10,
    zRot = 0.0,
    category = "smg",
    model = "w_sb_mp40"
},
{
    name = "WEAPON_scorpianblue",
    bone = 58271,
    x = -0.01,
    y = 0.1,
    z = -0.07,
    xRot = -55.0,
    yRot = 0.10,
    zRot = 0.0,
    category = "shotgun",
    model = "w_sb_scorpionblue"
},
{
    name = "WEAPON_UMPV2NEONOIR",
    bone = 58271,
    x = -0.01,
    y = 0.1,
    z = -0.07,
    xRot = -55.0,
    yRot = 0.10,
    zRot = 0.0,
    category = "shotgun",
    model = "w_sb_umpv2neonoir"
},
{
    name = "WEAPON_blackicepeacekeeper",
    bone = 58271,
    x = -0.01,
    y = 0.1,
    z = -0.07,
    xRot = -55.0,
    yRot = 0.10,
    zRot = 0.0,
    category = "shotgun",
    model = "w_sb_blackicepeacekeeper"
},
{
    name = "WEAPON_ICEVECTOR",
    bone = 58271,
    x = -0.01,
    y = 0.1,
    z = -0.07,
    xRot = -55.0,
    yRot = 0.10,
    zRot = 0.0,
    category = "shotgun",
    model = "w_sb_icevector"
},

{
    name = "WEAPON_DIAMONDMP5",
    bone = 58271,
    x = -0.01,
    y = 0.1,
    z = -0.07,
    xRot = -55.0,
    yRot = 0.10,
    zRot = 0.0,
    category = "shotgun",
    model = "w_sb_diamondmp5"
},
{
    name = "WEAPON_REMINGTON700",
    bone = 24818,
    x = -0.12,
    y = -0.14,
    z = -0.13,
    xRot = 100.0,
    yRot = -3.0,
    zRot = 5.0,
    category = "assault",
    model = "w_sr_remington700"
},
{
    name = "WEAPON_AX50",
    bone = 24818,
    x = -0.12,
    y = -0.14,
    z = -0.13,
    xRot = 100.0,
    yRot = -3.0,
    zRot = 5.0,
    category = "assault",
    model = "w_sr_ax50"
},
{
    name = "WEAPON_L96A3",
    bone = 24818,
    x = -0.12,
    y = -0.14,
    z = -0.13,
    xRot = 100.0,
    yRot = -3.0,
    zRot = 5.0,
    category = "assault",
    model = "w_sr_l96a3"
},
{
    name = "WEAPON_NEONOIRMAC10",
    bone = 58271,
    x = -0.01,
    y = 0.1,
    z = -0.07,
    xRot = -55.0,
    yRot = 0.10,
    zRot = 0.0,
    category = "smg",
    model = "w_sb_neonoirmac10"
},
{
    name = "WEAPON_UMP45",
    bone = 58271,
    x = -0.01,
    y = 0.1,
    z = -0.07,
    xRot = -55.0,
    yRot = 0.10,
    zRot = 0.0,
    category = "smg",
    model = "w_sb_ump45"
},

{
    name = "WEAPON_MP7",
    bone = 58271,
    x = -0.01,
    y = 0.1,
    z = -0.07,
    xRot = -55.0,
    yRot = 0.10,
    zRot = 0.0,
    category = "shotgun",
    model = "w_sb_mp7"
},
{
    name = "WEAPON_VESPER",
    bone = 24818,
    x = -0.04,
    y = 0.25,
    z = 0.05,
    xRot = -2.0,
    yRot = 324.50,
    zRot = 185.75,
    category = "assault",
    model = "w_sb_vesper"
},
{
    name = "WEAPON_BROOM",
    bone = 24818,
    x = -0.60,
    y = -0.15,
    z = 0.13,
    xRot = 50.0,
    yRot = 90.0,
    zRot = 2.0,
    category = "melee",
    model = "w_me_broom"
},
{
    name = "WEAPON_TOILETBRUSH",
    bone = 24818,
    x = 0.32,
    y = -0.15,
    z = 0.13,
    xRot = 0.0,
    yRot = -90.0,
    zRot = 0.0,
    category = "melee",
    model = "w_me_toiletbrush"
},
{
    name = "WEAPON_DILDO",
    bone = 24818,
    x = 0.32,
    y = -0.15,
    z = 0.13,
    xRot = 0.0,
    yRot = -90.0,
    zRot = 0.0,
    category = "melee",
    model = "w_me_dildo"
},
-----
   
   
    {
        name = "WEAPON_REMINGTON870",
        bone = 24818,
        x = 0.0,
        y = -0.15,
        z = 0.00,
        xRot = 0.0,
        yRot = 45.0,
        zRot = 0.0,
        category = "shotgun",
        model = "w_sg_remington870"
    },
    {
        name = "WEAPON_FNTACSHOTGUN",
        bone = 24818,
        x = 0.0,
        y = -0.15,
        z = 0.00,
        xRot = 0.0,
        yRot = 45.0,
        zRot = 0.0,
        category = "shotgun",
        model = "w_sg_fortnitetacshotgun"
    },
    {
        name = "WEAPON_WINCHESTER",
        bone = 24818,
        x = 0.0,
        y = -0.15,
        z = 0.00,
        xRot = 0.0,
        yRot = 45.0,
        zRot = 0.0,
        category = "shotgun",
        model = "w_sg_winchester"
    },
    {
        name = "WEAPON_M4A1",
        bone = 24818,
        x = 0.0,
        y = -0.15,
        z = 0.00,
        xRot = 0.0,
        yRot = 45.0,
        zRot = 0.0,
        category = "assault",
        model = "w_ar_m4a1"
    },
    {
        name = "WEAPON_HK416",
        bone = 24818,
        x = 0.0,
        y = -0.15,
        z = 0.00,
        xRot = 0.0,
        yRot = 45.0,
        zRot = 0.0,
        category = "assault",
        model = "w_ar_hk416"
    },
    {
        name = "WEAPON_MK1EMR",
        bone = 24818,
        x = 0.0,
        y = -0.15,
        z = 0.00,
        xRot = 0.0,
        yRot = 45.0,
        zRot = 0.0,
        category = "assault",
        model = "w_ar_mk1emr"
    },
    {
        name = "WEAPON_AK74",
        bone = 24818,
        x = 0.0,
        y = -0.15,
        z = 0.00,
        xRot = 0.0,
        yRot = 45.0,
        zRot = 0.0,
        category = "assault",
        model = "w_ar_ak74"
    },
    {
        name = "WEAPON_RUSTAK",
        bone = 24818,
        x = 0.0,
        y = -0.15,
        z = 0.00,
        xRot = 0.0,
        yRot = 45.0,
        zRot = 0.0,
        category = "assault",
        model = "w_ar_rustak"
    },
    
    {
        name = "WEAPON_MXM",
        bone = 24818,
        x = 0.0,
        y = -0.15,
        z = 0.00,
        xRot = 0.0,
        yRot = 45.0,
        zRot = 0.0,
        category = "assault",
        model = "w_ar_mxm"
    },
    {
        name = "WEAPON_MXC",
        bone = 24818,
        x = 0.0,
        y = -0.15,
        z = 0.00,
        xRot = 0.0,
        yRot = 45.0,
        zRot = 0.0,
        category = "assault",
        model = "w_ar_mxc"
    },
   
    {
        name = "WEAPON_AKM",
        bone = 24818,
        x = 0.0,
        y = -0.15,
        z = 0.00,
        xRot = 0.0,
        yRot = 45.0,
        zRot = 0.0,
        category = "assault",
        model = "w_ar_akm"
    },
    {
        name = "WEAPON_AK200",
        bone = 24818,
        x = 0.0,
        y = -0.15,
        z = 0.00,
        xRot = 0.0,
        yRot = 45.0,
        zRot = 0.0,
        category = "assault",
        model = "w_ar_akkal"
    },
    {
        name = "WEAPON_HKJAMO",
        bone = 24818,
        x = 0.0,
        y = -0.15,
        z = 0.00,
        xRot = 0.0,
        yRot = 45.0,
        zRot = 0.0,
        category = "assault",
        model = "w_ar_hk416eft"
    },
    {
        name = "WEAPON_MOSIN",
        bone = 24818,
        x = 0.0,
        y = -0.2,
        z = 0.0,
        xRot = 0.0,
        yRot = 45.0,
        zRot = 0.0,
        category = "assault",
        model = "w_ar_mosin"
    },
    {
        name = "WEAPON_NERFMOSIN",
        bone = 24818,
        x = 0.0,
        y = -0.2,
        z = 0.0,
        xRot = 0.0,
        yRot = 45.0,
        zRot = 0.0,
        category = "assault",
        model = "w_ar_nerfmosin"
    },
    {
        name = "WEAPON_CHERRYMOSIN",
        bone = 24818,
        x = 0.0,
        y = -0.2,
        z = 0.0,
        xRot = 0.0,
        yRot = 45.0,
        zRot = 0.0,
        category = "assault",
        model = "w_ar_cherrymosin"
    },
    {
        name = "WEAPON_NOVMOSIN",
        bone = 24818,
        x = 0.0,
        y = -0.2,
        z = 0.0,
        xRot = 0.0,
        yRot = 45.0,
        zRot = 0.0,
        category = "assault",
        model = "w_ar_novmosin"
    },
    {
        name = "WEAPON_SVD",
        bone = 24818,
        x = 0.0,
        y = -0.15,
        z = 0.00,
        xRot = 0.0,
        yRot = 45.0,
        zRot = 0.0,
        category = "assault",
        model = "w_sr_svd"
    },
    {
        name = "WEAPON_REAVEROP",
        bone = 24818,
        x = 0.0,
        y = -0.15,
        z = 0.00,
        xRot = 0.0,
        yRot = 45.0,
        zRot = 0.0,
        category = "assault",
        model = "w_sr_reaveroperator"
    },
    
    {
        name = "WEAPON_GOLDAK",
        bone = 24818,
        x = 0.0,
        y = -0.15,
        z = 0.00,
        xRot = 0.0,
        yRot = 45.0,
        zRot = 0.0,
        category = "assault",
        model = "w_ar_goldak"
    },

    {
        name = "WEAPON_M4A4FIRE",
        bone = 24818,
        x = 0.0,
        y = -0.15,
        z = 0.00,
        xRot = 0.0,
        yRot = 45.0,
        zRot = 0.0,
        category = "assault",
        model = "w_ar_m4a4fire"
    },
    {
        name = "WEAPON_RGXVANDAL",
        bone = 24818,
        x = 0.0,
        y = -0.15,
        z = 0.00,
        xRot = 0.0,
        yRot = 45.0,
        zRot = 0.0,
        category = "assault",
        model = "w_ar_rgxvandal"
    },
    {
        name = "WEAPON_PRIMEVANDAL",
        bone = 24818,
        x = 0.0,
        y = -0.15,
        z = 0.00,
        xRot = 0.0,
        yRot = 45.0,
        zRot = 0.0,
        category = "assault",
        model = "w_ar_primevandal"
    },
    {
        name = "WEAPON_spar16",
        bone = 24818,
        x = 0.0,
        y = -0.15,
        z = 0.00,
        xRot = 0.0,
        yRot = 45.0,
        zRot = 0.0,
        category = "assault",
        model = "w_ar_spar16"
    },
    {
        name = "WEAPON_MEDSWORD",
        bone = 24818,
        x = 0.0,
        y = -0.15,
        z = 0.00,
        xRot = 0.0,
        yRot = 45.0,
        zRot = 0.0,
        category = "assault",
        model = "medievalsword"
    },
    {
        name = "WEAPON_SAGIRI",
        bone = 24818,
        x = 0.0,
        y = -0.15,
        z = 0.00,
        xRot = 0.0,
        yRot = 45.0,
        zRot = 0.0,
        category = "assault",
        model = "w_ar_sagiri"
    },

    {
        name = "WEAPON_GRAU556",
        bone = 24818,
        x = 0.0,
        y = -0.15,
        z = 0.00,
        xRot = 0.0,
        yRot = 45.0,
        zRot = 0.0,
        category = "assault",
        model = "w_ar_grau556"
    },
    {
        name = "WEAPON_BLASTXPHANTOM",
        bone = 24818,
        x = 0.0,
        y = -0.15,
        z = 0.00,
        xRot = 0.0,
        yRot = 45.0,
        zRot = 0.0,
        category = "assault",
        model = "WEAPON_BLASTXPHANTOM"
    },
  
}


WeaponsOnBackConfig.RealWeapons2 = {
    --melee
    {
        name = "WEAPON_BROOM",
        bone = 24818,
        x = -0.60,
        y = -0.15,
        z = 0.13,
        xRot = 50.0,
        yRot = 90.0,
        zRot = 2.0,
        category = "melee",
        model = "w_me_broom"
    },
    {
        name = "WEAPON_TOILETBRUSH",
        bone = 51826,
        x = -0.01,
        y = 0.10,
        z = 0.07,
        xRot = 0.0,
        yRot = 0.0,
        zRot = -100.0,
        category = "melee",
        model = "w_me_toiletbrush"
    },
    {
        name = "WEAPON_DILDO",
        bone = 58271,
        x = -0.01,
        y = 0.1,
        z = -0.07,
        xRot = -35.0,
        yRot = 0.10,
        zRot = -100.0,
        category = "melee",
        model = "w_me_dildo"
    },
    --
    {
        name = "WEAPON_REMINGTON870",
        bone = 24818,
        x = 0.02,
        y = -0.12,
        z = -0.13,
        xRot = 100.0,
        yRot = -3.0,
        zRot = 5.0,
        category = "shotgun",
        model = "w_sg_remington870"
    },
    {
        name = "WEAPON_FNTACSHOTGUN",
        bone = 24818,
        x = -0.12,
        y = -0.12,
        z = -0.13,
        xRot = 100.0,
        yRot = -3.0,
        zRot = 5.0,
        category = "shotgun",
        model = "w_sg_fortnitetacshotgun"
    },
    {
        name = "WEAPON_WINCHESTER",
        bone = 24818,
        x = -0.12,
        y = -0.12,
        z = -0.13,
        xRot = 100.0,
        yRot = -3.0,
        zRot = 5.0,
        category = "shotgun",
        model = "w_sg_winchester"
    },
    {
        name = "WEAPON_MP7",
        bone = 58271,
        x = -0.01,
        y = 0.1,
        z = -0.07,
        xRot = -55.0,
        yRot = 0.10,
        zRot = 0.0,
        category = "shotgun",
        model = "w_sb_mp7"
    },
    {
        name = "WEAPON_VESPER",
        bone = 24818,
        x = -0.04,
        y = 0.25,
        z = 0.05,
        xRot = -2.0,
        yRot = 324.50,
        zRot = 185.75,
        category = "assault",
        model = "w_sb_vesper"
    },
    {
        name = "WEAPON_M4A1",
        bone = 24818,
        x = -0.12,
        y = -0.14,
        z = -0.13,
        xRot = 100.0,
        yRot = -3.0,
        zRot = 5.0,
        category = "assault",
        model = "w_ar_m4a1"
    },
    {
        name = "WEAPON_HK416",
        bone = 24818,
        x = -0.12,
        y = -0.12,
        z = -0.13,
        xRot = 100.0,
        yRot = -3.0,
        zRot = 5.0,
        category = "assault",
        model = "w_ar_hk416"
    },
    {
        name = "WEAPON_MK1EMR",
        bone = 24818,
        x = -0.12,
        y = -0.12,
        z = -0.13,
        xRot = 100.0,
        yRot = -3.0,
        zRot = 5.0,
        category = "assault",
        model = "w_ar_mk1emr"
    },
    {
        name = "WEAPON_AK74",
        bone = 24818,
        x = -0.12,
        y = -0.12,
        z = -0.13,
        xRot = 100.0,
        yRot = -3.0,
        zRot = 5.0,
        category = "assault",
        model = "w_ar_ak74"
    },
    {
        name = "WEAPON_RUSTAK",
        bone = 24818,
        x = -0.12,
        y = -0.12,
        z = -0.13,
        xRot = 100.0,
        yRot = -3.0,
        zRot = 5.0,
        category = "assault",
        model = "w_ar_rustak"
    },
    {
        name = "WEAPON_MXM",
        bone = 24818,
        x = -0.12,
        y = -0.12,
        z = -0.13,
        xRot = 100.0,
        yRot = -3.0,
        zRot = 5.0,
        category = "assault",
        model = "w_ar_mxm"
    },
    {
        name = "WEAPON_MXC",
        bone = 24818,
        x = -0.12,
        y = -0.12,
        z = -0.13,
        xRot = 100.0,
        yRot = -3.0,
        zRot = 5.0,
        category = "assault",
        model = "w_ar_mxc"
    },
    {
        name = "WEAPON_AKM",
        bone = 24818,
        x = -0.12,
        y = -0.12,
        z = -0.13,
        xRot = 100.0,
        yRot = -3.0,
        zRot = 5.0,
        category = "assault",
        model = "w_ar_akm"
    },
    {
        name = "WEAPON_AK200",
        bone = 24818,
        x = -0.12,
        y = -0.12,
        z = -0.13,
        xRot = 100.0,
        yRot = -3.0,
        zRot = 5.0,
        category = "assault",
        model = "w_ar_akkal"
    },
    {
        name = "WEAPON_HKJAMO",
        bone = 24818,
        x = -0.12,
        y = -0.12,
        z = -0.13,
        xRot = 100.0,
        yRot = -3.0,
        zRot = 5.0,
        category = "assault",
        model = "w_ar_hk416eft"
    },
    
    {
        name = "WEAPON_MOSIN",
        bone = 24818,
        x = -0.12,
        y = -0.12,
        z = -0.13,
        xRot = 100.0,
        yRot = -3.0,
        zRot = 5.0,
        category = "assault",
        model = "w_ar_mosin"
    },
    {
        name = "WEAPON_NERFMOSIN",
        bone = 24818,
        x = -0.12,
        y = -0.12,
        z = -0.13,
        xRot = 100.0,
        yRot = -3.0,
        zRot = 5.0,
        category = "assault",
        model = "w_ar_nerfmosin"
    },
    {
        name = "WEAPON_CHERRYMOSIN",
        bone = 24818,
        x = -0.12,
        y = -0.12,
        z = -0.13,
        xRot = 100.0,
        yRot = -3.0,
        zRot = 5.0,
        category = "assault",
        model = "w_ar_cherrymosin"
    },
    {
        name = "WEAPON_NOVMOSIN",
        bone = 24818,
        x = -0.12,
        y = -0.12,
        z = -0.13,
        xRot = 100.0,
        yRot = -3.0,
        zRot = 5.0,
        category = "assault",
        model = "w_ar_novmosin"
    },
    {
        name = "WEAPON_SVD",
        bone = 24818,
        x = -0.12,
        y = -0.14,
        z = -0.13,
        xRot = 100.0,
        yRot = -3.0,
        zRot = 5.0,
        category = "assault",
        model = "w_sr_svd"
    },
    {
        name = "WEAPON_REAVEROP",
        bone = 24818,
        x = -0.12,
        y = -0.14,
        z = -0.13,
        xRot = 100.0,
        yRot = -3.0,
        zRot = 5.0,
        category = "assault",
        model = "w_sr_reaveroperator"
    },
    {
        name = "WEAPON_REMINGTON700",
        bone = 24818,
        x = -0.12,
        y = -0.14,
        z = -0.13,
        xRot = 100.0,
        yRot = -3.0,
        zRot = 5.0,
        category = "assault",
        model = "w_sr_remington700"
    },
    {
        name = "WEAPON_L96A3",
        bone = 24818,
        x = -0.12,
        y = -0.14,
        z = -0.13,
        xRot = 100.0,
        yRot = -3.0,
        zRot = 5.0,
        category = "assault",
        model = "w_sr_l96a3"
    },
    {
        name = "WEAPON_NEONOIRMAC10",
        bone = 58271,
        x = -0.01,
        y = 0.1,
        z = -0.07,
        xRot = -55.0,
        yRot = 0.10,
        zRot = 0.0,
        category = "smg",
        model = "w_sb_neonoirmac10"
    },
    {
        name = "WEAPON_UMP45",
        bone = 58271,
        x = -0.01,
        y = 0.1,
        z = -0.07,
        xRot = -55.0,
        yRot = 0.10,
        zRot = 0.0,
        category = "smg",
        model = "w_sb_ump45"
    },
    {
        name = "WEAPON_GOLDAK",
        bone = 24818,
        x = -0.12,
        y = -0.13,
        z = -0.13,
        xRot = 100.0,
        yRot = -3.0,
        zRot = 5.0,
        category = "assault",
        model = "w_ar_goldak"
    },
    {
        name = "WEAPON_spar16",
        bone = 24818,
        x = -0.12,
        y = -0.13,
        z = -0.13,
        xRot = 100.0,
        yRot = -3.0,
        zRot = 5.0,
        category = "assault",
        model = "w_ar_spar16"
    },
    {
        name = "WEAPON_MEDSWORD",
        bone = 24818,
        x = -0.12,
        y = -0.13,
        z = -0.13,
        xRot = 100.0,
        yRot = -3.0,
        zRot = 5.0,
        category = "assault",
        model = "medievalsword"
    },
    {
        name = "WEAPON_GRAU556",
        bone = 24818,
        x = -0.12,
        y = -0.13,
        z = -0.13,
        xRot = 100.0,
        yRot = -3.0,
        zRot = 5.0,
        category = "assault",
        model = "w_ar_grau556"
    },
    {
        name = "WEAPON_BLASTXPHANTOM",
        bone = 24818,
        x = -0.12,
        y = -0.13,
        z = -0.13,
        xRot = 100.0,
        yRot = -3.0,
        zRot = 5.0,
        category = "assault",
        model = "w_ar_blastxphantom"
    },
    {
        name = "WEAPON_M4A4FIRE",
        bone = 24818,
        x = -0.12,
        y = -0.13,
        z = -0.13,
        xRot = 100.0,
        yRot = -3.0,
        zRot = 5.0,
        category = "assault",
        model = "w_ar_m4a4fire"
    },
    {
        name = "WEAPON_RGXVANDAL",
        bone = 24818,
        x = -0.12,
        y = -0.13,
        z = -0.13,
        xRot = 100.0,
        yRot = -3.0,
        zRot = 5.0,
        category = "assault",
        model = "w_ar_rgxvandal"
    },
    {
        name = "WEAPON_PRIMEVANDAL",
        bone = 24818,
        x = -0.12,
        y = -0.13,
        z = -0.13,
        xRot = 100.0,
        yRot = -3.0,
        zRot = 5.0,
        category = "assault",
        model = "w_ar_primevandal"
    },
    {
        name = "WEAPON_M16A1",
        bone = 24818,
        x = -0.12,
        y = -0.13,
        z = -0.13,
        xRot = 100.0,
        yRot = -3.0,
        zRot = 5.0,
        category = "assault",
        model = "w_ar_m16a1"
    },
    {
        name = "WEAPON_MP5",
        bone = 58271,
        x = -0.01,
        y = 0.1,
        z = -0.07,
        xRot = -55.0,
        yRot = 0.10,
        zRot = 0.0,
        category = "assault",
        model = "w_sb_mp5"
    },
    {
        name = "WEAPON_cq300",
        bone = 58271,
        x = -0.01,
        y = 0.1,
        z = -0.07,
        xRot = -55.0,
        yRot = 0.10,
        zRot = 0.0,
        category = "assault",
        model = "w_sb_cq300"
    },
    {
        name = "WEAPON_MP9PD",
        bone = 58271,
        x = -0.01,
        y = 0.1,
        z = -0.07,
        xRot = -55.0,
        yRot = 0.10,
        zRot = 0.0,
        category = "assault",
        model = "w_sb_mp9"
    },
    {
        name = "WEAPON_PDHK416",
        bone = 24818,
        x = -0.04,
        y = 0.25,
        z = 0.05,
        xRot = -2.0,
        yRot = 324.50,
        zRot = 185.75,
        category = "assault",
        model = "w_ar_pdhk416"
    },
    {
        name = "WEAPON_PDMCX",
        bone = 24818,
        x = -0.04,
        y = 0.25,
        z = 0.05,
        xRot = -2.0,
        yRot = 324.50,
        zRot = 185.75,
        category = "assault",
        model = "w_ar_PDMCX"
    },
    {
        name = "WEAPON_spar17",
        bone = 24818,
        x = -0.04,
        y = 0.25,
        z = 0.05,
        xRot = -2.0,
        yRot = 324.50,
        zRot = 185.75,
        category = "assault",
        model = "w_ar_spar17"
    },
    {
        name = "WEAPON_M16A1PD",
        bone = 24818,
        x = -0.04,
        y = 0.25,
        z = 0.05,
        xRot = -2.0,
        yRot = 324.50,
        zRot = 185.75,
        category = "assault",
        model = "w_ar_m16a1pd"
    },
    {
        name = "WEAPON_SA80",
        bone = 24818,
        x = -0.04,
        y = 0.25,
        z = 0.05,
        xRot = -2.0,
        yRot = 324.50,
        zRot = 185.75,
        category = "assault",
        model = "w_ar_sa80"
    },
    {
        name = "WEAPON_M4SANDSTORM",
        bone = 24818,
        x = -0.04,
        y = 0.25,
        z = 0.05,
        xRot = -2.0,
        yRot = 324.50,
        zRot = 185.75,
        category = "assault",
        model = "w_ar_m4sandstorm"
    },
    {
        name = "WEAPON_MP40",
        bone = 58271,
        x = -0.01,
        y = 0.1,
        z = -0.07,
        xRot = -55.0,
        yRot = 0.10,
        zRot = 0.0,
        category = "smg",
        model = "w_sb_mp40"
    },
    {
        name = "WEAPON_scorpianblue",
        bone = 58271,
        x = -0.01,
        y = 0.1,
        z = -0.07,
        xRot = -55.0,
        yRot = 0.10,
        zRot = 0.0,
        category = "shotgun",
        model = "w_sb_scorpionblue"
    },
    {
        name = "WEAPON_UMPV2NEONOIR",
        bone = 58271,
        x = -0.01,
        y = 0.1,
        z = -0.07,
        xRot = -55.0,
        yRot = 0.10,
        zRot = 0.0,
        category = "shotgun",
        model = "w_sb_umpv2neonoir"
    },
    {
        name = "WEAPON_blackicepeacekeeper",
        bone = 58271,
        x = -0.01,
        y = 0.1,
        z = -0.07,
        xRot = -55.0,
        yRot = 0.10,
        zRot = 0.0,
        category = "shotgun",
        model = "w_sb_blackicepeacekeeper"
    },
    {
        name = "WEAPON_ICEVECTOR",
        bone = 58271,
        x = -0.01,
        y = 0.1,
        z = -0.07,
        xRot = -55.0,
        yRot = 0.10,
        zRot = 0.0,
        category = "shotgun",
        model = "w_sb_icevector"
    },
    {
        name = "WEAPON_DIAMONDMP5",
        bone = 58271,
		x = -0.01,
		y = 0.1,
		z = -0.07,
		xRot = -55.0,
		yRot = 0.10,
		zRot = 0.0,
        category = "shotgun",
        model = "w_sb_diamondmp5"
    }
    
}

 
 local Weapons = {}
 
 
 function dump(o)
	if type(o) == 'table' then
	   local s = '{ '
	   for k,v in pairs(o) do
		  if type(k) ~= 'number' then k = '"'..k..'"' end
		  s = s .. '['..k..'] = ' .. dump(v) .. ','
	   end
	   return s .. '} '
	else
	   return tostring(o)
	end
 end
 
 Citizen.CreateThread(function()
	 while true do
        Wait(1500)
		 local playerPed = GetPlayerPed(-1)
 
		 for i=1, #WeaponsOnBackConfig.RealWeapons, 1 do
 
			 local weaponHash = GetHashKey(WeaponsOnBackConfig.RealWeapons[i].name)
 
			 if HasPedGotWeapon(playerPed, weaponHash, false) then
				 local onPlayer = false
 
				 for k, entity in pairs(Weapons) do
				   if entity then
					   if entity.weapon == WeaponsOnBackConfig.RealWeapons[i].name then
						   onPlayer = true
						   break
					   end
				   end
				   end
				   
				   if not onPlayer and weaponHash ~= GetSelectedPedWeapon(playerPed) then
					   SetGear(WeaponsOnBackConfig.RealWeapons[i].name)
				   elseif onPlayer and weaponHash == GetSelectedPedWeapon(playerPed) then
					   RemoveGear(WeaponsOnBackConfig.RealWeapons[i].name)
				   end
			 else
				 RemoveGear(WeaponsOnBackConfig.RealWeapons[i].name)
			 end
		   end
		
	 end
 end)






 RegisterNetEvent('removeWeapon')
 AddEventHandler('removeWeapon', function(weaponName)
	 RemoveGear(weaponName)
 end)
 RegisterNetEvent('removeWeapons')
 AddEventHandler('removeWeapons', function()
	 RemoveGears()
 end)

 function RemoveGear(weapon)
	 local _Weapons = {}
 
	 for i, entity in pairs(Weapons) do
		 if entity.weapon ~= weapon then
			 _Weapons[i] = entity
		 else
			 DeleteWeapon(entity.obj)
		 end
	 end
 
	 Weapons = _Weapons
 end

 function RemoveGears()
	 for i, entity in pairs(Weapons) do
		 DeleteWeapon(entity.obj)
	 end
	 Weapons = {}
 end
 -----------------------------------------------------------
 -----------------------------------------------------------
 function SpawnObject(model, coords, cb)
 
   local model = (type(model) == 'number' and model or GetHashKey(model))
 
   Citizen.CreateThread(function()
 
	 RequestModel(model)
 
	 while not HasModelLoaded(model) do
	   Citizen.Wait(0)
	 end
 
	 local obj = CreateObject(model, coords.x, coords.y, coords.z, true, true, true)
	 DecorSetInt(obj,"ACVeh",955)
 
	 if cb ~= nil then
	   cb(obj)
	 end
 
   end)
 
 end
 
 function DeleteWeapon(object)
   SetEntityAsMissionEntity(object,  false,  true)
   DeleteObject(object)
 end
 
 function SetGear(weapon)
	local bone       = nil
	local boneX      = 0.0
	local boneY      = 0.0
	local boneZ      = 0.0
	local boneXRot   = 0.0
	local boneYRot   = 0.0
	local boneZRot   = 0.0
	local playerPed  = PlayerPedId()
	local model      = nil
	local playerWeapons = getWeapons()
		
	for i=1, #WeaponsOnBackConfig.RealWeapons, 1 do
		if WeaponsOnBackConfig.RealWeapons[i].name == weapon then
		   if orientation then
			   bone     = WeaponsOnBackConfig.RealWeapons[i].bone
			   boneX    = WeaponsOnBackConfig.RealWeapons[i].x
			   boneY    = WeaponsOnBackConfig.RealWeapons[i].y
			   boneZ    = WeaponsOnBackConfig.RealWeapons[i].z
			   boneXRot = WeaponsOnBackConfig.RealWeapons[i].xRot
			   boneYRot = WeaponsOnBackConfig.RealWeapons[i].yRot
			   boneZRot = WeaponsOnBackConfig.RealWeapons[i].zRot
			   model    = WeaponsOnBackConfig.RealWeapons[i].model
			   break
		   else
			   if not orientation then
				   for i=1, #WeaponsOnBackConfig.RealWeapons2, 1 do
					   if WeaponsOnBackConfig.RealWeapons2[i].name == weapon then
						   bone     = WeaponsOnBackConfig.RealWeapons2[i].bone
						   boneX    = WeaponsOnBackConfig.RealWeapons2[i].x
						   boneY    = WeaponsOnBackConfig.RealWeapons2[i].y 
						   boneZ    = WeaponsOnBackConfig.RealWeapons2[i].z
						   boneXRot = WeaponsOnBackConfig.RealWeapons2[i].xRot
						   boneYRot = WeaponsOnBackConfig.RealWeapons2[i].yRot
						   boneZRot = WeaponsOnBackConfig.RealWeapons2[i].zRot
						   model    = WeaponsOnBackConfig.RealWeapons2[i].model
						   break
					   end
				   end
			   end
		   end
		end
	end

	SpawnObject(model, {
		x = x,
		y = y,
		z = z
	}, function(obj)
		local playerPed = PlayerPedId()
		local boneIndex = GetPedBoneIndex(playerPed, bone)
		local bonePos 	= GetWorldPositionOfEntityBone(playerPed, boneIndex)
		AttachEntityToEntity(obj, playerPed, boneIndex, boneX, boneY, boneZ, boneXRot, boneYRot, boneZRot, false, false, false, false, 2, true)
		table.insert(Weapons,{weapon = weapon, obj = obj})
	end)
end
 
 local weapon_types = {
-- [Knives]
"WEAPON_broom", 
"WEAPON_dildo",
"WEAPON_toiletbrush",
"WEAPON_shank",
"WEAPON_PEAKYHAT",
-- [Pistol]
"WEAPON_m1911",
"WEAPON_beretta",
"WEAPON_TEC9",
"WEAPON_hawk",
"WEAPON_PYTHON",
-- [SMG]
'WEAPON_scorpianblue',
'WEAPON_blackicepeacekeeper',
"WEAPON_UMP45",
-- [PD]
"WEAPON_remington870",
"WEAPON_mp5",
"WEAPON_PDMCX",
"WEAPON_PDHK416",
"WEAPON_PDAR15",
"WEAPON_REMINGTON700",
"WEAPON_GLOCK",
"WEAPON_STUNGUN",
"WEAPON_SMOKEGRENADE",
"WEAPON_FLASHBANG",
"WEAPON_CQ300",
"WEAPON_SPAR17",
"WEAPON_M4SANDSTORM",
"WEAPON_AX50",
-- [Rebel]
"WEAPON_mosin",
"WEAPON_m4a1",
"WEAPON_m16a1",
"WEAPON_pp",
"WEAPON_MK1EMR",
"WEAPON_MXM",
"WEAPON_MXC",
"WEAPON_saige",
"WEAPON_SVD",
"WEAPON_AK200",
"WEAPON_SPAR16",
-- [Light Arms]
"WEAPON_goldendeagle",
"WEAPON_mac10",
"WEAPON_olympia", 
"WEAPON_usps",
-- [Large Arms]
"WEAPON_akm",
"WEAPON_vesper",
"WEAPON_aks74u",
"WEAPON_mp7",
"WEAPON_mp40",
"WEAPON_winchester",
"WEAPON_GUNGNIR",
"WEAPON_SINGULARITYPHANTOM",
"WEAPON_GURA",
"WEAPON_SAGIRI",
"WEAPON_DIAMONDMP5",
"WEAPON_GOLDAK",
"WEAPON_ANIMEM16",
-- SAME AS REBEL ATM
"WEAPON_CHEERYAK",
"WEAPON_NERFMOSIN",
"WEAPON_ODIN",
"WEAPON_NEONOIRMAC10",
"WEAPON_BLASTXPHANTOM",
"WEAPON_GRAU556",
"WEAPON_CHERRYMOSIN",
"WEAPON_HAHA47U",
"WEAPON_FNSCAR",
"WEAPON_RUSTAK",
 }
 
 function getWeapons()
   local player = GetPlayerPed(-1)
 
   local ammo_types = {} -- rem ammo type to not duplicate ammo amount
 
   local weapons = {}
   for k,v in pairs(weapon_types) do
	 local hash = GetHashKey(v)
	 if HasPedGotWeapon(player,hash) then
	   local weapon = {}
	   weapons[v] = weapon
 
	   local atype = Citizen.InvokeNative(0x7FEAD38B326B9F74, player, hash)
	   if ammo_types[atype] == nil then
		 ammo_types[atype] = true
		 weapon.ammo = GetAmmoInPedWeapon(player,hash)
	   else
		 weapon.ammo = 0
	   end
	 end
   end
 
   return weapons
 end
 
 
 -----------------------------------------------------------
 -----------------------------------------------------------
 -- Add all the weapons in the xPlayer's loadout
 -- on the ped
 function SetGears()
	local bone       = nil
	local boneX      = 0.0
	local boneY      = 0.0
	local boneZ      = 0.0
	local boneXRot   = 0.0
	local boneYRot   = 0.0
	local boneZRot   = 0.0
	local playerPed  = PlayerPedId()
	local model      = nil
	local playerWeapons = getWeapons()
	local weapon 	 = nil
	
	for k,v in pairs(playerWeapons) do
		
		for j=1, #WeaponsOnBackConfig.RealWeapons, 1 do
			if WeaponsOnBackConfig.RealWeapons[j].name == k then
			   if orientation then
				   
				   bone     = WeaponsOnBackConfig.RealWeapons[j].bone
				   boneX    = WeaponsOnBackConfig.RealWeapons[j].x
				   boneY    = WeaponsOnBackConfig.RealWeapons[j].y
				   boneZ    = WeaponsOnBackConfig.RealWeapons[j].z
				   boneXRot = WeaponsOnBackConfig.RealWeapons[j].xRot
				   boneYRot = WeaponsOnBackConfig.RealWeapons[j].yRot
				   boneZRot = WeaponsOnBackConfig.RealWeapons[j].zRot
				   model    = WeaponsOnBackConfig.RealWeapons[j].model
				   weapon   = WeaponsOnBackConfig.RealWeapons[j].name 
				   
				   break
			   else
				   if not orientation then
					   for j=1, #WeaponsOnBackConfig.RealWeapons2, 1 do
						   if WeaponsOnBackConfig.RealWeapons2[j].name == k then
							   bone     = WeaponsOnBackConfig.RealWeapons2[j].bone
							   boneX    = WeaponsOnBackConfig.RealWeapons2[j].x
							   boneY    = WeaponsOnBackConfig.RealWeapons2[j].y
							   boneZ    = WeaponsOnBackConfig.RealWeapons2[j].z
							   boneXRot = WeaponsOnBackConfig.RealWeapons2[j].xRot
							   boneYRot = WeaponsOnBackConfig.RealWeapons2[j].yRot
							   boneZRot = WeaponsOnBackConfig.RealWeapons2[j].zRot
							   model    = WeaponsOnBackConfig.RealWeapons2[j].model
							   weapon   = WeaponsOnBackConfig.RealWeapons2[j].name 
							   
							   break
						   end
					   end
				   end
			   end
		   end
		end

		local _wait = true

		SpawnObject(model, {
			x = x,
			y = y,
			z = z
		}, function(obj)
			
			local playerPed = PlayerPedId()
			local boneIndex = GetPedBoneIndex(playerPed, bone)
			local bonePos 	= GetWorldPositionOfEntityBone(playerPed, boneIndex)

			AttachEntityToEntity(obj, playerPed, boneIndex, boneX, boneY, boneZ, boneXRot, boneYRot, boneZRot, false, false, false, false, 2, true)						

			table.insert(Weapons,{weapon = weapon, obj = obj})

			_wait = false

		end)

		while _wait do
			Wait(0)
		end
	end

end
