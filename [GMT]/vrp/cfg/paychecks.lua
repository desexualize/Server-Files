local cfg = {}

cfg.paychecks = {
    -- Police,
    {
        name = "Special Constable",
        paycheck = 25000,
        permissions = {"specialconstable.pd"}
    },
    {
        name = "Commissioner",
        paycheck = 65000,
        permissions = {"commissioner.pd"}
    },
    {
        name = "Deputy Commissioner",
        paycheck = 60000,
        permissions = {"deputycommissioner.pd"}
    },
    {
        name = "Deputy Assistant Commissioner",
        paycheck = 55000,
        permissions = {"deputyassistantcommissioner.pd"}
    },
    {
        name = "Commander",
        paycheck = 50000,
        permissions = {"commander.pd"}
    },
    {
        name = "Chief Superintendent",
        paycheck = 45000,
        permissions = {"chiefsuperintendent.pd"}
    },
    {
        name = "Superintendent",
        paycheck = 40000,
        permissions = {"superintendent.pd"}
    },
    {
        name = "ChiefInspector",
        paycheck = 35000,
        permissions = {"chiefinspector.pd"}
    },
    {
        name = "Inspector",
        paycheck = 30000,
        permissions = {"inspector.pd"}
    },
    {
        name = "Sergeant",
        paycheck = 25000,
        permissions = {"sergeant.pd"}
    },
    {
        name = "Senior Constable",
        paycheck = 20000,
        permissions = {"seniorconstable.pd"}
    },
    {
        name = "Police Constable",
        paycheck = 15000,
        permissions = {"policeconstable.pd"}
    },
    {
        name = "PCSO",
        paycheck = 10000,
        permissions = {"pcso.pd"}
    },
}

cfg.interval = 1800000
return cfg

