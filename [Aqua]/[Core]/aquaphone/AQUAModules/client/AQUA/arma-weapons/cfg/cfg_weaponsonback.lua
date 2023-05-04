local cfg = {}

cfg.weapons = {
    --?Melee's
	[`WEAPON_WOODENBAT`] = {bone = 24818, offset = vector3(0.32, -0.15, 0.13), rotation = vector3(0.0, -90.0, 0.0), model = `w_me_woodenbat`},
	[`WEAPON_BROOM`] = {bone = 24818, offset = vector3(-0.60, -0.15, 0.13), rotation = vector3(50.0, 90.0, 2.0), model = `w_me_broom`},
	[`WEAPON_SLEDGEHAMMER`] = {bone = 24818, offset = vector3(-0.35, -0.10, 0.13), rotation = vector3(190.0, 180.0, 105.0), model = `w_me_sledgehammer`},
	[`WEAPON_SHOVEL`] = {bone = 24818, offset = vector3(0.32, -0.10, 0.10), rotation = vector3(5.0, 200.0, 80.0), model = `w_me_shovel`},
	[`WEAPON_GUITAR`] = {bone = 24818, offset = vector3(0.32, -0.15, 0.13), rotation = vector3(0.0, -90.0, 0.0), model = `w_me_guitar`},
	[`WEAPON_TOILETBRUSH`] = {bone = 51826, offset = vector3(-0.01, 0.10, 0.07),  rotation = vector3(0.0, 0.0, -100.0), model = `w_me_toiletbrush`},
	[`WEAPON_DILDO`] = {bone = 58271, offset = vector3(-0.01, 0.1, -0.07), rotation = vector3(-35.0, 0.10, -100.0), model = `w_me_dildo`},
	[`WEAPON_MJOLNIR`] = {bone = 58271, offset = vector3(-0.01, 0.1, -0.07), rotation = vector3(-35.0, 0.10, -100.0), model = `w_me_mjolnir`},
	[`WEAPON_CRICKETBAT`] = {bone = 24818, offset = vector3(0.32, -0.15, 0.13), rotation = vector3(0.0, -90.0, 0.0), model = `w_me_cricketbat`},
	[`WEAPON_BASEBALLBAT`] = {bone = 24818, offset = vector3(0.32, -0.15, 0.13), rotation = vector3(0.0, -90.0, 0.0), model = `w_me_baseballbat`},
	[`WEAPON_FIREAXE`] = {bone = 24818, offset = vector3(0.32, -0.15, 0.13), rotation = vector3(0.0, -90.0, 0.0), model = `w_me_fireaxe`},

	--?PD SMGs/Rifles
	[`WEAPON_STING`] = {bone = 24818, offset = vector3(0.0, 0.18, 0.0), rotation = vector3(180.0, 148.0, 0.0), model = `w_sb_sting`},
	[`WEAPON_MP5`] = {bone = 24818, offset = vector3(0.0, 0.18, 0.0), rotation = vector3(180.0, 148.0, 0.0), model = `w_sb_mp5`},
	[`WEAPON_NONMP5`] = {bone = 24818, offset = vector3(0.0, 0.18, 0.0), rotation = vector3(180.0, 148.0, 0.0), model = `w_sb_nonmp5`},
	[`WEAPON_M4A1`] = {bone = 24818, offset = vector3(0.0, 0.18, 0.0), rotation = vector3(180.0, 148.0, 0.0), model = `w_ar_m4a1`},
	[`WEAPON_SIGMCX`] = {bone = 24818, offset = vector3(0.0, 0.18, 0.0), rotation = vector3(180.0, 148.0, 0.0), model = `w_ar_sigmcx`},
	[`WEAPON_SIGMPX`] = {bone = 24818, offset = vector3(0.0, 0.18, 0.0), rotation = vector3(180.0, 148.0, 0.0), model = `w_ar_sigmpx`},
	[`WEAPON_SPAR17`] = {bone = 24818, offset = vector3(0.0, 0.18, 0.0), rotation = vector3(180.0, 148.0, 0.0), model = `w_ar_spar17`},
	[`WEAPON_G36K`] = {bone = 24818, offset = vector3(0.0, 0.18, 0.0), rotation = vector3(180.0, 148.0, 0.0), model = `w_ar_g36k`},
	[`WEAPON_REMINGTON870`] = {bone = 24818, offset = vector3(-0.12, -0.12, -0.13), rotation = vector3(100.0, -3.0, 5.0), model = `w_sg_remington870`, components = {`COMPONENT_REMINGTON870_CLIP_01`, `COMPONENT_REMINGTON870_TUBE_01`, `COMPONENT_REMINGTON870_STOCK_01`, `COMPONENT_REMINGTON870_SCOPE_01`}, removeComponents = {`COMPONENT_REMINGTON870_FLSH_01`}},
	[`WEAPON_NOVESKENSR9`] = {bone = 24818, offset = vector3(0.0, 0.18, 0.0), rotation = vector3(180.0, 148.0, 0.0), model = `w_ar_noveskensr9`},
	[`WEAPON_TYLON`] = {bone = 24818, offset = vector3(0.0, 0.18, 0.0), rotation = vector3(180.0, 148.0, 0.0), model = `w_ar_tylon`},

	--?Mosin
	[`WEAPON_MOSIN`] = {bone = 24818, offset = vector3(-0.12, -0.12, -0.13), rotation = vector3(100.0, -3.0, 5.0), model = `w_ar_mosin`},
}

return cfg