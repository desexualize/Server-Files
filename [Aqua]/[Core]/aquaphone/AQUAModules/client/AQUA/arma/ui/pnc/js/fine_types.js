
const fines = [
    
    {title: "Offences against a person", subcats:[
            {main: "Common Assault", amount: 25000, act: "Section 39, Criminal Justice Act 1988 "},
            {main: "Manslaughter", amount: 150000, act:"Common Law"},
            {main: "Actual Bodily Harm (ABH)", amount: 45000, act:"Section 47, Offences Against The Person Act 1861 "},
            {main: "Murder", amount: 250000, act: "Common Law"},
            {main: "Grievous Bodily Harm (GBH)", amount: 70000, act:"Section 18, Offences Against the Person Act 1861"},
            {main: "Assault of an emergency worker", amount: 100000, act:"Section 1, Assaults on Emergency Workers Act 2018"},
            {main: "Conspiracy to commit Murder", amount: 100000, act:"Section 4, Offences Against the Person Act 1861"}
    ]},
    {title: "Theft Offences", subcats:[
            {main: "Theft", amount: 40000, act:"Section 1, Theft Act 1968"},
            {main: "Theft of a vehicle", amount:100000, act:"Section 12, Theft Act 1968"},
            {main: "Burglary", amount:60000, act:"Section 9, Theft Act 1968"},
            {main: "Theft of an emergency vehicle", amount: 150000, act: "Section 12, Theft Act 1968"},
            {main: "Aggravated Burglary", amount: 100000, act: "Section 10, Theft Act 1968"},
            {main: "Robbery", amount: 200000, act:"Section 8, Theft Act 1968"}
    ]},
    {title: "Firearms and other Weapons Offences", subcats:[
            {main: "Possession of Firearm", amount: 200000, act: "Section 5, Firearms Act 1968"},
            {main: "Possession of a Bladed Article", amount: 50000, act: "Section 139, Criminal Justice Act 1988"},
            {main: "Possession of Offensive Weapon", amount: 50000, act: "Section 1, Prevention of Crime Act 1953"}
    ]},
    {title: "Criminal Damage Offences", subcats:[
            {main: "Criminal Damage", amount: 25000, act:"Section 1, Criminal Damage Act 1971"},
            {main: "Damage to Government Property", amount: 40000, act:"Section 1, Criminal Damage Act 1971"},
    ]},
    {title: "Road Traffic Offences", subcats:[
            {main: "Death by Dangerous Driving", amount: 150000, act:"Section 1, Road Traffic Act 1988"},
            {main: "Drink Driving", amount:80000, act:"Section 5, Road Traffic Act 1988"},
            {main: "Careless Driving", amount: 25000, act:"Section 3, Road Traffic Act 1988"},
            {main: "Dangerous Driving", amount: 50000, act:"Section 2, Road Traffic Act 1988"},
            {main: "Drug Driving", amount: 60000, act:"Section 5a, Road Traffic Act 1988"},
            {main: "Failing to stop for Police", amount: 50000, act:"Section 163(3), Road Traffic Act 1988"},
            {main: "Not wearing a helmet on a motorbike", amount: 10000, act:"Section 16, Road Traffic Act 1988"},
            {main: "Vehicle Interference", amount: 20000, act:"Section 9, Criminal Attempts Act 1981"},
            {main: "Speeding +10 mph", amount: 20000, act:"Section 89, Road Traffic Regulation Act 1984"},
            {main: "Speeding +20 mph", amount: 40000, act:"Section 89, Road Traffic Regulation Act 1984"},
            {main: "Road Racing", amount: 40000, act:"Section 12, Road Traffic Act 1988"},
            {main: "Illegal Parking", amount: 10000, act:"Section 22, Road Traffic Act 1988"},
            {main: "Failure to comply with a traffic sign/light", amount: 2000, act: "Failure to comply with a traffic sign/light"},
    ]},
    {title: "Drugs Offences", subcats:[
            {main: "Possession of a Class B Drug", amount: 40000, act: "Section 5, Misuse of Drugs Act 1971"},
            {main: "Possession of a Class A Drug", amount: 50000, act:"Section 5, Misuse of Drugs Act 1971"},
            {main: "Possession with intent to supply a Class B Drug", amount: 70000, act:"Section 5, Misuse of Drugs Act 1971"},
            {main: "Possession with intent to supply a Class A Drug", amount: 80000, act:"Section 5, Misuse of Drugs Act 1971"},
            {main: "Concerned in the supply of an illegal drug", amount: 30000, act:"Section 4, Misuse of Drugs Act 1971"}
    ]},
    {title: "Sexual Offences", subcats:[
            {main: "Sexual Assault", amount: 70000, act:"Section 3, Sexual Offences Act 2003"},
            {main: "Indecent Exposure", amount: 30000, act:"Section 66, Sexual Offences Act 2003"},
            {main: "Solicitation", amount: 50000, act: "Section 1, Street Offences Act 1959"}
    ]},
    {title: "Fraud Offences", subcats:[
            {main: "Fraud by False Representation",amount: 40000, act: "Section 2, Fraud Act 2006"},
            {main: "Possession of articles related to Fraud",amount: 30000, act:"Section 6, Fraud Act 2006"},
    ]},
    {title: "Miscellaneous Offences", subcats:[
            {main: "Causing Harassment, Alarm or Distress", amount: 30000, act:"Section 5, Public Order Act 1986"},
            {main: "Intentionally causing Harassment, Alarm or Distress", amount: 40000, act:"Section 4a, Public Order Act 1986"},
            {main: "Harassment", amount: 50000, act: "Section 1, Protection from Harassment Act 1997"},
            {main: "Bribery", amount: 50000, act:"Section 1, Bribery Act 2010"},
            {main: "False imprisonment", amount: 80000, act:"Common Law"},
            {main: "Prison break", amount: 250000, act:"Common Law"},
            {main: "Kidnapping", amount: 50000, act:"Common Law"},
            {main: "Gang Affiliation", amount: 150000, act:"Section 45, Serious Crime Act 2015"},
            {main: "Escaping lawful custody", amount: 60000, act: "Common Law"},
            {main: "Impersonation of a Police Officer", amount: 40000, act: "Section 90, Police Act 1996"},
            {main: "Impeding an Active Police Investigation", amount: 20000, act:"Section 89, Police Act 1996"},
            {main: "Wasting Police Time", amount: 20000, act:"Section 5, Criminal Law Act 1967"},
            {main: "Drunk and Disorderly", amount: 20000, act:"Section 91, Criminal Justice Act 1967"},
            {main: "Aggravated Trespassing", amount: 20000, act:"Section 69, Criminal Justice and Public Order Act 1994"},
            {main: "Failure to provide Identification", amount: 10000, act:"Section 50, Police Reform Act 2002"}
    ]}


]

const points = [
        {
                name : "Driving without due care or attention",
                points : 1,
        },
        {
                name : "Driving without reasonable consideration for other road users",
                points : 1,
        },
        {
                name : "Dangerous driving",
                points : 1,
        },
        {
                name : "Causing death by driving dangerously",
                points : 6,
        },
        {
                name : "Causing serious injury by dangerous driving",
                points : 2,
        },
        {
                name : "Using a vehicle with defective tyre(s)",
                points : 1,
        },
        {
                name : "Using a mobile phone while driving",
                points : 1,
        },
        {
                name : "Driving an unsuitable vehicle, creating danger",
                points : 1,
        },
        {
                name : "Driving whilst above the alcohol limit",
                points : 1,
        },
        {
                name : "Failed to provide a specimen of breath",
                points : 1,
        },
        {
                name : "Leaving a vehicle in a dangerous position",
                points : 1,
        },
        {
                name : "Speeding",
                points : 1,
        },
        {
                name:"Aggravated taking of a vehicle",
                points : 1,
        },
]
