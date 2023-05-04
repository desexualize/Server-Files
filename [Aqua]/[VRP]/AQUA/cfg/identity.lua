
local cfg = {}

-- city hall position


-- cityhall blip {blipid,blipcolor}


-- cost of a new identity


-- phone format (max: 20 chars, use D for a random digit)
cfg.phone_format = "07DDDDDDDD" -- another example for cellphone in France


-- config the random name generation (first join identity)
-- (I know, it's a lot of names for a little feature)
-- (cf: http://names.mongabay.com/most_common_surnames.htm)
cfg.random_first_names = {
  "Change",
  "Change"
}

cfg.random_last_names = {
  "Me",
  "Me"
}

return cfg
