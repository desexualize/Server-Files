dstatus = {}

dstatus.Debug = false

dstatus.Webhook = 'https://discord.com/api/webhooks/1012510588179595324/Gw13lYPYgYWK6IpCGCoVdLrhHn3uNLBNeyAIxSgUQvc9vcFqRTOdUcOfPLtThG48C4ts'
dstatus.ServerName = 'Nova UK'

dstatus.MessageId = '932311449664098364' --Copy messageid from deployed message and restart script!

dstatus.UpdateTime = 1000*60*1 -- 1 minute
dstatus.Use24hClock = true -- false = 12h clock
dstatus.JoinLink = 'https://cfx.re/join/p4yde7' -- Make sure that JoinLink is URL, like: https://cfx.re/join/xp34mg, currenlty does not support Redm

dstatus.EmbedColor = 3015041

dstatus.Locale = 'en'

dstatus.Locales = {
    ['fi'] = {
        ['date'] = 'Päivä',
        ['time'] = 'Aika',
        ['players'] = 'Pelaajia',
        ['connect'] = 'Yhdistä palvelimelle',
    },
    ['en'] = {
        ['date'] = 'Date',
        ['time'] = 'Time',
        ['players'] = 'Players',
        ['connect'] = 'Connect to server',
    }
}
