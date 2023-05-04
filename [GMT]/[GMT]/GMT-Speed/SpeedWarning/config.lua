main = {
    leeWay = 0.0, -- Set this to 0.0 to activate immediately when they exceed the limit
    useKmh = false, -- If you set this to true, the resource will use km/h instead of mph
    detectionRadius = 80.0, -- This is the furthest distance you can be from a radar to activate it
    networked = true, -- Set this to true if you wish to network the speed warnings.
}

mainProp = `prop_led_sign`
circleProp = `prop_orange_leds`

props = {
    {
        speed = 30.0,
        modelName = `prop_led_30`
    },
    {
        speed = 40.0,
        modelName = `prop_led_40`
    },
    {
        speed = 50.0,
        modelName = `prop_led_50`
    },
    {
        speed = 60.0,
        modelName = `prop_led_60`
    },
}

locations = {
    {
        limit = 40.0,
        coords = vector3(867.81622314453,-832.78131103516,43.282249450684),
        heading = 90.86,
    },
	{
        limit = 40.0,
        coords = vector3(480.3356628418,-864.31433105469,37.262077331543),
        heading = 265.45,
    },
	{
        limit = 40.0,
        coords = vector3(319.41986083984,-814.41882324219,29.277896881104),
        heading = 341.47,
    },
	{
        limit = 40.0,
        coords = vector3(320.61996459961,-716.52734375,29.31042098999),
        heading = 158.21,
    },
	{
        limit = 40.0,
        coords = vector3(-81.182762145996,-915.29260253906,29.341621398926),
        heading = 64.41,
    },
	{
        limit = 40.0,
        coords = vector3(-158.36999511719,-919.14288330078,29.243787765503),
        heading = 240.76,
    },
	{
        limit = 40.0,
        coords = vector3(-78.409156799316,-743.14782714844,33.935371398926),
        heading = 247.35,
    },
	{
        limit = 40.0,
        coords = vector3(-2.9179878234863,-738.35949707031,32.23416519165),
        heading = 70.11
    },
	{
        limit = 30.0,
        coords = vector3(75.698928833008,-799.08203125,31.574987411499),
        heading = 243.88
    },
	{
        limit = 30.0,
        coords = vector3(147.96415710449,-793.04730224609,31.171054840088),
        heading = 71.77
    },
	{
        limit = 30.0,
        coords = vector3(146.30186462402,-845.74713134766,30.911014556885),
        heading = 158.21
    },
	{
        limit = 30.0,
        coords = vector3(139.51914978027,-951.27722167969,29.690511703491),
        heading = 338.53
    },
	{
        limit = 30.0,
        coords = vector3(141.96131896973,-1028.2622070312,29.350721359253),
        heading = 250.38
    },
	{
        limit = 30.0,
        coords = vector3(161.19586181641,-1008.8147583008,29.52507019043),
        heading = 70.69
    },
	{
        limit = 30.0,
        coords = vector3(249.41529846191,-1007.6521606445,29.271160125732),
        heading = 340.38
    },
	{
        limit = 30.0,
        coords = vector3(251.37547302246,-913.74200439453,29.063556671143),
        heading = 159.56
    },
	{
        limit = 30.0,
        coords = vector3(263.40600585938,-835.68988037109,29.432601928711),
        heading = 67.23
    },
	{
        limit = 30.0,
        coords = vector3(204.17408752441,-849.33825683594,30.643995285034),
        heading = 246.8
    },
	{
        limit = 40.0,
        coords = vector3(77.115631103516,-972.892578125,29.357583999634),
        heading = 70.08
    },
	{
        limit = 40.0,
        coords = vector3(1.7189590930939,-972.13330078125,29.596092224121),
        heading = 249.29
    },
	{
        limit = 40.0,
        coords = vector3(-121.60761260986,-1194.1809082031,27.104818344116),
        heading = 175.84
    },
	{
        limit = 40.0,
        coords = vector3(-121.60761260986,-1194.1809082031,27.104818344116),
        heading = 175.84
    },
	{
        limit = 40.0,
        coords = vector3(-89.242874145508,-1250.8377685547,29.224451065063),
        heading = 352.57
    },
	{
        limit = 30.0,
        coords = vector3(-46.169624328613,-1379.2952880859,29.350046157837),
        heading = 268.1
    },
	{
        limit = 30.0,
        coords = vector3(37.293739318848,-1354.6977539062,29.300163269043),
        heading = 90.1
    },
	{
        limit = 30.0,
        coords = vector3(103.43514251709,-1431.0723876953,29.292896270752),
        heading = 141.94
    },
	{
        limit = 30.0,
        coords = vector3(92.829071044922,-1489.9786376953,29.294422149658),
        heading = 317.43
    },
	{
        limit = 30.0,
        coords = vector3(206.55195617676,-1619.9744873047,29.285629272461),
        heading = 209.97
    },
	{
        limit = 30.0,
        coords = vector3(332.40853881836,-1706.7180175781,29.325614929199),
        heading = 47.52
    },
	{
        limit = 30.0,
        coords = vector3(218.88354492188,-1744.5852050781,29.00830078125),
        heading = 298.16
    },
	{
        limit = 30.0,
        coords = vector3(140.41015625,-1797.7784423828,28.350072860718),
        heading = 138.84
    },
	{
        limit = 30.0,
        coords = vector3(-102.82416534424,-1775.1572265625,29.517436981201),
        heading = 228.55
    },
	{
        limit = 40.0,
        coords = vector3(-166.64848327637,-1752.3649902344,29.976579666138),
        heading = 139.83
    },
	{
        limit = 40.0,
        coords = vector3(-221.23745727539,-1825.6240234375,30.002511978149),
        heading = 297.75
    },
	{
        limit = 40.0,
        coords = vector3(-466.75128173828,-1772.4486083984,20.858991622925),
        heading = 92.71
    },
	{
        limit = 40.0,
        coords = vector3(-657.50103759766,-1676.6151123047,25.28059387207),
        heading = 219.15
    },
	{
        limit = 40.0,
        coords = vector3(-678.79223632812,-1579.2236328125,18.401857376099),
        heading = 321.42
    },
	{
        limit = 40.0,
        coords = vector3(-660.76123046875,-1392.7131347656,10.638459205627),
        heading = 171.41
    },
	{
        limit = 30.0,
        coords = vector3(1051.4545898438,-405.94879150391,66.957763671875),
        heading = 130.16
    },
	{
        limit = 30.0,
        coords = vector3(900.76104736328,-577.65411376953,57.360877990723),
        heading = 54.24
    },
	{
        limit = 40.0,
        coords = vector3(1303.7026367188,-1629.7503662109,52.224590301514),
        heading = 125.07
    },
	{
        limit = 40.0,
        coords = vector3(1193.4221191406,-1713.9113769531,35.54224395752),
        heading = 297.89
    },
	{
        limit = 40.0,
        coords = vector3(948.10467529297,-1791.5307617188,31.136507034302),
        heading = 173.95
    },
	{
        limit = 40.0,
        coords = vector3(946.16088867188,-2033.1687011719,30.140871047974),
        heading = 352.24
    },
	{
        limit = 40.0,
        coords = vector3(1055.0656738281,-1872.6278076172,30.527578353882),
        heading = 96.71
    },
	{
        limit = 50.0,
        coords = vector3(1105.5740966797,580.72772216797,100.4454574585),
        heading = 347.75
    },
	{
        limit = 50.0,
        coords = vector3(481.16094970703,862.74792480469,197.99496459961),
        heading = 255.41
    },
	{
        limit = 40.0,
        coords = vector3(-12.962394714355,1056.4543457031,219.4083404541),
        heading = 81.9
    },
	{
        limit = 40.0,
        coords = vector3(-583.85406494141,967.13433837891,241.9677734375),
        heading = 231.4
    },
	{
        limit = 30.0,
        coords = vector3(-412.79434204102,6050.2172851562,31.590328216553),
        heading = 34.38
    },
	{
        limit = 30.0,
        coords = vector3(-330.98568725586,6215.4106445312,31.337661743164),
        heading = 133.14
    },
	{
        limit = 30.0,
        coords = vector3(-393.00296020508,6297.4995117188,29.474477767944),
        heading = 119.01
    },
	{
        limit = 30.0,
        coords = vector3(-147.30581665039,6377.2924804688,31.527755737305),
        heading = 311.27
    },
	{
        limit = 30.0,
        coords = vector3(-7.0239720344543,6537.931640625,31.455959320068),
        heading = 134.91
    },
	{
        limit = 30.0,
        coords = vector3(-154.75106811523,6452.603515625,31.376420974731),
        heading = 220.97
    },
	{
        limit = 50.0,
        coords = vector3(-815.67370605469,1817.9106445312,166.62837219238),
        heading = 131.65
    },
	{
        limit = 50.0,
        coords = vector3(138.92471313477,1613.8673095703,229.15576171875),
        heading = 180.96
    },
	{
        limit = 50.0,
        coords = vector3(135.13459777832,1669.8150634766,228.55128479004),
        heading = 42.46
    },
	{
        limit = 40.0,
        coords = vector3(328.83099365234,1020.1640014648,210.52578735352),
        heading = 358.62
    },
	{
        limit = 40.0,
        coords = vector3(241.10844421387,1279.9792480469,234.41209411621),
        heading = 182.48
    },
	{
        limit = 40.0,
        coords = vector3(483.49383544922,48.593879699707,93.484931945801),
        heading = 154.29
    },
	{
        limit = 40.0,
        coords = vector3(434.95065307617,-98.92497253418,68.264335632324),
        heading = 322.58
    },
}