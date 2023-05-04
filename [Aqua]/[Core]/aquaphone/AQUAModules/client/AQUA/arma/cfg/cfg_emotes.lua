local cfg = {}

cfg.moods = {
    ["Angry"] = {"Expression", "mood_angry_1"},
    ["Drunk"] = {"Expression", "mood_drunk_1"},
    ["Dumb"] = {"Expression", "pose_injured_1"},
    ["Electrocuted"] = {"Expression", "electrocuted_1"},
    ["Grumpy"] = {"Expression", "effort_1"},
    ["Grumpy2"] = {"Expression", "mood_drivefast_1"},
    ["Grumpy3"] = {"Expression", "pose_angry_1"},
    ["Happy"] = {"Expression", "mood_happy_1"},
    ["Injured"] = {"Expression", "mood_injured_1"},
    ["Joyful"] = {"Expression", "mood_dancing_low_1"},
    ["Mouthbreather"] = {"Expression", "smoking_hold_1"},
    ["Never Blink"] = {"Expression", "pose_normal_1"},
    ["One Eye"] = {"Expression", "pose_aiming_1"},
    ["Shocked"] = {"Expression", "shocked_1"},
    ["Shocked2"] = {"Expression", "shocked_2"},
    ["Sleeping"] = {"Expression", "mood_sleeping_1"},
    ["Sleeping2"] = {"Expression", "dead_1"},
    ["Sleeping3"] = {"Expression", "dead_2"},
    ["Smug"] = {"Expression", "mood_smug_1"},
    ["Speculative"] = {"Expression", "mood_aiming_1"},
    ["Stressed"] = {"Expression", "mood_stressed_1"},
    ["Sulking"] = {"Expression", "mood_sulk_1"},
    ["Weird"] = {"Expression", "effort_2"},
    ["Weird2"] = {"Expression", "effort_3"},
}

cfg.walks = {
    ["Alien"] = {"move_m@alien"},
    ["Armored"] = {"anim_group_move_ballistic"},
    ["Arrogant"] = {"move_f@arrogant@a"},
    ["Brave"] = {"move_m@brave"},
    ["Casual"] = {"move_m@casual@a"},
    ["Casual2"] = {"move_m@casual@b"},
    ["Casual3"] = {"move_m@casual@c"},
    ["Casual4"] = {"move_m@casual@d"},
    ["Casual5"] = {"move_m@casual@e"},
    ["Casual6"] = {"move_m@casual@f"},
    ["Chichi"] = {"move_f@chichi"},
    ["Confident"] = {"move_m@confident"},
    ["Cop"] = {"move_m@business@a"},
    ["Cop2"] = {"move_m@business@b"},
    ["Cop3"] = {"move_m@business@c"},
    ["Defult Female"] = {"move_f@multiplayer"},
    ["Default Male"] = {"move_m@multiplayer"},
    ["Drunk"] = {"move_m@drunk@a"},
    ["Drunk1"] = {"move_m@drunk@slightlydrunk"},
    ["Drunk2"] = {"move_m@buzzed"},
    ["Drunk3"] = {"move_m@drunk@verydrunk"},
    ["Femme"] = {"move_f@femme@"},
    ["Fire"] = {"move_characters@franklin@fire"},
    ["Fire2"] = {"move_characters@michael@fire"},
    ["Fire3"] = {"move_m@fire"},
    ["Flee"] = {"move_f@flee@a"},
    ["Franklin"] = {"move_p_m_one"},
    ["Gangster"] = {"move_m@gangster@generic"},
    ["Gangster2"] = {"move_m@gangster@ng"},
    ["Gangster3"] = {"move_m@gangster@var_e"},
    ["Gangster4"] = {"move_m@gangster@var_f"},
    ["Gangster5"] = {"move_m@gangster@var_i"},
    ["Grooving"] = {"anim@move_m@grooving@"},
    ["Guard"] = {"move_m@prison_gaurd"},
    ["Handcuffs"] = {"move_m@prisoner_cuffed"},
    ["Heels"] = {"move_f@heels@c"},
    ["Heels2"] = {"move_f@heels@d"},
    ["Hiking"] = {"move_m@hiking"},
    ["Hipster"] = {"move_m@hipster@a"},
    ["Hobo"] = {"move_m@hobo@a"},
    ["Hurry"] = {"move_f@hurry@a"},
    ["Janitor"] = {"move_p_m_zero_janitor"},
    ["Janitor2"] = {"move_p_m_zero_slow"},
    ["Jog"] = {"move_m@jog@"},
    ["Lemar"] = {"anim_group_move_lemar_alley"},
    ["Lester"] = {"move_heist_lester"},
    ["Lester2"] = {"move_lester_caneup"},
    ["Maneater"] = {"move_f@maneater"},
    ["Michael"] = {"move_ped_bucket"},
    ["Money"] = {"move_m@money"},
    ["Muscle"] = {"move_m@muscle@a"},
    ["Posh"] = {"move_m@posh@"},
    ["Posh2"] = {"move_f@posh@"},
    ["Quick"] = {"move_m@quick"},
    ["Runner"] = {"female_fast_runner"},
    ["Sad"] = {"move_m@sad@a"},
    ["Sassy"] = {"move_m@sassy"},
    ["Sassy2"] = {"move_f@sassy"},
    ["Scared"] = {"move_f@scared"},
    ["Sexy"] = {"move_f@sexy@a"},
    ["Shady"] = {"move_m@shadyped@a"},
    ["Slow"] = {"move_characters@jimmy@slow@"},
    ["Swagger"] = {"move_m@swagger"},
    ["Tough"] = {"move_m@tough_guy@"},
    ["Tough2"] = {"move_f@tough_guy@"},
    ["Trash"] = {"clipset@move@trash_fast_turn"},
    ["Trash2"] = {"missfbi4prepp1_garbageman"},
    ["Trevor"] = {"move_p_m_two"},
    ["Wide"] = {"move_m@bag"},
    ["Chubby Male"] = {"move_chubby"},
    ["Chubby Female"] = {"move_f@chubby@a"},
    ["Depressed1"] = {"move_m@depressed@a"},
    ["Depressed2"] = {"move_m@depressed@b"},
}

cfg.shared = {
    ["handshake"] = {"mp_ped_interaction", "handshake_guy_a", "Handshake", "handshake2", animationOptions =
    {
        emoteMoving = true,
        emoteDuration = 3000,
        syncOffsetFront = 0.9
    }},
    ["handshake2"] = {"mp_ped_interaction", "handshake_guy_b", "Handshake 2", "handshake", animationOptions =
    {
        emoteMoving = true,
        emoteDuration = 3000
    }},
    --["hug"] = {"mp_ped_interaction", "kisses_guy_a", "Hug", "hug2", animationOptions =
    --    {
    --        emoteMoving = false,
    --        emoteDuration = 5000,
    --        syncOffsetFront = 1.05,
    --    }},
    --["hug2"] = {"mp_ped_interaction", "kisses_guy_b", "Hug 2", "hug", animationOptions =
    --    {
    --        emoteMoving = false,
    --        emoteDuration = 5000,
    --        syncOffsetFront = 1.13
    --    }},
    --["bro"] = {"mp_ped_interaction", "hugs_guy_a", "Bro", "bro2", animationOptions =
    --    {
    --         syncOffsetFront = 1.14
    --}},
    -- ["bro2"] = {"mp_ped_interaction", "hugs_guy_b", "Bro 2", "bro", animationOptions =
    -- {
    --     syncOffsetFront = 1.14
    -- }},
    ["give"] = {"mp_common", "givetake1_a", "Give", "give2", animationOptions =
    {
        emoteMoving = true,
        emoteDuration = 2000
    }},
    ["give2"] = {"mp_common", "givetake1_b", "Give 2", "give", animationOptions =
    {
        emoteMoving = true,
        emoteDuration = 2000
    }},
    ["baseball"] = {"anim@arena@celeb@flat@paired@no_props@", "baseball_a_player_a", "Baseball", "baseballthrow"},
    ["baseballthrow"] = {"anim@arena@celeb@flat@paired@no_props@", "baseball_a_player_b", "Baseball Throw", "baseball"},
    ["stickup"] = {"random@countryside_gang_fight", "biker_02_stickup_loop", "Stick Up", "stickupscared", animationOptions =
    {
        emoteLoop = true,
        emoteMoving = true,
    }},
    ["stickupscared"] = {"missminuteman_1ig_2", "handsup_base", "Stickup Scared", "stickup", animationOptions =
    {
        emoteMoving = true,
        emoteLoop = true,
    }},
    ["punch"] = {"melee@unarmed@streamed_variations", "plyr_takedown_rear_lefthook", "Punch", "punched"},
    ["punched"] = {"melee@unarmed@streamed_variations", "victim_takedown_front_cross_r", "Punched", "punch"},
    ["headbutt"] = {"melee@unarmed@streamed_variations", "plyr_takedown_front_headbutt", "Headbutt", "headbutted"},
    ["headbutted"] = {"melee@unarmed@streamed_variations", "victim_takedown_front_headbutt", "Headbutted", "headbutt"},
    ["slap2"] = {"melee@unarmed@streamed_variations", "plyr_takedown_front_backslap", "Slap 2", "slapped2", animationOptions =
    {
        emoteLoop = true,
        emoteMoving = true,
        emoteDuration = 2000,
    }},
    ["slap"] = {"melee@unarmed@streamed_variations", "plyr_takedown_front_slap", "Slap", "slapped", animationOptions =
    {
        emoteLoop = true,
        emoteMoving = true,
        emoteDuration = 2000,
    }},
    ["slapped"] = {"melee@unarmed@streamed_variations", "victim_takedown_front_slap", "Slapped", "slap"},
    ["slapped2"] = {"melee@unarmed@streamed_variations", "victim_takedown_front_backslap", "Slapped 2", "slap2"},
    ["Receive Blowjob"] = {"misscarsteal2pimpsex", "pimpsex_punter", "Receive Blowjob", "Give Blowjob", animationOptions =
    {
        emoteMoving = false,
        emoteDuration = 30000,
        syncOffsetFront = 0.63
    }},
    ["Give Blowjob"] = {"misscarsteal2pimpsex", "pimpsex_hooker", "Give Blowjob", "Receive Blowjob", animationOptions =
    {
        emoteMoving = false,
        emoteDuration = 30000,
        syncOffsetFront = 0.63
    }},
    ["Street Sex Male"] = {"misscarsteal2pimpsex", "shagloop_pimp", "Street Sex Male", "Street Sex Female", animationOptions =
    {
        emoteMoving = false,
        emoteLoop = true,
        syncOffsetFront = 0.50
    }},
    ["Street Sex Female"] = {"misscarsteal2pimpsex", "shagloop_hooker", "Street Sex Female", "Street Sex Male", animationOptions =
    {
        emoteMoving = false,
        emoteLoop = true,
        syncOffsetFront = 0.50
    }},
    --["hug3"] = {"misscarsteal2chad_goodbye", "chad_armsaround_chad", "Hug 3", "hug4", animationOptions =
    --    {
    --       emoteMoving = false,
    --       emoteLoop = true,
    --       syncOffsetFront = 0.05,
    --    }},
    --["hug4"] = {"misscarsteal2chad_goodbye", "chad_armsaround_girl", "Hug 4", "hug3", animationOptions =
    --    {
    --       emoteMoving = false,
    --       emoteLoop = true,
    --       syncOffsetFront = 0.13
    --    }},
    ["hug"] = {"mp_ped_interaction", "kisses_guy_b", "Hug", "hug", animationOptions = {
        emoteMoving = false,
        emoteDuration = 3000,
        syncOffsetFront = 1.1
    }},
    ["kiss"] = {"mp_ped_interaction", "kisses_guy_a", "Kiss", "kiss", animationOptions = {
        emoteMoving = false,
        emoteDuration = 10000,
        syncOffsetFront = 1.325
    }},
    ["ganghug"] = {"mp_ped_interaction", "hugs_guy_b", "Gang Hug", "ganghug", animationOptions = {
        emoteMoving = false,
        emoteDuration = 3000,
        syncOffsetFront = 1.15
    }},
    ["givetake"] = {"mp_common", "givetake1_a", "Give Take", "givetake", animationOptions = {
        emoteMoving = false,
        emoteDuration = 3000,
        syncOffsetFront = 0.8
    }},
    ["angryclap"] = {"anim@arena@celeb@flat@solo@no_props@", "angry_clap_a_player_a", "Angry Clap", "angryclap", animationOptions = {
        emoteMoving = false,
        emoteDuration = 30000,
        syncOffsetFront = 1.15
    }},
    ["backslap"] = {"anim@mp_player_intcelebrationpaired@f_f_backslap", "backslap_left", "Backslap", "backslap_remote", animationOptions = {
        emoteMoving = false,
        emoteDuration = 30000,
        syncOffsetFront = 1.15
    }},
    ["backslap_remote"] = {"anim@mp_player_intcelebrationpaired@f_f_backslap", "backslap_right", "Backslap", "backslap", animationOptions = {
        invisible = true,
        emoteMoving = false,
        emoteDuration = 30000,
        syncOffsetFront = 0.0
    }},
    ["smug"] = {"anim@arena@celeb@flat@solo@no_props@", "smug_a_player_a", "Smug", "smug_remote", animationOptions = {
        emoteMoving = false,
        emoteDuration = 30000,
        syncOffsetFront = 1.15
    }},
    ["smug_remote"] = {"anim@arena@celeb@flat@solo@no_props@", "smug_a_player_b", "Smug", "smug", animationOptions = {
        invisible = true,
        emoteMoving = false,
        emoteDuration = 30000,
        syncOffsetFront = 1.15
    }},
    ["highfive"] = {"mp_ped_interaction", "highfive_guy_a", "High Five", "highfive_remote", animationOptions = {
        emoteMoving = false,
        emoteDuration = 3000,
        syncOffsetFront = 1.2
    }},
    ["highfive_remote"] = {"mp_ped_interaction", "highfive_guy_b", "High Five", "highfive", animationOptions = {
        invisible = true,
        emoteMoving = false,
        emoteDuration = 3000,
        syncOffsetFront = -0.3
    }},
    ["slapbum"] = {"misscarsteal2chad_goodbye", "chad_dip_chad", "Slap Bum", "slapbum_remote", animationOptions = {
        emoteMoving = false,
        emoteDuration = 30000,
        syncOffsetFront = 0.55
    }},
    ["slapbum_remote"] = {"misscarsteal2chad_goodbye", "chad_dip_girl", "Slap Bum", "slapbum", animationOptions = {
        invisible = true,
        emoteMoving = false,
        emoteDuration = 30000,
        syncOffsetFront = 0.12
    }},
    ["thumbsdown"] = {"anim@arena@celeb@flat@solo@no_props@", "thumbs_down_a_player_a", "Thumbs Down", "thumbsdown_remote", animationOptions = {
        emoteMoving = false,
        emoteDuration = 30000,
        syncOffsetFront = 1.15
    }},
    ["thumbsdown_remote"] = {"anim@arena@celeb@flat@solo@no_props@", "thumbs_down_a_player_b", "Thumb Down", "thumbsdown", animationOptions = {
        invisible = true,
        emoteMoving = false,
        emoteDuration = 30000,
        syncOffsetFront = 0.0
    }},
    ["baseball2"] = {"anim@arena@celeb@flat@paired@no_props@", "daps_b_player_a", "Baseball 2", "baseball2_remote", animationOptions = {
        emoteMoving = false,
        emoteDuration = 30000,
        syncOffsetFront = 2.0
    }},
    ["baseball2_remote"] = {"anim@arena@celeb@flat@paired@no_props@", "daps_b_player_b", "Baseball 2", "baseball2", animationOptions = {
        invisible = true,
        emoteMoving = false,
        emoteDuration = 30000,
        syncOffsetFront = 0.5
    }},
    ["baseball3"] = {"anim@arena@celeb@flat@paired@no_props@", "did_you_see_a_player_a", "Baseball 3", "baseball3_remote", animationOptions = {
        emoteMoving = false,
        emoteDuration = 30000,
        syncOffsetFront = 1.15
    }},
    ["baseball3_remote"] = {"anim@arena@celeb@flat@paired@no_props@", "did_you_see_a_player_b", "Baseball 3", "baseball3", animationOptions = {
        invisible = true,
        emoteMoving = false,
        emoteDuration = 30000,
        syncOffsetFront = 0.0
    }},
    ["baseball4"] = {"anim@arena@celeb@flat@paired@no_props@", "high_five_b_player_a", "Baseball 4", "baseball4_remote", animationOptions = {
        emoteMoving = false,
        emoteDuration = 30000,
        syncOffsetFront = 1.15
    }},
    ["baseball4_remote"] = {"anim@arena@celeb@flat@paired@no_props@", "high_five_b_player_b", "Baseball 4", "baseball4", animationOptions = {
        invisible = true,
        emoteMoving = false,
        emoteDuration = 30000,
        syncOffsetFront = 0.0
    }},
    ["baseball5"] = {"anim@arena@celeb@flat@paired@no_props@", "high_five_c_player_a", "Baseball 5", "baseball5_remote", animationOptions = {
        emoteMoving = false,
        emoteDuration = 30000,
        syncOffsetFront = 2.7
    }},
    ["baseball5_remote"] = {"anim@arena@celeb@flat@paired@no_props@", "high_five_c_player_b", "Baseball 5", "baseball5", animationOptions = {
        invisible = true,
        emoteMoving = false,
        emoteDuration = 30000,
        syncOffsetFront = -0.5
    }},
    ["baseball6"] = {"anim@arena@celeb@flat@paired@no_props@", "hype_a_player_a", "Baseball 6", "baseball6_remote", animationOptions = {
        emoteMoving = false,
        emoteDuration = 30000,
        syncOffsetFront = 2.15
    }},
    ["baseball6_remote"] = {"anim@arena@celeb@flat@paired@no_props@", "hype_a_player_b", "Baseball 6", "baseball6", animationOptions = {
        invisible = true,
        emoteMoving = false,
        emoteDuration = 30000,
        syncOffsetFront = 0.0
    }},
    ["baseball7"] = {"anim@arena@celeb@flat@paired@no_props@", "laugh_a_player_a", "Baseball 7", "baseball7_remote", animationOptions = {
        emoteMoving = false,
        emoteDuration = 30000,
        syncOffsetFront = 1.15
    }},
    ["baseball7_remote"] = {"anim@arena@celeb@flat@paired@no_props@", "laugh_a_player_b", "Baseball 7", "baseball7", animationOptions = {
        invisible = true,
        emoteMoving = false,
        emoteDuration = 30000,
        syncOffsetFront = 0.0
    }},
    ["baseball8"] = {"anim@arena@celeb@flat@paired@no_props@", "laugh_b_player_a", "Baseball 8", "baseball8_remote", animationOptions = {
        emoteMoving = false,
        emoteDuration = 30000,
        syncOffsetFront = 1.15
    }},
    ["baseball8_remote"] = {"anim@arena@celeb@flat@paired@no_props@", "laugh_b_player_b", "Baseball 8", "baseball8", animationOptions = {
        invisible = true,
        emoteMoving = false,
        emoteDuration = 30000,
        syncOffsetFront = 0.0
    }},
    ["baseball9"] = {"anim@arena@celeb@flat@paired@no_props@", "the_bird_a_player_a", "Baseball 9", "baseball9_remote", animationOptions = {
        emoteMoving = false,
        emoteDuration = 30000,
        syncOffsetFront = 1.15
    }},
    ["baseball9_remote"] = {"anim@arena@celeb@flat@paired@no_props@", "the_bird_a_player_b", "Baseball 9", "baseball9", animationOptions = {
        invisible = true,
        emoteMoving = false,
        emoteDuration = 30000,
        syncOffsetFront = 0.0
    }},
    ["trophy"] = {"anim@arena@celeb@flat@paired@props@", "trophy_a_player_a", "Trophy", "trophy_remote", animationOptions = {
        emoteMoving = false,
        emoteDuration = 30000,
        syncOffsetFront = 1.15
    }},
    ["trophy_remote"] = {"anim@arena@celeb@flat@paired@props@", "trophy_a_player_b", "Trophy", "trophy", animationOptions = {
        invisible = true,
        emoteMoving = false,
        emoteDuration = 30000,
        syncOffsetFront = 0.0
    }},
    ["trophy2"] = {"anim@arena@celeb@flat@paired@props@", "trophy_b_player_a", "Trophy 2", "trophy2_remote", animationOptions = {
        emoteMoving = false,
        emoteDuration = 30000,
        syncOffsetFront = 1.15
    }},
    ["trophy2_remote"] = {"anim@arena@celeb@flat@paired@props@", "trophy_b_player_b", "Trophy 2", "trophy2", animationOptions = {
        invisible = true,
        emoteMoving = false,
        emoteDuration = 30000,
        syncOffsetFront = 0.0
    }},
    ["trophy3"] = {"anim@arena@celeb@flat@paired@props@", "trophy_c_player_a", "Trophy 3", "trophy3_remote", animationOptions = {
        emoteMoving = false,
        emoteDuration = 30000,
        syncOffsetFront = 1.15
    }},
    ["trophy3_remote"] = {"anim@arena@celeb@flat@paired@props@", "trophy_c_player_b", "Trophy 3", "trophy3", animationOptions = {
        invisible = true,
        emoteMoving = false,
        emoteDuration = 30000,
        syncOffsetFront = 0.0
    }},
    ["celebrate"] = {"anim@arena@celeb@flat@paired@props@", "cham_a_player_a", "Celebrate", "celebrate_remote", animationOptions = {
        emoteMoving = false,
        emoteDuration = 30000,
        syncOffsetFront = 1.15
    }},
    ["celebrate_remote"] = {"anim@arena@celeb@flat@paired@props@", "cham_a_player_b", "Celebrate", "celebrate", animationOptions = {
        invisible = true,
        emoteMoving = false,
        emoteDuration = 30000,
        syncOffsetFront = 0.0
    }},
    ["celebrate2"] = {"anim@arena@celeb@flat@paired@props@", "cham_b_player_a", "Celebrate 2", "celebrate2_remote", animationOptions = {
        emoteMoving = false,
        emoteDuration = 30000,
        syncOffsetFront = 1.15
    }},
    ["celebrate2_remote"] = {"anim@arena@celeb@flat@paired@props@", "cham_b_player_b", "Celebrate 2", "celebrate2", animationOptions = {
        invisible = true,
        emoteMoving = false,
        emoteDuration = 30000,
        syncOffsetFront = 0.0
    }},
    ["celebrate3"] = {"anim@arena@celeb@flat@paired@props@", "cham_c_player_a", "Celebrate 3", "celebrate3_remote", animationOptions = {
        emoteMoving = false,
        emoteDuration = 30000,
        syncOffsetFront = 1.15
    }},
    ["celebrate3_remote"] = {"anim@arena@celeb@flat@paired@props@", "cham_c_player_b", "Celebrate 3", "celebrate3", animationOptions = {
        invisible = true,
        emoteMoving = false,
        emoteDuration = 30000,
        syncOffsetFront = 0.0
    }},
    ["celebrate4"] = {"anim@arena@celeb@flat@paired@props@", "cham_d_player_a", "Celebrate 4", "celebrate4_remote", animationOptions = {
        emoteMoving = false,
        emoteDuration = 30000,
        syncOffsetFront = 1.15
    }},
    ["celebrate4_remote"] = {"anim@arena@celeb@flat@paired@props@", "cham_d_player_b", "Celebrate 4", "celebrate4", animationOptions = {
        invisible = true,
        emoteMoving = false,
        emoteDuration = 30000,
        syncOffsetFront = 0.0
    }},
    ["celebrate5"] = {"anim@arena@celeb@flat@solo@no_props@", "jump_a_player_a", "Celebrate 5", "celebrate5_remote", animationOptions = {
        emoteMoving = false,
        emoteDuration = 30000,
        syncOffsetFront = 1.15
    }},
    ["celebrate5_remote"] = {"anim@arena@celeb@flat@solo@no_props@", "jump_a_player_a", "Celebrate 5", "celebrate5", animationOptions = {
        invisible = true,
        emoteMoving = false,
        emoteDuration = 30000,
        syncOffsetFront = 0.0
    }},
    ["celebrate6"] = {"anim@arena@celeb@flat@solo@no_props@", "jump_b_player_a", "Celebrate 6", "celebrate6_remote", animationOptions = {
        emoteMoving = false,
        emoteDuration = 30000,
        syncOffsetFront = 3.45
    }},
    ["celebrate6_remote"] = {"anim@arena@celeb@flat@solo@no_props@", "jump_b_player_a", "Celebrate 6", "celebrate6", animationOptions = {
        invisible = true,
        emoteMoving = false,
        emoteDuration = 30000,
        syncOffsetFront = 0.0
    }},
    ["celebrate7"] = {"anim@arena@celeb@flat@solo@no_props@", "jump_c_player_a", "Celebrate 7", "celebrate7_remote", animationOptions = {
        emoteMoving = false,
        emoteDuration = 30000,
        syncOffsetFront = 3.45
    }},
    ["celebrate7_remote"] = {"anim@arena@celeb@flat@solo@no_props@", "jump_c_player_a", "Celebrate 7", "celebrate7", animationOptions = {
        invisible = true,
        emoteMoving = false,
        emoteDuration = 30000,
        syncOffsetFront = 0.0
    }},
    ["brohug"] = {"anim@mp_player_intcelebrationpaired@f_f_bro_hug", "bro_hug_left", "Bro Hug", "brohug_remote", animationOptions = {
        emoteMoving = false,
        emoteDuration = 30000,
        syncOffsetFront = 0.6
    }},
    ["brohug_remote"] = {"anim@mp_player_intcelebrationpaired@f_f_bro_hug", "bro_hug_right", "Bro Hug", "brohug", animationOptions = {
        invisible = true,
        emoteMoving = false,
        emoteDuration = 30000,
        syncOffsetFront = 0.2
    }},
    ["cowering"] = {"anim@mp_player_intcelebrationpaired@f_f_cowering", "cowering_left", "Cowering", "cowering_remote", animationOptions = {
        emoteMoving = false,
        emoteDuration = 30000,
        syncOffsetFront = 1.15
    }},
    ["cowering_remote"] = {"anim@mp_player_intcelebrationpaired@f_f_cowering", "cowering_right", "Cowering", "cowering", animationOptions = {
        invisible = true,
        emoteMoving = false,
        emoteDuration = 30000,
        syncOffsetFront = 0.0
    }}
}

cfg.dances = {
    ["dancef"] = {"anim@amb@nightclub@dancers@solomun_entourage@", "mi_dance_facedj_17_v1_female^1", "Dance F", animationOptions =
    {
        emoteLoop = true,
    }},
    ["dancef2"] = {"anim@amb@nightclub@mini@dance@dance_solo@female@var_a@", "high_center", "Dance F2", animationOptions =
    {
        emoteLoop = true,
    }},
    ["dancef3"] = {"anim@amb@nightclub@mini@dance@dance_solo@female@var_a@", "high_center_up", "Dance F3", animationOptions =
    {
        emoteLoop = true,
    }},
    ["dancef4"] = {"anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", "hi_dance_facedj_09_v2_female^1", "Dance F4", animationOptions =
    {
        emoteLoop = true,
    }},
    ["dancef5"] = {"anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", "hi_dance_facedj_09_v2_female^3", "Dance F5", animationOptions =
    {
        emoteLoop = true,
    }},
    ["dancef6"] = {"anim@amb@nightclub@mini@dance@dance_solo@female@var_a@", "high_center_up", "Dance F6", animationOptions =
    {
        emoteLoop = true,
    }},
    ["danceslow2"] = {"anim@amb@nightclub@mini@dance@dance_solo@female@var_a@", "low_center", "Dance Slow 2", animationOptions =
    {
        emoteLoop = true,
    }},
    ["danceslow3"] = {"anim@amb@nightclub@mini@dance@dance_solo@female@var_a@", "low_center_down", "Dance Slow 3", animationOptions =
    {
        emoteLoop = true,
    }},
    ["danceslow4"] = {"anim@amb@nightclub@mini@dance@dance_solo@female@var_b@", "low_center", "Dance Slow 4", animationOptions =
    {
        emoteLoop = true,
    }},
    ["dance"] = {"anim@amb@nightclub@dancers@podium_dancers@", "hi_dance_facedj_17_v2_male^5", "Dance", animationOptions =
    {
        emoteLoop = true,
    }},
    ["dance2"] = {"anim@amb@nightclub@mini@dance@dance_solo@male@var_b@", "high_center_down", "Dance 2", animationOptions =
    {
        emoteLoop = true,
    }},
    ["dance3"] = {"anim@amb@nightclub@mini@dance@dance_solo@male@var_a@", "high_center", "Dance 3", animationOptions =
    {
        emoteLoop = true,
    }},
    ["dance4"] = {"anim@amb@nightclub@mini@dance@dance_solo@male@var_b@", "high_center_up", "Dance 4", animationOptions =
    {
        emoteLoop = true,
    }},
    ["danceupper"] = {"anim@amb@nightclub@mini@dance@dance_solo@female@var_b@", "high_center", "Dance Upper", animationOptions =
    {
        emoteLoop = true,
        emoteMoving = true,
    }},
    ["danceupper2"] = {"anim@amb@nightclub@mini@dance@dance_solo@female@var_b@", "high_center_up", "Dance Upper 2", animationOptions =
    {
        emoteLoop = true,
        emoteMoving = true,
    }},
    ["danceshy"] = {"anim@amb@nightclub@mini@dance@dance_solo@male@var_a@", "low_center", "Dance Shy", animationOptions =
    {
        emoteLoop = true,
    }},
    ["danceshy2"] = {"anim@amb@nightclub@mini@dance@dance_solo@female@var_b@", "low_center_down", "Dance Shy 2", animationOptions =
    {
        emoteLoop = true,
    }},
    ["danceslow"] = {"anim@amb@nightclub@mini@dance@dance_solo@male@var_b@", "low_center", "Dance Slow", animationOptions =
    {
        emoteLoop = true,
    }},
    ["dancesilly9"] = {"rcmnigel1bnmt_1b", "dance_loop_tyler", "Dance Silly 9", animationOptions =
    {
        emoteLoop = true,
    }},
    ["dance6"] = {"misschinese2_crystalmazemcs1_cs", "dance_loop_tao", "Dance 6", animationOptions =
    {
        emoteLoop = true,
    }},
    ["dance7"] = {"misschinese2_crystalmazemcs1_ig", "dance_loop_tao", "Dance 7", animationOptions =
    {
        emoteLoop = true,
    }},
    ["dance8"] = {"missfbi3_sniping", "dance_m_default", "Dance 8", animationOptions =
    {
        emoteLoop = true,
    }},
    ["dancesilly"] = {"special_ped@mountain_dancer@monologue_3@monologue_3a", "mnt_dnc_buttwag", "Dance Silly", animationOptions =
    {
        emoteLoop = true,
    }},
    ["dancesilly2"] = {"move_clown@p_m_zero_idles@", "fidget_short_dance", "Dance Silly 2", animationOptions =
    {
        emoteLoop = true,
    }},
    ["dancesilly3"] = {"move_clown@p_m_two_idles@", "fidget_short_dance", "Dance Silly 3", animationOptions =
    {
        emoteLoop = true,
    }},
    ["dancesilly4"] = {"anim@amb@nightclub@lazlow@hi_podium@", "danceidle_hi_11_buttwiggle_b_laz", "Dance Silly 4", animationOptions =
    {
        emoteLoop = true,
    }},
    ["dancesilly5"] = {"timetable@tracy@ig_5@idle_a", "idle_a", "Dance Silly 5", animationOptions =
    {
        emoteLoop = true,
    }},
    ["dancesilly6"] = {"timetable@tracy@ig_8@idle_b", "idle_d", "Dance Silly 6", animationOptions =
    {
        emoteLoop = true,
    }},
    ["dance9"] = {"anim@amb@nightclub@mini@dance@dance_solo@female@var_a@", "med_center_up", "Dance 9", animationOptions =
    {
        emoteLoop = true,
    }},
    ["dancesilly8"] = {"anim@mp_player_intcelebrationfemale@the_woogie", "the_woogie", "Dance Silly 8", animationOptions =
    {
        emoteLoop = true
    }},
    ["dancesilly7"] = {"anim@amb@casino@mini@dance@dance_solo@female@var_b@", "high_center", "Dance Silly 7", animationOptions =
    {
        emoteLoop = true
    }},
    ["dance5"] = {"anim@amb@casino@mini@dance@dance_solo@female@var_a@", "med_center", "Dance 5", animationOptions =
    {
        emoteLoop = true
    }},
    ["danceglowstick"] = {"anim@amb@nightclub@lazlow@hi_railing@", "ambclub_13_mi_hi_sexualgriding_laz", "Dance Glowsticks", animationOptions =
    {
        prop = "ba_prop_battle_glowstick_01",
        propBone = 28422,
        propPlacement = {0.0700,0.1400,0.0,-80.0,20.0},
        secondProp = "ba_prop_battle_glowstick_01",
        secondPropBone = 60309,
        secondPropPlacement = {0.0700,0.0900,0.0,-120.0,-20.0},
        emoteLoop = true,
        emoteMoving = true,
    }},
    ["danceglowstick2"] = {"anim@amb@nightclub@lazlow@hi_railing@", "ambclub_12_mi_hi_bootyshake_laz", "Dance Glowsticks 2", animationOptions =
    {
        prop = "ba_prop_battle_glowstick_01",
        propBone = 28422,
        propPlacement = {0.0700,0.1400,0.0,-80.0,20.0},
        secondProp = "ba_prop_battle_glowstick_01",
        secondPropBone = 60309,
        secondPropPlacement = {0.0700,0.0900,0.0,-120.0,-20.0},
        emoteLoop = true,
    }},
    ["danceglowstick3"] = {"anim@amb@nightclub@lazlow@hi_railing@", "ambclub_09_mi_hi_bellydancer_laz", "Dance Glowsticks 3", animationOptions =
    {
        prop = "ba_prop_battle_glowstick_01",
        propBone = 28422,
        propPlacement = {0.0700,0.1400,0.0,-80.0,20.0},
        secondProp = "ba_prop_battle_glowstick_01",
        secondPropBone = 60309,
        secondPropPlacement = {0.0700,0.0900,0.0,-120.0,-20.0},
        emoteLoop = true,
    }},
    ["dancehorse"] = {"anim@amb@nightclub@lazlow@hi_dancefloor@", "dancecrowd_li_15_handup_laz", "Dance Horse", animationOptions =
    {
        prop = "ba_prop_battle_hobby_horse",
        propBone = 28422,
        propPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
        emoteLoop = true,
        emoteMoving = true,
    }},
    ["dancehorse2"] = {"anim@amb@nightclub@lazlow@hi_dancefloor@", "crowddance_hi_11_handup_laz", "Dance Horse 2", animationOptions =
    {
        prop = "ba_prop_battle_hobby_horse",
        propBone = 28422,
        propPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
        emoteLoop = true,
    }},
    ["dancehorse3"] = {"anim@amb@nightclub@lazlow@hi_dancefloor@", "dancecrowd_li_11_hu_shimmy_laz", "Dance Horse 3", animationOptions =
    {
        prop = "ba_prop_battle_hobby_horse",
        propBone = 28422,
        propPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
        emoteLoop = true,
    }},
    ["dj2"] = {"anim@amb@nightclub@djs@solomun@", "sol_idle_ctr_mid_a_sol", "DJ 2", animationOptions =
    {
        emoteLoop = true,
        emoteMoving = false,
    }},
    ["dj3"] = {"anim@amb@nightclub@djs@solomun@", "sol_dance_l_sol", "DJ 3", animationOptions =
    {
        emoteLoop = true,
        emoteMoving = false,
    }},
    ["dj4"] = {"anim@amb@nightclub@djs@black_madonna@", "dance_b_idle_a_blamadon", "DJ 4", animationOptions =
    {
        emoteLoop = true,
        emoteMoving = false,
    }},
    ["dj5"] = {"anim@amb@nightclub@djs@dixon@", "dixn_end_dix", "DJ 5", animationOptions =
    {
        emoteLoop = true,
        emoteMoving = false,
    }},
    ["dj6"] = {"anim@amb@nightclub@djs@dixon@", "dixn_idle_cntr_a_dix", "DJ 6", animationOptions =
    {
        emoteLoop = true,
        emoteMoving = false,
    }},
    ["dj7"] = {"anim@amb@nightclub@djs@dixon@", "dixn_idle_cntr_b_dix", "DJ 7", animationOptions =
    {
        emoteLoop = true,
        emoteMoving = false,
    }},
    ["dj8"] = {"anim@amb@nightclub@djs@dixon@", "dixn_idle_cntr_g_dix", "DJ 8", animationOptions =
    {
        emoteLoop = true,
        emoteMoving = false,
    }},
    ["dj9"] = {"anim@amb@nightclub@djs@dixon@", "dixn_idle_cntr_gb_dix", "DJ 9", animationOptions =
    {
        emoteLoop = true,
        emoteMoving = false,
    }},
    ["dj10"] = {"anim@amb@nightclub@djs@dixon@", "dixn_sync_cntr_j_dix", "DJ 10", animationOptions =
    {
        emoteLoop = true,
        emoteMoving = false,
    }},
}

cfg.emotes = {
    ["drink"] = {"mp_player_inteat@pnq", "loop", "Drink", animationOptions =
    {
        emoteMoving = true,
        emoteDuration = 2500,
        allowedPrison = true,
    }},
    ["beast"] = {"anim@mp_fm_event@intro", "beast_transform", "Beast", animationOptions =
    {
        emoteMoving = true,
        emoteDuration = 5000,
        allowedPrison = true,
    }},
    -- ["chill"] = {"switch@trevor@scares_tramp", "trev_scares_tramp_idle_tramp", "Chill", animationOptions =
    -- {
        -- emoteLoop = true,
    -- }},
    -- ["cloudgaze"] = {"switch@trevor@annoys_sunbathers", "trev_annoys_sunbathers_loop_girl", "Cloudgaze", animationOptions =
    -- {
        -- emoteLoop = true,
    -- }},
    -- ["cloudgaze2"] = {"switch@trevor@annoys_sunbathers", "trev_annoys_sunbathers_loop_guy", "Cloudgaze 2", animationOptions =
    -- {
        -- emoteLoop = true,
    -- }},
    --    ["prone"] = {"missfbi3_sniping", "prone_dave", "Prone", animationOptions =
    --    {
    --        emoteLoop = true,
    --    }},
    ["pullover"] = {"misscarsteal3pullover", "pull_over_right", "Pullover", animationOptions =
    {
        emoteMoving = true,
        emoteDuration = 1300,
        allowedPrison = true,
    }},
    ["idle"] = {"anim@heists@heist_corona@team_idles@male_a", "idle", "Idle", animationOptions =
    {
        emoteLoop = true,
        allowedPrison = true,
    }},
    ["idle8"] = {"amb@world_human_hang_out_street@male_b@idle_a", "idle_b", "Idle 8"},
    ["idle9"] = {"friends@fra@ig_1", "base_idle", "Idle 9", animationOptions =
    {
        emoteLoop = true,
        allowedPrison = true,
    }},
    ["idle10"] = {"mp_move@prostitute@m@french", "idle", "Idle 10", animationOptions =
    {
        emoteLoop = true,
        emoteMoving = true,
        allowedPrison = true,
    }},
    ["idle11"] = {"random@countrysiderobbery", "idle_a", "Idle 11", animationOptions =
    {
        emoteLoop = true,
        allowedPrison = true,
    }},
    ["idle2"] = {"anim@heists@heist_corona@team_idles@female_a", "idle", "Idle 2", animationOptions =
    {
        emoteLoop = true,
        allowedPrison = true,
    }},
    ["idle3"] = {"anim@heists@humane_labs@finale@strip_club", "ped_b_celebrate_loop", "Idle 3", animationOptions =
    {
        emoteLoop = true,
        allowedPrison = true,
    }},
    ["idle4"] = {"anim@mp_celebration@idles@female", "celebration_idle_f_a", "Idle 4", animationOptions =
    {
        emoteLoop = true,
        allowedPrison = true,
    }},
    ["idle5"] = {"anim@mp_corona_idles@female_b@idle_a", "idle_a", "Idle 5", animationOptions =
    {
        emoteLoop = true,
        allowedPrison = true,
    }},
    ["idle6"] = {"anim@mp_corona_idles@male_c@idle_a", "idle_a", "Idle 6", animationOptions =
    {
        emoteLoop = true,
        allowedPrison = true,
    }},
    ["idle7"] = {"anim@mp_corona_idles@male_d@idle_a", "idle_a", "Idle 7", animationOptions =
    {
        emoteLoop = true,
        allowedPrison = true,
    }},
    ["wait3"] = {"amb@world_human_hang_out_street@female_hold_arm@idle_a", "idle_a", "Wait 3", animationOptions =
    {
        emoteLoop = true,
        allowedPrison = true,
    }},
    ["idledrunk"] = {"random@drunk_driver_1", "drunk_driver_stand_loop_dd1", "Idle Drunk", animationOptions =
    {
        emoteLoop = true,
        allowedPrison = true,
    }},
    ["idledrunk2"] = {"random@drunk_driver_1", "drunk_driver_stand_loop_dd2", "Idle Drunk 2", animationOptions =
    {
        emoteLoop = true,
        allowedPrison = true,
    }},
    ["idledrunk3"] = {"missarmenian2", "standing_idle_loop_drunk", "Idle Drunk 3", animationOptions =
    {
        emoteLoop = true,
        allowedPrison = true,
    }},
    ["airguitar"] = {"anim@mp_player_intcelebrationfemale@air_guitar", "air_guitar", "Air Guitar"},
    ["airsynth"] = {"anim@mp_player_intcelebrationfemale@air_synth", "air_synth", "Air Synth"},
    ["argue"] = {"misscarsteal4@actor", "actor_berating_loop", "Argue", animationOptions =
    {
        emoteLoop = true,
        emoteMoving = true,
        allowedPrison = true,
    }},
    ["argue2"] = {"oddjobs@assassinate@vice@hooker", "argue_a", "Argue 2", animationOptions =
    {
        emoteLoop = true,
        emoteMoving = true,
        allowedPrison = true,
    }},
    ["bartender"] = {"anim@amb@clubhouse@bar@drink@idle_a", "idle_a_bartender", "Bartender", animationOptions =
    {
        emoteLoop = true,
        emoteMoving = true,
        allowedPrison = true,
    }},
    ["blowkiss"] = {"anim@mp_player_intcelebrationfemale@blow_kiss", "blow_kiss", "Blow Kiss"},
    ["blowkiss2"] = {"anim@mp_player_intselfieblow_kiss", "exit", "Blow Kiss 2", animationOptions =
    {
        emoteMoving = true,
        emoteDuration = 2000,
        allowedPrison = true,

    }},
    ["curtsy"] = {"anim@mp_player_intcelebrationpaired@f_f_sarcastic", "sarcastic_left", "Curtsy"},
    ["bringiton"] = {"misscommon@response", "bring_it_on", "Bring It On", animationOptions =
    {
        emoteMoving = true,
        emoteDuration = 3000,
        allowedPrison = true,
    }},
    ["comeatmebro"] = {"mini@triathlon", "want_some_of_this", "Come at me bro", animationOptions =
    {
        emoteMoving = true,
        emoteDuration = 2000,
        allowedPrison = true,
    }},
    ["cop2"] = {"anim@amb@nightclub@peds@", "rcmme_amanda1_stand_loop_cop", "Cop 2", animationOptions =
    {
        emoteLoop = true,
        allowedPrison = true,
    }},
    ["cop3"] = {"amb@code_human_police_investigate@idle_a", "idle_b", "Cop 3", animationOptions =
    {
        emoteLoop = true,
        allowedPrison = true,
    }},
    ["crossarms"] = {"amb@world_human_hang_out_street@female_arms_crossed@idle_a", "idle_a", "Crossarms", animationOptions =
    {
        emoteLoop = true,
        emoteMoving = true,
        allowedPrison = true,
    }},
    ["crossarms2"] = {"amb@world_human_hang_out_street@male_c@idle_a", "idle_b", "Crossarms 2", animationOptions =
    {
        emoteMoving = true,
        allowedPrison = true,
    }},
    ["crossarms3"] = {"anim@heists@heist_corona@single_team", "single_team_loop_boss", "Crossarms 3", animationOptions =
    {
        emoteLoop = true,
        emoteMoving = true,
        allowedPrison = true,
    }},
    ["crossarms4"] = {"random@street_race", "_car_b_lookout", "Crossarms 4", animationOptions =
    {
        emoteLoop = true,
        emoteMoving = true,
        allowedPrison = true,
    }},
    ["crossarms5"] = {"anim@amb@nightclub@peds@", "rcmme_amanda1_stand_loop_cop", "Crossarms 5", animationOptions =
    {
        emoteLoop = true,
        emoteMoving = true,
        allowedPrison = true,
    }},
    ["foldarms2"] = {"anim@amb@nightclub@peds@", "rcmme_amanda1_stand_loop_cop", "Fold Arms 2", animationOptions =
    {
        emoteLoop = true,
        emoteMoving = true,
        allowedPrison = true,
    }},
    ["crossarms6"] = {"random@shop_gunstore", "_idle", "Crossarms 6", animationOptions =
    {
        emoteLoop = true,
        emoteMoving = true,
        allowedPrison = true,
    }},
    ["foldarms"] = {"anim@amb@business@bgen@bgen_no_work@", "stand_phone_phoneputdown_idle_nowork", "Fold Arms", animationOptions =
    {
        emoteLoop = true,
        emoteMoving = true,
        allowedPrison = true,
    }},
    ["crossarmsside"] = {"rcmnigel1a_band_groupies", "base_m2", "Crossarms Side", animationOptions =
    {
        emoteLoop = true,
        emoteMoving = true,
        allowedPrison = true,
    }},
    ["damn"] = {"gestures@m@standing@casual", "gesture_damn", "Damn", animationOptions =
    {
        emoteMoving = true,
        emoteDuration = 1000,
        allowedPrison = true,
    }},
    ["damn2"] = {"anim@am_hold_up@male", "shoplift_mid", "Damn 2", animationOptions =
    {
        emoteMoving = true,
        emoteDuration = 1000,
        allowedPrison = true,
    }},
    ["pointdown"] = {"gestures@f@standing@casual", "gesture_hand_down", "Point Down", animationOptions =
    {
        emoteMoving = true,
        emoteDuration = 1000,
        allowedPrison = true,
    }},
    -- ["surrender"] = {"random@arrests@busted", "idle_a", "Surrender", animationOptions =
    -- {
        -- emoteLoop = true,
    -- }},
    ["facepalm2"] = {"anim@mp_player_intcelebrationfemale@face_palm", "face_palm", "Facepalm 2", animationOptions =
    {
        emoteMoving = true,
        emoteDuration = 8000,
        allowedPrison = true,
    }},
    ["facepalm"] = {"random@car_thief@agitated@idle_a", "agitated_idle_a", "Facepalm", animationOptions =
    {
        emoteMoving = true,
        emoteDuration = 8000,
        allowedPrison = true,
    }},
    ["facepalm3"] = {"missminuteman_1ig_2", "tasered_2", "Facepalm 3", animationOptions =
    {
        emoteMoving = true,
        emoteDuration = 8000,
        allowedPrison = true,
    }},
    ["facepalm4"] = {"anim@mp_player_intupperface_palm", "idle_a", "Facepalm 4", animationOptions =
    {
        emoteMoving = true,
        emoteLoop = true,
        allowedPrison = true,
    }},
    -- ["fallover"] = {"random@drunk_driver_1", "drunk_fall_over", "Fall Over"},
    -- ["fallover2"] = {"mp_suicide", "pistol", "Fall Over 2"},
    -- ["fallover3"] = {"mp_suicide", "pill", "Fall Over 3"},
    -- ["fallover4"] = {"friends@frf@ig_2", "knockout_plyr", "Fall Over 4"},
    -- ["fallover5"] = {"anim@gangops@hostage@", "victim_fail", "Fall Over 5"},
    ["fallasleep"] = {"mp_sleep", "sleep_loop", "Fall Asleep", animationOptions =
    {
        emoteMoving = true,
        emoteLoop = true,
        allowedPrison = true,
    }},
    ["fightme"] = {"anim@deathmatch_intros@unarmed", "intro_male_unarmed_c", "Fight Me"},
    ["fightme2"] = {"anim@deathmatch_intros@unarmed", "intro_male_unarmed_e", "Fight Me 2"},
    ["finger"] = {"anim@mp_player_intselfiethe_bird", "idle_a", "Finger", animationOptions =
    {
        emoteLoop = true,
        emoteMoving = true,
        allowedPrison = true,
    }},
    ["finger2"] = {"anim@mp_player_intupperfinger", "idle_a_fp", "Finger 2", animationOptions =
    {
        emoteLoop = true,
        emoteMoving = true,
        allowedPrison = true,
    }},
    ["handshake"] = {"mp_ped_interaction", "handshake_guy_a", "Handshake", animationOptions =
    {
        emoteMoving = true,
        emoteDuration = 3000,
        allowedPrison = true,
    }},
    ["handshake2"] = {"mp_ped_interaction", "handshake_guy_b", "Handshake 2", animationOptions =
    {
        emoteMoving = true,
        emoteDuration = 3000,
        allowedPrison = true,
    }},
    ["wait4"] = {"amb@world_human_hang_out_street@Female_arm_side@idle_a", "idle_a", "Wait 4", animationOptions =
    {
        emoteLoop = true,
        allowedPrison = true,
    }},
    ["wait5"] = {"missclothing", "idle_storeclerk", "Wait 5", animationOptions =
    {
        emoteLoop = true,
        emoteMoving = true,
        allowedPrison = true,
    }},
    ["wait6"] = {"timetable@amanda@ig_2", "ig_2_base_amanda", "Wait 6", animationOptions =
    {
        emoteLoop = true,
        emoteMoving = true,
        allowedPrison = true,
    }},
    ["wait7"] = {"rcmnigel1cnmt_1c", "base", "Wait 7", animationOptions =
    {
        emoteLoop = true,
        emoteMoving = true,
        allowedPrison = true,
    }},
    ["wait8"] = {"rcmjosh1", "idle", "Wait 8", animationOptions =
    {
        emoteLoop = true,
        emoteMoving = true,
        allowedPrison = true,
    }},
    ["wait9"] = {"rcmjosh2", "josh_2_intp1_base", "Wait 9", animationOptions =
    {
        emoteLoop = true,
        emoteMoving = true,
        allowedPrison = true,
    }},
    ["wait10"] = {"timetable@amanda@ig_3", "ig_3_base_tracy", "Wait 10", animationOptions =
    {
        emoteLoop = true,
        emoteMoving = true,
        allowedPrison = true,
    }},
    ["wait11"] = {"misshair_shop@hair_dressers", "keeper_base", "Wait 11", animationOptions =
    {
        emoteLoop = true,
        emoteMoving = true,
        allowedPrison = true,
    }},
    ["hiking"] = {"move_m@hiking", "idle", "Hiking", animationOptions =
    {
        emoteLoop = true,
        emoteMoving = true,
        allowedPrison = true,
    }},

    ["hug"] = {"mp_ped_interaction", "kisses_guy_a", "Hug", animationOptions =
    {
        allowedPrison = true,
    }},
    ["hug2"] = {"mp_ped_interaction", "kisses_guy_b", "Hug 2", animationOptions =
    {
        allowedPrison = true,
    }},
    ["hug3"] = {"mp_ped_interaction", "hugs_guy_a", "Hug 3", animationOptions =
    {
        allowedPrison = true,
    }},
    ["inspect"] = {"random@train_tracks", "idle_e", "Inspect"},
    ["jazzhands"] = {"anim@mp_player_intcelebrationfemale@jazz_hands", "jazz_hands", "Jazzhands", animationOptions =
    {
        emoteMoving = true,
        emoteDuration = 6000,
        allowedPrison = true,
    }},
    ["jog2"] = {"amb@world_human_jog_standing@male@idle_a", "idle_a", "Jog 2", animationOptions =
    {
        emoteLoop = true,
        emoteMoving = true,
        allowedPrison = true,
    }},
    ["jog3"] = {"amb@world_human_jog_standing@female@idle_a", "idle_a", "Jog 3", animationOptions =
    {
        emoteLoop = true,
        emoteMoving = true,
        allowedPrison = true,
    }},
    ["jog4"] = {"amb@world_human_power_walker@female@idle_a", "idle_a", "Jog 4", animationOptions =
    {
        emoteLoop = true,
        emoteMoving = true,
        allowedPrison = true,
    }},
    ["jog5"] = {"move_m@joy@a", "walk", "Jog 5", animationOptions =
    {
        emoteLoop = true,
        emoteMoving = true,
        allowedPrison = true,
    }},
    ["jumpingjacks"] = {"timetable@reunited@ig_2", "jimmy_getknocked", "Jumping Jacks", animationOptions =
    {
        emoteLoop = true,
        allowedPrison = true,
    }},
    -- ["kneel2"] = {"rcmextreme3", "idle", "Kneel 2", animationOptions =
    -- {
        -- emoteLoop = true,
    -- }},
    -- ["kneel3"] = {"amb@world_human_bum_wash@male@low@idle_a", "idle_a", "Kneel 3", animationOptions =
    -- {
        -- emoteLoop = true,
    -- }},
    ["knock"] = {"timetable@jimmy@doorknock@", "knockdoor_idle", "Knock", animationOptions =
    {
        emoteMoving = true,
        emoteLoop = true,
        allowedPrison = true,
    }},
    ["knock2"] = {"missheistfbi3b_ig7", "lift_fibagent_loop", "Knock 2", animationOptions =
    {
        emoteLoop = true,
        allowedPrison = true,
    }},
    ["knucklecrunch"] = {"anim@mp_player_intcelebrationfemale@knuckle_crunch", "knuckle_crunch", "Knuckle Crunch", animationOptions =
    {
        emoteLoop = true,
        emoteMoving = true,
        allowedPrison = true,
    }},
    ["lapdance"] = {"mp_safehouse", "lap_dance_girl", "Lapdance"},
    ["lean2"] = {"amb@world_human_leaning@female@wall@back@hand_up@idle_a", "idle_a", "Lean 2", animationOptions =
    {
        emoteLoop = true,
        allowedPrison = true,
    }},
    ["lean3"] = {"amb@world_human_leaning@female@wall@back@holding_elbow@idle_a", "idle_a", "Lean 3", animationOptions =
    {
        emoteLoop = true,
        allowedPrison = true,
    }},
    ["lean4"] = {"amb@world_human_leaning@male@wall@back@foot_up@idle_a", "idle_a", "Lean 4", animationOptions =
    {
        emoteLoop = true,
        allowedPrison = true,
    }},
    ["lean5"] = {"amb@world_human_leaning@male@wall@back@hands_together@idle_b", "idle_b", "Lean 5", animationOptions =
    {
        emoteLoop = true,
        allowedPrison = true,
    }},
    --    ["leanflirt"] = {"random@street_race", "_car_a_flirt_girl", "Lean Flirt", animationOptions =
    --    {
    --        emoteLoop = true,
    --    }},
    ["leanbar2"] = {"amb@prop_human_bum_shopping_cart@male@idle_a", "idle_c", "Lean Bar 2", animationOptions =
    {
        emoteLoop = true,
        allowedPrison = true,
    }},
    ["leanbar3"] = {"anim@amb@nightclub@lazlow@ig1_vip@", "clubvip_base_laz", "Lean Bar 3", animationOptions =
    {
        emoteLoop = true,
        allowedPrison = true,
    }},
    ["leanbar4"] = {"anim@heists@prison_heist", "ped_b_loop_a", "Lean Bar 4", animationOptions =
    {
        emoteLoop = true,
        allowedPrison = true,
    }},
    ["leanhigh"] = {"anim@mp_ferris_wheel", "idle_a_player_one", "Lean High", animationOptions =
    {
        emoteLoop = true,
        emoteMoving = true,
        allowedPrison = true,
    }},
    ["leanhigh2"] = {"anim@mp_ferris_wheel", "idle_a_player_two", "Lean High 2", animationOptions =
    {
        emoteLoop = true,
        emoteMoving = true,
        allowedPrison = true,
    }},
    ["leanside"] = {"timetable@mime@01_gc", "idle_a", "Leanside", animationOptions =
    {
        emoteLoop = true,
        emoteMoving = true,
        allowedPrison = true,
    }},
    ["leanside2"] = {"misscarstealfinale", "packer_idle_1_trevor", "Leanside 2", animationOptions =
    {
        emoteLoop = true,
        emoteMoving = true,
        allowedPrison = true,
    }},
    ["leanside3"] = {"misscarstealfinalecar_5_ig_1", "waitloop_lamar", "Leanside 3", animationOptions =
    {
        emoteLoop = true,
        emoteMoving = true,
        allowedPrison = true,
    }},
    ["leanside4"] = {"misscarstealfinalecar_5_ig_1", "waitloop_lamar", "Leanside 4", animationOptions =
    {
        emoteLoop = true,
        emoteMoving = false,
        allowedPrison = true,
    }},
    ["leanside5"] = {"rcmjosh2", "josh_2_intp1_base", "Leanside 5", animationOptions =
    {
        emoteLoop = true,
        emoteMoving = false,
        allowedPrison = true,
    }},
    ["me"] = {"gestures@f@standing@casual", "gesture_me_hard", "Me", animationOptions =
    {
        emoteMoving = true,
        emoteDuration = 1000,
        allowedPrison = true,
    }},
    -- ["mechanic"] = {"mini@repair", "fixing_a_ped", "Mechanic", animationOptions =
    -- {
        -- emoteLoop = true,
        -- emoteMoving = true,
    -- }},
    -- ["mechanic2"] = {"amb@world_human_vehicle_mechanic@male@base", "idle_a", "Mechanic 2", animationOptions =
    -- {
        -- emoteLoop = true,
    -- }},
    -- ["mechanic3"] = {"anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer", "Mechanic 3", animationOptions =
    -- {
        -- emoteLoop = true,
    -- }},
    -- ["mechanic4"] = {"anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer", "Mechanic 4", animationOptions =
    -- {
        -- emoteLoop = true,
        -- emoteMoving = true,
    -- }},
    ["medic2"] = {"amb@medic@standing@tendtodead@base", "base", "Medic 2", animationOptions =
    {
        emoteLoop = true,
        allowedPrison = true,
    }},
    -- ["meditate"] = {"rcmcollect_paperleadinout@", "meditiate_idle", "Meditiate", animationOptions = -- CHANGE ME
    -- {
        -- emoteLoop = true,
    -- }},
    -- ["meditate2"] = {"rcmepsilonism3", "ep_3_rcm_marnie_meditating", "Meditiate 2", animationOptions = -- CHANGE ME
    -- {
        -- emoteLoop = true,
    -- }},
    -- ["meditate3"] = {"rcmepsilonism3", "base_loop", "Meditiate 3", animationOptions = -- CHANGE ME
    -- {
        -- emoteLoop = true,
    -- }},
    ["metal"] = {"anim@mp_player_intincarrockstd@ps@", "idle_a", "Metal", animationOptions = -- CHANGE ME
    {
        emoteLoop = true,
        emoteMoving = true,
        allowedPrison = true,
    }},
    ["no"] = {"anim@heists@ornate_bank@chat_manager", "fail", "No", animationOptions =
    {
        emoteLoop = true,
        emoteMoving = true,
        allowedPrison = true,
    }},
    ["no2"] = {"mp_player_int_upper_nod", "mp_player_int_nod_no", "No 2", animationOptions =
    {
        emoteLoop = true,
        emoteMoving = true,
        allowedPrison = true,
    }},
    ["nosepick"] = {"anim@mp_player_intcelebrationfemale@nose_pick", "nose_pick", "Nose Pick", animationOptions =
    {
        emoteLoop = true,
        emoteMoving = true,
        allowedPrison = true,
    }},
    ["noway"] = {"gestures@m@standing@casual", "gesture_no_way", "No Way", animationOptions =
    {
        emoteDuration = 1500,
        emoteMoving = true,
        allowedPrison = true,
    }},
    ["ok"] = {"anim@mp_player_intselfiedock", "idle_a", "OK", animationOptions =
    {
        emoteLoop = true,
        emoteMoving = true,
        allowedPrison = true,
    }},
    ["outofbreath"] = {"re@construction", "out_of_breath", "Out of Breath", animationOptions =
    {
        emoteLoop = true,
        emoteMoving = true,
        allowedPrison = true,
    }},
    ["pickup"] = {"random@domestic", "pickup_low", "Pickup"},
    ["push"] = {"missfinale_c2ig_11", "pushcar_offcliff_f", "Push", animationOptions =
    {
        emoteLoop = true,
    }},
    ["push2"] = {"missfinale_c2ig_11", "pushcar_offcliff_m", "Push 2", animationOptions =
    {
        emoteLoop = true,
    }},
    ["point"] = {"gestures@f@standing@casual", "gesture_point", "Point", animationOptions =
    {
        emoteLoop = true,
        emoteMoving = true,
        allowedPrison = true,
    }},
    -- ["pushup"] = {"amb@world_human_push_ups@male@idle_a", "idle_d", "Pushup", animationOptions =
    -- {
        -- emoteLoop = true,
    -- }},
    ["countdown"] = {"random@street_race", "grid_girl_race_start", "Countdown", animationOptions =
    {
        emoteLoop = true,
        emoteMoving = true,
        allowedPrison = true,
    }},
    ["pointright"] = {"mp_gun_shop_tut", "indicate_right", "Point Right", animationOptions =
    {
        emoteLoop = true,
        emoteMoving = true,
        allowedPrison = true,
    }},
    ["salute"] = {"anim@mp_player_intincarsalutestd@ds@", "idle_a", "Salute", animationOptions =
    {
        emoteLoop = true,
        emoteMoving = true,
        allowedPrison = true,
    }},
    ["salute2"] = {"anim@mp_player_intincarsalutestd@ps@", "idle_a", "Salute 2", animationOptions =
    {
        emoteLoop = true,
        emoteMoving = true,
        allowedPrison = true,
    }},
    ["salute3"] = {"anim@mp_player_intuppersalute", "idle_a", "Salute 3", animationOptions =
    {
        emoteLoop = true,
        emoteMoving = true,
        allowedPrison = true,
    }},
    ["scared"] = {"random@domestic", "f_distressed_loop", "Scared", animationOptions =
    {
        emoteLoop = true,
        emoteMoving = true,
        allowedPrison = true,
    }},
    ["scared2"] = {"random@homelandsecurity", "knees_loop_girl", "Scared 2", animationOptions =
    {
        emoteLoop = true,
        emoteMoving = true,
        allowedPrison = true,
    }},
    ["screwyou"] = {"misscommon@response", "screw_you", "Screw You", animationOptions =
    {
        emoteLoop = true,
        emoteMoving = true,
        allowedPrison = true,
    }},
    ["shakeoff"] = {"move_m@_idles@shake_off", "shakeoff_1", "Shake Off", animationOptions =
    {
        emoteMoving = true,
        emoteDuration = 3500,
        allowedPrison = true,
    }},
    -- ["shot"] = {"random@dealgonewrong", "idle_a", "Shot", animationOptions =
    -- {
        -- emoteLoop = true,
    -- }},
    -- ["sleep"] = {"timetable@tracy@sleep@", "idle_c", "Sleep", animationOptions =
    -- {
        -- emoteLoop = true,
    -- }},
    ["shrug"] = {"gestures@f@standing@casual", "gesture_shrug_hard", "Shrug", animationOptions =
    {
        emoteMoving = true,
        emoteDuration = 1000,
        allowedPrison = true,
    }},
    ["shrug2"] = {"gestures@m@standing@casual", "gesture_shrug_hard", "Shrug 2", animationOptions =
    {
        emoteMoving = true,
        emoteDuration = 1000,
        allowedPrison = true,
    }},
    -- ["sit"] = {"anim@amb@business@bgen@bgen_no_work@", "sit_phone_phoneputdown_idle_nowork", "Sit", animationOptions =
    -- {
        -- emoteLoop = true,
    -- }},
    -- ["sit2"] = {"rcm_barry3", "barry_3_sit_loop", "Sit 2", animationOptions =
    -- {
        -- emoteLoop = true,
    -- }},
    -- ["sit3"] = {"amb@world_human_picnic@male@idle_a", "idle_a", "Sit 3", animationOptions =
    -- {
        -- emoteLoop = true,
    -- }},
    -- ["sit4"] = {"amb@world_human_picnic@female@idle_a", "idle_a", "Sit 4", animationOptions =
    -- {
        -- emoteLoop = true,
    -- }},
    -- ["sit5"] = {"anim@heists@fleeca_bank@ig_7_jetski_owner", "owner_idle", "Sit 5", animationOptions =
    -- {
        -- emoteLoop = true,
    -- }},
    -- ["sit6"] = {"timetable@jimmy@mics3_ig_15@", "idle_a_jimmy", "Sit 6", animationOptions =
    -- {
        -- emoteLoop = true,
    -- }},
    -- ["sit7"] = {"anim@amb@nightclub@lazlow@lo_alone@", "lowalone_base_laz", "Sit 7", animationOptions =
    -- {
        -- emoteLoop = true,
    -- }},
    -- ["sit8"] = {"timetable@jimmy@mics3_ig_15@", "mics3_15_base_jimmy", "Sit 8", animationOptions =
    -- {
        -- emoteLoop = true,
    -- }},
    -- ["sit9"] = {"amb@world_human_stupor@male@idle_a", "idle_a", "Sit 9", animationOptions =
    -- {
        -- emoteLoop = true,
    -- }},
    ["sitlean"] = {"timetable@tracy@ig_14@", "ig_14_base_tracy", "Sit Lean", animationOptions =
    {
        emoteLoop = true,
    }},
    -- ["sitsad"] = {"anim@amb@business@bgen@bgen_no_work@", "sit_phone_phoneputdown_sleeping-noworkfemale", "Sit Sad", animationOptions =
    -- {
        -- emoteLoop = true,
    -- }},
    -- ["sitscared"] = {"anim@heists@ornate_bank@hostages@hit", "hit_loop_ped_b", "Sit Scared", animationOptions =
    -- {
        -- emoteLoop = true,
    -- }},
    -- ["sitscared2"] = {"anim@heists@ornate_bank@hostages@ped_c@", "flinch_loop", "Sit Scared 2", animationOptions =
    -- {
        -- emoteLoop = true,
    -- }},
    -- ["sitscared3"] = {"anim@heists@ornate_bank@hostages@ped_e@", "flinch_loop", "Sit Scared 3", animationOptions =
    -- {
        -- emoteLoop = true,
    -- }},
    -- ["sitdrunk"] = {"timetable@amanda@drunk@base", "base", "Sit Drunk", animationOptions =
    -- {
        -- emoteLoop = true,
    -- }},
    ["sitchair2"] = {"timetable@ron@ig_5_p3", "ig_5_p3_base", "Sit Chair 2", animationOptions =
    {
        emoteLoop = true,
        allowedPrison = true,
    }},
    ["sitchair3"] = {"timetable@reunited@ig_10", "base_amanda", "Sit Chair 3", animationOptions =
    {
        emoteLoop = true,
        allowedPrison = true,
    }},
    ["sitchair4"] = {"timetable@ron@ig_3_couch", "base", "Sit Chair 4", animationOptions =
    {
        emoteLoop = true,
        allowedPrison = true,
    }},
    --    ["sitchair5"] = {"timetable@jimmy@mics3_ig_15@", "mics3_15_base_tracy", "Sit Chair 5", animationOptions =
    --    {
    --        emoteLoop = true,
    --    }},
    ["sitchair6"] = {"timetable@maid@couch@", "base", "Sit Chair 6", animationOptions =
    {
        emoteLoop = true,
    }},
    ["sitchairside"] = {"timetable@ron@ron_ig_2_alt1", "ig_2_alt1_base", "Sit Chair Side", animationOptions =
    {
        emoteLoop = true,
    }},
    -- ["situp"] = {"amb@world_human_sit_ups@male@idle_a", "idle_a", "Sit Up", animationOptions =
    -- {
        -- emoteLoop = true,
    -- }},
    ["clapangry"] = {"anim@arena@celeb@flat@solo@no_props@", "angry_clap_a_player_a", "Clap Angry", animationOptions =
    {
        emoteLoop = true,
        allowedPrison = true,
    }},
    ["slowclap3"] = {"anim@mp_player_intupperslow_clap", "idle_a", "Slow Clap 3", animationOptions =
    {
        emoteLoop = true,
        emoteMoving = true,
        allowedPrison = true,
    }},
    ["clap"] = {"amb@world_human_cheering@male_a", "base", "Clap", animationOptions =
    {
        emoteLoop = true,
        emoteMoving = true,
        allowedPrison = true,
    }},
    ["slowclap"] = {"anim@mp_player_intcelebrationfemale@slow_clap", "slow_clap", "Slow Clap", animationOptions =
    {
        emoteLoop = true,
        emoteMoving = true,
        allowedPrison = true,
    }},
    ["slowclap2"] = {"anim@mp_player_intcelebrationmale@slow_clap", "slow_clap", "Slow Clap 2", animationOptions =
    {
        emoteLoop = true,
        emoteMoving = true,
        allowedPrison = true,
    }},
    ["smell"] = {"move_p_m_two_idles@generic", "fidget_sniff_fingers", "Smell", animationOptions =
    {
        emoteLoop = true,
        emoteMoving = true,
        allowedPrison = true,
    }},
    ["stickup"] = {"random@countryside_gang_fight", "biker_02_stickup_loop", "Stick Up", animationOptions =
    {
        emoteLoop = true,
        emoteMoving = true,
        allowedPrison = true,
    }},
    ["stumble"] = {"misscarsteal4@actor", "stumble", "Stumble", animationOptions =
    {
        emoteLoop = true,
    }},
    ["stunned"] = {"stungun@standing", "damage", "Stunned", animationOptions =
    {
        emoteLoop = true,
    }},
    -- ["sunbathe"] = {"amb@world_human_sunbathe@male@back@base", "base", "Sunbathe", animationOptions =
    -- {
        -- emoteLoop = true,
    -- }},
    -- ["sunbathe2"] = {"amb@world_human_sunbathe@female@back@base", "base", "Sunbathe 2", animationOptions =
    -- {
        -- emoteLoop = true,
    -- }},
    ["t"] = {"missfam5_yoga", "a2_pose", "T", animationOptions =
    {
        emoteLoop = true,
        emoteMoving = true,
        allowedPrison = true,
    }},
    ["t2"] = {"mp_sleep", "bind_pose_180", "T 2", animationOptions =
    {
        emoteLoop = true,
        allowedPrison = true,
    }},
    ["think5"] = {"mp_cp_welcome_tutthink", "b_think", "Think 5", animationOptions =
    {
        emoteMoving = true,
        emoteDuration = 2000,
        allowedPrison = true,
    }},
    ["think"] = {"misscarsteal4@aliens", "rehearsal_base_idle_director", "Think", animationOptions =
    {
        emoteLoop = true,
        emoteMoving = true,
        allowedPrison = true,
    }},
    ["think3"] = {"timetable@tracy@ig_8@base", "base", "Think 3", animationOptions =
    {
        emoteLoop = true,
        emoteMoving = true,
        allowedPrison = true,
    }},

    ["think2"] = {"missheist_jewelleadinout", "jh_int_outro_loop_a", "Think 2", animationOptions =
    {
        emoteLoop = true,
        emoteMoving = true,
        allowedPrison = true,
    }},
    ["thumbsup3"] = {"anim@mp_player_intincarthumbs_uplow@ds@", "enter", "Thumbs Up 3", animationOptions =
    {
        emoteMoving = true,
        emoteDuration = 3000,
        allowedPrison = true,
    }},
    ["thumbsup2"] = {"anim@mp_player_intselfiethumbs_up", "idle_a", "Thumbs Up 2", animationOptions =
    {
        emoteLoop = true,
        emoteMoving = true,
        allowedPrison = true,
    }},
    ["thumbsup"] = {"anim@mp_player_intupperthumbs_up", "idle_a", "Thumbs Up", animationOptions =
    {
        emoteLoop = true,
        emoteMoving = true,
        allowedPrison = true,
    }},
    ["type"] = {"anim@heists@prison_heiststation@cop_reactions", "cop_b_idle", "Type", animationOptions =
    {
        emoteLoop = true,
        emoteMoving = true,
        allowedPrison = true,
    }},
    ["type2"] = {"anim@heists@prison_heistig1_p1_guard_checks_bus", "loop", "Type 2", animationOptions =
    {
        emoteLoop = true,
        emoteMoving = true,
        allowedPrison = true,
    }},
    ["type3"] = {"mp_prison_break", "hack_loop", "Type 3", animationOptions =
    {
        emoteLoop = true,
        emoteMoving = true,
        allowedPrison = true,
    }},
    ["type4"] = {"mp_fbi_heist", "loop", "Type 4", animationOptions =
    {
        emoteLoop = true,
        allowedPrison = true,
    }},
    ["warmth"] = {"amb@world_human_stand_fire@male@idle_a", "idle_a", "Warmth", animationOptions =
    {
        emoteLoop = true,
        emoteMoving = true,
        allowedPrison = true,
    }},
    ["wave4"] = {"random@mugging5", "001445_01_gangintimidation_1_female_idle_b", "Wave 4", animationOptions =
    {
        emoteMoving = true,
        emoteDuration = 3000,
        allowedPrison = true,
    }},
    ["wave2"] = {"anim@mp_player_intcelebrationfemale@wave", "wave", "Wave 2", animationOptions =
    {
        emoteLoop = true,
        emoteMoving = true,
        allowedPrison = true,
    }},
    ["wave3"] = {"friends@fra@ig_1", "over_here_idle_a", "Wave 3", animationOptions =
    {
        emoteLoop = true,
        emoteMoving = true,
        allowedPrison = true,
    }},
    ["wave"] = {"friends@frj@ig_1", "wave_a", "Wave", animationOptions =
    {
        emoteLoop = true,
        emoteMoving = true,
        allowedPrison = true,
    }},
    ["wave5"] = {"friends@frj@ig_1", "wave_b", "Wave 5", animationOptions =
    {
        emoteLoop = true,
        emoteMoving = true,
        allowedPrison = true,
    }},
    ["wave6"] = {"friends@frj@ig_1", "wave_c", "Wave 6", animationOptions =
    {
        emoteLoop = true,
        emoteMoving = true,
        allowedPrison = true,
    }},
    ["wave7"] = {"friends@frj@ig_1", "wave_d", "Wave 7", animationOptions =
    {
        emoteLoop = true,
        emoteMoving = true,
        allowedPrison = true,
    }},
    ["wave8"] = {"friends@frj@ig_1", "wave_e", "Wave 8", animationOptions =
    {
        emoteLoop = true,
        emoteMoving = true,
        allowedPrison = true,
    }},
    ["wave9"] = {"gestures@m@standing@casual", "gesture_hello", "Wave 9", animationOptions =
    {
        emoteLoop = true,
        emoteMoving = true,
        allowedPrison = true,
    }},
    ["whistle"] = {"taxi_hail", "hail_taxi", "Whistle", animationOptions =
    {
        emoteMoving = true,
        emoteDuration = 1300,
        allowedPrison = true,
    }},
    ["whistle2"] = {"rcmnigel1c", "hailing_whistle_waive_a", "Whistle 2", animationOptions =
    {
        emoteMoving = true,
        emoteDuration = 2000,
        allowedPrison = true,
    }},
    ["yeah"] = {"anim@mp_player_intupperair_shagging", "idle_a", "Yeah", animationOptions =
    {
        emoteLoop = true,
        emoteMoving = true,
        allowedPrison = true,
    }},
    ["lift"] = {"random@hitch_lift", "idle_f", "Lift", animationOptions =
    {
        emoteLoop = true,
        emoteMoving = true,
        allowedPrison = true,
    }},
    ["lol"] = {"anim@arena@celeb@flat@paired@no_props@", "laugh_a_player_b", "LOL", animationOptions =
    {
        emoteLoop = true,
        allowedPrison = true,
    }},
    ["lol2"] = {"anim@arena@celeb@flat@solo@no_props@", "giggle_a_player_b", "LOL 2", animationOptions =
    {
        emoteLoop = true,
        allowedPrison = true,
    }},
    ["statue2"] = {"fra_0_int-1", "cs_lamardavis_dual-1", "Statue 2", animationOptions =
    {
        emoteLoop = true,
        emoteMoving = true,
        allowedPrison = true,
    }},
    ["statue3"] = {"club_intro2-0", "csb_englishdave_dual-0", "Statue 3", animationOptions =
    {
        emoteLoop = true,
        allowedPrison = true,
    }},
    ["gangsign"] = {"mp_player_int_uppergang_sign_a", "mp_player_int_gang_sign_a", "Gang Sign", animationOptions =
    {
        emoteLoop = true,
        emoteMoving = true,
        allowedPrison = true,
    }},
    ["gangsign2"] = {"mp_player_int_uppergang_sign_b", "mp_player_int_gang_sign_b", "Gang Sign 2", animationOptions =
    {
        emoteLoop = true,
        emoteMoving = true,
        allowedPrison = true,
    }},
    -- ["passout"] = {"missarmenian2", "drunk_loop", "Passout", animationOptions =
    -- {
        -- emoteLoop = true,
    -- }},
    -- ["passout2"] = {"missarmenian2", "corpse_search_exit_ped", "Passout 2", animationOptions =
    -- {
        -- emoteLoop = true,
    -- }},
    -- ["passout3"] = {"anim@gangops@morgue@table@", "body_search", "Passout 3", animationOptions =
    -- {
        -- emoteLoop = true,
    -- }},
    -- ["passout4"] = {"mini@cpr@char_b@cpr_def", "cpr_pumpchest_idle", "Passout 4", animationOptions =
    -- {
        -- emoteLoop = true,
    -- }},
    -- ["passout5"] = {"random@mugging4", "flee_backward_loop_shopkeeper", "Passout 5", animationOptions =
    -- {
        -- emoteLoop = true,
    -- }},
    ["petting"] = {"creatures@rottweiler@tricks@", "petting_franklin", "Petting", animationOptions =
    {
        emoteLoop = true,
    }},
    -- ["crawl"] = {"move_injured_ground", "front_loop", "Crawl", animationOptions =
    -- {
        -- emoteLoop = true,
    -- }},
    ["flip2"] = {"anim@arena@celeb@flat@solo@no_props@", "cap_a_player_a", "Flip 2"},
    ["flip"] = {"anim@arena@celeb@flat@solo@no_props@", "flip_a_player_a", "Flip"},
    -- ["slide"] = {"anim@arena@celeb@flat@solo@no_props@", "slide_a_player_a", "Slide"},
    -- ["slide2"] = {"anim@arena@celeb@flat@solo@no_props@", "slide_b_player_a", "Slide 2"},
    -- ["slide3"] = {"anim@arena@celeb@flat@solo@no_props@", "slide_c_player_a", "Slide 3"},
    ["slugger"] = {"anim@arena@celeb@flat@solo@no_props@", "slugger_a_player_a", "Slugger"},
    ["flipoff"] = {"anim@arena@celeb@podium@no_prop@", "flip_off_a_1st", "Flip Off", animationOptions =
    {
        emoteMoving = true,
        allowedPrison = true,
    }},
    ["flipoff2"] = {"anim@arena@celeb@podium@no_prop@", "flip_off_c_1st", "Flip Off 2", animationOptions =
    {
        emoteMoving = true,
        allowedPrison = true,
    }},
    ["bow"] = {"anim@arena@celeb@podium@no_prop@", "regal_c_1st", "Bow", animationOptions =
    {
        emoteLoop = true,
        emoteMoving = true,
        allowedPrison = true,
    }},
    ["bow2"] = {"anim@arena@celeb@podium@no_prop@", "regal_a_1st", "Bow 2", animationOptions =
    {
        emoteLoop = true,
        emoteMoving = true,
        allowedPrison = true,
    }},
    ["keyfob"] = {"anim@mp_player_intmenu@key_fob@", "fob_click", "Key Fob", animationOptions =
    {
        emoteLoop = false,
        emoteMoving = true,
        emoteDuration = 1000,
        allowedPrison = true,
    }},
    ["golfswing"] = {"rcmnigel1d", "swing_a_mark", "Golf Swing"},
    ["eat"] = {"mp_player_inteat@burger", "mp_player_int_eat_burger", "Eat", animationOptions =
    {
        emoteMoving = true,
        emoteDuration = 3000,
        allowedPrison = true,
    }},
    ["reaching"] = {"move_m@intimidation@cop@unarmed", "idle", "Reaching", animationOptions =
    {
        emoteLoop = true,
        emoteMoving = true,
        allowedPrison = true,
    }},
    ["wait"] = {"random@shop_tattoo", "_idle_a", "Wait", animationOptions =
    {
        emoteLoop = true,
        emoteMoving = true,
        allowedPrison = true,
    }},
    ["wait2"] = {"missbigscore2aig_3", "wait_for_van_c", "Wait 2", animationOptions =
    {
        emoteLoop = true,
        emoteMoving = true,
        allowedPrison = true,
    }},
    ["wait12"] = {"rcmjosh1", "idle", "Wait 12", animationOptions =
    {
        emoteLoop = true,
        emoteMoving = true,
        allowedPrison = true,
    }},
    ["wait13"] = {"rcmnigel1a", "base", "Wait 13", animationOptions =
    {
        emoteLoop = true,
        emoteMoving = true,
        allowedPrison = true,
    }},
    ["lapdance1"] = {"mini@strip_club@private_dance@idle", "priv_dance_idle", "Lapdance 2", animationOptions =
    {
        emoteLoop = true,
        allowedPrison = true,
    }},
    ["lapdance2"] = {"mini@strip_club@private_dance@part2", "priv_dance_p2", "Lapdance 3", animationOptions =
    {
        emoteLoop = true,
        allowedPrison = true,
    }},
    ["lapdance3"] = {"mini@strip_club@private_dance@part3", "priv_dance_p3", "Lapdance 3", animationOptions =
    {
        emoteLoop = true,
        allowedPrison = true,
    }},
    ["twerk"] = {"switch@trevor@mocks_lapdance", "001443_01_trvs_28_idle_stripper", "Twerk", animationOptions =
    {
        emoteLoop = true,
        allowedPrison = true,
    }},
    ["slap"] = {"melee@unarmed@streamed_variations", "plyr_takedown_front_slap", "Slap", animationOptions =
    {
        emoteLoop = true,
        emoteMoving = true,
        emoteDuration = 2000,
        allowedPrison = true,
    }},
    ["headbutt"] = {"melee@unarmed@streamed_variations", "plyr_takedown_front_headbutt", "Headbutt"},
    ["fishdance"] = {"anim@mp_player_intupperfind_the_fish", "idle_a", "Fish Dance", animationOptions =
    {
        emoteLoop = true,
        emoteMoving = true,
        allowedPrison = true,
    }},
    ["peace"] = {"mp_player_int_upperpeace_sign", "mp_player_int_peace_sign", "Peace", animationOptions =
    {
        emoteLoop = true,
        emoteMoving = true,
        allowedPrison = true,
    }},
    ["peace2"] = {"anim@mp_player_intupperpeace", "idle_a", "Peace 2", animationOptions =
    {
        emoteLoop = true,
        emoteMoving = true,
        allowedPrison = true,
    }},
    ["peace3"] = {"anim@mp_player_intupperpeace", "idle_a_fp", "Peace 3", animationOptions =
    {
        emoteLoop = true,
        emoteMoving = true,
        allowedPrison = true,
    }},
    ["peace4"] = {"anim@mp_player_intincarpeacestd@ds@", "idle_a", "Peace 4", animationOptions =
    {
        emoteLoop = true,
        emoteMoving = true,
        allowedPrison = true,
    }},
    ["peace5"] = {"anim@mp_player_intincarpeacestd@ds@", "idle_a_fp", "Peace 5", animationOptions =
    {
        emoteLoop = true,
        emoteMoving = true,
        allowedPrison = true,
    }},
    ["peace6"] = {"anim@mp_player_intincarpeacebodhi@ds@", "idle_a", "Peace 6", animationOptions =
    {
        emoteLoop = true,
        emoteMoving = true,
        allowedPrison = true,
    }},
    ["peace7"] = {"anim@mp_player_intincarpeacebodhi@ds@", "idle_a_fp", "Peace 7", animationOptions =
    {
        emoteLoop = true,
        emoteMoving = true,
        allowedPrison = true,
    }},
    ["peacef"] = {"anim@mp_player_intcelebrationfemale@peace", "peace", "Peace Female", animationOptions =
    {
        emoteLoop = true,
        emoteMoving = true,
        allowedPrison = true,
    }},
    -- ["cpr"] = {"mini@cpr@char_a@cpr_str", "cpr_pumpchest", "CPR", animationOptions =
    -- {
        -- emoteLoop = true,
    -- }},
    -- ["cpr2"] = {"mini@cpr@char_a@cpr_str", "cpr_pumpchest", "CPR 2", animationOptions =
    -- {
        -- emoteLoop = true,
        -- emoteMoving = true,
    -- }},
    -- ["ledge"] = {"missfbi1", "ledge_loop", "Ledge", animationOptions =
    -- {
        -- emoteLoop = true,
    -- }},
    ["airplane"] = {"missfbi1", "ledge_loop", "Air Plane", animationOptions =
    {
        emoteLoop = true,
        emoteMoving = true,
        allowedPrison = true,
    }},
    ["peek"] = {"random@paparazzi@peek", "left_peek_a", "Peek", animationOptions =
    {
        emoteLoop = true,
    }},
    ["cough"] = {"timetable@gardener@smoking_joint", "idle_cough", "Cough", animationOptions =
    {
        emoteLoop = true,
        emoteMoving = true,
        allowedPrison = true,
    }},
    ["stretch"] = {"mini@triathlon", "idle_e", "Stretch", animationOptions =
    {
        emoteLoop = true,
    }},
    ["stretch2"] = {"mini@triathlon", "idle_f", "Stretch 2", animationOptions =
    {
        emoteLoop = true,
    }},
    ["stretch3"] = {"mini@triathlon", "idle_d", "Stretch 3", animationOptions =
    {
        emoteLoop = true,
    }},
    ["stretch4"] = {"rcmfanatic1maryann_stretchidle_b", "idle_e", "Stretch 4", animationOptions =
    {
        emoteLoop = true,
    }},
    ["celebrate"] = {"rcmfanatic1celebrate", "celebrate", "Celebrate", animationOptions =
    {
        emoteLoop = true,
    }},
    ["punching"] = {"rcmextreme2", "loop_punching", "Punching", animationOptions =
    {
        emoteLoop = true,
        emoteMoving = true,
        allowedPrison = true,
    }},
    ["superhero"] = {"rcmbarry", "base", "Superhero", animationOptions =
    {
        emoteLoop = true,
        allowedPrison = true,
    }},
    ["superhero2"] = {"rcmbarry", "base", "Superhero 2", animationOptions =
    {
        emoteLoop = true,
        emoteMoving = true,
        allowedPrison = true,
    }},
    ["mindcontrol"] = {"rcmbarry", "mind_control_b_loop", "Mind Control", animationOptions =
    {
        emoteLoop = true,
    }},
    ["mindcontrol2"] = {"rcmbarry", "bar_1_attack_idle_aln", "Mind Control 2", animationOptions =
    {
        emoteLoop = true,
    }},
    ["clown"] = {"rcm_barry2", "clown_idle_0", "Clown", animationOptions =
    {
        emoteLoop = true,
    }},
    ["clown2"] = {"rcm_barry2", "clown_idle_1", "Clown 2", animationOptions =
    {
        emoteLoop = true,
    }},
    ["clown3"] = {"rcm_barry2", "clown_idle_2", "Clown 3", animationOptions =
    {
        emoteLoop = true,
    }},
    ["clown4"] = {"rcm_barry2", "clown_idle_3", "Clown 4", animationOptions =
    {
        emoteLoop = true,
        emoteMoving = true,
    }},
    ["clown5"] = {"rcm_barry2", "clown_idle_6", "Clown 5", animationOptions =
    {
        emoteLoop = true,
    }},
    ["tryclothes"] = {"mp_clothing@female@trousers", "try_trousers_neutral_a", "Try Clothes", animationOptions =
    {
        emoteLoop = true,
        allowedPrison = true,
    }},
    ["tryclothes2"] = {"mp_clothing@female@shirt", "try_shirt_positive_a", "Try Clothes 2", animationOptions =
    {
        emoteLoop = true,
        allowedPrison = true,
    }},
    ["tryclothes3"] = {"mp_clothing@female@shoes", "try_shoes_positive_a", "Try Clothes 3", animationOptions =
    {
        emoteLoop = true,
        allowedPrison = true,
    }},
    ["nervous2"] = {"mp_missheist_countrybank@nervous", "nervous_idle", "Nervous 2", animationOptions =
    {
        emoteLoop = true,
        emoteMoving = true,
        allowedPrison = true,
    }},
    ["nervous"] = {"amb@world_human_bum_standing@twitchy@idle_a", "idle_c", "Nervous", animationOptions =
    {
        emoteLoop = true,
        emoteMoving = true,
        allowedPrison = true,
    }},
    ["nervous3"] = {"rcmme_tracey1", "nervous_loop", "Nervous 3", animationOptions =
    {
        emoteLoop = true,
        emoteMoving = true,
        allowedPrison = true,
    }},
    ["uncuff"] = {"mp_arresting", "a_uncuff", "Uncuff", animationOptions =
    {
        emoteLoop = true,
        emoteMoving = true,
        allowedPrison = true,
    }},
    ["namaste"] = {"timetable@amanda@ig_4", "ig_4_base", "Namaste", animationOptions =
    {
        emoteLoop = true,
        emoteMoving = true,
        allowedPrison = true,
    }},
    ["dj"] = {"anim@amb@nightclub@djs@dixon@", "dixn_dance_cntr_open_dix", "DJ", animationOptions =
    {
        emoteLoop = true,
        emoteMoving = true,
        allowedPrison = true,
    }},
    ["dj2"] = {"anim@mp_player_intcelebrationmale@dj", "dj", "DJ 2", animationOptions =
    {
        emoteLoop = true,
        emoteMoving = true,
        allowedPrison = true,
    }},
    ["threaten"] = {"random@atmrobberygen", "b_atm_mugging", "Threaten", animationOptions =
    {
        emoteLoop = true,
        emoteMoving = true,
        allowedPrison = true,
    }},
    ["radio"] = {"random@arrests", "generic_radio_chatter", "Radio", animationOptions =
    {
        emoteLoop = true,
        emoteMoving = true,
        allowedPrison = true,
    }},
    ["pull"] = {"random@mugging4", "struggle_loop_b_thief", "Pull", animationOptions =
    {
        emoteLoop = true,
        emoteMoving = true,
        allowedPrison = true,
    }},
    ["bird"] = {"random@peyote@bird", "wakeup", "Bird"},
    ["chicken"] = {"random@peyote@chicken", "wakeup", "Chicken", animationOptions =
    {
        emoteLoop = true,
        emoteMoving = true,
        allowedPrison = true,
    }},
    -- ["bark"] = {"random@peyote@dog", "wakeup", "Bark"},
    --   ["rabbit"] = {"random@peyote@rabbit", "wakeup", "Rabbit"},
    --    ["spiderman"] = {"missexile3", "ex03_train_roof_idle", "Spider-Man", animationOptions =
    --    {
    --        emoteLoop = true,
    --    }},
    ["boi"] = {"special_ped@jane@monologue_5@monologue_5c", "brotheradrianhasshown_2", "BOI", animationOptions =
    {
        emoteMoving = true,
        emoteDuration = 3000,
        allowedPrison = true,
    }},
    ["adjust"] = {"missmic4", "michael_tux_fidget", "Adjust", animationOptions =
    {
        emoteMoving = true,
        emoteDuration = 4000,
        allowedPrison = true,
    }},
    ["handsup"] = {"missminuteman_1ig_2", "handsup_base", "Hands Up", animationOptions =
    {
        emoteMoving = true,
        emoteLoop = true,
        allowedPrison = true,
    }},
    ["omgterrorist"] = {"oddjobs@assassinate@hotel@", "alert_gunshot", "Terrorist", animationOptions =
    {
        --emoteMoving = true,
        emoteLoop = true,
    }},
    ["helpme"] = {"oddjobs@assassinate@bus@", "looking_for_help", "Help Me", animationOptions =
    {
        --emoteMoving = true,
        emoteLoop = true,
        allowedPrison = true,
    }},
    ["titanic"] = {"nm@hands", "flat_floor", "Titanic", animationOptions =
    {
        emoteMoving = true,
        emoteLoop = true,
    }},
    ["grabtits"] = {"mp_player_int_uppertit_squeeze", "mp_player_int_tit_squeeze", "Grab Tits", animationOptions =
    {
        emoteMoving = true,
        emoteLoop = true,
        allowedPrison = true,
    }},
    ["upyours"] = {"mp_player_int_upperup_yours", "mp_player_int_up_yours", "Up yours", animationOptions =
    {
        emoteMoving = true,
        emoteLoop = true,
        allowedPrison = true,
    }},
    ["chinbrush"] = {"anim@mp_player_intcelebrationfemale@chin_brush", "chin_brush", "Chin Brush", animationOptions =
    {
        emoteMoving = true,
        emoteLoop = true,
        allowedPrison = true,
    }},
    ["physco"] = {"anim@mp_player_intcelebrationfemale@you_loco", "you_loco", "Physco", animationOptions =
    {
        emoteMoving = true,
        emoteLoop = true,
        allowedPrison = true,
    }},
    ["showtits"] = {"mini@strip_club@backroom@", "stripper_b_backroom_idle_b", "Show Tits", animationOptions =
    {
        emoteMoving = true,
        emoteLoop = true,
        allowedPrison = true,
    }},
    ["whatdidido"] = {"oddjobs@assassinate@multi@", "react_big_variations_a", "What Did I Do?", animationOptions =
    {
        --emoteMoving = true,
        emoteLoop = true,
    }},
    ["airshagging"] = {"anim@mp_player_intcelebrationfemale@air_shagging", "air_shagging", "Air Shagging", animationOptions =
    {
        --emoteMoving = true,
        emoteLoop = true,
    }},
    ["onfire"] = {"ragdoll@human", "on_fire", "On Fire", animationOptions =
    {
        --emoteMoving = true,
        --emoteLoop = true,
    }},
    ["electrocuted"] = {"ragdoll@human", "electrocute", "On Fire", animationOptions =
    {
        --emoteMoving = true,
        --emoteLoop = true,
    }},
    ["pee"] = {"misscarsteal2peeing", "peeing_loop", "Pee", animationOptions =
    {
        emoteStuck = true,
        ptfxAsset = "scr_amb_chop",
        ptfxName = "ent_anim_dog_peeing",
        PtfxNoprop = true,
        ptfxPlacement = {-0.05, 0.3, 0.0, 0.0, 90.0, 90.0, 1.0},
        ptfxInfo = "Hold ~y~G~w~ to pee.",
        ptfxWait = 3000,
        allowedPrison = true,
    }},
    ["valet"] = {"anim@amb@casino@valet_scenario@pose_a@", "base_a_m_y_vinewood_01", "Valet", animationOptions =
    {
        emoteLoop = true,
        emoteMoving = false,
        allowedPrison = true,
    }},
    ["valet2"] = {"anim@amb@casino@valet_scenario@pose_b@", "base_a_m_y_vinewood_01", "Valet 2", animationOptions =
    {
        emoteLoop = true,
        emoteMoving = false,
        allowedPrison = true,
    }},
    ["valet3"] = {"anim@amb@casino@valet_scenario@pose_d@", "base_a_m_y_vinewood_01", "Valet 3", animationOptions =
    {
        emoteLoop = true,
        emoteMoving = true,
        allowedPrison = true,
    }},
    ["grieve"] = {"anim@miss@low@fin@vagos@", "idle_ped05", "Grieve The Dead", animationOptions =
    {
        emoteLoop = true,
        emoteMoving = true,
        allowedPrison = true,
    }},
    ["respect"] = {"anim@mp_player_intcelebrationmale@respect", "respect", "Respect Male", animationOptions =
    {
        emoteLoop = false,
        emoteMoving = true,
        allowedPrison = true,
    }},
    ["respectf"] = {"anim@mp_player_intcelebrationfemale@respect", "respect", "Respect Female", animationOptions =
    {
        emoteLoop = false,
        emoteMoving = true,
        allowedPrison = true,
    }},

    -----------------------------------------------------------------------------------------------------------
    ------ These are Scenarios, some of these dont work on women and some other issues, but still good to have.
    -----------------------------------------------------------------------------------------------------------

        ["atm"] = {"Scenario", "PROP_HUMAN_ATM", "ATM"},
        ["bbq"] = {"MaleScenario", "PROP_HUMAN_BBQ", "BBQ"},
        ["bumbin"] = {"Scenario", "PROP_HUMAN_BUM_BIN", "Bum Bin"},
        --["bumsleep"] = {"Scenario", "WORLD_HUMAN_BUM_SLUMPED", "Bum Sleep"},
        ["cheer"] = {"Scenario", "WORLD_HUMAN_CHEERING", "Cheer"},
        ["chinup"] = {"Scenario", "PROP_HUMAN_MUSCLE_CHIN_UPS", "Chinup"},
        ["clipboard2"] = {"MaleScenario", "WORLD_HUMAN_CLIPBOARD", "Clipboard 2", animationOptions =
        {
            allowedPrison = true,
        }},
        ["cop"] = {"Scenario", "WORLD_HUMAN_COP_IDLES", "Cop"},
        ["copbeacon"] = {"MaleScenario", "WORLD_HUMAN_CAR_PARK_ATTENDANT", "Cop Beacon"},
        ["filmshocking"] = {"Scenario", "WORLD_HUMAN_MOBILE_FILM_SHOCKING", "Film Shocking"},
        ["flex"] = {"Scenario", "WORLD_HUMAN_MUSCLE_FLEX", "Flex"},
        ["guard"] = {"Scenario", "WORLD_HUMAN_GUARD_STAND", "Guard"},
        ["hammer"] = {"Scenario", "WORLD_HUMAN_HAMMERING", "Hammer"},
        ["hangout"] = {"Scenario", "WORLD_HUMAN_HANG_OUT_STREET", "Hangout"},
        ["impatient"] = {"Scenario", "WORLD_HUMAN_STAND_IMPATIENT", "Impatient"},
        ["janitor"] = {"Scenario", "WORLD_HUMAN_JANITOR", "Janitor"},
        ["jog"] = {"Scenario", "WORLD_HUMAN_JOG_STANDING", "Jog"},
        --["kneel"] = {"Scenario", "CODE_HUMAN_MEDIC_KNEEL", "Kneel"},
        ["leafblower"] = {"MaleScenario", "WORLD_HUMAN_GARDENER_LEAF_BLOWER", "Leafblower"},
        ["lean"] = {"Scenario", "WORLD_HUMAN_LEANING", "Lean"},
        ["leanbar"] = {"Scenario", "PROP_HUMAN_BUM_SHOPPING_CART", "Lean Bar", animationOptions =
        {
            allowedPrison = true,
        }},
        ["lookout"] = {"Scenario", "CODE_HUMAN_CROSS_ROAD_WAIT", "Lookout"},
        ["maid"] = {"Scenario", "WORLD_HUMAN_MAID_CLEAN", "Maid"},
        --["medic"] = {"Scenario", "CODE_HUMAN_MEDIC_TEND_TO_DEAD", "Medic"},
        ["musician"] = {"MaleScenario", "WORLD_HUMAN_MUSICIAN", "Musician"},
        ["notepad2"] = {"Scenario", "CODE_HUMAN_MEDIC_TIME_OF_DEATH", "Notepad 2"},
        ["parkingmeter"] = {"Scenario", "PROP_HUMAN_PARKING_METER", "Parking Meter"},
        ["party"] = {"Scenario", "WORLD_HUMAN_PARTYING", "Party"},
        ["phone"] = {"Scenario", "WORLD_HUMAN_STAND_MOBILE", "Phone"},
        ["prosthigh"] = {"Scenario", "WORLD_HUMAN_PROSTITUTE_HIGH_CLASS", "Prostitue High"},
        ["prostlow"] = {"Scenario", "WORLD_HUMAN_PROSTITUTE_LOW_CLASS", "Prostitue Low"},
        ["puddle"] = {"Scenario", "WORLD_HUMAN_BUM_WASH", "Puddle"},
        ["record"] = {"Scenario", "WORLD_HUMAN_MOBILE_FILM_SHOCKING", "Record"},
        -- Sitchair is a litte special, since you want the player to be seated correctly.
        -- So we set it as "ScenarioObject" and do TaskStartScenarioAtPosition() instead of "AtPlace"
        ["sitchair"] = {"ScenarioObject", "PROP_HUMAN_SEAT_CHAIR_MP_PLAYER", "Sit Chair", animationOptions =
        {
            allowedPrison = true,
        }},
        ["smoke"] = {"Scenario", "WORLD_HUMAN_SMOKING", "Smoke", animationOptions =
        {
            allowedPrison = true,
        }},
        ["smokeweed"] = {"MaleScenario", "WORLD_HUMAN_DRUG_DEALER", "Smoke Weed (Male)"}, -- Male
        ["smokepot"] = {"Scenario", "WORLD_HUMAN_SMOKING_POT", "Smoke Weed (Female)"}, -- Female
        ["statue"] = {"Scenario", "WORLD_HUMAN_HUMAN_STATUE", "Statue"},
        --["sunbathe3"] = {"Scenario", "WORLD_HUMAN_SUNBATHE", "Sunbathe 3"},
        --["sunbatheback"] = {"Scenario", "WORLD_HUMAN_SUNBATHE_BACK", "Sunbathe Back"},
        ["weld"] = {"Scenario", "WORLD_HUMAN_WELDING", "Weld"},
        ["windowshop"] = {"Scenario", "WORLD_HUMAN_WINDOW_SHOP_BROWSE", "Window Shop"},
        ["yoga"] = {"Scenario", "WORLD_HUMAN_YOGA", "Yoga", animationOptions =
        {
            allowedPrison = true,
        }},
        -- CASINO DLC EMOTES (STREAMED)
        ["karate"] = {"anim@mp_player_intcelebrationfemale@karate_chops", "karate_chops", "Karate"},
        ["karate2"] = {"anim@mp_player_intcelebrationmale@karate_chops", "karate_chops", "Karate 2"},
        ["cutthroat"] = {"anim@mp_player_intcelebrationmale@cut_throat", "cut_throat", "Cut Throat"},
        ["cutthroat2"] = {"anim@mp_player_intcelebrationfemale@cut_throat", "cut_throat", "Cut Throat 2"},
        ["mindblown"] = {"anim@mp_player_intcelebrationmale@mind_blown", "mind_blown", "Mind Blown", animationOptions =
        {
            emoteMoving = true,
            emoteDuration = 4000,
            allowedPrison = true,
        }},
        ["mindblown2"] = {"anim@mp_player_intcelebrationfemale@mind_blown", "mind_blown", "Mind Blown 2", animationOptions =
        {
            emoteMoving = true,
            emoteDuration = 4000,
            allowedPrison = true,
        }},
        ["boxing"] = {"anim@mp_player_intcelebrationmale@shadow_boxing", "shadow_boxing", "Boxing", animationOptions =
        {
            emoteMoving = true,
            emoteDuration = 4000,
            allowedPrison = true,
        }},
        ["boxing2"] = {"anim@mp_player_intcelebrationfemale@shadow_boxing", "shadow_boxing", "Boxing 2", animationOptions =
        {
            emoteMoving = true,
            emoteDuration = 4000,
            allowedPrison = true,
        }},
        ["stink"] = {"anim@mp_player_intcelebrationfemale@stinker", "stinker", "Stink", animationOptions =
        {
            emoteMoving = true,
            emoteLoop = true,
            allowedPrison = true,
        }},
        ["think4"] = {"anim@amb@casino@hangout@ped_male@stand@02b@idles", "idle_a", "Think 4", animationOptions =
        {
            emoteLoop = true,
            emoteMoving = true,
            allowedPrison = true,
        }},
        ["adjusttie"] = {"clothingtie", "try_tie_positive_a", "Adjust Tie", animationOptions =
        {
            emoteMoving = true,
            emoteDuration = 5000,
            allowedPrison = true,
        }},
        ["guard2"] = {"rcmepsilonism8", "base_carrier", "Guard 2", animationOptions =
        {
            emoteLoop = true,
            emoteMoving = false,
            allowedPrison = true,
        }},
        ["lean6"] = {"amb@lo_res_idles@", "world_human_lean_male_foot_up_lo_res_base", "Lean 6", animationOptions =
        {
            emoteLoop = true,
            emoteMoving = false,
            allowedPrison = true,
        }},
        ["copcrowd"] = {"amb@code_human_police_crowd_control@idle_a", "idle_a", "Cop Crowd", animationOptions =
        {
            emoteLoop = true,
            emoteMoving = false
        }},
        ["copcrowd2"] = {"amb@code_human_police_crowd_control@idle_b", "idle_d", "Cop Crowd 2", animationOptions =
        {
            emoteLoop = true,
            emoteMoving = false
        }},
        ["fingerbum"] = {"mp_player_int_upperarse_pick", "mp_player_int_arse_pick", "Finger Bum", animationOptions = {
            emoteLoop = true,
            emoteMoving = true,
            allowedPrison = true,
        }},
        ["touchself"] = {"mp_player_int_uppergrab_crotch", "mp_player_int_grab_crotch", "Touch Self", animationOptions = {
            emoteLoop = true,
            emoteMoving = true,
            allowedPrison = true,
        }},
        ["wanker"] = {"mp_player_intwank", "mp_player_int_wank", "Wanker", animationOptions = {
            emoteLoop = false,
            emoteMoving = false,
            allowedPrison = true,
        }},
        ["carbjgive"] = {"oddjobs@towing", "f_blow_job_loop", "Car Blowjob Give", animationOptions = {
            emoteLoop = false,
            emoteMoving = false
        }},
        ["carbjget"] = {"oddjobs@towing", "m_blow_job_loop", "Car Blowjob Get", animationOptions = {
            emoteLoop = false,
            emoteMoving = false
        }},
        ["carsexgive"] = {"mini@prostitutes@sexlow_veh", "low_car_sex_loop_female", "Car Sex Give", animationOptions = {
            emoteLoop = false,
            emoteMoving = false
        }},
        ["carsexget"] = {"mini@prostitutes@sexlow_veh", "low_car_sex_loop_player", "Car Sex Get", animationOptions = {
            emoteLoop = false,
            emoteMoving = false
        }}
}

cfg.props = {
    ["umbrella"] = {"amb@world_human_drinking@coffee@male@base", "base", "Umbrella", animationOptions =
    {
        prop = "p_amb_brolly_01",
        propBone = 57005,
        propPlacement = {0.15, 0.005, 0.0, 87.0, -20.0, 180.0},
        emoteLoop = true,
        emoteMoving = true,
    }},
    ["umbrella2"] = {"rcmnigel1d", "base_club_shoulder", "Umbrella 2", animationOptions =
    {
        prop = "p_amb_brolly_01",
        propBone = 28422,
        propPlacement = {0.0700, 0.0100, 0.1100, 2.3402393, -150.9605721, 57.3374916},
        emoteLoop = true,
        emoteMoving = true,
    }},

    -----------------------------------------------------------------------------------------------------
    ------ This is an example of an emote with 2 props, pretty simple! ----------------------------------
    -----------------------------------------------------------------------------------------------------

    ["notepad"] = {"missheistdockssetup1clipboard@base", "base", "Notepad", animationOptions =
    {
        prop = "prop_notepad_01",
        propBone = 18905,
        propPlacement = {0.1, 0.02, 0.05, 10.0, 0.0, 0.0},
        secondProp = "prop_pencil_01",
        secondPropBone = 58866,
        secondPropPlacement = {0.11, -0.02, 0.001, -120.0, 0.0, 0.0},
        -- emoteLoop is used for emotes that should loop, its as simple as that.
        -- Then emoteMoving is used for emotes that should only play on the upperbody.
        -- The code then checks both values and sets the MovementType to the correct one
        emoteLoop = true,
        emoteMoving = true,
        allowedPrison = true
    }},
    ["box"] = {"anim@heists@box_carry@", "idle", "Box", animationOptions =
    {
        prop = "hei_prop_heist_box",
        propBone = 60309,
        propPlacement = {0.025, 0.08, 0.255, -145.0, 290.0, 0.0},
        emoteLoop = true,
        emoteMoving = true,
    }},
    ["tray"] = {"anim@heists@box_carry@", "idle", "Tray", animationOptions =
    {
        prop = "vw_prop_vw_tray_01a",
        propBone = 60309,
        propPlacement = {0.21, -0.0, 0.19, -60.1, -22.0, 30.0},
        emoteLoop = true,
        emoteMoving = true,
    }},
    ["tray2"] = {"anim@heists@box_carry@", "idle", "Tray 2", animationOptions =
    {
        prop = "sum_mp_h_acc_drink_tray_02",
        propBone = 60309,
        propPlacement = {0.21, -0.0, 0.19, -60.1, -22.0, 30.0},
        emoteLoop = true,
        emoteMoving = true,
    }},
    ["tray3"] = {"anim@heists@box_carry@", "idle", "Tray 3", animationOptions =
    {
        prop = "prop_food_bs_tray_01",
        propBone = 60309,
        propPlacement = {0.17, -0.0, 0.21, -52.0, -75.0, -6.0},
        emoteLoop = true,
        emoteMoving = true,
    }},
    ["tray4"] = {"anim@heists@box_carry@", "idle", "Tray 4", animationOptions =
    {
        prop = "prop_food_bs_tray_02",
        propBone = 60309,
        propPlacement = {0.17, -0.0, 0.21, -52.0, -75.0, -6.0},
        emoteLoop = true,
        emoteMoving = true,
    }},
    ["tray5"] = {"anim@heists@box_carry@", "idle", "Tray 5", animationOptions =
    {
        prop = "prop_food_bs_tray_03",
        propBone = 60309,
        propPlacement = {0.17, -0.0, 0.21, -52.0, -75.0, -6.0},
        emoteLoop = true,
        emoteMoving = true,
    }},
    ["tray6"] = {"anim@heists@box_carry@", "idle", "Tray 6", animationOptions =
    {
        prop = "v_ind_cftrayfillets",
        propBone = 60309,
        propPlacement = {0.17, -0.0, 0.21, -52.0, -75.0, -6.0},
        emoteLoop = true,
        emoteMoving = true,
    }},
    ["tray_champ_1"] = {"anim@heists@box_carry@", "idle", "Tray Champagne", animationOptions =
    {
        prop = "h4_prop_h4_champ_tray_01a",
        propBone = 60309,
        propPlacement = {0.21, -0.0, 0.19, -60.1, -22.0, 30.0},
        emoteLoop = true,
        emoteMoving = true,
    }},
    ["tray_champ_2"] = {"anim@heists@box_carry@", "idle", "Tray Champagne 2", animationOptions =
    {
        prop = "h4_prop_h4_champ_tray_01b",
        propBone = 60309,
        propPlacement = {0.21, -0.0, 0.19, -60.1, -22.0, 30.0},
        emoteLoop = true,
        emoteMoving = true,
    }},
    ["tray_champ_3"] = {"anim@heists@box_carry@", "idle", "Tray Champagne 3", animationOptions =
    {
        prop = "h4_prop_h4_champ_tray_01c",
        propBone = 60309,
        propPlacement = {0.21, -0.0, 0.19, -60.1, -22.0, 30.0},
        emoteLoop = true,
        emoteMoving = true,
    }},
    ["rose"] = {"anim@heists@humane_labs@finale@keycards", "ped_a_enter_loop", "Rose", animationOptions =
    {
        prop = "prop_single_rose",
        propBone = 18905,
        propPlacement = {0.13, 0.15, 0.0, -100.0, 0.0, -20.0},
        emoteLoop = true,
        emoteMoving = true,
    }},
    ["smoke2"] = {"amb@world_human_aa_smoke@male@idle_a", "idle_c", "Smoke 2", animationOptions =
    {
        prop = "prop_cs_ciggy_01",
        propBone = 28422,
        propPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
        emoteLoop = true,
        emoteMoving = true,
    }},
    ["smoke3"] = {"amb@world_human_aa_smoke@male@idle_a", "idle_b", "Smoke 3", animationOptions =
    {
        prop = "prop_cs_ciggy_01",
        propBone = 28422,
        propPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
        emoteLoop = true,
        emoteMoving = true,
    }},
    ["smoke4"] = {"amb@world_human_smoking@female@idle_a", "idle_b", "Smoke 4", animationOptions =
    {
        prop = "prop_cs_ciggy_01",
        propBone = 28422,
        propPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
        emoteLoop = true,
        emoteMoving = true,
    }},
    ["bong"] = {"anim@safehouse@bong", "bong_stage3", "Bong", animationOptions =
    {
        prop = "hei_heist_sh_bong_01",
        propBone = 18905,
        propPlacement = {0.10,-0.25,0.0,95.0,190.0,180.0},
    }},
    ["fishing1"] = {"amb@world_human_stand_fishing@idle_a", "idle_a", "Fishing1", animationOptions =
    {
        prop = "prop_fishing_rod_01",
        propBone = 60309,
        propPlacement = {0.0,0.0,0.0,0.0,0.0,0.0},
        emoteLoop = true,
        emoteMoving = false,
    }},
    ["fishing2"] = {"amb@world_human_stand_fishing@idle_a", "idle_b", "Fishing2", animationOptions =
    {
        prop = "prop_fishing_rod_01",
        propBone = 60309,
        propPlacement = {0.0,0.0,0.0,0.0,0.0,0.0},
        emoteLoop = true,
        emoteMoving = false,
    }},
    ["fishing3"] = {"amb@world_human_stand_fishing@idle_a", "idle_c", "Fishing3", animationOptions =
    {
        prop = "prop_fishing_rod_01",
        propBone = 60309,
        propPlacement = {0.0,0.0,0.0,0.0,0.0,0.0},
        emoteLoop = true,
        emoteMoving = false,
    }},
    ["suitcase"] = {"move_weapon@jerrycan@generic", "idle", "Suitcase", animationOptions =
    {
        prop = "prop_ld_suitcase_01",
        propBone = 57005,
        propPlacement = {0.35, 0.0, 0.0, 0.0, 266.0, 90.0},
        emoteLoop = true,
        emoteMoving = true,
    }},
    ["suitcase2"] = {"move_weapon@jerrycan@generic", "idle", "Suitcase 2", animationOptions =
    {
        prop = "prop_security_case_01",
        propBone = 57005,
        propPlacement = {0.13, 0.0, -0.01, 0.0, 280.0, 90.0},
        emoteLoop = true,
        emoteMoving = true,
    }},
    ["boombox"] = {"move_weapon@jerrycan@generic", "idle", "Boombox", animationOptions =
    {
        prop = "prop_boombox_01",
        propBone = 57005,
        propPlacement = {0.27, 0.0, 0.0, 0.0, 263.0, 58.0},
        emoteLoop = true,
        emoteMoving = true,
    }},
    ["beerbox"] = {"move_weapon@jerrycan@generic", "idle", "Beer Box 1", animationOptions =
    {
        prop = "v_ret_ml_beerdus",
        propBone = 57005,
        propPlacement = {0.22, 0.0, 0.0, 0.0, 266.0, 48.0},
        emoteLoop = true,
        emoteMoving = true,
    }},
    ["beerbox2"] = {"move_weapon@jerrycan@generic", "idle", "Beer Box 2", animationOptions =
    {
        prop = "v_ret_ml_beeram",
        propBone = 57005,
        propPlacement = {0.22, 0.0, 0.0, 0.0, 266.0, 48.0},
        emoteLoop = true,
        emoteMoving = true,
    }},
    ["mugshot"] = {"mp_character_creation@customise@male_a", "loop", "Mugshot", animationOptions =
    {
        prop = "prop_police_id_board",
        propBone = 58868,
        propPlacement = {0.12, 0.24, 0.0, 5.0, 0.0, 70.0},
        emoteLoop = true,
        emoteMoving = true,
    }},
    ["coffee"] = {"amb@world_human_drinking@coffee@male@idle_a", "idle_c", "Coffee", animationOptions =
    {
        prop = "p_amb_coffeecup_01",
        propBone = 28422,
        propPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
        emoteLoop = true,
        emoteMoving = true,
    }},
    ["whiskey"] = {"amb@world_human_drinking@coffee@male@idle_a", "idle_c", "Whiskey", animationOptions =
    {
        prop = "prop_drink_whisky",
        propBone = 28422,
        propPlacement = {0.01, -0.01, -0.06, 0.0, 0.0, 0.0},
        emoteLoop = true,
        emoteMoving = true,
    }},
    ["beer"] = {"amb@world_human_drinking@coffee@male@idle_a", "idle_c", "Beer", animationOptions =
    {
        prop = "prop_amb_beer_bottle",
        propBone = 28422,
        propPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
        emoteLoop = true,
        emoteMoving = true,
    }},
    ["cup"] = {"amb@world_human_drinking@coffee@male@idle_a", "idle_c", "Cup", animationOptions =
    {
        prop = "prop_plastic_cup_02",
        propBone = 28422,
        propPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
        emoteLoop = true,
        emoteMoving = true,
    }},
    ["donut"] = {"mp_player_inteat@burger", "mp_player_int_eat_burger", "Donut", animationOptions =
    {
        prop = "prop_amb_donut",
        propBone = 18905,
        propPlacement = {0.13, 0.05, 0.02, -50.0, 16.0, 60.0},
        emoteMoving = true,
    }},
    ["burger"] = {"mp_player_inteat@burger", "mp_player_int_eat_burger", "Burger", animationOptions =
    {
        prop = "prop_cs_burger_01",
        propBone = 18905,
        propPlacement = {0.13, 0.05, 0.02, -50.0, 16.0, 60.0},
        emoteMoving = true,
    }},
    ["sandwich"] = {"mp_player_inteat@burger", "mp_player_int_eat_burger", "Sandwich", animationOptions =
    {
        prop = "prop_sandwich_01",
        propBone = 18905,
        propPlacement = {0.13, 0.05, 0.02, -50.0, 16.0, 60.0},
        emoteMoving = true,
    }},
    ["soda"] = {"amb@world_human_drinking@coffee@male@idle_a", "idle_c", "Soda", animationOptions =
    {
        prop = "prop_ecola_can",
        propBone = 28422,
        propPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 130.0},
        emoteLoop = true,
        emoteMoving = true,
    }},
    ["water"] = {"amb@world_human_drinking@coffee@male@idle_a", "idle_c", "Water", animationOptions =
    {
        prop = "ba_prop_club_water_bottle",
        propBone = 28422,
        propPlacement = {0.0, 0.0, -0.090, 0.0, 0.0, 130.0},
        emoteLoop = true,
        emoteMoving = true,
    }},
    ["egobar"] = {"mp_player_inteat@burger", "mp_player_int_eat_burger", "Ego Bar", animationOptions =
    {
        prop = "prop_choc_ego",
        propBone = 60309,
        propPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
        emoteMoving = true,
    }},
    ["wine"] = {"anim@heists@humane_labs@finale@keycards", "ped_a_enter_loop", "Wine", animationOptions =
    {
        prop = "prop_drink_redwine",
        propBone = 18905,
        propPlacement = {0.10, -0.03, 0.03, -100.0, 0.0, -10.0},
        emoteMoving = true,
        emoteLoop = true
    }},
    ["flute"] = {"anim@heists@humane_labs@finale@keycards", "ped_a_enter_loop", "Flute", animationOptions =
    {
        prop = "prop_champ_flute",
        propBone = 18905,
        propPlacement = {0.10, -0.03, 0.03, -100.0, 0.0, -10.0},
        emoteMoving = true,
        emoteLoop = true
    }},
    ["champagne"] = {"anim@heists@humane_labs@finale@keycards", "ped_a_enter_loop", "Champagne", animationOptions =
    {
        prop = "prop_drink_champ",
        propBone = 18905,
        propPlacement = {0.10, -0.03, 0.03, -100.0, 0.0, -10.0},
        emoteMoving = true,
        emoteLoop = true
    }},
    ["cigar"] = {"amb@world_human_smoking@male@male_a@enter", "enter", "Cigar", animationOptions =
    {
        prop = "prop_cigar_02",
        propBone = 47419,
        propPlacement = {0.010, 0.0, 0.0, 50.0, 0.0, -80.0},
        emoteMoving = true,
        emoteDuration = 2600
    }},
    ["cigar2"] = {"amb@world_human_smoking@male@male_a@enter", "enter", "Cigar 2", animationOptions =
    {
        prop = "prop_cigar_01",
        propBone = 47419,
        propPlacement = {0.010, 0.0, 0.0, 50.0, 0.0, -80.0},
        emoteMoving = true,
        emoteDuration = 2600
    }},
    ["guitar"] = {"amb@world_human_musician@guitar@male@idle_a", "idle_b", "Guitar", animationOptions =
    {
        prop = "prop_acc_guitar_01",
        propBone = 24818,
        propPlacement = {-0.1, 0.31, 0.1, 0.0, 20.0, 150.0},
        emoteMoving = true,
        emoteLoop = true
    }},
    ["guitar2"] = {"switch@trevor@guitar_beatdown", "001370_02_trvs_8_guitar_beatdown_idle_busker", "Guitar 2", animationOptions =
    {
        prop = "prop_acc_guitar_01",
        propBone = 24818,
        propPlacement = {-0.05, 0.31, 0.1, 0.0, 20.0, 150.0},
        emoteMoving = true,
        emoteLoop = true
    }},
    ["guitarelectric"] = {"amb@world_human_musician@guitar@male@idle_a", "idle_b", "Guitar Electric", animationOptions =
    {
        prop = "prop_el_guitar_01",
        propBone = 24818,
        propPlacement = {-0.1, 0.31, 0.1, 0.0, 20.0, 150.0},
        emoteMoving = true,
        emoteLoop = true
    }},
    ["guitarelectric2"] = {"amb@world_human_musician@guitar@male@idle_a", "idle_b", "Guitar Electric 2", animationOptions =
    {
        prop = "prop_el_guitar_03",
        propBone = 24818,
        propPlacement = {-0.1, 0.31, 0.1, 0.0, 20.0, 150.0},
        emoteMoving = true,
        emoteLoop = true
    }},
    ["book"] = {"cellphone@", "cellphone_text_read_base", "Book", animationOptions =
    {
        prop = "prop_novel_01",
        propBone = 6286,
        propPlacement = {0.15, 0.03, -0.065, 0.0, 180.0, 90.0}, -- This positioning isnt too great, was to much of a hassle
        emoteMoving = true,
        emoteLoop = true,
        allowedPrison = true
    }},
    ["bouquet"] = {"impexp_int-0", "mp_m_waremech_01_dual-0", "Bouquet", animationOptions =
    {
        prop = "prop_snow_flower_02",
        propBone = 24817,
        propPlacement = {-0.29, 0.40, -0.02, -90.0, -90.0, 0.0},
        emoteMoving = true,
        emoteLoop = true
    }},
    ["teddy"] = {"impexp_int-0", "mp_m_waremech_01_dual-0", "Teddy", animationOptions =
    {
        prop = "v_ilev_mr_rasberryclean",
        propBone = 24817,
        propPlacement = {-0.20, 0.46, -0.016, -180.0, -90.0, 0.0},
        emoteMoving = true,
        emoteLoop = true
    }},
    ["backpack"] = {"move_p_m_zero_rucksack", "idle", "Backpack", animationOptions =
    {
        prop = "p_michael_backpack_s",
        propBone = 24818,
        propPlacement = {0.07, -0.11, -0.05, 0.0, 90.0, 175.0},
        emoteMoving = true,
        emoteLoop = true
    }},
    ["clipboard"] = {"missfam4", "base", "Clipboard", animationOptions =
    {
        prop = "p_amb_clipboard_01",
        propBone = 36029,
        propPlacement = {0.16, 0.08, 0.1, -130.0, -50.0, 0.0},
        emoteMoving = true,
        emoteLoop = true,
        allowedPrison = true
    }},
    ["map"] = {"amb@world_human_tourist_map@male@base", "base", "Map", animationOptions =
    {
        prop = "prop_tourist_map_01",
        propBone = 28422,
        propPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
        emoteMoving = true,
        emoteLoop = true
    }},
    ["map2"] = {"amb@code_human_in_bus_passenger_idles@female@tablet@idle_a", "idle_a", "Map 2", animationOptions =
    {
        prop = "prop_tourist_map_01",
        propBone = 28422,
        propPlacement = {-0.05, 0.0, 0.0, 0.0, 0.0, 0.0},
        emoteLoop = true,
        emoteMoving = true,
    }},
    ["beg"] = {"amb@world_human_bum_freeway@male@base", "base", "Beg", animationOptions =
    {
        prop = "prop_beggers_sign_03",
        propBone = 58868,
        propPlacement = {0.19, 0.18, 0.0, 5.0, 0.0, 40.0},
        emoteLoop = true,
        emoteMoving = true,
    }},
    ["makeitrain"] = {"anim@mp_player_intupperraining_cash", "idle_a", "Make It Rain", animationOptions =
    {
        prop = "prop_anim_cash_pile_01",
        propBone = 60309,
        propPlacement = {0.0, 0.0, 0.0, 180.0, 0.0, 70.0},
        emoteMoving = true,
        emoteLoop = true,
        ptfxAsset = "scr_xs_celebration",
        ptfxName = "scr_xs_money_rain",
        ptfxPlacement = {0.0, 0.0, -0.09, -80.0, 0.0, 0.0, 1.0},
        ptfxInfo = "Press ~y~G~w~ to make it rain.",
        ptfxWait = 500,
    }},
    ["camera"] = {"amb@world_human_paparazzi@male@base", "base", "Camera", animationOptions =
    {
        prop = "prop_pap_camera_01",
        propBone = 28422,
        propPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
        emoteLoop = true,
        emoteMoving = true,
        ptfxAsset = "scr_bike_business",
        ptfxName = "scr_bike_cfid_camera_flash",
        ptfxPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0},
        ptfxInfo = "Press ~y~G~w~ to use camera flash.",
        ptfxWait = 200,
    }},
    ["champagnespray"] = {"anim@mp_player_intupperspray_champagne", "idle_a", "Champagne Spray", animationOptions =
    {
        prop = "ba_prop_battle_champ_open",
        propBone = 28422,
        propPlacement = {0.0,0.0,0.0,0.0,0.0,0.0},
        emoteMoving = true,
        emoteLoop = true,
        ptfxAsset = "scr_ba_club",
        ptfxName = "scr_ba_club_champagne_spray",
        ptfxPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
        ptfxInfo = "Hold ~y~G~w~ to spray champagne",
        ptfxWait = 500,
    }},
    ["joint"] = {"amb@world_human_smoking@male@male_a@enter", "enter", "Joint", animationOptions =
    {
        prop = "p_cs_joint_02",
        propBone = 47419,
        propPlacement = {0.015, -0.009, 0.003, 55.0, 0.0, 110.0},
        emoteMoving = true,
        emoteDuration = 2600
    }},
    ["cig"] = {"amb@world_human_smoking@male@male_a@enter", "enter", "Cig", animationOptions =
    {
        prop = "prop_amb_ciggy_01",
        propBone = 47419,
        propPlacement = {0.015, -0.009, 0.003, 55.0, 0.0, 110.0},
        emoteMoving = true,
        emoteDuration = 2600
    }},
    ["brief3"] = {"missheistdocksprep1hold_cellphone", "static", "Brief 3", animationOptions =
    {
        prop = "prop_ld_case_01",
        propBone = 57005,
        propPlacement = {0.10, 0.0, 0.0, 0.0, 280.0, 53.0},
        emoteLoop = true,
        emoteMoving = true,
    }},
    ["tablet"] = {"amb@world_human_tourist_map@male@base", "base", "Tablet", animationOptions =
    {
        prop = "prop_cs_tablet",
        propBone = 28422,
        propPlacement = {0.0, -0.03, 0.0, 20.0, -90.0, 0.0},
        emoteLoop = true,
        emoteMoving = true,
    }},
    ["tablet2"] = {"amb@code_human_in_bus_passenger_idles@female@tablet@idle_a", "idle_a", "Tablet 2", animationOptions =
    {
        prop = "prop_cs_tablet",
        propBone = 28422,
        propPlacement = {-0.05, 0.0, 0.0, 0.0, 0.0, 0.0},
        emoteLoop = true,
        emoteMoving = true,
    }},
    ["phonecall"] = {"cellphone@", "cellphone_call_listen_base", "Phone Call", animationOptions =
    {
        prop = "prop_npc_phone_02",
        propBone = 28422,
        propPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
        emoteLoop = true,
        emoteMoving = true,
    }},
    ["phone"] = {"cellphone@", "cellphone_text_read_base", "Phone", animationOptions =
    {
        prop = "prop_phone_cs_frank",
        propBone = 28422,
        propPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
        emoteLoop = true,
        emoteMoving = true,
    }},
    ["wt"] = {"cellphone@", "cellphone_text_read_base", "Walkie Talkie", animationOptions =
    {
        prop = "prop_cs_hand_radio",
        propBone = 28422,
        propPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
        emoteLoop = true,
        emoteMoving = true,
    }},
    ["clean"] = {"timetable@floyd@clean_kitchen@base", "base", "Clean", animationOptions =
    {
        prop = "prop_sponge_01",
        propBone = 28422,
        propPlacement = {0.0, 0.0, -0.01, 90.0, 0.0, 0.0},
        emoteLoop = true,
        emoteMoving = true,
    }},
    ["selfie2"] = {"cellphone@self@franklin@", "peace", "Selfie 2", animationOptions =
    {
        prop = "prop_phone_ing",
        propBone = 28422,
        propPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
        emoteLoop = true,
        emoteMoving = true,
    }},
    ["selfie3"] = {"cellphone@self@franklin@", "west_coast", "Selfie 3 - West Side", animationOptions =
    {
        prop = "prop_phone_ing",
        propBone = 28422,
        propPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
        emoteLoop = true,
        emoteMoving = true,
    }},
    ["selfie4"] = {"cellphone@self@trevor@", "aggressive_finger", "Selfie 4 - Finger", animationOptions =
    {
        prop = "prop_phone_ing",
        propBone = 28422,
        propPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
        emoteLoop = true,
        emoteMoving = true,
    }},
    ["selfie5"] = {"cellphone@self@trevor@", "proud_finger", "Selfie 5 - Finger 2", animationOptions =
    {
        prop = "prop_phone_ing",
        propBone = 28422,
        propPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
        emoteLoop = true,
        emoteMoving = true,
    }},
    ["selfie6"] = { "cellphone@self@trevor@", "throat_slit", "Selfie 6 - Throat Slit", animationOptions =
    {
        prop = "prop_phone_ing",
        propBone = 28422,
        propPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
        emoteLoop = true,
        emoteMoving = true,
    }},
    ["selfie7"] = {"cellphone@self@franklin@", "chest_bump", "Selfie 7 - Chest Bump", animationOptions =
    {
        prop = "prop_phone_ing",
        propBone = 28422,
        propPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
        emoteLoop = true,
        emoteMoving = true,
    }},
    ["clean2"] = {"amb@world_human_maid_clean@", "base", "Clean 2", animationOptions =
    {
        prop = "prop_sponge_01",
        propBone = 28422,
        propPlacement = {0.0, 0.0, -0.01, 90.0, 0.0, 0.0},
        emoteLoop = true,
        emoteMoving = true,
    }},
    ["protest"] = {"rcmnigel1d", "base_club_shoulder", "Protest", animationOptions =
    {
        prop = "prop_cs_protest_sign_01",
        propBone = 57005,
        propPlacement = {0.1820, 0.2400, 0.0600, -69.3774235, 5.9142048, -13.9572354},
        --
        emoteLoop = true,
        emoteMoving = true,
    }},
    ["binoculars"] = {"amb@world_human_binoculars@male@idle_b", "idle_f", "Binoculars", animationOptions =
    {
        prop = "prop_binoc_01",
        propBone = 28422,
        propPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
        --
        emoteLoop = true,
        emoteMoving = true,
    }},
    ["binoculars2"] = {"amb@world_human_binoculars@male@idle_a", "idle_c", "Binoculars 2", animationOptions =
    {
        prop = "prop_binoc_01",
        propBone = 28422,
        propPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
        --
        emoteLoop = true,
        emoteMoving = true,
    }},
    ["tennisplay"] = {"move_weapon@jerrycan@generic", "idle", "Tennis Play", animationOptions =
    {
        prop = "prop_tennis_bag_01",
        propBone = 57005,
        propPlacement = {0.27, 0.0, 0.0, 91.0, 0.0, -82.9999951},
        secondProp = "prop_tennis_rack_01",
        secondPropBone = 60309,
        secondPropPlacement = {0.0800, 0.0300, 0.0, -130.2907295, 3.8782324, 6.588224},
        emoteLoop = true,
        emoteMoving = true,


    }},
    ["weights"] = {"amb@world_human_muscle_free_weights@male@barbell@base", "base", "Weights", animationOptions =
    {
        prop = "prop_curl_bar_01",
        propBone = 28422,
        propPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
        emoteLoop = true,
        emoteMoving = true,
    }},
    ["weights2"] = {"amb@world_human_muscle_free_weights@male@barbell@idle_a", "idle_d", "Weights 2", animationOptions =
    {
        prop = "prop_curl_bar_01",
        propBone = 28422,
        propPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
        emoteLoop = true,
        emoteMoving = true,
    }},
    ["fuel"] = {"weapons@misc@jerrycan@", "fire", "Fuel", animationOptions =
    {
        prop = "w_am_jerrycan",
        propBone = 57005,
        propPlacement = {0.1800, 0.1300, -0.2400, -165.8693883, -11.2122753, -32.9453021},
        emoteLoop = true,
        emoteMoving = true,
    }},
    ["fuelcarry"] = {"weapons@misc@jerrycan@franklin", "idle", "Fuel Carry", animationOptions =
    {
        prop = "w_am_jerrycan",
        propBone = 28422,
        propPlacement = {0.26, 0.050, 0.0300, 80.00, 180.000, 79.99},
        emoteLoop = true,
        emoteMoving = true,
    }},
    ["hitchhike"] = {"random@hitch_lift", "idle_f", "Hitchhike", animationOptions =
    {
        prop = "w_am_jerrycan",
        propBone = 18905,
        propPlacement = {0.32, -0.0100, 0.0, -162.423, 74.83, 58.79},
        secondProp = "prop_michael_backpack",
        secondPropBone = 40269,
        secondPropPlacement = {-0.07, -0.21, -0.11, -144.93, 117.358, -6.16},
        emoteLoop = true,
        emoteMoving = true,
    }},
    ["ssign"] = {"rcmnigel1d", "base_club_shoulder", "Steal Stop Sign ", animationOptions =
    {
        prop = "prop_sign_road_01a",
        propBone = 60309,
        propPlacement = {-0.1390, -0.9870, 0.4300, -67.3315314, 145.0627869, -4.4318885},
        --
        emoteLoop = true,
        emoteMoving = true,
    }},
    ["ssign2"] = {"rcmnigel1d", "base_club_shoulder", "Steal Yield Sign ", animationOptions =
    {
        prop = "prop_sign_road_02a",
        propBone = 60309,
        propPlacement = {-0.1390, -0.9870, 0.4300, -67.3315314, 145.0627869, -4.4318885},
        --
        emoteLoop = true,
        emoteMoving = true,
    }},
    ["ssign3"] = {"rcmnigel1d", "base_club_shoulder", "Steal Hospital Sign ", animationOptions =
    {
        prop = "prop_sign_road_03d",
        propBone = 60309,
        propPlacement = {-0.1390, -0.9870, 0.4300, -67.3315314, 145.0627869, -4.4318885},
        --
        emoteLoop = true,
        emoteMoving = true,
    }},
    ["ssign4"] = {"rcmnigel1d", "base_club_shoulder", "Steal Parking Sign ", animationOptions =
    {
        prop = "prop_sign_road_04a",
        propBone = 60309,
        propPlacement = {-0.1390, -0.9870, 0.4300, -67.3315314, 145.0627869, -4.4318885},
        --
        emoteLoop = true,
        emoteMoving = true,
    }},
    ["ssign5"] = {"rcmnigel1d", "base_club_shoulder", "Steal Parking Sign 2 ", animationOptions =
    {
        prop = "prop_sign_road_04w",
        propBone = 60309,
        propPlacement = {-0.1390, -0.9870, 0.4300, -67.3315314, 145.0627869, -4.4318885},
        --
        emoteLoop = true,
        emoteMoving = true,
    }},
    ["ssign6"] = {"rcmnigel1d", "base_club_shoulder", "Steal Pedestrian Sign ", animationOptions =
    {
        prop = "prop_sign_road_05a",
        propBone = 60309,
        propPlacement = {-0.1390, -0.9870, 0.4300, -67.3315314, 145.0627869, -4.4318885},
        --
        emoteLoop = true,
        emoteMoving = true,
    }},
    ["ssign7"] = {"rcmnigel1d", "base_club_shoulder", "Steal Street Sign ", animationOptions =
    {
        prop = "prop_sign_road_05t",
        propBone = 60309,
        propPlacement = {-0.1390, -0.9870, 0.4300, -67.3315314, 145.0627869, -4.4318885},
        --
        emoteLoop = true,
        emoteMoving = true,
    }},
    ["ssign8"] = {"rcmnigel1d", "base_club_shoulder", "Steal Freeway Sign ", animationOptions =
    {
        prop = "prop_sign_freewayentrance",
        propBone = 60309,
        propPlacement = {-0.1390, -0.9870, 0.4300, -67.3315314, 145.0627869, -4.4318885},
        --
        emoteLoop = true,
        emoteMoving = true,
    }},
    ["ssign9"] = {"rcmnigel1d", "base_club_shoulder", "Steal Stop Sign Snow ", animationOptions =
    {
        prop = "prop_snow_sign_road_01a",
        propBone = 60309,
        propPlacement = {-0.1390, -0.9870, 0.4300, -67.3315314, 145.0627869, -4.4318885},
        --
        emoteLoop = true,
        emoteMoving = true,
    }},
    ["conehead"] = {"move_m@drunk@verydrunk_idles@", "fidget_07", "Cone Head ", animationOptions =
    {
        prop = "prop_roadcone02a",
        propBone = 31086,
        propPlacement = {-0.0300, 0.0200, 0.000, 0.000, 83.9000, 0.000},
        --
        emoteLoop = true,
        emoteMoving = true,
    }},
    ["carryfoodtray"] = {"anim@heists@box_carry@", "idle", "Carry Food Tray", animationOptions =
    {
        prop = "prop_food_bs_tray_03",
        propBone = 28422,
        propPlacement = {0.0100, -0.0400, -0.1390,20.0000007, 0.0, 0.0},
        emoteLoop = true,
        emoteMoving = true,
    }},
    ["carryfoodtray2"] = {"anim@heists@box_carry@", "idle", "Carry Food Tray 2", animationOptions =
    {
        prop = "prop_food_bs_tray_02",
        propBone = 28422,
        propPlacement = {0.0100, -0.0400, -0.1390,20.0000007, 0.0, 0.0},
        emoteLoop = true,
        emoteMoving = true,
    }},
    ["carryfoodtray3"] = {"anim@heists@box_carry@", "idle", "Carry Food Tray 3", animationOptions =
    {
        prop = "prop_food_cb_tray_02",
        propBone = 28422,
        propPlacement = {0.0100, -0.0400, -0.1390,20.0000007, 0.0, 0.0},
        emoteLoop = true,
        emoteMoving = true,
        }},
    ["carryfoodtray4"] = {"anim@heists@box_carry@", "idle", "Carry Food Tray 4", animationOptions =
    {
        prop = "prop_food_tray_02",
        propBone = 28422,
        propPlacement = {0.0100, -0.0400, -0.1390,20.0000007, 0.0, 0.0},
        emoteLoop = true,
        emoteMoving = true,
        }},
    ["carryfoodtray5"] = {"anim@heists@box_carry@", "idle", "Carry Food Tray 5", animationOptions =
    {
        prop = "prop_food_tray_03",
        propBone = 28422,
        propPlacement = {0.0100, -0.0400, -0.1390,20.0000007, 0.0, 0.0},
        emoteLoop = true,
        emoteMoving = true,
    }},
    ["carryfoodtray6"] = {"anim@heists@box_carry@", "idle", "Carry Food Tray 6", animationOptions =
    {
        prop = "prop_food_bs_tray_02",
        propBone = 57005,
        propPlacement = {0.2500, 0.1000, 0.0700,-110.5483936, 73.3529273, -16.338362},
        secondProp = "prop_food_bs_tray_03",
        secondPropBone =18905,
        secondPropPlacement = {0.2200, 0.1300, -0.1000, -127.7725487, 110.2074758, -3.5886263},
        emoteLoop = true,
        emoteMoving = true,
    }},
    ["carryfoodtray7"] = {"anim@heists@box_carry@", "idle", "Carry Food Tray 7", animationOptions =
    {
        prop = "prop_food_cb_tray_02",
        propBone = 57005,
        propPlacement = {0.2500, 0.1000, 0.0700,-110.5483936, 73.3529273, -16.338362},
        secondProp = "prop_food_cb_tray_02",
        secondPropBone =18905,
        secondPropPlacement = {0.2200, 0.1300, -0.1000, -127.7725487, 110.2074758, -3.5886263},
        emoteLoop = true,
        emoteMoving = true,
    }},
    ["carryfoodtray8"] = {"anim@heists@box_carry@", "idle", "Carry Food Tray 8", animationOptions =
    {
        prop = "prop_food_tray_02",
        propBone = 57005,
        propPlacement = {0.2500, 0.1000, 0.0700,-110.5483936, 73.3529273, -16.338362},
        secondProp = "prop_food_tray_03",
        secondPropBone =18905,
        secondPropPlacement = {0.2200, 0.1300, -0.1000, -127.7725487, 110.2074758, -3.5886263},
        emoteLoop = true,
        emoteMoving = true,
    }},
    ["carryfoodtraytray9"] = {"anim@heists@box_carry@", "idle", "Carry Food Tray 9", animationOptions =
    {
        prop = "prop_food_tray_02",
        propBone = 57005,
        propPlacement = {0.2500, 0.1000, 0.0700,-110.5483936, 73.3529273, -16.338362},
        secondProp = "prop_food_tray_02",
        secondPropBone =18905,
        secondPropPlacement = {0.2200, 0.1300, -0.1000, -127.7725487, 110.2074758, -3.5886263},
        emoteLoop = true,
        emoteMoving = true,
    }},
    ["carrypizza"] = {"anim@heists@box_carry@", "idle", "Carry Pizza Box", animationOptions =
    {
        prop = "prop_pizza_box_02",
        propBone = 28422,
        propPlacement = {0.0100, -0.1000, -0.1590,20.0000007, 0.0, 0.0},
        emoteLoop = true,
        emoteMoving = true,
    }},
    ["carryfoodbag"] = {"move_weapon@jerrycan@generic", "idle", "Carry Food Bag", animationOptions =
    {
        prop = "prop_food_bs_bag_01",
        propBone = 57005,
        propPlacement = {0.3300, 0.0, -0.0300, 0.0017365, -79.9999997, 110.0651988},
        emoteLoop = true,
        emoteMoving = true,
        }},
    ["carryfoodbag2"] = {"move_weapon@jerrycan@generic", "idle", "Carry Food Bag 2", animationOptions =
    {
        prop = "prop_food_cb_bag_01",
        propBone = 57005,
        propPlacement = {0.3800, 0.0, -0.0300, 0.0017365, -79.9999997, 110.0651988},
        emoteLoop = true,
        emoteMoving = true,
    }},
    ["carryfoodbag3"] = {"move_weapon@jerrycan@generic", "idle", "Carry Food Bag 3", animationOptions =
    {
        prop = "prop_food_bag1",
        propBone = 57005,
        propPlacement = {0.3800, 0.0, -0.0300, 0.0017365, -79.9999997, 110.0651988},
        emoteLoop = true,
        emoteMoving = true,
    }},
    ["toolbox"] = {"move_weapon@jerrycan@generic", "idle", "Toolbox", animationOptions =
    {
        prop = "prop_tool_box_04",
        propBone = 28422,
        propPlacement = {0.3960,0.0410,-0.0030, -90.00, 0.0, 90.00},
        emoteLoop = true,
        emoteMoving = true,
    }},
    ["toolbox2"] = {"move_weapon@jerrycan@generic", "idle", "Toolbox 2", animationOptions =
    {
        prop = "imp_prop_tool_box_01a",
        propBone = 28422,
        propPlacement = {0.3700,0.0200, 0.0, 90.00, 0.0, -90.00},
        emoteLoop = true,
        emoteMoving = true,
    }},
    ["tag"] = {"anim@scripted@freemode@postertag@graffiti_spray@male@", "shake_can_male", "Spray Can Shake Male", animationOptions =
    {
        prop = "prop_cs_spray_can",
        propBone = 28422,
        propPlacement = {0.0, 0.0, 0.0700, 0.0017365, 0.0, 0.0},
        emoteLoop = true,
        emoteMoving = true,
    }},
    ["tag2"] = {"anim@scripted@freemode@postertag@graffiti_spray@heeled@", "shake_can_female", "Spray Can Shake Female", animationOptions =
    {
        prop = "prop_cs_spray_can",
        propBone = 28422,
        propPlacement = {0.0, 0.0, 0.0700, 0.0017365, 0.0, 0.0},
        emoteLoop = true,
        emoteMoving = true,
    }},
    ["tag3"] = {"anim@scripted@freemode@postertag@graffiti_spray@male@", "spray_can_var_01_male", "Spray Male 1", animationOptions =
    {
        prop = "prop_cs_spray_can",
        propBone = 28422,
        propPlacement = {0.0, 0.0, 0.0700, 0.0017365, 0.0, 0.0},
        emoteLoop = true,
        emoteMoving = true,
    }},
    ["tag4"] = {"anim@scripted@freemode@postertag@graffiti_spray@male@", "spray_can_var_02_male", "Spray Male 2", animationOptions =
    {
        prop = "prop_cs_spray_can",
        propBone = 28422,
        propPlacement = {0.0, 0.0, 0.0700, 0.0017365, 0.0, 0.0},
        emoteLoop = true,
        emoteMoving = true,
    }},
    ["tag5"] = {"anim@scripted@freemode@postertag@graffiti_spray@heeled@", "spray_can_var_01_female", "Spray Female 1", animationOptions =
    {
        prop = "prop_cs_spray_can",
        propBone = 28422,
        propPlacement = {0.0, 0.0, 0.0700, 0.0017365, 0.0, 0.0},
        emoteLoop = true,
        emoteMoving = true,
    }},
    ["tag6"] = {"anim@scripted@freemode@postertag@graffiti_spray@heeled@", "spray_can_var_02_female", "Spray Female 2", animationOptions =
    {
        prop = "prop_cs_spray_can",
        propBone = 28422,
        propPlacement = {0.0, 0.0, 0.0700, 0.0017365, 0.0, 0.0},
        emoteLoop = true,
        emoteMoving = true,
    }},
    ["beans"] = {"anim@scripted@island@special_peds@pavel@hs4_pavel_ig5_caviar_p1", "base_idle", "Beans", animationOptions =
    {
        prop = "h4_prop_h4_caviar_tin_01a",
        propBone = 60309,
        propPlacement = {0.0, 0.0300, 0.0100,0.0,0.0,0.0},
        secondProp = "h4_prop_h4_caviar_spoon_01a",
        secondPropBone = 28422,
        secondPropPlacement = {0.0,0.0,0.0,0.0,0.0,0.0},
        emoteLoop = true,
        emoteMoving = true,
    }},
    ["pump"] = {"missfbi4prepp1", "idle", "Pumpkin", animationOptions =
    {
        prop = "prop_veg_crop_03_pump",
        propBone = 28422,
        propPlacement = {0.0200, 0.0600, -0.1200, 0.0, 0.0, 0.0},
        emoteLoop = true,
        emoteMoving = true,
    }},
    ["pump2"] = {"anim@heists@box_carry@", "idle", "Pumpkin 2", animationOptions =
    {
        prop = "prop_veg_crop_03_pump",
        propBone = 28422,
        propPlacement = {0.0100, -0.16000, -0.2100, 0.0, 0.0, 0.0},
        emoteLoop = true,
        emoteMoving = true,
    }},
    ["shit"] = {"missfbi3ig_0", "shit_loop_trev", "Shit", animationOptions =
    {
        prop = "prop_toilet_roll_01",
        propBone = 28422,
        propPlacement = {0.0700, -0.02000, -0.2100, 0,0, 0.0, 0.0},
        secondProp = "prop_big_shit_01",
        secondPropBone = 0,
        secondPropPlacement = {-0.0100, 0.0600, -0.1550, 101.3015175, 7.3512213,-29.2665794},
        emoteLoop = true,
        emoteMoving = false,
    }},
    ["rake"] = {"anim@amb@drug_field_workers@rake@male_a@base", "base", "Rake", animationOptions =
    {
        prop = "prop_tool_rake",
        propBone = 28422,
        propPlacement = {0.0, 0.0, -0.0300, 0.0, 0.0, 0.0},
        emoteLoop = true,
    }},
    ["rake2"] = {"anim@amb@drug_field_workers@rake@male_a@idles", "idle_b", "Rake 2", animationOptions =
    {
        prop = "prop_tool_rake",
        propBone = 28422,
        propPlacement = {0.0, 0.0, -0.0300, 0.0, 0.0, 0.0},
        emoteLoop = true,
    }},
    ["rake3"] = {"anim@amb@drug_field_workers@rake@male_b@base", "base", "Rake 3", animationOptions =
    {
        prop = "prop_tool_rake",
        propBone = 28422,
        propPlacement = {0.0, 0.0, -0.0300, 0.0, 0.0, 0.0},
        emoteLoop = true,
    }},
    ["rake4"] = {"anim@amb@drug_field_workers@rake@male_b@idles", "idle_d", "Rake 4", animationOptions =
    {
        prop = "prop_tool_rake",
        propBone = 28422,
        propPlacement = {0.0, 0.0, -0.0300, 0.0, 0.0, 0.0},
        emoteLoop = true,
    }},
    ["broom"] = {"anim@amb@drug_field_workers@rake@male_a@base", "base", "Broom", animationOptions =
    {
        prop = "prop_tool_broom",
        propBone = 28422,
        propPlacement = {-0.0100, 0.0400, -0.0300, 0.0, 0.0, 0.0},
        emoteLoop = true,
    }},
    ["broom2"] = {"anim@amb@drug_field_workers@rake@male_a@idles", "idle_b", "Broom 2", animationOptions =
    {
        prop = "prop_tool_broom",
        propBone = 28422,
        propPlacement = {-0.0100, 0.0400, -0.0300, 0.0, 0.0, 0.0},
        emoteLoop = true,
    }},
    ["broom3"] = {"anim@amb@drug_field_workers@rake@male_b@base", "base", "Broom 3", animationOptions =
    {
        prop = "prop_tool_broom",
        propBone = 28422,
        propPlacement = {-0.0100, 0.0400, -0.0300, 0.0, 0.0, 0.0},
        emoteLoop = true,
    }},
    ["broom4"] = {"anim@amb@drug_field_workers@rake@male_b@idles", "idle_d", "Broom 4", animationOptions =
    {
        prop = "prop_tool_broom",
        propBone = 28422,
        propPlacement = {-0.0100, 0.0400, -0.0300, 0.0, 0.0, 0.0},
        emoteLoop = true,
    }},
}

cfg.custom = {
    ["divbdance1"] = {"divined@breakdances@new", "divbdance1", "Custom Break Dance 1", animationOptions =
    {
        emoteLoop = true
    }},
    ["divbdance2"] = {"divined@breakdances@new", "divbdance2", "Custom Break Dance 2", animationOptions =
    {
        emoteLoop = true
    }},
    ["divbdance3"] = {"divined@breakdances@new", "divbdance3", "Custom Break Dance 3", animationOptions =
    {
        emoteLoop = true
    }},
    ["divbdance4"] = {"divined@breakdances@new", "divbdance4", "Custom Break Dance 4", animationOptions =
    {
        emoteLoop = true
    }},
    ["divbdance5"] = {"divined@breakdances@new", "divbdance5", "Custom Break Dance 5", animationOptions =
    {
        emoteLoop = true
    }},
    ["divbdance6"] = {"divined@breakdances@new", "divbdance6", "Custom Break Dance 6", animationOptions =
    {
        emoteLoop = true
    }},
    ["divbdance7"] = {"divined@breakdances@new", "divbdance7", "Custom Break Dance 7", animationOptions =
    {
        emoteLoop = true
    }},
    ["divbdance8"] = {"divined@breakdances@new", "divbdance8", "Custom Break Dance 8", animationOptions =
    {
        emoteLoop = true
    }},
    ["divbdance9"] = {"divined@breakdances@new", "divbdance9", "Custom Break Dance 9", animationOptions =
    {
        emoteLoop = true
    }},
    ["divbdance10"] = {"divined@breakdances@new", "divbdance10", "Custom Break Dance 10", animationOptions =
    {
        emoteLoop = true
    }},
    ["divbdance11"] = {"divined@breakdances@new", "divbdance11", "Custom Break Dance 11", animationOptions =
    {
        emoteLoop = true
    }},
    ["divbdance12"] = {"divined@breakdances@new", "divbdance12", "Custom Break Dance 12", animationOptions =
    {
        emoteLoop = true
    }},
    ["divbdance13"] = {"divined@breakdances@new", "divbdance13", "Custom Break Dance 13", animationOptions =
    {
        emoteLoop = true
    }},
    ["divbdance14"] = {"divined@breakdances@new", "divbdance14", "Custom Break Dance 14", animationOptions =
    {
        emoteLoop = true
    }},
    ["divbdance15"] = {"divined@breakdances@new", "divbdance14", "Custom Break Dance 15", animationOptions =
    {
        emoteLoop = true
    }},
        ["dbrdance1"] = {"divined@brdancesv2@new", "dbrdance1", "Custom Dance 1", animationOptions =
    {
        emoteLoop = true
    }},
    ["dbrdance2"] = {"divined@brdancesv2@new", "dbrdance2", "Custom Dance 2", animationOptions =
    {
        emoteLoop = true
    }},
    ["dbrdance3"] = {"divined@brdancesv2@new", "dbrdance3", "Custom Dance 3", animationOptions =
    {
        emoteLoop = true
    }},
    ["dbrdance4"] = {"divined@brdancesv2@new", "dbrdance4", "Custom Dance 4", animationOptions =
    {
        emoteLoop = true
    }},
    ["dbrdance5"] = {"divined@brdancesv2@new", "dbrdance5", "Custom Dance 5", animationOptions =
    {
        emoteLoop = true
    }},
    ["dbrdance6"] = {"divined@brdancesv2@new", "dbrdance6", "Custom Dance 6", animationOptions =
    {
        emoteLoop = true
    }},
    ["dbrdance7"] = {"divined@brdancesv2@new", "dbrdance7", "Custom Dance 7", animationOptions =
    {
        emoteLoop = true
    }},
    ["dbrdance8"] = {"divined@brdancesv2@new", "dbrdance8", "Custom Dance 8", animationOptions =
    {
        emoteLoop = true
    }},
    ["dbrdance9"] = {"divined@brdancesv2@new", "dbrdance9", "Custom Dance 9", animationOptions =
    {
        emoteLoop = true
    }},
    ["dbrdance10"] = {"divined@brdancesv2@new", "dbrdance10", "Custom Dance 10", animationOptions =
    {
        emoteLoop = true
    }},
    ["dbrdance11"] = {"divined@brdancesv2@new", "dbrdance11", "Custom Dance 11", animationOptions =
    {
        emoteLoop = true
    }},
    ["dbrdance12"] = {"divined@brdancesv2@new", "dbrdance12", "Custom Dance 12", animationOptions =
    {
        emoteLoop = true
    }},
    ["backflip"] = {"divined@fighting@new", "backflip", "Custom Backflip", animationOptions =
    {
        emoteLoop = true,
    }},
    ["crouchstand"] = {"divined@fighting@new", "crouchstand", "Custom Crouch Stand", animationOptions =
    {
        emoteLoop = true,
    }},
    ["diefallback"] = {"divined@fighting@new", "diefallback", "Custom Die Fall Back", animationOptions =
    {
        emoteLoop = true,
    }},
    ["diefromback"] = {"divined@fighting@new", "diefromback", "Custom Die From Back", animationOptions =
    {
        emoteLoop = true,
    }},
    ["femalewalk"] = {"divined@fighting@new", "femalewalk", "Custom Female Arms", animationOptions =
    {
        emoteLoop = true,
        emoteMoving = true,
    }},
    ["fistsup1"] = {"divined@fighting@new", "fistsup1", "Custom Fists Up 1", animationOptions =
    {
        emoteLoop = true,
    }},
    ["fistsup2"] = {"divined@fighting@new", "fistsup2", "Custom Fists Up 2", animationOptions =
    {
        emoteLoop = true,
    }},
    ["fistsup3"] = {"divined@fighting@new", "fistsup3", "Custom Fists Up 2", animationOptions =
    {
        emoteLoop = true,
    }},
    ["hitback"] = {"divined@fighting@new", "hitback", "Custom Hit From Back", animationOptions =
    {
        emoteLoop = true,
    }},
    ["hitbackhead"] = {"divined@fighting@new", "hitbackhead", "Custom Head Hit", animationOptions =
    {
        emoteLoop = true,
    }},
    ["injuredarm"] = {"divined@fighting@new", "injuredarm", "Custom Injured Arm", animationOptions =
    {
        emoteLoop = true,
        emoteMoving = true,
    }},
    ["jumpingjacks"] = {"divined@fighting@new", "jumpingjacks", "Custom Jumping Jacks", animationOptions =
    {
        emoteLoop = true,
    }},
    ["mmakick"] = {"divined@fighting@new", "mmakick", "MMA Kick", animationOptions =
    {
        emoteLoop = true,
    }},
        ["pickingfruit"] = {"divined@fighting@new", "pickingfruit", "Custom Picking", animationOptions =
    {
        emoteLoop = true,
        emoteMoving = true,
    }},
        ["sitlaughing"] = {"divined@fighting@new", "sitlaughing", "Custom Sit Laughing", animationOptions =
    {
        emoteLoop = true,
    }},
        ["standdie"] = {"divined@fighting@new", "standdie", "Custom Die Standing", animationOptions =
    {
        emoteLoop = true,
    }},
        ["strutwalk"] = {"divined@fighting@new", "strutwalk", "Custom Strut Walk", animationOptions =
    {
        emoteLoop = true,
        emoteMoving = true,
    }},
        ["stunned"] = {"divined@fighting@new", "stunned", "Custom Stunned", animationOptions =
    {
        emoteLoop = true,
    }},
        ["textingwalk"] = {"divined@fighting@new", "textingwalk", "Custom Texting Walk", animationOptions =
    {
        emoteLoop = true,
        emoteMoving = true,
    }},
        ["tripping"] = {"divined@fighting@new", "tripping", "Custom Tripping", animationOptions =
    {
        emoteLoop = true,
    }},
        ["divdance1"] = {"divined@dancesv2@new", "divdance1", "Custom Dance 13", animationOptions =
    {
        emoteLoop = true
    }},
    ["divdance2"] = {"divined@dancesv2@new", "divdance2", "Custom Dance 14", animationOptions =
    {
        emoteLoop = true
    }},
    ["divdance3"] = {"divined@dancesv2@new", "divdance3", "Custom Dance 15", animationOptions =
    {
        emoteLoop = true
    }},
    ["divdance4"] = {"divined@dancesv2@new", "divdance4", "Custom Dance 16", animationOptions =
    {
        emoteLoop = true
    }},
    ["divdance5"] = {"divined@dancesv2@new", "divdance5", "Custom Dance 17", animationOptions =
    {
        emoteLoop = true
    }},
    ["divdance6"] = {"divined@dancesv2@new", "divdance6", "Custom Dance 18", animationOptions =
    {
        emoteLoop = true
    }},
    ["divdance7"] = {"divined@dancesv2@new", "divdance7", "Custom Dance 19", animationOptions =
    {
        emoteLoop = true
    }},
    ["divdance8"] = {"divined@dancesv2@new", "divdance8", "Custom Dance 20", animationOptions =
    {
        emoteLoop = true
    }},
    ["divdance9"] = {"divined@dancesv2@new", "divdance9", "Custom Dance 21", animationOptions =
    {
        emoteLoop = true
    }},
    ["divdance10"] = {"divined@dancesv2@new", "divdance10", "Custom Dance 22", animationOptions =
    {
        emoteLoop = true
    }},
    ["divdance11"] = {"divined@dancesv2@new", "divdance11", "Custom Dance 23", animationOptions =
    {
        emoteLoop = true
    }},
    ["divdance12"] = {"divined@dancesv2@new", "divdance12", "Custom Dance 24", animationOptions =
    {
        emoteLoop = true
    }},
    ["divdance13"] = {"divined@dancesv2@new", "divdance13", "Custom Dance 25", animationOptions =
    {
        emoteLoop = true
    }},
    ["divdance14"] = {"divined@dancesv2@new", "divdance14", "Custom Dance 26", animationOptions =
    {
        emoteLoop = true
    }},
        ["dbdance1"] = {"divined@fndances@new", "dbdance1", "Mdance", animationOptions =
    {
        emoteLoop = true,
    }},
    ["dbdance2"] = {"divined@fndances@new", "dbdance2", "A1 Dance", animationOptions =
    {
        emoteLoop = true,
    }},
    ["dbdance3"] = {"divined@fndances@new", "dbdance3", "Boogie Down", animationOptions =
    {
        emoteLoop = true,
    }},
    ["dbdance4"] = {"divined@fndances@new", "dbdance4", "Break Boy", animationOptions =
    {
        emoteLoop = true,
    }},
    ["dbdance5"] = {"divined@fndances@new", "dbdance5", "Breakfast Coffee Dance", animationOptions =
    {
        emoteLoop = true,
    }},
    ["dbdance6"] = {"divined@fndances@new", "dbdance6", "Candy Dance", animationOptions =
    {
        emoteLoop = true,
    }},
    ["dbdance7"] = {"divined@fndances@new", "dbdance7", "Cheerleader Dance", animationOptions =
    {
        emoteLoop = true,
    }},
    ["dbdance8"] = {"divined@fndances@new", "dbdance8", "Crab Dance", animationOptions =
    {
        emoteLoop = true,
    }},
    ["dbdance9"] = {"divined@fndances@new", "dbdance9", "Eastern Blocc", animationOptions =
    {
        emoteLoop = true,
    }},
        ["dbdance10"] = {"divined@fndances@new", "dbdance10", "Electro Swing", animationOptions =
    {
        emoteLoop = true,
    }},
        ["dbdance11"] = {"divined@fndances@new", "dbdance11", "Electro Shuffle", animationOptions =
    {
        emoteLoop = true,
    }},
    ["dbdance12"] = {"divined@fndances@new", "dbdance12", "Floss", animationOptions =
    {
        emoteLoop = true,
    }},
    ["dbdance13"] = {"divined@fndances@new", "dbdance13", "Grooving Jam", animationOptions =
    {
        emoteLoop = true,
    }},
    ["dbdance14"] = {"divined@fndances@new", "dbdance14", "Hillbilly Shuffle", animationOptions =
    {
        emoteLoop = true,
    }},
    ["dbdance15"] = {"divined@fndances@new", "dbdance15", "Laser Dance", animationOptions =
    {
        emoteLoop = true,
    }},
    ["dbdance16"] = {"divined@fndances@new", "dbdance16", "Ribbon Dance", animationOptions =
    {
        emoteLoop = true,
    }},
    ["dbdance17"] = {"divined@fndances@new", "dbdance17", "Running Man", animationOptions =
    {
        emoteLoop = true,
    }},
    ["dbdance18"] = {"divined@fndances@new", "dbdance18", "Step Breakdance", animationOptions =
    {
        emoteLoop = true,
    }},
    ["dbdance19"] = {"divined@fndances@new", "dbdance19", "Cowboy Dance", animationOptions =
    {
        emoteLoop = true,
    }},
    ["dbdance20"] = {"divined@fndances@new", "dbdance20", "Egyptian Dance", animationOptions =
    {
        emoteLoop = true,
    }},
    ["dbdance21"] = {"divined@fndances@new", "dbdance21", "Swipe It", animationOptions =
    {
        emoteLoop = true,
    }},
    ["dfdance1"] = {"divined@fndances2@new", "dfdance1", "Warehouse Dance", animationOptions =
    {
        emoteLoop = true,
    }},
    ["dfdance2"] = {"divined@fndances2@new", "dfdance2", "Breakdance", animationOptions =
    {
        emoteLoop = true,
    }},
    ["dfdance3"] = {"divined@fndances2@new", "dfdance3", "Treadmill", animationOptions =
    {
        emoteLoop = true,
    }},
    ["dfdance4"] = {"divined@fndances2@new", "dfdance4", "Shoot Dance", animationOptions =
    {
        emoteLoop = true,
    }},
    ["dfdance5"] = {"divined@fndances2@new", "dfdance5", "Swim Dance", animationOptions =
    {
        emoteLoop = true,
    }},
    ["dfdance6"] = {"divined@fndances2@new", "dfdance6", "Jumpstyle Dance", animationOptions =
    {
        emoteLoop = true,
    }},
    ["dfdance7"] = {"divined@fndances2@new", "dfdance7", "GOAT Dance", animationOptions =
    {
        emoteLoop = true,
    }},
    ["dfdance8"] = {"divined@fndances2@new", "dfdance8", "Glowstick Dance", animationOptions =
    {
        emoteLoop = true,
    }},
    ["dfdance9"] = {"divined@fndances2@new", "dfdance9", "Crazy Dance", animationOptions =
    {
        emoteLoop = true,
    }},
    ["dfdance10"] = {"divined@fndances2@new", "dfdance10", "Goth Swing", animationOptions =
    {
        emoteLoop = true,
    }},
    ["dfdance11"] = {"divined@fndances2@new", "dfdance11", "Wave Dance", animationOptions =
    {
        emoteLoop = true,
    }},
    ["dfdance12"] = {"divined@fndances2@new", "dfdance12", "Pumpkin Dance", animationOptions =
    {
        emoteLoop = true,
    }},
    ["dfdance13"] = {"divined@fndances2@new", "dfdance13", "Wiggly Dance", animationOptions =
    {
        emoteLoop = true,
    }},
    ["dfdance14"] = {"divined@fndances2@new", "dfdance14", "Indian Shuffle", animationOptions =
    {
        emoteLoop = true,
    }},
    ["dfdance15"] = {"divined@fndances2@new", "dfdance15", "Salton Lake Dance", animationOptions =
    {
        emoteLoop = true,
    }},
    ["dfdance16"] = {"divined@fndances2@new", "dfdance16", "Gwara Dance", animationOptions =
    {
        emoteLoop = true,
    }},
    ["dfdance17"] = {"divined@fndances2@new", "dfdance17", "Zippy Dance", animationOptions =
    {
        emoteLoop = true,
    }},
    ["dfdance18"] = {"divined@fndances2@new", "dfdance18", "Dance", animationOptions =
    {
        emoteLoop = true,
    }},
    ["dfdance19"] = {"divined@fndances2@new", "dfdance19", "String Dance", animationOptions =
    {
        emoteLoop = true,
    }},
    ["dfdance20"] = {"divined@fndances2@new", "dfdance20", "Loser Dance", animationOptions =
    {
        emoteLoop = true,
    }},
        ["drdance1"] = {"divined@randomdances@new", "drdance1", "Gymnastics Dance", animationOptions =
    {
        emoteLoop = true,
    }},
    ["drdance2"] = {"divined@randomdances@new", "drdance2", "House Dance", animationOptions =
    {
        emoteLoop = true,
    }},
    ["drdance3"] = {"divined@randomdances@new", "drdance3", "Autumn Dance", animationOptions =
    {
        emoteLoop = true,
    }},
    ["drdance4"] = {"divined@randomdances@new", "drdance4", "Ballet Move", animationOptions =
    {
        emoteLoop = true,
    }},
    ["drdance5"] = {"divined@randomdances@new", "drdance5", "Ballet Spin", animationOptions =
    {
        emoteLoop = true,
    }},
    ["drdance6"] = {"divined@randomdances@new", "drdance6", "Bhangra Dance", animationOptions =
    {
        emoteLoop = true,
    }},
    ["drdance7"] = {"divined@randomdances@new", "drdance7", "Photo Dance", animationOptions =
    {
        emoteLoop = true,
    }},
    ["drdance8"] = {"divined@randomdances@new", "drdance8", "Smooth Dance", animationOptions =
    {
        emoteLoop = true,
    }},
    ["drdance9"] = {"divined@randomdances@new", "drdance9", "Bouncy Dance", animationOptions =
    {
        emoteLoop = true,
    }},
    ["drdance10"] = {"divined@randomdances@new", "drdance10", "DJ Dance", animationOptions =
    {
        emoteLoop = true,
    }},
    ["drdance11"] = {"divined@randomdances@new", "drdance11", "Hoppin", animationOptions =
    {
        emoteLoop = true,
    }},
    ["drdance12"] = {"divined@randomdances@new", "drdance12", "Pop Dance", animationOptions =
    {
        emoteLoop = true,
    }},
    ["drdance13"] = {"divined@randomdances@new", "drdance13", "Pop Dance 2", animationOptions =
    {
        emoteLoop = true,
    }},
    ["drdance14"] = {"divined@randomdances@new", "drdance14", "Pop Dance 3", animationOptions =
    {
        emoteLoop = true,
    }},
    ["drdance15"] = {"divined@randomdances@new", "drdance15", "Mixed Dance", animationOptions =
    {
        emoteLoop = true,
    }},
    ["drdance16"] = {"divined@randomdances@new", "drdance16", "Raise The Roof", animationOptions =
    {
        emoteLoop = true,
    }},
    ["drdance17"] = {"divined@randomdances@new", "drdance17", "Rick Astley Dance", animationOptions =
    {
        emoteLoop = true,
    }},
    ["drdance18"] = {"divined@randomdances@new", "drdance18", "Splits", animationOptions =
    {
        emoteLoop = true,
    }},
    ["banddance"] = {"divined@tdances@new", "dtdance1", "Band Dance", animationOptions =
    {
        emoteLoop = true,
    }},
    ["bopdance"] = {"divined@tdances@new", "dtdance2", "Bop", animationOptions =
    {
        emoteLoop = true,
    }},
    ["bboydance"] = {"divined@tdances@new", "dtdance3", "BBoy Dance", animationOptions =
    {
        emoteLoop = true,
    }},
    ["capoeiramove"] = {"divined@tdances@new", "dtdance4", "Capoeira Move", animationOptions =
    {
        emoteLoop = true,
    }},
    ["hiphopdance"] = {"divined@tdances@new", "dtdance5", "Hip Hop Dance", animationOptions =
    {
        emoteLoop = true,
    }},
    ["hipsterdance"] = {"divined@tdances@new", "dtdance6", "Hipster Dance", animationOptions =
    {
        emoteLoop = true,
    }},
    ["hippiedance"] = {"divined@tdances@new", "dtdance7", "Hippie Dance", animationOptions =
    {
        emoteLoop = true,
    }},
    ["hiphoptaunt"] = {"divined@tdances@new", "dtdance8", "Hip Hop Taunt", animationOptions =
    {
        emoteLoop = true,
    }},
    ["hilowave"] = {"divined@tdances@new", "dtdance9", "Hi Lo Wave", animationOptions =
    {
        emoteLoop = true,
    }},
    ["squaredance"] = {"divined@tdances@new", "dtdance10", "Square Dance", animationOptions =
    {
        emoteLoop = true,
    }},
    ["hotdance"] = {"divined@tdances@new", "dtdance11", "Hot Dance", animationOptions =
    {
        emoteLoop = true,
    }},
    ["hulahula"] = {"divined@tdances@new", "dtdance12", "Hula-Hula", animationOptions =
    {
        emoteLoop = true,
    }},
    ["dabloop"] = {"divined@tdances@new", "dtdance13", "Dab Loop", animationOptions =
    {
        emoteLoop = true,
    }},
    ["kingdance"] = {"divined@tdances@new", "dtdance14", "The King's Dance", animationOptions =
    {
        emoteLoop = true,
    }},
    ["linedance"] = {"divined@tdances@new", "dtdance15", "Dance Line", animationOptions =
    {
        emoteLoop = true,
    }},
    ["magicman"] = {"divined@tdances@new", "dtdance16", "Magic Man", animationOptions =
    {
        emoteLoop = true,
    }},
    ["marat"] = {"divined@tdances@new", "dtdance17", "Marat", animationOptions =
    {
        emoteLoop = true,
    }},
    ["maskoff"] = {"divined@tdances@new", "dtdance18", "Mask Off", animationOptions =
    {
        emoteLoop = true,
    }},
    ["mellow"] = {"divined@tdances@new", "dtdance19", "Mellow", animationOptions =
    {
        emoteLoop = true,
    }},
    ["showroomdance"] = {"divined@tdances@new", "dtdance20", "Showroom Dance", animationOptions =
    {
        emoteLoop = true,
    }},
    ["windmillfloss"] = {"divined@tdances@new", "dtdance21", "Windmill Floss", animationOptions =
    {
        emoteLoop = true,
    }},
    ["woahdance"] = {"divined@tdances@new", "dtdance22", "Woah", animationOptions =
    {
        emoteLoop = true,
    }},
    ["corkscrew"] = {"mikey@acrobatics@new", "corkscrew", "Corkscrew", animationOptions =
    {
        emoteLoop = true
    }},
    ["corkscrew2"] = {"mikey@acrobatics@new", "corkscrew2", "Corkscrew 2", animationOptions =
    {
        emoteLoop = true
    }},
    ["prop_flip"] = {"mikey@acrobatics@new", "prop_flip", "Prop Flip", animationOptions =
    {
        emoteLoop = true
    }},
    ["runfrontflip"] = {"mikey@acrobatics@new", "runfrontflip", "Run Front Flip", animationOptions =
    {
        emoteLoop = true
    }},
    ["runwallbackflip"] = {"mikey@acrobatics@new", "runwallbackflip", "Run Wall Back Flip", animationOptions =
    {
        emoteLoop = true
    }},
    ["spin_kickflip"] = {"mikey@acrobatics@new", "spin_kick_flip", "Spin Kick Flip", animationOptions =
    {
        emoteLoop = true
    }},
    ["standingbackflip"] = {"mikey@acrobatics@new", "standingbackflip", "Standing Back Flip", animationOptions =
    {
        emoteLoop = true
    }},
    ["steeze_backflip"] = {"mikey@acrobatics@new", "steeze_backflip", "Steeze Back Flip", animationOptions =
    {
        emoteLoop = true
    }},
    ["twistflip"] = {"mikey@acrobatics@new", "twistflip", "Twistflip", animationOptions =
    {
        emoteLoop = true
    }},
    ["mdance1"] = {"mikey@dances@new", "mdance1", "Custom Dance 27", animationOptions =
    {
        emoteLoop = true
    }},
    ["mdance2"] = {"mikey@dances@new", "mdance2", "Custom Dance 28", animationOptions =
    {
        emoteLoop = true
    }},
    ["mdance3"] = {"mikey@dances@new", "mdance3", "Custom Dance 29", animationOptions =
    {
        emoteLoop = true
    }},
    ["mdance4"] = {"mikey@dances@new", "mdance4", "Custom Dance 30", animationOptions =
    {
        emoteLoop = true
    }},
    ["mdance5"] = {"mikey@dances@new", "mdance5", "Custom Dance 31", animationOptions =
    {
        emoteLoop = true
    }},
    ["mdance6"] = {"mikey@dances@new", "mdance6", "Custom Dance 32", animationOptions =
    {
        emoteLoop = true
    }},
    ["mdance7"] = {"mikey@dances@new", "mdance7", "Custom Dance 33", animationOptions =
    {
        emoteLoop = true
    }},
    ["mdance8"] = {"mikey@dances@new", "mdance8", "Custom Dance 34", animationOptions =
    {
        emoteLoop = true
    }},
    ["mdance9"] = {"mikey@dances@new", "mdance9", "Custom Dance 35", animationOptions =
    {
        emoteLoop = true
    }},
    ["mdance10"] = {"mikey@dances@new", "mdance10", "Custom Dance 36", animationOptions =
    {
        emoteLoop = true
    }},
    ["mdance11"] = {"mikey@dances@new", "mdance11", "Custom Dance 37", animationOptions =
    {
        emoteLoop = true
    }},
    ["mdance12"] = {"mikey@dances@new", "mdance12", "Custom Dance 38", animationOptions =
    {
        emoteLoop = true
    }},
    ["mdance13"] = {"mikey@dances@new", "mdance13", "Custom Dance 39", animationOptions =
    {
        emoteLoop = true
    }},
    ["mdance14"] = {"mikey@dances@new", "mdance14", "Custom Dance 40", animationOptions =
    {
        emoteLoop = true
    }},
    ["mgangsign_1"] = {"mikey@gangsigns@new", "mgangsign_1", "Gangsign 1", animationOptions =
    {
        emoteLoop = true,
        emoteMoving = true,
    }},
    ["mgangsign_2"] = {"mikey@gangsigns@new", "mgangsign_2", "Gangsign 2", animationOptions =
    {
        emoteLoop = true,
        emoteMoving = true,
    }},
    ["mgangsign_3"] = {"mikey@gangsigns@new", "mgangsign_3", "Gangsign 3", animationOptions =
    {
        emoteLoop = true,
        emoteMoving = true,
    }},
    ["mgangsign_4"] = {"mikey@gangsigns@new", "mgangsign_4", "Gangsign 4", animationOptions =
    {
        emoteLoop = true,
        emoteMoving = true,
    }},
    ["mgangsign_5"] = {"mikey@gangsigns@new", "mgangsign_5", "Gangsign 5", animationOptions =
    {
        emoteLoop = true,
        emoteMoving = true,
    }},
    ["mgangsign_6"] = {"mikey@gangsigns@new", "mgangsign_6", "Gangsign 6", animationOptions =
    {
        emoteLoop = true,
        emoteMoving = true,
    }},
    ["mgangsign_7"] = {"mikey@gangsigns@new", "mgangsign_7", "Gangsign 7", animationOptions =
    {
        emoteLoop = true,
        emoteMoving = true,
    }},
    ["mgangsign_8"] = {"mikey@gangsigns@new", "mgangsign_8", "Gangsign 8", animationOptions =
    {
        emoteLoop = true,
        emoteMoving = true,
    }},
    ["mgangsign_9"] = {"mikey@gangsigns@new", "mgangsign_9", "Gangsign 9", animationOptions =
    {
        emoteLoop = true,
        emoteMoving = true,
    }},
    ["mgangsign_10"] = {"mikey@gangsigns@new", "mgangsign_10", "Gangsign 10", animationOptions =
    {
        emoteLoop = true,
        emoteMoving = true,
    }},
    ["mgangsign_11"] = {"mikey@gangsigns@new", "mgangsign_11", "Gangsign 11", animationOptions =
    {
        emoteLoop = true,
        emoteMoving = true,
    }},
    ["mgangsigns_1"] = {"mikey@gangsigns2@new", "mgangsigns_1", "Gangsign 1", animationOptions =
    {
        emoteLoop = true,
    }},
    ["mgangsigns_2"] = {"mikey@gangsigns2@new", "mgangsigns_2", "Gangsign 2", animationOptions =
    {
        emoteLoop = true,
    }},
    ["mgangsigns_3"] = {"mikey@gangsigns2@new", "mgangsigns_3", "Gangsign 3", animationOptions =
    {
        emoteLoop = true,
    }},
    ["mgangsigns_4"] = {"mikey@gangsigns2@new", "mgangsigns_4", "Gangsign 4", animationOptions =
    {
        emoteLoop = true,
    }},
    ["mgangsigns_5"] = {"mikey@gangsigns2@new", "mgangsigns_5", "Gangsign 5", animationOptions =
    {
        emoteLoop = true,
    }},
    ["mgangsigns_6"] = {"mikey@gangsigns2@new", "mgangsigns_6", "Gangsign 6", animationOptions =
    {
        emoteLoop = true,
    }},
    ["mgangsigns_7"] = {"mikey@gangsigns2@new", "mgangsigns_7", "Gangsign 7", animationOptions =
    {
        emoteLoop = true,
    }},
    ["mgangsigns_8"] = {"mikey@gangsigns2@new", "mgangsigns_8", "Gangsign 8", animationOptions =
    {
        emoteLoop = true,
    }},
    ["mgangsigns_9"] = {"mikey@gangsigns2@new", "mgangsigns_9", "Gangsign 9", animationOptions =
    {
        emoteLoop = true,
    }},
    ["gesture_doublepoint"] = {"mikey@gestures@new", "gesture_doublepoint", "Come At Me", animationOptions =
    {
        emoteLoop = true
    }},
    ["gesture_dramaticpoint"] = {"mikey@gestures@new", "gesture_dramaticpoint", "Dramatic Point", animationOptions =
    {
        emoteLoop = true
    }},
    ["gesture_flex"] = {"mikey@gestures@new", "gesture_flex", "Flex Arms", animationOptions =
    {
        emoteLoop = true
    }},
    ["gesture_icant"] = {"mikey@gestures@new", "gesture_icant", "Fall Back", animationOptions =
    {
        emoteLoop = true
    }},
    ["gesture_loser"] = {"mikey@gestures@new", "gesture_loser", "Loser", animationOptions =
    {
        emoteLoop = true
    }},
    ["gesture_salute"] = {"mikey@gestures@new", "gesture_salute", "Salute", animationOptions =
    {
        emoteLoop = true
    }},
    ["gesture_taunt"] = {"mikey@gestures@new", "gesture_taunt", "Slit Throat", animationOptions =
    {
        emoteLoop = true
    }},
    ["gesture_victory"] = {"mikey@gestures@new", "gesture_victory", "Victory Cheer", animationOptions =
    {
        emoteLoop = true
    }},
    ["gesture_wave"] = {"mikey@gestures@new", "gesture_wave", "Wave", animationOptions =
    {
        emoteLoop = true
    }},
    ["gesture_whatever"] = {"mikey@gestures@new", "gesture_whatever", "Shrug", animationOptions =
    {
        emoteLoop = true
    }},
    ["followa"] = {"dollie_mods@follow_me_001", "follow_me_001", "Follow A (Front)", animationOptions =
    {
        emoteLoop = true,
        emoteMoving = false
    }},
    ["followb"] = {"dollie_mods@follow_me_002", "follow_me_002", "Follow B (Back)", animationOptions =
    {
        emoteLoop = true
    }},
    ["csdog2"] = {"misssnowie@little_doggy_lying_down", "base", "Small Dog Carried", animationOptions =
    {
        emoteMoving = false,
        emoteLoop = true
    }},
    ["csdog3"] = {"hooman@hugging_little_doggy", "base", "Carry Small Dog 2", animationOptions =
    {
        emoteMoving = true,
        emoteLoop = true
    }},
    ["csdog4"] = {"little_doggy@hugging_hooman", "base", "Small Dog Carried 2", animationOptions =
    {
        emoteMoving = false,
        emoteLoop = true
    }},
    ["hhands"] = {"misssnowie@hearthands", "base", "Heart Hands", animationOptions =
    {
        emoteLoop = true,
        emoteMoving = true
    }},
    ["selfiecrouch"] = {"crouching@taking_selfie", "base", "Selfie Crouching", animationOptions =
    {
        prop = "prop_phone_ing",
        propBone = 18905,
        propPlacement = {0.1580,0.0180,0.0300,-150.4798,-67.8240,-46.0417},
        emoteLoop = true,
        emoteMoving = false,
        ptfxAsset = "scr_tn_meet",
        ptfxName = "scr_tn_meet_phone_camera_flash",
        ptfxPlacement = {-0.015,0.0,0.041,0.0,0.0,0.0,1.0},
        ptfxInfo = "Press ~y~G~w~ to flash camera.",
        ptfxWait = 200
    }},
    ["surfboard"] = {"beachanims@molly", "beachanim_surf_clip", "Surf Board", animationOptions =
    {
        prop = "prop_surf_board_01",
        propBone = 28252,
        propPlacement = {0.1020,-0.1460,-0.1160,-85.5416,176.1446,-2.1500},
        emoteLoop = true,
        emoteMoving = true
    }},
    ["stealtv"] = {"beachanims@molly", "beachanim_surf_clip", "Steal TV", animationOptions =
    {
        prop = "xs_prop_arena_screen_tv_01",
        propBone = 28252,
        propPlacement = {0.2600,0.1100,-0.1400,96.1620,168.9069,84.2402},
        emoteLoop = true,
        emoteMoving = true
    }},
    ["beachring"] = {"beachanims@free", "beachanim_clip", "Beach Floatie Thingy", animationOptions =
    {
        prop = "prop_beach_ring_01",
        propBone = 0,
        propPlacement = {0.0,0.0,0.0100,-12.0,0.0,-2.0},
        emoteLoop = true,
        emoteMoving = true
    }},
    ["sitchairf"] = {"mouse@femalearmchair", "female_armchair_clip_01", "Sit Chair - Armchair", animationOptions =
    {
        prop = "p_armchair_01_s",
        propBone = 11816,
        propPlacement = {0.5320,-0.3310,0.2000,-90.0000,-180.0000,-40.9999},
        emoteLoop = true,
        emoteMoving = false
    }},
    ["sitchairf2"] = { "mouse@female_sitting_folded", "female_sitting_folded_clip", "Sit Chair - Arms Folded", animationOptions =
    {
        prop = "ba_prop_battle_club_chair_03",
        propBone = 0,
        propPlacement = {0.0,0.0,0.0,0.0,0.0,-170.0000},
        emoteLoop = true,
        emoteMoving = false
    }},
    ["sitchairf3"] = {"mouse@female_sitting_forward", "female_sitting_forward_clip", "Sit Chair - Leaning Forward", animationOptions =
    {
        prop = "ba_prop_battle_club_chair_03",
        propBone = 0,
        propPlacement = {0.0,0.0,0.0,0.0,0.0,-170.0000},
        emoteLoop = true,
        emoteMoving = false
    }},
    ["sitchairf4"] = {"mouse@female_smart_sitting", "female_smart_sitting_clip", "Sit Chair - Smart", animationOptions =
    {
        prop = "ba_prop_battle_club_chair_03",
        propBone = 0,
        propPlacement = {0.0,0.0,0.0,0.0,0.0,-170.0000},
        emoteLoop = true,
        emoteMoving = false
    }},
    ["sitchairf5"] = {"mouse@female_smart_sitting_crossed", "female_smart_sitting_crossed_clip", "Sit Chair - Legs Crossed", animationOptions =
    {
        prop = "ba_prop_battle_club_chair_03",
        propBone = 0,
        propPlacement = {0.0,0.0,0.0,0.0,0.0,-170.0000},
        emoteLoop = true,
        emoteMoving = false
    }},
    ["sitchairf6"] = {"mouse@female_sitting_laptop", "female_sitting_laptop_clip", "Sit Chair - Laptop", animationOptions =
    {
        prop = "ba_prop_club_laptop_dj_02",
        propBone = 57005,
        propPlacement = {0.0860,-0.1370,-0.1750,-79.9999,-90.0000,0.0000},
        secondProp = "ba_prop_battle_club_chair_02",
        secondPropBone = 0,
        secondPropPlacement = {-0.0400,-0.1900,0.0000,-180.0000,-180.0000,9.0999},
        emoteLoop = true,
        emoteMoving = false
    }},
    ["sitchairf7"] = {"mouse@female_sitting_tablet", "female_sitting_tablet_clip", "Sit Chair - Tablet", animationOptions =
    {
        prop = "hei_prop_dlc_tablet",
        propBone = 28422,
        propPlacement = {0.0870,0.1030,-0.1240,144.3540,157.8527,-4.6318},
        secondProp = "ba_prop_battle_club_chair_02",
        secondPropBone = 0,
        secondPropPlacement = {0.0100,-0.0800,0.0200,150.0000,-180.0000,10.0000},
        emoteLoop = true,
        emoteMoving = false
    }},
    ["sitchairf8"] = {"mouse@female_sitting_tablet", "female_sitting_tablet_clip", "Sit Chair - Book", animationOptions =
    {
        prop = "v_ilev_mp_bedsidebook",
        propBone = 28422,
        propPlacement = {0.1300,0.1100,-0.1200,120.3356,-15.9891,26.1497},
        secondProp = "ba_prop_battle_club_chair_02",
        secondPropBone = 0,
        secondPropPlacement = {0.0100,-0.0800,0.0200,150.0000,-180.0000,10.0000},
        emoteLoop = true,
        emoteMoving = false
    }},
    ["selfiecrouch2"] = {"eagle@girlphonepose13", "girl", "Selfie Crouching 2", animationOptions =
    {
        prop = "prop_phone_ing",
        propBone = 60309,
        propPlacement = {0.0670,0.0300,0.0300,-90.0000,0.0000,-25.9000},
        emoteLoop = true,
        emoteMoving = false,
        ptfxAsset = "scr_tn_meet",
        ptfxName = "scr_tn_meet_phone_camera_flash",
        ptfxPlacement = {-0.015,0.0,0.041,0.0,0.0,0.0,1.0},
        ptfxInfo = "Press ~y~G~w~ to flash camera.",
        ptfxWait = 200
    }},
    ["dancepride"] = {"anim@amb@nightclub@lazlow@hi_railing@", "ambclub_09_mi_hi_bellydancer_laz", "Dance Pride A", animationOptions =
    {
        prop = "lilprideflag1",
        propBone = 18905,
        propPlacement = {0.0900,0.0000,0.0300,-39.911,93.9166,-5.8062},
        secondProp = "lilprideflag1",
        secondPropBone = 57005,
        secondPropPlacement = {0.0900,-0.0200,-0.0300,-90.2454,5.7068,-28.7797},
        emoteLoop = true,
        emoteMoving = false
    }},
    ["danceprideb"] = {"anim@amb@nightclub@lazlow@hi_railing@", "ambclub_09_mi_hi_bellydancer_laz", "Dance Pride B - LGBTQIA", animationOptions =
    {
        prop = "lilprideflag2",
        propBone = 18905,
        propPlacement = {0.0900,0.0000,0.0300,-39.911,93.9166,-5.8062},
        secondProp = "lilprideflag2",
        secondPropBone = 57005,
        secondPropPlacement = {0.0900,-0.0200,-0.0300,-90.2454,5.7068,-28.7797},
        emoteLoop = true,
        emoteMoving = false
    }},
    ["dancepridec"] = {"anim@amb@nightclub@lazlow@hi_railing@", "ambclub_09_mi_hi_bellydancer_laz", "Dance Pride C - Bisexual", animationOptions =
    {
        prop = "lilprideflag3",
        propBone = 18905,
        propPlacement = {0.0900,0.0000,0.0300,-39.911,93.9166,-5.8062},
        secondProp = "lilprideflag3",
        secondPropBone = 57005,
        secondPropPlacement = {0.0900,-0.0200,-0.0300,-90.2454,5.7068,-28.7797},
        emoteLoop = true,
        emoteMoving = false
    }},
    ["danceprided"] = {"anim@amb@nightclub@lazlow@hi_railing@", "ambclub_09_mi_hi_bellydancer_laz", "Dance Pride D - Pansexual", animationOptions =
    {
        prop = "lilprideflag5",
        propBone = 18905,
        propPlacement = {0.0900,0.0000,0.0300,-39.911,93.9166,-5.8062},
        secondProp = "lilprideflag5",
        secondPropBone = 57005,
        secondPropPlacement = {0.0900,-0.0200,-0.0300,-90.2454,5.7068,-28.7797},
        emoteLoop = true,
        emoteMoving = false
    }},
    ["dancepridee"] = {"anim@amb@nightclub@lazlow@hi_railing@", "ambclub_09_mi_hi_bellydancer_laz", "Dance Pride E - Transexual", animationOptions =
    {
        prop = "lilprideflag6",
        propBone = 18905,
        propPlacement = {0.0900,0.0000,0.0300,-39.911,93.9166,-5.8062},
        secondProp = "lilprideflag6",
        secondPropBone = 57005,
        secondPropPlacement = {0.0900,-0.0200,-0.0300,-90.2454,5.7068,-28.7797
        },
        emoteLoop = true,
        emoteMoving = false
    }},
    ["dancepridef"] = {"anim@amb@nightclub@lazlow@hi_railing@", "ambclub_09_mi_hi_bellydancer_laz", "Dance Pride F - Non Binary", animationOptions =
    {
        prop = "lilprideflag7",
        propBone = 18905,
        propPlacement = {0.0900,0.0000,0.0300,-39.911,93.9166,-5.8062},
        secondProp = "lilprideflag7",
        secondPropBone = 57005,
        secondPropPlacement = {0.0900,-0.0200,-0.0300,-90.2454,5.7068,-28.7797},
        emoteLoop = true,
        emoteMoving = false
    }},
    ["danceprideg"] = {"anim@amb@nightclub@lazlow@hi_railing@", "ambclub_09_mi_hi_bellydancer_laz", "Dance Pride G - Asexual", animationOptions =
    {
        prop = "lilprideflag8",
        propBone = 18905,
        propPlacement = {0.0900,0.0000,0.0300,-39.911,93.9166,-5.8062},
        secondProp = "lilprideflag8",
        secondPropBone = 57005,
        secondPropPlacement = {0.0900,-0.0200,-0.0300,-90.2454,5.7068,-28.7797},
        emoteLoop = true,
        emoteMoving = false
    }},
    ["danceprideh"] = {"anim@amb@nightclub@lazlow@hi_railing@", "ambclub_09_mi_hi_bellydancer_laz", "Dance Pride H - Straight Ally", animationOptions =
    {
        prop = "lilprideflag9",
        propBone = 18905,
        propPlacement = {0.0900,0.0000,0.0300,-39.911,93.9166,-5.8062},
        secondProp = "lilprideflag9",
        secondPropBone = 57005,
        secondPropPlacement = {0.0900,-0.0200,-0.0300,-90.2454,5.7068,-28.7797},
        emoteLoop = true,
        emoteMoving = false
    }},
    ["pflag"] = {"rcmnigel1d", "base_club_shoulder", "Pride Flag - Rainbow", animationOptions =
    {
        prop = "prideflag1",
        propBone = 18905,
        propPlacement = {0.0800,-0.2090,0.0900,-82.6677,-141.2988,12.3308},
        emoteLoop = true,
        emoteMoving = true
    }},
    ["pflag2"] = {"rcmnigel1d", "base_club_shoulder", "Pride Flag 2 - LGBTQ", animationOptions =
    {
        prop = "prideflag2",
        propBone = 18905,
        propPlacement = {0.0800,-0.2090,0.0900,-82.6677,-141.2988,12.3308},
        emoteLoop = true,
        emoteMoving = true
    }},
    ["pflag3"] = { "rcmnigel1d", "base_club_shoulder", "Pride Flag 3 - Bisexual ", animationOptions =
    {
        prop = "prideflag3",
        propBone = 18905,
        propPlacement = {0.0800,-0.2090,0.0900,-82.6677,-141.2988,12.3308},
        emoteLoop = true,
        emoteMoving = true
    }},
    ["pflag4"] = {"rcmnigel1d", "base_club_shoulder", "Pride Flag 4 - Lesbian ", animationOptions =
    {
        prop = "prideflag4",
        propBone = 18905,
        propPlacement = {0.0800,-0.2090,0.0900,-82.6677,-141.2988,12.3308},
        emoteLoop = true,
        emoteMoving = true
    }},
    ["pflag5"] = {"rcmnigel1d", "base_club_shoulder", "Pride Flag 5 - Pansexual ", animationOptions =
    {
        prop = "prideflag5",
        propBone = 18905,
        propPlacement = {0.0800,-0.2090,0.0900,-82.6677,-141.2988,12.3308},
        emoteLoop = true,
        emoteMoving = true
    }},
    ["pflag6"] = {"rcmnigel1d", "base_club_shoulder", "Pride Flag 6 - Transexual ", animationOptions =
    {
        prop = "prideflag6",
        propBone = 18905,
        propPlacement = { 0.0800,-0.2090,0.0900,-82.6677,-141.2988,12.3308},
        emoteLoop = true,
        emoteMoving = true
    }},
    ["pflag7"] = {"rcmnigel1d", "base_club_shoulder", "Pride Flag 7 - Non Binary ", animationOptions =
    {
        prop = "prideflag7",
        propBone = 18905,
        propPlacement = {0.0800,-0.2090,0.0900,-82.6677,-141.2988,12.3308},
        emoteLoop = true,
        emoteMoving = true
    }},
    ["pflag8"] = {"rcmnigel1d", "base_club_shoulder", "Pride Flag 8 - Asexual ", animationOptions =
    {
        prop = "prideflag8",
        propBone = 18905,
        propPlacement = {0.0800,-0.2090,0.0900,-82.6677,-141.2988,12.3308},
        emoteLoop = true,
        emoteMoving = true
    }},
    ["pflag9"] = {"rcmnigel1d", "base_club_shoulder", "Pride Flag 9 - Straight Ally ", animationOptions =
    {
        prop = "prideflag9",
        propBone = 18905,
        propPlacement = {0.0800,-0.2090,0.0900,-82.6677,-141.2988,12.3308},
        emoteLoop = true,
        emoteMoving = true
    }},
    ["kiss2"] = {"hs3_ext-20","csb_georginacheng_dual-20", "Kiss 2", animationOptions =
    {
        emoteMoving = false,
        emoteDuration = 10000,
        syncOffsetFront = 0.08
    }},
    ["kiss3"] = {"hs3_ext-19", "cs_lestercrest_3_dual-19", "Kiss 3", animationOptions =
    {
        emoteMoving = false,
        emoteDuration = 10000,
        syncOffsetFront = 0.08
    }},
    ["kiss4"] = {"hs3_ext-19", "csb_georginacheng_dual-19", "Kiss 4", animationOptions =
    {
        emoteMoving = false,
        emoteDuration = 10000,
        syncOffsetFront = 0.08
    }},
    ["boombox2"] = {"molly@boombox1", "boombox1_clip", "Boombox 2", animationOptions =
    {
        prop = "prop_cs_sol_glasses",
        propBone = 31086,
        propPlacement = {0.0440,0.0740,0.0000,-160.9843,-88.7288,-0.6197},
        secondProp = "prop_ghettoblast_02",
        secondPropBone = 10706,
        secondPropPlacement = {-0.2310,-0.0770,0.2410,-179.7256,176.7406,23.0190},
        emoteLoop = true,
        emoteMoving = true
    }},
    ["airportbag"] = {"anim@heists@narcotics@trash", "idle", "Airport Bag", animationOptions =
    {
        prop = "prop_suitcase_01c",
        propBone = 28422,
        propPlacement = {0.1100,-0.2100,-0.4300,-11.8999,0.0,30.0000},
        emoteLoop = true,
        emoteMoving = true
    }},
    ["cashcase"] = {"move_weapon@jerrycan@generic", "idle", "Cash Briefcase", animationOptions =
    {
        prop = "bkr_prop_biker_case_shut",
        propBone = 28422,
        propPlacement = {0.1000, 0.0100, 0.0040, 0.0, 0.0, -90.00},
        emoteLoop = true,
        emoteMoving = true
    } },
    ["cashcase2"] = {"anim@heists@box_carry@", "idle", "Cash Briefcase 2", animationOptions =
    {
        prop = "prop_cash_case_01",
        propBone = 28422,
        propPlacement = {-0.0050, -0.1870, -0.1400, 0.0, 0.0, 0.0},
        emoteLoop = true,
        emoteMoving = true
    } },
    ["cashcase3"] = {"anim@heists@box_carry@", "idle", "Cash Briefcase 3", animationOptions =
    {
        prop = "prop_cash_case_02",
        propBone = 28422,
        propPlacement = {0.0050, -0.1170, -0.1400, 14.000, 0.0, 0.0},
        emoteLoop = true,
        emoteMoving = true
    } },
    ["cashcase4"] = {"anim@heists@box_carry@", "idle", "Cash Briefcase 4 - Diamonds", animationOptions =
    {
        prop = "ch_prop_ch_security_case_01a",
        propBone = 28422,
        propPlacement = {0.0, -0.0900, -0.1800, 14.4000, 0.0, 0.0},
        emoteLoop = true,
        emoteMoving = true
    } },
    ["guitarcarry"] = {"move_weapon@jerrycan@generic", "idle", "Guitar Case Carry", animationOptions =
    {
        prop = "sf_prop_sf_guitar_case_01a",
        propBone = 28422,
        propPlacement = {0.2800, -0.2000, -0.0600, 0.0, 0.0, 15.0000},
        emoteLoop = true,
        emoteMoving = true
    } },
    ["guitarcarry2"] = {"move_weapon@jerrycan@generic", "idle", "Guitar Carry Accoustic", animationOptions =
    {
        prop = "prop_acc_guitar_01",
        propBone = 28422,
        propPlacement = {0.1500, -0.1400, -0.0200, -101.5083, 5.7251, 29.4987},
        emoteLoop = true,
        emoteMoving = true
    }},
    ["guitarcarry3"] = {"move_weapon@jerrycan@generic", "idle", "Guitar Carry Electric ", animationOptions =
    {
        prop = "prop_el_guitar_01",
        propBone = 28422,
        propPlacement = {0.1100, -0.1200, -0.0500, -80.0000, 0.0, 21.9999},
        emoteLoop = true,
        emoteMoving = true
    }},
    ["guitarcarry4"] = {"move_weapon@jerrycan@generic", "idle", "Guitar Carry Electric 2 ", animationOptions =
    {
        prop = "prop_el_guitar_02",
        propBone = 28422,
        propPlacement = {0.1100, -0.1200, -0.0500, -80.0000, 0.0, 21.9999},
        emoteLoop = true,
        emoteMoving = true
    }},
    ["guitarcarry5"] = {"move_weapon@jerrycan@generic", "idle", "Guitar Carry Electric 3 ", animationOptions =
    {
        prop = "prop_el_guitar_03",
        propBone = 28422,
        propPlacement = {0.1100, -0.1200, -0.0500, -80.0000, 0.0, 21.9999},
        emoteLoop = true,
        emoteMoving = true
    }},
    ["guitarcarry6"] = {"move_weapon@jerrycan@generic", "idle", "Guitar Carry Electric 4 ", animationOptions =
    {
        prop = "vw_prop_casino_art_guitar_01a",
        propBone = 28422,
        propPlacement = {0.1100, -0.1200, -0.0500, -80.0000, 0.0, 21.9999},
        emoteLoop = true,
        emoteMoving = true
    }},
    ["guitarcarry7"] = {"move_weapon@jerrycan@generic", "idle", "Guitar Carry Electric 5 ", animationOptions =
    {
        prop = "sf_prop_sf_el_guitar_02a",
        propBone = 28422,
        propPlacement = {0.1100, -0.1200, -0.0500, -80.0000, 0.0, 21.9999},
        emoteLoop = true,
        emoteMoving = true
    }},
    ["guncase"] = {"move_weapon@jerrycan@generic", "idle", "Guncase", animationOptions =
    {
        prop = "prop_gun_case_01",
        propBone = 57005,
        propPlacement = {0.10, 0.02, -0.02, 40.0, 145.0, 115.0},
        emoteLoop = true,
        emoteMoving = true
    }},
    ["dispenser"] = {"mini@sprunk", "plyr_buy_drink_pt1", "Dispenser", animationOptions =
    {
         emoteLoop = false
    }},
    ["protest2"] = {"rcmnigel1d", "base_club_shoulder", "Protest 2 - Pride ", animationOptions = {
        prop = "pride_sign_01",
        propBone = 57005,
        propPlacement = {0.1820, 0.2400, 0.0600, -69.3774235, 5.9142048, -13.9572354},
        emoteLoop = true,
        emoteMoving = true
    }},
    ["relax"] = {"lying@on_grass", "base", "Relax ", animationOptions = {
        emoteLoop = true
    }},
    ["relax2"] = {"lying@on_couch_legs_crossed", "base", "Relax ",animationOptions = {
        emoteLoop = true
    }},
    ["uwu"] = {"uwu@egirl", "base", "uWu", animationOptions = {
        emoteLoop = true,
        emoteMoving = true
    }},
    ["guitarsit"] = {"misssnowie@gatlax", "base", "Guitar Sit And Play", animationOptions = {
        prop = "prop_acc_guitar_01",
        propBone = 24818,
        propPlacement = {-0.0510, 0.2770, -0.0299, -140.3349, 166.3300, 29.7590},
        emoteLoop = true
    }},
    ["megaphone"] = {"molly@megaphone", "megaphone_clip", "Megaphone", animationOptions = {
        prop = "prop_megaphone_01",
        propBone = 28422,
        propPlacement = {0.0500, 0.0540, -0.0060, -71.8855, -13.0889, -16.0242},
        emoteLoop = true,
        emoteMoving = true
    }},
    ["selfiepeace"] = {"mirror_selfie@peace_sign", "base", "Selfie Peace", animationOptions = {
        prop = "prop_phone_ing",
        propBone = 57005,
        propPlacement = {0.1700, 0.0299, -0.0159, -126.2687, -139.9058, 35.6203},
        emoteLoop = true,
        emoteMoving = true,
        ptfxAsset = "scr_tn_meet",
        ptfxName = "scr_tn_meet_phone_camera_flash",
        ptfxPlacement = {-0.015, 0.0, 0.041, 0.0, 0.0, 0.0, 1.0},
        ptfxInfo = "Press ~y~G~w~ to flash camera.",
        ptfxWait = 200
    }},
    ["kneelthot"] = {"anim@model_kylie_insta", "kylie_insta_clip", "Kneel Thot Instagram", animationOptions = {
        emoteLoop = true
    }},
    ["selfiefu"] = {"anim@fuck_you_selfie", "fuck_you_selfie_clip", "Selfie Middle Finger", animationOptions = {
        prop = "prop_phone_ing",
        propBone = 28422,
        propPlacement = {0.1200, 0.0220, -0.0210, 98.6822, -4.9809, 109.6216},
        emoteLoop = true,
        emoteMoving = false,
        ptfxAsset = "scr_tn_meet",
        ptfxName = "scr_tn_meet_phone_camera_flash",
        ptfxPlacement = {-0.015, 0.0, 0.041, 0.0, 0.0, 0.0, 1.0},
        ptfxInfo = "Press ~y~G~w~ to flash camera.",
        ptfxWait = 200
    }},
    ["selfiethot"] = {"anim@sitting_thot", "sitting_thot_clip", "Selfie Thot Instagram", animationOptions = {
        prop = "prop_phone_ing",
        propBone = 28422,
        propPlacement = {0.1030, 0.0440, -0.0270, -160.2802, -99.4080, -3.4048},
        emoteLoop = true,
        emoteMoving = false,
        ptfxAsset = "scr_tn_meet",
        ptfxName = "scr_tn_meet_phone_camera_flash",
        ptfxPlacement = {-0.015, 0.0, 0.041, 0.0, 0.0, 0.0, 1.0},
        ptfxInfo = "Press ~y~G~w~ to flash camera.",
        ptfxWait = 200
    }},
    ["bball"] = {"anim@male_bskball_hold", "bskball_hold_clip", "Basketball Hold", animationOptions = {
        prop = "prop_bskball_01",
        propBone = 28422,
        propPlacement = {0.0600, 0.0400, -0.1200, 0.0, 0.0, 40.00},
        emoteLoop = true,
        emoteMoving = true,
    }},
    ["bball2"] = {"anim@male_bskball_photo_pose", "photo_pose_clip", "Basketball Pose", animationOptions = {
        prop = "prop_bskball_01",
        propBone = 60309,
        propPlacement = {-0.0100, 0.0200, 0.1300, 0.0, 0.0, 0.0},
        emoteLoop = true,
        emoteMoving = true,
    }},
    ["wank"] = {"anim@mp_player_intselfiewank", "idle_a", "Wank", animationOptions = {
        emoteMoving = true,
        emoteLoop = true
    }},
    ["wank2"] = {"anim@mp_player_intupperwank", "idle_a", "Wank 2", animationOptions = {
        emoteMoving = true,
        emoteLoop = true,
    }},
    ["wank3"] = {"mp_player_int_upperwank", "mp_player_int_wank_02", "Wank 3", animationOptions = {
        emoteMoving = true,
        emoteLoop = true,
    }},
    ["wank4"] = {"mp_player_int_upperwank", "mp_player_int_wank_02_fp", "Wank 4",  animationOptions = {
        emoteMoving = true,
        emoteLoop = true,
    }},
    ["wank5"] = {"mp_player_intwank", "mp_player_int_wank", "Wank 5", animationOptions = {
        emoteMoving = false,
        emoteLoop = false,
    }},
    ["newspaper"] = {"amb@world_human_clipboard@male@idle_a", "idle_a", "Newspaper", animationOptions = {
        prop = "prop_cliff_paper",
        propBone = 60309,
        propPlacement = {0.0970, -0.0280, -0.0170, 107.4008, 3.2712, -10.5080},
        emoteMoving = true,
        emoteLoop = true
    }},
    ["newspaper2"] = {"amb@world_human_clipboard@male@idle_a", "idle_a", "Newspaper 2", animationOptions = {
        prop = "ng_proc_paper_news_quik",
        propBone = 60309,
        propPlacement = {0.1590, 0.0290, -0.0100, 90.9998, 0.0087, 0.5000},
        emoteMoving = true,
        emoteLoop = true
    }},
    ["newspaper3"] = {"amb@world_human_clipboard@male@idle_a", "idle_a", "Newspaper 3", animationOptions = {
        prop = "ng_proc_paper_news_rag",
        propBone = 60309,
        propPlacement = {0.1760, -0.00070, 0.0200, 99.8306, 3.2841, -4.7185},
        emoteMoving = true,
        emoteLoop = true
    }},
    ["flex2"] = {"frabi@malepose@solo@firstsport", "pose_sport_002", "Flex 2", animationOptions = {
        emoteLoop = true,
        emoteMoving = true
    }},
    ["gympose"] = {"frabi@malepose@solo@firstsport", "pose_sport_001", "Gym Pose", animationOptions = {
        emoteLoop = true
    }},
	["gympose2"] = {"frabi@malepose@solo@firstsport", "pose_sport_005", "Gym Pose 2 - One Handed Push Up", animationOptions = {
        emoteLoop = true
    }},
    ["weights3"] = {"frabi@malepose@solo@firstsport", "pose_sport_004", "Weights 3 - Pose", animationOptions = {
		prop = "prop_barbell_01",
        propBone = 28422,
        propPlacement = {0.0660, 0.0100, -0.0300, 90.0000, 90.0000, -79.9999},
        emoteLoop = true
    }},
    ["weights4"] = {"frabi@malepose@solo@firstsport", "pose_sport_003", "Weights 4 - Pose", animationOptions = {
		prop = "prop_barbell_01",
        propBone = 60309,
        propPlacement = {0.0520, -0.0010, 0.0131, 21.5428, 70.2098, 74.5019},
        secondProp = "prop_barbell_01",
        secondPropBone = 28422,
        secondPropPlacement = {0.0660, 0.0100, -0.0300, 90.0000, 90.0000, -79.9999},
        emoteLoop = true
    }},
    ["vape"] = { "amb@world_human_smoking@male@male_b@base", "base", "Vape", animationOptions = {
        prop = 'ba_prop_battle_vape_01',
        propBone = 28422,
        propPlacement = {-0.0290, 0.0070, -0.0050, 91.0, 270.0, -360.0},
        emoteMoving = true,
        emoteLoop = true,
        ptfxAsset = "core",
        ptfxName = "exp_grd_bzgas_smoke",
        ptfxNoProp = true,
        ptfxPlacement = {-0.0100, 0.0600, 0.6600, 0.0, 0.0, 0.0, 2.0},
        ptfxInfo = "Press ~y~G~w~ to vape.",
        ptfxWait = 0,
        ptfxCanHold = true
    }},
    ["weedbucket"] = {"anim@heists@box_carry@", "idle", "Weed Bucket", animationOptions = {
        prop = "bkr_prop_weed_bucket_open_01a",
        propBone = 28422,
        propPlacement = {0.0, -0.1000, -0.1800, 0.0, 0.0, 0.0},
        emoteLoop = true,
        emoteMoving = true,
    }},
    ["candyapple"] = {"anim@heists@humane_labs@finale@keycards", "ped_a_enter_loop", "Candy Apple", animationOptions = {
        prop = "apple_1",
        propBone = 18905,
        propPlacement = {0.12, 0.15, 0.0, -100.0, 0.0, -12.0},
        emoteLoop = true,
        emoteMoving = true,
    }},
}

cfg.guns = {
    -- Pack 1
    ["riflerelaxed"] = {"anim@fog_rifle_relaxed", "rifle_relaxed_clip", "Rifle Relaxed", animationOptions =
    {
        emoteLoop = true
    }},
    ["riflehighlean"] = {"anim@highlow_high_lean", "high_lean_clip", "Rifle High Lean", animationOptions =
    {
        emoteLoop = true
    }},
    ["riflelowlean"] = {"anim@highlow_low_lean", "low_lean_clip", "Rifle Low Lean", animationOptions =
    {
        emoteLoop = true
    }},
    ["stackpointman"] = {"anim@stack_pointman", "pointman_clip", "Stack Pointman", animationOptions =
    {
        emoteLoop = true
    }},
    ["stacktwoman"] = {"anim@stack_two_man", "two_man_clip", "Stack Two Man", animationOptions =
    {
        emoteLoop = true
    }},
    ["stackthreeman"] = {"anim@stack_three_man", "three_man_clip", "Stack Three Man", animationOptions =
    {
        emoteLoop = true
    }},
    -- Pack 2
    ["tacticallowready"] = {"anim@male_tactical_collapsed_lowready", "collapsed_lowready_clip", "Tactical Low Ready", animationOptions =
    {
        emoteLoop = true
    }},
    ["tacticalhighready"] = {"anim@male_tactical_highready_relaxed", "highready_relaxed_clip", "Tactical High Ready", animationOptions =
    {
        emoteLoop = true
    }},
    ["tacticalhighlean"] = {"anim@tactical_highlow_high_leftlean", "high_leftlean_clip", "Tactical High Lean", animationOptions =
    {
        emoteLoop = true
    }},
    ["tacticallowlean"] = {"anim@tactical_highlow_low_leftlean", "low_leftlean_clip", "Tactical Low Lean", animationOptions =
    {
        emoteLoop = true
    }},
    ["tacticalkneelaiming"] = {"anim@tactical_kneel_aiming", "kneel_aiming_clip", "Tactical Kneel Aiming", animationOptions =
    {
        emoteLoop = true
    }},
    ["tacticalkneelwalkie"] = {"anim@tactical_kneel_walkie", "kneel_walkie_clip", "Tactical Kneel Walkie", animationOptions =
    {
        emoteLoop = true
    }},
    -- Pack 3
    ["holdingsidevest"] = {"anim@holding_side_vest", "holding_side_vest_clip", "Holding Side Vest", animationOptions =
    {
        emoteLoop = true
    }},
    ["holdingsiegevest"] = {"anim@holding_siege_vest_side", "holding_siege_vest_side_clip", "Holding Siege Vest", animationOptions =
    {
        emoteLoop = true
    }},
    ["aimweapon"] = {"anim@male@aim_weapon", "aim_weapon_clip", "Aim Weapon", animationOptions =
    {
        emoteLoop = true
    }},
    ["holdingradio"] = {"anim@male@holding_radio", "holding_radio_clip", "Holding Radio", animationOptions =
    {
        emoteLoop = true
    }},
    ["holdingvest"] = {"anim@male@holding_vest", "holding_vest_clip", "Holding Vest", animationOptions =
    {
        emoteLoop = true
    }},
    ["holdingvest2"] = {"anim@male@holding_vest_2", "holding_vest_2_clip", "Holding Vest 2", animationOptions =
    {
        emoteLoop = true
    }},
    ["holdingvestseige"] = {"anim@male@holding_vest_siege", "holding_vest_siege_clip", "Holding Vest Siege", animationOptions =
    {
        emoteLoop = true
    }},
    ["holdingvestseige2"] = {"anim@male@holding_vest_siege_2", "holding_vest_siege_2_clip", "Holding Vest Siege 2", animationOptions =
    {
        emoteLoop = true
    }},
    ["holdingweapon2"] = {"anim@male@holding_weapon_2", "holding_weapon_2_clip", "Holding Weapon 2", animationOptions =
    {
        emoteLoop = true
    }},
    ["holdingweapon4"] = {"anim@male@holding_weapon_4", "holding_weapon_4_clip", "Holding Weapon 4", animationOptions =
    {
        emoteLoop = true
    }},
    ["holdingweaponkneel"] = {"anim@male@holding_weapon_kneel", "anim@male@holding_weapon_kneel_clip", "Holding Weapon Kneel", animationOptions =
    {
        emoteLoop = true
    }},
    ["holdingweaponnvg"] = {"anim@male@holding_weapon_nvg", "holding_weapon_nvg_clip", "Holding Weapon NVG", animationOptions =
    {
        emoteLoop = true
    }},
    ["holdingweaponnvg2"] = {"anim@male@holding_weapon_nvg_2", "holding_weapon_nvg_2_clip", "Holding Weapon NVG 2", animationOptions =
    {
        emoteLoop = true
    }},
    ["hugweapon"] = {"anim@male@hug_weapon", "hug_weapon_clip", "Hug Weapon", animationOptions =
    {
        emoteLoop = true
    }},
    ["hugweapon2"] = {"anim@male@hug_weapon_2", "hug_weapon_2_clip", "Hug Weapon 2", animationOptions =
    {
        emoteLoop = true
    }},
    ["poseweapon"] = {"anim@male@pose_weapon", "pose_weapon_clip", "Pose Weapon", animationOptions =
    {
        emoteLoop = true
    }},
    ["poseweapon2"] = {"anim@male@pose_weapon_2", "pose_weapon_2_clip", "Pose Weapon 2", animationOptions =
    {
        emoteLoop = true
    }},
    ["poseweapon3"] = {"anim@male@pose_weapon_3", "pose_weapon_3_clip", "Pose Weapon 3", animationOptions =
    {
        emoteLoop = true
    }},
    ["preaimweapon"] = {"anim@male@preaim_weapon", "preaim_weapon_clip", "Preaim weapon", animationOptions =
    {
        emoteLoop = true
    }},
    ["runweapon"] = {"anim@male@run_weapon", "run_weapon_clip", "Run Weapon", animationOptions =
    {
        emoteLoop = true
    }},
    ["tacticalkneel"] = {"anim@male@tactical_kneel", "tactical_kneel_clip", "Tactical Kneel", animationOptions =
    {
        emoteLoop = true
    }},
    ["radioleft"] = {"anim@radio_left", "radio_left_clip", "Radio Left", animationOptions =
    {
        emoteLoop = true
    }},
}

return cfg