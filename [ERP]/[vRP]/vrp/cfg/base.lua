
local cfg = {}

cfg.save_interval = 30 -- seconds
cfg.whitelist = false -- enable/disable whitelist
cfg.ignore_ip_identifier = true -- This will allow multiple same IP connections (for families etc)
cfg.load_duration = 5 -- seconds, player duration in loading mode at the first spawn
cfg.load_delay = 0 -- milliseconds, delay the tunnel communication when in loading mode
cfg.global_delay = 0 -- milliseconds, delay the tunnel communication when not in loading mode
cfg.lang = "en" -- en / fr / it / ger / pt / ru / lith / dan / ar / pl / es / swe / fin / cn / ro 
cfg.debug = false


return cfg
