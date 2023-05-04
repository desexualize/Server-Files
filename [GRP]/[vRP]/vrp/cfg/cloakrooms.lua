
-- this file configure the cloakrooms on the map

local cfg = {}

-- prepare surgeries customizations
local surgery_male = { model = "mp_m_freemode_01" }
local surgery_female = { model = "mp_f_freemode_01" }
local emergency_male = { model = "s_m_m_paramedic_01" }
local emergency_female = { model = "s_f_y_paramedic_01" }
local fbi_male = { model = "s_m_y_swat_01" }
local sheriff_male = { model = "s_m_y_sheriff_01"}
local sheriff_female = { model = "s_f_y_sheriff_01"}
local hway_male = { model = "s_m_y_hwaycop_01"}
local cop_male = { model = "s_m_y_cop_01"}
local ups_male = { model = "s_m_m_ups_02"}
local cop_female = { model = "s_f_y_cop_01"}
local detective_male = { model = "s_m_m_CIASec_01"}
local officer_male = { model = "s_m_y_cop_01"}
local bounty_male = { model = "s_m_y_BlackOps_01"}
local captain_male = { model = "s_m_y_fibcop_01"}
local lieutenant_male = { model = "s_m_m_Armoured_02"}
local sergeant_male = { model = "s_m_y_Ranger_01"}
local deputy_male = { model = "s_m_y_ranger_01"}
local chief_male = {model = "s_m_m_ciasec_01"}
local santa = {model = "Santaclaus"}

--s_m_m_paramedic_01
--s_f_y_scrubs_01
--mp_m_freemode_01
--mp_f_freemode_01


for i=0,19 do
  surgery_female[i] = {0,0}
  surgery_male[i] = {0,0}
end

-- cloakroom types (_config, map of name => customization)
--- _config:
---- permissions (optional)
---- not_uniform (optional): if true, the cloakroom will take effect directly on the player, not as a uniform you can remove
cfg.cloakroom_types = {
}

cfg.cloakrooms = {
}

return cfg
