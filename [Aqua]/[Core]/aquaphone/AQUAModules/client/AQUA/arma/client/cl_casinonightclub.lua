local a = vector3(987.5367, 79.6912, 80.9905)
local b = vector3(1578.3608, 253.3105, -46.0051)
local c = false
local d = {}
local e = {"h4_int_placement_h4_interior_1_dlc_int_02_h4_milo_", "ba_int_placement_ba_interior_0_dlc_int_01_ba_milo_"}
local f = {
    ["h4_int_placement_h4_interior_1_dlc_int_02_h4_milo_"] = {
        "EntitySet_DJ_Lighting",
        "int01_ba_bar_content",
        "dj_01_lights_02",
        "int01_ba_booze_0",
        "int01_ba_dj_moodyman",
        "int01_ba_dry_ice",
        "int01_ba_equipment_upgrade",
        "int01_ba_lightgrid_01",
        "int01_ba_lights_screen",
        "int01_ba_security_upgrade",
        "int01_ba_style02_podium"
    },
    ["ba_int_placement_ba_interior_0_dlc_int_01_ba_milo_"] = {
        "Int01_ba_clubname_0",
        "Int01_ba_Style03",
        "Int01_ba_style03_podium",
        "Int01_ba_equipment_setup",
        "Int01_ba_equipment_upgrade",
        "Int01_ba_security_upgrade",
        "Int01_ba_dj04",
        "Int01_ba_trad_lights",
        "Int01_ba_bar_content",
        "Int01_ba_booze_03",
        "Int01_ba_trophy03",
        "Int01_ba_lightgrid_01",
        "Int01_ba_dry_ice",
        "DJ_04_Lights_03"
    }
}
local g = {
    ["h4_int_placement_h4_interior_1_dlc_int_02_h4_milo_"] = vector3(1550.0, 250.0, -48.0),
    ["ba_int_placement_ba_interior_0_dlc_int_01_ba_milo_"] = vector3(-1602.932, -3019.1, -79.99)
}
local h = {
    [1] = {
        vector4(14.1066, -0.004, -0.006, 90.72),
        vector4(14.2118, 1.6497, -0.006, 90.72),
        vector4(14.4652, -0.99, -0.006, 90.72),
        vector4(13.953, 2.9431, -0.006, 126.029),
        vector4(13.9901, -3.994, -0.0061, 81.3059),
        vector4(13.1489, 0.2935, -0.006, 90.72),
        vector4(13.1326, 1.5934, -0.006, 90.72),
        vector4(13.0323, -1.4729, -0.0061, 90.72),
        vector4(13.0574, 2.9834, -0.006, 127.247),
        vector4(12.6299, -3.748, -0.0061, 72.6747),
        vector4(11.6042, 0.1852, -0.006, 90.72),
        vector4(11.8326, 1.5771, -0.006, 90.72),
        vector4(11.3999, -1.0555, -0.006, 90.72),
        vector4(12.0172, 3.4456, -0.006, 119.071),
        vector4(11.4506, -3.2887, -0.0061, 72.1923),
        vector4(10.5491, 0.2608, -0.006, 90.72),
        vector4(9.9551, 2.0054, -0.006, 90.72),
        vector4(11.152, -2.0034, -0.006, 90.72),
        vector4(10.6118, 3.4276, -0.006, 118.315),
        vector4(10.1354, -5.3062, -0.0061, 58.0551),
        vector4(9.2491, 0.2445, -0.006, 90.72),
        vector4(8.4462, 1.3009, -0.006, 90.72),
        vector4(10.0466, -2.4479, -0.0061, 90.72),
        vector4(7.9424, 3.9798, -0.006, 143.329),
        vector4(8.0686, -4.8352, -0.006, 49.0066),
        vector4(9.8762, -0.2156, -0.006, 90.72),
        vector4(8.0876, -3.3494, -0.006, 68.3493),
        vector4(8.0961, -0.791, -0.006, 90.72),
        vector4(7.6494, 2.9714, -0.006, 90.72),
        vector4(6.5189, -5.3575, -0.006, 39.0677),
        vector4(3.934, 1.1671, -0.006, 90.72),
        vector4(6.9264, 1.2787, -0.006, 90.72),
        vector4(6.1118, -1.3144, -0.006, 90.72),
        vector4(5.7732, 3.3293, -0.006, 90.72),
        vector4(5.4131, -3.1404, -0.0061, 72.3159),
        vector4(4.3295, -1.4238, -0.0061, 90.72),
        vector4(4.2454, 0.0191, -0.006, 90.72),
        vector4(5.202, -4.9, -0.0061, 49.517),
        vector4(4.3119, 3.6567, -0.006, 119.624),
        vector4(4.0693, -4.9017, -0.0061, 40.6287)
    },
    [2] = {
        vector4(-4.7166, 4.3972, 2.9939, 1.75),
        vector4(-3.4264, 4.4338, 2.9939, 0),
        vector4(-5.9635, 4.9735, 2.9939, 0),
        vector4(-3.8318, 5.2218, 2.9939, 0),
        vector4(-4.8292, 5.175, 2.9939, 0),
        vector4(-4.6708, 6.342, 2.994, 266.6845),
        vector4(-3.8696, 6.0818, 2.994, 270.1852),
        vector4(-6.0946, 6.2608, 2.994, 0),
        vector4(-5.4019, 5.7052, 2.994, 0),
        vector4(-5.0105, 7.1524, 2.994, 0),
        vector4(-4.937, 8.0797, 2.994, 0),
        vector4(-3.7645, 6.9808, 2.994, 269.721),
        vector4(-5.9934, 8.1567, 2.994, 0),
        vector4(-5.9642, 7.1713, 2.994, 0),
        vector4(-4.8008, 6.3983, -0.006, 269.6776),
        vector4(-5.1895, 7.4267, -0.0067, 194.7584),
        vector4(-5.9725, 6.4977, -0.0073, 270.4127),
        vector4(-5.3469, 5.3851, -0.006, 281.4741),
        vector4(-1.5503, 7.1695, 2.9949, 272.13),
        vector4(-5.9514, 7.7227, -0.0103, 179.9022),
        vector4(0.7411, 7.0505, 2.9949, 271.0977),
        vector4(9.2726, 5.9283, 2.9949, 270.6819),
        vector4(1.6549, 6.0675, 2.9949, 271.9964),
        vector4(5.4897, 7.0512, 2.9949, 270.5276),
        vector4(-0.4957, 6.0731, 2.9949, 270.885),
        vector4(4.1071, 5.9848, 2.9949, 269.5193),
        vector4(7.1014, 5.9366, 2.9949, 270.8759),
        vector4(2.9392, 6.9576, 2.9949, 269.525),
        vector4(8.2488, 7.1301, 2.9949, 267.3192),
        vector4(10.911, 7.0374, 2.9949, 271.4559)
    },
    [3] = {
        vector4(28.0829, 3.3995, 2.9949, 178.56),
        vector4(29.0067, 3.0168, 2.9949, 178.56),
        vector4(27.2, 2.9756, 2.9949, 178.56),
        vector4(29.059, 3.7822, 2.9949, 178.56),
        vector4(27.166, 3.8234, 2.9949, 178.56),
        vector4(28.924, 2.393, 2.9949, 178.56),
        vector4(28.076, 2.6583, 2.9949, 178.56),
        vector4(27.142, 2.3061, 2.9949, 178.56),
        vector4(28.889, 1.8407, 2.9949, 178.56),
        vector4(28.031, 2.0341, 2.9949, 178.56),
        vector4(27.135, 1.7517, 2.9949, 178.56),
        vector4(28.9351, 1.2649, 2.9949, 178.56),
        vector4(28.048, 1.4473, 2.9949, 178.56),
        vector4(27.165, 1.1864, 2.9949, 178.56),
        vector4(28.97, 0.7171, 2.9949, 178.56),
        vector4(28, 0.9126, 2.9949, 178.56),
        vector4(27.196, 0.5819, 2.9949, 178.56),
        vector4(28.954, 0.1514, 2.9949, 178.56),
        vector4(28.035, 0.3279, 2.9949, 178.56),
        vector4(27.2111, 0.0476, 2.9949, 178.56),
        vector4(28.8311, -0.3289, 2.9949, 178.56),
        vector4(28.006, -0.2201, 2.9949, 178.56),
        vector4(27.163, -0.6241, 2.9949, 178.56),
        vector4(28.1591, -0.7808, 2.9949, 178.56),
        vector4(27.203, -1.1769, 2.9949, 178.56),
        vector4(28.178, -1.4312, 2.9949, 178.56),
        vector4(28.252, -2.096, 2.9949, 178.56),
        vector4(27.187, -1.7698, 2.9949, 178.56),
        vector4(28.214, -2.705, 2.9949, 178.56),
        vector4(28.248, -3.3267, 2.9949, 178.56)
    }
}
local i = {
    {
        dics = "anim@amb@nightclub_island@dancers@club@",
        anim = {
            "ti_idle_c_f03",
            "ti_idle_c_f02",
            "ti_idle_c_f01",
            "ti_to_hi_f02",
            "ti_to_hi_f01",
            "li_idle_a_f03",
            "li_idle_a_f02",
            "li_idle_a_f01",
            "ti_to_hi_f03",
            "li_idle_f_f02",
            "hi_to_li_m03",
            "hi_to_li_m02",
            "mi_idle_c_m01",
            "hi_idle_d_m03",
            "hi_idle_d_m02",
            "hi_idle_d_m01",
            "hi_idle_c_m03",
            "hi_idle_c_m02",
            "mi_idle_c_m03",
            "mi_idle_c_m02",
            "li_to_mi_m03",
            "li_to_mi_m02",
            "hi_to_li_m01",
            "li_idle_a_f04",
            "li_to_mi_m01",
            "mi_idle_e_f02",
            "hi_idle_c_m01",
            "ti_idle_a_m02",
            "mi_loop_m02",
            "mi_loop_m01",
            "ti_idle_a_m03",
            "ti_idle_a_m01",
            "mi_loop_m03",
            "ti_loop_m03",
            "ti_loop_m02",
            "ti_loop_m01",
            "ti_idle_b_m03",
            "ti_idle_b_m02",
            "ti_idle_b_m01",
            "ti_to_li_m03",
            "ti_to_li_m02",
            "ti_to_li_m01",
            "li_to_ti_f03",
            "li_to_ti_f02",
            "li_to_ti_f01",
            "li_idle_e_f02",
            "mi_idle_a_f01",
            "mi_idle_b_m03",
            "mi_idle_b_m02",
            "mi_idle_b_m01",
            "mi_idle_a_f04",
            "mi_idle_a_f03",
            "mi_idle_a_f02",
            "hi_loop_m03",
            "mi_to_hi_f03",
            "mi_to_hi_f02",
            "mi_to_hi_f01",
            "hi_loop_m02",
            "hi_loop_m01",
            "hi_to_ti_m02",
            "hi_to_ti_m01",
            "hi_idle_d_f02",
            "mi_idle_b_f04",
            "mi_idle_b_f03",
            "mi_idle_b_f02",
            "mi_idle_b_f01",
            "hi_to_ti_m03",
            "hi_idle_d_f03",
            "hi_idle_d_f01",
            "li_idle_b_f04",
            "li_idle_b_f03",
            "li_idle_b_f02",
            "li_idle_b_f01",
            "li_idle_c_f01",
            "ti_idle_b_f02",
            "ti_idle_b_f01",
            "li_idle_c_f04",
            "ti_idle_b_f03",
            "li_idle_c_f03",
            "li_idle_c_f02",
            "mi_idle_d_f04",
            "mi_idle_d_f02",
            "hi_loop_f03",
            "hi_loop_f02",
            "hi_loop_f01",
            "ti_to_mi_f01",
            "ti_to_mi_f03",
            "ti_to_mi_f02",
            "hi_idle_b_m01",
            "mi_to_ti_f03",
            "mi_to_ti_f01",
            "li_loop_m03",
            "li_loop_m02",
            "li_loop_m01",
            "mi_to_ti_f02",
            "li_loop_f04",
            "li_loop_f03",
            "li_loop_f02",
            "li_loop_f01",
            "hi_to_li_f03",
            "hi_to_li_f02",
            "hi_to_li_f01",
            "ti_to_li_f03",
            "ti_to_li_f02",
            "ti_to_li_f01",
            "li_idle_d_f02",
            "ti_to_hi_m03",
            "ti_to_hi_m02",
            "ti_to_hi_m01",
            "hi_idle_b_m03",
            "hi_idle_b_m02",
            "mi_to_hi_m02",
            "mi_to_hi_m01",
            "hi_idle_b_f03",
            "mi_to_hi_m03",
            "hi_idle_b_f02",
            "hi_idle_b_f01",
            "li_to_hi_m03",
            "li_to_hi_m02",
            "li_to_hi_m01",
            "li_to_mi_f04",
            "li_to_mi_f03",
            "hi_to_mi_f02",
            "ti_idle_d_f02",
            "hi_idle_f_f02",
            "hi_to_mi_f03",
            "hi_to_mi_f01",
            "li_to_mi_f02",
            "li_to_mi_f01",
            "hi_idle_a_m03",
            "hi_idle_a_m02",
            "mi_idle_a_m03",
            "mi_idle_a_m02",
            "mi_idle_a_m01",
            "li_to_ti_m02",
            "li_to_ti_m01",
            "mi_idle_c_f04",
            "mi_idle_c_f03",
            "mi_idle_c_f02",
            "mi_idle_c_f01",
            "hi_to_mi_m01",
            "li_idle_c_m02",
            "li_idle_c_m01",
            "li_idle_d_f03",
            "li_to_ti_m03",
            "li_idle_a_m03",
            "hi_to_mi_m03",
            "hi_to_mi_m02",
            "li_idle_c_m03",
            "li_idle_a_m02",
            "li_idle_a_m01",
            "mi_to_li_m03",
            "mi_to_li_m02",
            "mi_to_li_m01",
            "hi_idle_a_f03",
            "hi_idle_a_f02",
            "hi_idle_a_f01",
            "ti_to_mi_m03",
            "ti_to_mi_m02",
            "ti_to_mi_m01",
            "hi_to_si_f01",
            "hi_idle_e_f02",
            "mi_to_ti_m03",
            "mi_to_ti_m02",
            "mi_to_ti_m01",
            "mi_to_li_f04",
            "ti_idle_c_m03",
            "ti_idle_c_m02",
            "ti_idle_c_m01",
            "mi_to_li_f03",
            "mi_to_li_f02",
            "mi_idle_f_f02",
            "li_idle_b_m03",
            "li_idle_b_m02",
            "li_idle_b_m01",
            "mi_to_li_f01",
            "hi_idle_c_f03",
            "hi_idle_c_f02",
            "hi_idle_c_f01",
            "hi_to_ti_f03",
            "hi_to_ti_f02",
            "ti_loop_f02",
            "ti_loop_f01",
            "hi_to_ti_f01",
            "ti_loop_f03",
            "li_to_hi_f01",
            "li_to_hi_f03",
            "li_to_hi_f02",
            "mi_loop_f04",
            "mi_loop_f03",
            "mi_loop_f02",
            "mi_loop_f01",
            "ti_idle_e_f02",
            "hi_idle_a_m01",
            "ti_idle_a_f03",
            "ti_idle_a_f02",
            "ti_idle_a_f01"
        }
    }
}
local j = {
    "u_f_y_dancerave_01",
    "u_m_y_danceburl_01",
    "u_f_o_eileen",
    "ig_mrsphillips",
    "u_f_y_jewelass_01",
    "u_f_y_bikerchic",
    "u_f_y_spyactress",
    "ig_roccopelosi",
    "ig_money",
    "ig_bride",
    "mp_f_deadhooker",
    "csb_brucie2",
    "csb_undercover",
    "csb_oscar",
    "csb_bride",
    "cs_natalia",
    "cs_gurk",
    "a_m_y_soucent_04",
    "a_m_y_vinewood_03",
    "a_m_y_gay_02",
    "a_f_y_clubcust_01",
    "a_f_y_clubcust_02",
    "a_f_y_clubcust_03",
    "a_f_y_bevhills_04",
    "a_f_m_beach_01"
}
local k = {
    [1] = {
        vector3(3.7219, 3.4921, 5.721),
        vector3(3.7219, 2.1514, 5.4099),
        vector3(3.7219, 0.7985, 5.721),
        vector3(3.7219, -1.0028, 5.721),
        vector3(3.7219, -2.3244, 5.4099),
        vector3(3.7219, -3.7085, 5.721)
    },
    [2] = {
        vector3(5.8927, 3.4921, 5.721),
        vector3(5.8927, 2.1514, 5.4099),
        vector3(5.8927, 0.7985, 5.721),
        vector3(5.8927, -1.0028, 5.721),
        vector3(5.8927, -2.3244, 5.4099),
        vector3(5.8927, -3.7085, 5.721)
    },
    [3] = {
        vector3(8.0635, 3.4921, 5.721),
        vector3(8.0635, 2.1514, 5.4099),
        vector3(8.0635, 0.7985, 5.721),
        vector3(8.0635, -1.0028, 5.721),
        vector3(8.0635, -2.3244, 5.4099),
        vector3(8.0635, -3.7085, 5.721)
    },
    [4] = {
        vector3(10.2343, 3.4921, 5.721),
        vector3(10.2343, 2.1514, 5.4099),
        vector3(10.2343, 0.7985, 5.721),
        vector3(10.2343, -1.0028, 5.721),
        vector3(10.2343, -2.3244, 5.4099),
        vector3(10.2343, -3.7085, 5.721)
    },
    [5] = {
        vector3(12.4051, 3.4921, 5.721),
        vector3(12.4051, 2.1514, 5.4099),
        vector3(12.4051, 0.7985, 5.721),
        vector3(12.4051, -1.0028, 5.721),
        vector3(12.4051, -2.3244, 5.4099),
        vector3(12.4051, -3.7085, 5.721)
    }
}
local l = {
    "BA_PROP_BATTLE_LIGHTS_FX_RIGB",
    "BA_PROP_BATTLE_LIGHTS_FX_RIGC",
    "BA_PROP_BATTLE_LIGHTS_FX_RIGD",
    "BA_PROP_BATTLE_LIGHTS_FX_RIGE",
    "BA_PROP_BATTLE_LIGHTS_FX_RIGF",
    "BA_PROP_BATTLE_LIGHTS_FX_RIGG",
    "BA_PROP_BATTLE_LIGHTS_FX_RIGH"
}
local m = {}
local n = {}
local o = {
    vector3(1562.988, 248.8343, -47.4049),
    vector3(1562.988, 251.8804, -47.4049),
    vector3(1560.285, 254.2484, -47.4049),
    vector3(1556.933, 254.2484, -47.4049),
    vector3(1552.497, 251.6578, -46.9362),
    vector3(1552.497, 248.1372, -46.9367),
    vector3(1548.035, 252.1521, -45.7357),
    vector3(1548.023, 247.6361, -45.7357),
    vector3(1552.296, 243.7544, -47.4049)
}
local function p()
    c = true
    local q = tARMA.loadModel("BA_PROP_CLUB_EMIS_RIG_10")
    for r, s in pairs(k) do
        for r, t in pairs(s) do
            local u = GetObjectOffsetFromCoords(t.x, t.y, t.z, 0, 1550.0, 250.0, -50.0)
            local v = CreateObjectNoOffset(q, u, false, false, false)
            SetObjectLightColor(v, true, 141, 20, 178)
            m[#m + 1] = v
        end
    end
    SetModelAsNoLongerNeeded(q)
    local w = {}
    local x = 1
    for r, t in pairs(m) do
        w[x] = t
        x = x + 1
    end
    local function y(z)
        local A = #z
        local x = 1
        while x < A do
            z[x], z[A] = z[A], z[x]
            x = x + 1
            A = A - 1
        end
    end
    local function B(C)
        Citizen.CreateThread(function()
            for x = 0, 64 do
                SetEntityAlpha(C, x * 4, 0)
                Citizen.Wait(0)
            end
        end)
    end
    local function D(C)
        Citizen.CreateThread(function()
            for x = 64, 0, -1 do
                SetEntityAlpha(C, x * 4, 0)
                Citizen.Wait(0)
            end
        end)
    end
    local function E(F, G, H, I)
        while true do
            if c then
                local J = F
                for r, t in pairs(J) do
                    Citizen.CreateThread(function()
                        for K, L in pairs(t) do
                            if G == "hard" then
                                ResetEntityAlpha(w[L])
                            end
                            if G == "fade" then
                                B(w[L])
                            end
                        end
                        Citizen.Wait(150)
                        for K, L in pairs(t) do
                            if G == "hard" then
                                SetEntityAlpha(w[L], 255, 0)
                            end
                            if G == "fade" then
                                D(w[L])
                            end
                        end
                    end)
                    Citizen.Wait(I or 200)
                end
                if H then
                    J = y(J)
                end
            end
            Citizen.Wait(0)
        end
    end
    Citizen.CreateThread(function()
        local F = {
            {6},
            {5, 12},
            {18, 11, 4},
            {3, 10, 17, 24},
            {30, 23, 16, 9, 2},
            {1, 8, 15, 22, 29},
            {28, 21, 14, 7},
            {13, 20, 27},
            {19, 26},
            {25}
        }
        E(F, "fade", true, 200)
    end)
end
local function M()
    c = false
    DeleteEntity(d.Bouncer)
    for x, t in pairs(m) do
        DeleteEntity(t)
    end
    for x, t in pairs(n) do
        DeleteEntity(t)
    end
end
local function N()
    drawNativeNotification("Press ~INPUT_CONTEXT~ to enter the Diamond Casino Nightclub")
    if IsControlJustPressed(1, 51) then
        DoScreenFadeOut(1000)
        while not IsScreenFadedOut() do
            Citizen.Wait(1.0)
        end
        p()
        SetEntityCoords(PlayerPedId(), b.x, b.y, b.z)
        Citizen.Wait(200)
        DoScreenFadeIn(1000)
    end
end
local function O()
    drawNativeNotification("Press ~INPUT_CONTEXT~ to exit the Diamond Casino Nightclub")
    if IsControlJustPressed(1, 51) then
        DoScreenFadeOut(1000)
        while not IsScreenFadedOut() do
            Citizen.Wait(1.0)
        end
        M()
        SetEntityCoords(PlayerPedId(), a.x, a.y, a.z)
        Citizen.Wait(200)
        DoScreenFadeIn(1000)
    end
end
AddEventHandler("ARMA:onClientSpawn",function(P, Q)
    if Q then
        local R = function(S)
        end
        local T = function(S)
        end
        local U = function(S)
            N()
        end
        tARMA.createArea("nightclub_entrance", a, 3.0, 6, R, T, U, {})
        local R = function(S)
        end
        local T = function(S)
        end
        local U = function(S)
            O()
        end
        tARMA.createArea("nightclub_exit", b, 3.0, 6, R, T, U, {})
    end
end)
Citizen.CreateThread(function()
    local V = AddBlipForCoord(987.6535, 80.3114, 80.9905)
    SetBlipSprite(V, 136)
    SetBlipAsShortRange(V, true)
    SetBlipScale(V, 0.6)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentSubstringPlayerName("The Diamond Casino NightClub")
    EndTextCommandSetBlipName(V)
    for r, W in pairs(e) do
        if not IsIplActive(W) then
            RequestIpl(W)
        end
        if f[W] and g[W] then
            if IsIplActive(W) then
                local X = GetInteriorAtCoords(g[W])
                if IsValidInterior(X) then
                    for Y, Z in pairs(f[W]) do
                        ActivateInteriorEntitySet(X, Z)
                    end
                    RefreshInterior(X)
                end
            end
        end
    end
end)
AddEventHandler("onResourceStop",function(_)
    if GetCurrentResourceName() ~= _ then
        return
    end
    M()
end)
AddEventHandler("onResourceStart",function(_)
    if GetCurrentResourceName() ~= _ then
        return
    end
    Citizen.Wait(1000)
    if GetInteriorFromEntity(PlayerPedId()) == 281089 then
        p()
    end
end)
