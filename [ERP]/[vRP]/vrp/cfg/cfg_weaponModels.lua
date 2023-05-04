local weapons = {}

weapons.weapon_models = {
    [`w_me_axe`] = true,
    [`w_me_baseballbat`] = true,
    [`w_me_broom`] = true,
    [`w_me_diamondsword`] = true,
    [`w_me_shank`] = true,
    [`w_me_shovel`] = true,
    [`w_ar_ak47`] = true,
    [`w_ar_akkal`] = true,
    [`w_sb_uzi`] = true,
    [`w_sg_winchester12`] = true,
    [`w_ar_ak74kashnar`] = true,
    [`w_ar_mosin`] = true,
    [`w_ar_m4a1`] = true,
    [`w_ar_spar16`] = true,
    [`w_sr_svd`] = true,
}

return weapons

-- This is an example of the file that will allow weapon models to spawn and not cancel the event of the entity spawning.
-- You may place this anywhere such as your weapons resource, just make sure to set the correct module in the server side with
-- the correct file path.

-- The same goes for vrp garages.