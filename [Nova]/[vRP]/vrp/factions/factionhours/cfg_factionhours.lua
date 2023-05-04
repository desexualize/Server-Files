local config = {}

config.faction_duty_logs = {
    ['LFB'] = 'https://discord.com/api/webhooks/1019259186149859409/t6j4CYeAc3s40y6NwPcT7mFwY5q4_BE8eiSCmgQ8cZLLm5jFyW3Zxs9dp8kw4md-2VOm',
    ['NHS'] = 'https://discord.com/api/webhooks/1019259058701742190/idYZZmpYLgKoehThwLDinE_nk0h5jc6wu5wu5FHu-nBAyJ4Ca6-7tNhRhmm0kVpJugtP',
    ['HMP'] = 'https://discord.com/api/webhooks/1019258832880406668/MEQJV2r3AV-qVtp6rKfCOgwhQQsQv1vC3qe5HqeEWarYljL7ZR-IHhVhTh593JhmRTC9',
    ['MPD'] = 'https://discord.com/api/webhooks/1019258417703038996/S5C4n5oC4o8mCSmReYAPhPNABRGVfmS-y8wrjaBH56sw9VzGlsMH89Jl2JY5dC5Ne_Q1',
}

config.faction_embed_colours = {
    ['LFB'] = '14490909',
    ['NHS'] = '2067276',
    ['HMP'] = '2123412',
    ['MPD'] = '8703',
}

exports('Get_Faction_Embed_Colour', function(faction_name)
    return config.faction_embed_colours[faction_name]
end)

return config