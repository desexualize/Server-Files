local cfg = {}

cfg.paychecks = {
    ['MPD'] = {
        {
            name = "Commissioner",
            paycheck = 90000,
            permissions = {"commissioner.paycheck"}
        },
        {
            name = "Deputy Commissioner",
            paycheck = 85000,
            permissions = {"deputycommissioner.paycheck"}
        },
        {
            name = "Assistant Commissioner",
            paycheck = 80000,
            permissions = {"assistantcommissioner.paycheck"}
        },
        {
            name = "Deputy Assistant Commissioner",
            paycheck = 75000,
            permissions = {"assistantdeputycommissioner.paycheck"}
        },
        {
            name = "Commander",
            paycheck = 70000,
            permissions = {"commander.paycheck"}
        },
        {
            name = "Special Constable",
            paycheck = 70000,
            permissions = {"spc.paycheck"}
        },
        {
            name = "Chief Superintendent",
            paycheck = 65000,
            permissions = {"chiefsuperintendent.paycheck"}
        },
        {
            name = "Superintendent",
            paycheck = 60000,
            permissions = {"superintendent.paycheck"}
        },
        {
            name = "Officer of the week",
            paycheck = 65000,
            permissions = {"officeroftheweek.paycheck"}
        },
        {
            name = "Chief Inspector",
            paycheck = 55000,
            permissions = {"chiefinspector.paycheck"}
        },
        {
            name = "Inspector",
            paycheck = 50000,
            permissions = {"inspector.paycheck"}
        },
        {
            name = "Sergeant",
            paycheck = 45000,
            permissions = {"sergeant.paycheck"}
        },
        {
            name = "Senior Constable",
            paycheck = 35000,
            permissions = {"seniorconstable.paycheck"}
        },
        {
            name = "Police Constable",
            paycheck = 30000,
            permissions = {"policeconstable.paycheck"}
        },
        {
            name = "PCSO",
            paycheck = 25000,
            permissions = {"pcso.paycheck"}
        },
        {
            name = 'MPD Needs Training',
            paycheck = 10000,
            permissions = {'mpd_needs_training.paycheck'}
        },
    },

    ['NHS'] = {
        {
            name = "Chief Medical Director",
            paycheck = 80000,
            permissions = {"cmd.paycheck"}
        },
        {
            name = "Deputy Medical Director",
            paycheck = 75000,
            permissions = {"dmd.paycheck"}
        },
        {
            name = "Assistant Medical Director",
            paycheck = 70000,
            permissions = {"amd.paycheck"}
        },
        {
            name = "Captain",
            paycheck = 65000,
            permissions = {"captain.paycheck"}
        },
        {
            name = "Specialist",
            paycheck = 60000,
            permissions = {"specialist.paycheck"}
        },
        {
            name = "Medic of the week",
            paycheck = 65000,
            permissions = {"medicoftheweek.paycheck"}
        },
        {
            name = "Senior Doctor",
            paycheck = 55000,
            permissions = {"sd.paycheck"}
        },
        {
            name = "Doctor",
            paycheck = 50000,
            permissions = {"doctor.paycheck"}
        },
        {
            name = "Junior Doctor",
            paycheck = 45000,
            permissions = {"juniordoctor.paycheck"}
        },
        {
            name = "Critical Care Paramedic",
            paycheck = 40000,
            permissions = {"ccp.paycheck"}
        }, 
        {
            name = "Paramedic",
            paycheck = 30000,
            permissions = {"paramedic.paycheck"}
        },
        {
            name = "Trainee Paramedic",
            paycheck = 25000,
            permissions = {"trainee.paycheck"}
        },
        {
            name = 'NHS Needs Training',
            paycheck = 10000,
            permissions = {'nhs_needs_training.paycheck'}
        },
    },
    
    ['HMP'] = {
        {
            name = "Governor",
            paycheck = 60000,
            permissions = {"gov.paycheck"}
        },
        {
            name = "Deputy Governor",
            paycheck = 55000,
            permissions = {"depgov.paycheck"}
        },
        {
            name = "Assistant Governor",
            paycheck = 50000,
            permissions = {"assistantgovernor.paycheck"}
        },
        {
            name = "Custodial Supervisor",
            paycheck = 50000,
            permissions = {"custodialsupervisor.paycheck"}
        },
        {
            name = "Custodial Officer",
            paycheck = 42500,
            permissions = {"custodialofficer.paycheck"}
        },
        {
            name = "Honourable Guard",
            paycheck = 40000,
            permissions = {"hguard.paycheck"}
        },
        {
            name = "Guard of the week",
            paycheck = 65000,
            permissions = {"guardoftheweek.paycheck"}
        },
        {
            name = "Supervising Officer",
            paycheck = 40000,
            permissions = {"sofficer.paycheck"}
        },
        {
            name = "Principal Officer",
            paycheck = 37500,
            permissions = {"principal.paycheck"}
        },
        {
            name = "Specialist Officer",
            paycheck = 35000,
            permissions = {"specialistofficer.paycheck"}
        },
        {
            name = "Senior Officer",
            paycheck = 32500,
            permissions = {"so.paycheck"}
        },
        {
            name = "Prison Officer",
            paycheck = 30000,
            permissions = {"prisonofficer.paycheck"}
        },
        {
            name = "Trainee Prison Officer",
            paycheck = 20000,
            permissions = {"tpo.paycheck"}
        },
        {
            name = 'HMP Needs Training',
            paycheck = 10000,
            permissions = {'hmp_needs_training.paycheck'}
        },
    },

    ['LFB'] = {
        {
            name = "Chief Fire Command",
            paycheck = 100000,
            permissions = {"chieffirecommand.paycheck"}
        },
        {
            name = "Divisional Command",
            paycheck = 80000,
            permissions = {"divisionalcommand.paycheck"}
        },
        {
            name = "Sector Command",
            paycheck = 60000,
            permissions = {"sectorcommand.paycheck"}
        },
        {
            name = 'Hounourable Firefighter',
            paycheck = 55000,
            permissions = {'hounourablefirefighter.paycheck'}
        },
        {
            name = "Firefighter of the week",
            paycheck = 65000,
            permissions = {"firefighteroftheweek.paycheck"}
        },
        {
            name = "Leading Firefighter",
            paycheck = 50000,
            permissions = {"leadingfirefighter.paycheck"}
        },
        {
            name = "Specialist Firefighter",
            paycheck = 45000,
            permissions = {"specialistfirefighter.paycheck"}
        },
        {
            name = "Advanced Firefighter",
            paycheck = 40000,
            permissions = {"advancedfirefighter.paycheck"}
        },
        {
            name = "Senior Firefighter",
            paycheck = 35000,
            permissions = {"seniorfirefighter.paycheck"}
        },
        {
            name = "Firefighter",
            paycheck = 30000,
            permissions = {"firefighter.paycheck"}
        },
        {
            name = "Junior Firefighter",
            paycheck = 25000,
            permissions = {"juniorfirefighter.paycheck"}
        },
        {
            name = "Provisional Firefighter",
            paycheck = 20000,
            permissions = {"provisionalfirefighter.paycheck"}
        },    
        {
            name = 'LFB Needs Training',
            paycheck = 10000,
            permissions = {'lfb_needs_training.paycheck'}
        },
    },
}

cfg.minutes = 30 -- Enter Minutes
cfg.interval = cfg.minutes * 60 * 1000 -- Since every wait is done in milliseconds multiply by 1000

return cfg