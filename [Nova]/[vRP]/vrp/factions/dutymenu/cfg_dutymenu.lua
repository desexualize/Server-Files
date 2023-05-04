local config = {}

config.Menu_Open_Key = 51
config.Menu_Open_Proximity = 1.5
config.Extended_Proximity = config.Menu_Open_Proximity + 0.5

config.duty_groups = {
    ['LFB'] = {
        {'Chief Fire Command', 'Chief Fire Command Clocked', 'chieffirecommand.clockon', '~y~'},
        {'Divisional Command', 'Divisional Command Clocked', 'divisionalcommand.clockon'},
        {'Sector Command', 'Sector Command Clocked', 'sectorcommand.clockon'},
        {'Honourable Firefighter', 'Honourable Firefighter Clocked', 'honourablefirefighter.clockon'},
        {'Firefighter of the week', 'Firefighter of the week Clocked', 'firefighteroftheweek.clockon'},
        {'Leading Firefighter', 'Leading Firefighter Clocked', 'leadingfirefighter.clockon'},
        {'Specialist Firefighter', 'Specialist Firefighter Clocked', 'specialistfirefighter.clockon'},
        {'Advanced Firefighter', 'Advanced Firefighter Clocked', 'advancedfirefighter.clockon'},
        {'Senior Firefighter', 'Senior Firefighter Clocked', 'seniorfirefighter.clockon'},
        {'Firefighter', 'Firefighter Clocked', 'firefighter.clockon'},
        {'Junior Firefighter', 'Junior Firefighter Clocked', 'juniorfirefighter.clockon'},
        {'Provisional Firefighter', 'Provisional Firefighter Clocked', 'provisionalfirefighter.clockon'},
        {'LFB Needs Training', 'LFB Needs Training Clocked', 'lfb_needs_training.clockon'},
    },

    ['NHS'] = {
        {'Chief Medical Director', 'Chief Medical Director Clocked', 'cmd.clockon', '~y~'},
        {'Deputy Medical Director', 'Deputy Medical Director Clocked', 'dmd.clockon', '~y~'},
        {'Assistant Medical Director', 'Assistant Medical Director Clocked', 'amd.clockon', '~y~'},
        {'Captain', 'Captain Clocked', 'captain.clockon'},
        {'Specialist', 'Specialist Clocked', 'specialist.clockon'},
        {'Medic of the week', 'Medic of the week Clocked', 'medicoftheweek.clockon'},
        {'Senior Doctor', 'Senior Doctor Clocked', 'sd.clockon'},
        {'Doctor', 'Doctor Clocked', 'doctor.clockon'},
        {'Junior Doctor', 'Junior Doctor Clocked', 'juniordoctor.clockon'},
        {'Critical Care Paramedic', 'Critical Care Paramedic Clocked', 'ccp.clockon'},
        {'Paramedic', 'Paramedic Clocked', 'paramedic.clockon'},
        {'Trainee Paramedic', 'Trainee Paramedic Clocked', 'trainee.clockon'},
        {'NHS Needs Training', 'NHS Needs Training Clocked', 'nhs_needs_training.clockon'},
    },

    ['HMP'] = {
        {'Governor', 'Governor Clocked', 'gov.clockon', '~y~'},
        {'Deputy Governor', 'Deputy Governor Clocked', 'depgov.clockon', '~y~'},
        {'Assistant Governor', 'Assistant Governor Clocked', 'assistantgovernor.clockon', '~y~'},
        {'Custodial Supervisor', 'Custodial Supervisor Clocked', 'custodialsupervisor.clockon'},
        {'Custodial Officer', 'Custodial Officer Clocked', 'custodialofficer.clockon'},
        {'Honourable Guard', 'Honourable Guard Clocked', 'hguard.clockon'},
        {'Guard of the week', 'Guard of the week Clocked', 'guardoftheweek.clockon'},
        {'Supervising Officer', 'Supervising Officer Clocked', 'sofficer.clockon'},
        {'Principal Officer', 'Principal Officer Clocked', 'principal.clockon'},
        {'Specialist Officer', 'Specialist Officer Clocked', 'specialistofficer.clockon'},
        {'Senior Officer', 'Senior Officer Clocked', 'so.clockon'},
        {'Prison Officer', 'Prison Officer Clocked', 'prisonofficer.clockon'},
        {'Trainee Prison Officer', 'Trainee Prison Officer Clocked', '"tpo.clockon'},
        {'HMP Needs Training', 'HMP Needs Training Clocked', 'hmp_needs_training.clockon'},
    },

    ['MPD'] = {
        {'Commissioner', 'Commissioner Clocked', 'commissioner.clockon', '~y~'},
        {'Deputy Commissioner', 'Deputy Commissioner Clocked', 'depcommissioner.clockon', '~y~'},
        {'Assistant Commissioner', 'Assistant Commissioner Clocked', 'asscommissioner.clockon', '~y~'},
        {'Deputy Assistant Commissioner', 'Deputy Assistant Commissioner Clocked', 'depasscommissioner.clockon', '~y~'},
        {'Commander', 'Commander Clocked', 'commander.clockon', '~y~'},
        {'Chief Superintendent', 'Chief Superintendent Clocked', 'chiefsupint.clockon'},
        {'Superintendent', 'Superintendent Clocked', 'superint.clockon'},
        {'Chief Inspector', 'Chief Inspector Clocked', 'chiefinsp.clockon'},
        {'Officer of the week', 'Officer of the week Clocked', 'officeroftheweek.clockon'},
        {'Inspector', 'Inspector Clocked', 'inspector.clockon'},
        {'Sergeant', 'Sergeant Clocked', 'sgt.clockon'},
        {'Special Constable', 'Special Constable Clocked', 'specialpc.clockon'},
        {'Senior Constable', 'Senior Constable Clocked', 'seniorconstable.clockon'},
        {'Police Constable', 'Police Constable Clocked', 'pc.clockon'},
        {'PCSO', 'PCSO Clocked', 'pcso.clockon'},
        {'MPD Needs Training', 'MPD Needs Training Clocked', 'mpd_needs_training.clockon'},
    },
}

config.duty_menu_locations = {
    ['LFB'] = {
        ['EL Burro Heights Fire Station'] = vector3(1201.2091064453, -1473.7391357422, 34.85950088501),
        ['Sandy Shores Fire Station'] = vector3(1690.3746337891, 3581.2263183594, 35.620777130127),
        ['Davis Fire Station'] = vector3(205.31809997559, -1651.5455322266, 29.803230285645),
        ['Paleto Bay Fire Station'] = vector3(-381.85101318359, 6120.4282226562, 31.479551315308),
    },

    ['NHS'] = {
        ['Saint Thomas Hospital'] = vector3(305.70446777344, -600.53448486328, 43.283973693848),
        ['Sandy Shores Medical'] = vector3(1837.3723144531, 3684.2893066406, 34.270065307617),
        ['Paleto Medical Centre'] = vector3(-257.49011230469, 6332.1796875, 32.427223205566),
    },

    ['HMP'] = {
        ['Prison'] = vector3(1835.55078125, 2591.3793945312, 45.952289581299),
    },

    ['MPD'] = {
        ['Mission Row'] = vector3(447.52124023438, -976.28454589844, 30.689336776733),
        ['Sandy Shores Police'] = vector3(1851.5614013672, 3690.7155761719, 34.267013549805),
        ['Paleot Police Station'] = vector3(-449.61892700195, 6010.498046875, 31.716361999512),
    },
}

config.faction_functions = {
    ['LFB'] = function()
        return tvRP.Has_LFB_Permission()
    end,

    ['NHS'] = function()
        return tvRP.Has_NHS_Permission()
    end,

    ['HMP'] = function()
        return tvRP.Has_HMP_Permission()
    end,

    ['MPD'] = function()
        return tvRP.Has_MPD_Permission()
    end,
}

config.suspended_functions = {
    ['LFB'] = function()
        return tvRP.Is_LFB_Suspended()
    end,
    
    ['NHS'] = function()
        return tvRP.Is_NHS_Suspended()
    end,

    ['HMP'] = function()
        return tvRP.Is_HMP_Suspended()
    end,

    ['MPD'] = function()
        return tvRP.Is_MPD_Suspended()
    end,
}

config.Get_Reverse_Group = function(modified_group)
    for faction_name, faction_groups_table in pairs(config.duty_groups) do
        for table_index, groups_table in pairs(faction_groups_table) do
            local group_name = groups_table[1]
            local group_clocked_name = groups_table[2]

            if modified_group == group_name then
                return faction_name, group_clocked_name
            end
            
            if modified_group == group_clocked_name then
                return faction_name, group_name
            end
        end
    end
    return nil
end

config.Get_Group_Permission = function(selected_group_name)
    for faction_name, faction_groups_table in pairs(config.duty_groups) do
        for table_index, groups_table in pairs(faction_groups_table) do
            local group_name = groups_table[1]
            local group_clocked_name = groups_table[2]
            local group_permission = groups_table[3]

            if selected_group_name == group_clocked_name then
                return {faction_name, group_name, group_permission}
            end
        end
    end
    return nil
end

config.Is_Near_Duty_Point = function(selected_faction, player_position)
    for table_index, duty_position in pairs(config.duty_menu_locations[selected_faction]) do
        if #(player_position - duty_position) <= config.Extended_Proximity then
            return true
        end
    end
    return false
end

return config