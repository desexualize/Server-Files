dstatus = {}

dstatus.Debug = false

dstatus.Webhook = 'https://discord.com/api/webhooks/933906820836257892/oavvGK2FVz03WHHT0uZFh9_bX3EkUAiAB9iBMYlvcnue7bsh7qRTx5aJXlKRSq1SVvX9'
dstatus.ServerName = 'Galaxy Roleplay'

dstatus.MessageId = '932311449664098364' --Copy messageid from deployed message and restart script!

dstatus.UpdateTime = 1000*60*1 -- 1 minute
dstatus.Use24hClock = true -- false = 12h clock
dstatus.JoinLink = 'https://cfx.re/join/' -- Make sure that JoinLink is URL, like: https://cfx.re/join/xp34mg, currenlty does not support Redm

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
