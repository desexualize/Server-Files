function table.has(table, val)
    for i=1, #table do
        if table[i] == val then
            return true
        end
    end
    return false
end

function table.find(table, val)  -- find hte key of the value
    for k,v in pairs(table) do
        if v == val then return k end
    end
    return false
end

function table.add(table, value)
    table[#table+1] = value
end

function stringsplit(inputstr, sep) --[[Left this here, not sure if needed]]
    if sep == nil then
        sep = "%s"
    end
    local t={} ; i=1
    for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
        t[i] = str
        i = i + 1
    end
    return t
end

function table.count(self)
    local count = 0
    for _, _ in pairs(self) do
        count = count + 1
    end
    return count
end

--second param is for recursion, ignore when called.
function table.copy(obj, seen)
    if type(obj) ~= 'table' then return obj end
    if seen and seen[obj] then return seen[obj] end
    local s = seen or {}
    local res = setmetatable({}, getmetatable(obj))
    s[obj] = res
    for k, v in pairs(obj) do res[table.copy(k, s)] = table.copy(v, s) end
    return res
end

function sortedKeys(query, sortFunction)
	local keys, len = {}, 0
	for k,_ in pairs(query) do
		len = len + 1
		keys[len] = k
	end
	table.sort(keys, sortFunction)
	return keys
end

function getMoneyStringFormatted(cashString)
	local i, j, minus, int, fraction = tostring(cashString):find('([-]?)(%d+)([.]?%d*)')

	-- reverse the int-string and append a comma to all blocks of 3 digits
	int = int:reverse():gsub("(%d%d%d)", "%1,")

	-- reverse the int-string back remove an optional comma and put the
	-- optional minus and fractional part back
	return minus .. int:reverse():gsub("^,", "") .. fraction
end

function dump(o)
    if type(o) == 'table' then
        local s = '{ '
        for k,v in pairs(o) do
            if type(k) ~= 'number' then k = '"'..k..'"' end
            s = s .. '['..k..'] = ' .. dump(v) .. ','
        end
        return s .. '} '
    else
        return tostring(o)
    end
end

function math.round(a, b)
	return (math.floor(a / b) * b)
end

function math.rounddp(a, b)
	local b = b or 0
	return(math.floor(a*10^b+0.5)/10^b)
end

function table.contentEquals(o1, o2, ignore_mt)
    if o1 == o2 then return true end
    local o1Type = type(o1)
    local o2Type = type(o2)
    if o1Type ~= o2Type then return false end
    if o1Type ~= 'table' then return false end

    if not ignore_mt then
        local mt1 = getmetatable(o1)
        if mt1 and mt1.__eq then
            --compare using built in method
            return o1 == o2
        end
    end

    local keySet = {}

    for key1, value1 in pairs(o1) do
        local value2 = o2[key1]
        if value2 == nil or table.contentEquals(value1, value2, ignore_mt) == false then
            return false
        end
        keySet[key1] = true
    end

    for key2, _ in pairs(o2) do
        if not keySet[key2] then return false end
    end
    return true
end

function table.empty(self)
    for _, _ in pairs(self) do
        return false
    end
    return true
end
