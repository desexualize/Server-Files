
local cfg = {}
cfg.gaptitudes = {
  ["physical"] = {
    _title = "Physical",
    ["strength"] = {"Strength", 30, 275} -- required, level 3 to 6 (by default, can carry 10kg per level)
  },
  ["science"] = {
    _title = "Science",
    ["chemicals"] = {"Study of chemicals", 0, -1}, -- example
    ["mathematics"] = {"Study of mathematics", 0, -1} -- example
  },
  ["laboratory"] = {
    _title = "laboratory of drugs",
	["cocaine"] = {"process you cocaine, need benzoilmetilecgonina, find in Plantation .", 0, -1},
	["weed"] = {"process you weed, need seeds, find in Plantation .", 0, -1},
	["lsd"] = {"process you lsd, need Harness, find in Plantation .", 0, -1}
  },
  ["hacker"] = {
    _title = "Study of hacker",
	["logic"] = {"Study of logic.", 0, -1},
	["c++"] = {"Study of C++ language.", 0, -1},
	["lua"] = {"Study of lua language.", 0, -1},
	["hacking"] = {"Study of hackers.", 0, -1}
  }
}

return cfg
