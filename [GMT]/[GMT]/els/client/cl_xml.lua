--[[------------------------------------------------------------------------------
  -- File         : /client/cl_xml.lua
  -- Purpose      : XML Deserialisation of VCFs
--]]------------------------------------------------------------------------------

local glm = require("glm")

local function GetExtraOverride(config, xml)
	for _, element in ipairs(xml.kids) do
		if string.upper(string.sub(element.name, 1, -3)) == "EXTRA" then
			if element.attr["AllowEnvLight"] == "true" then
				local data = {}
				data.offset = vector3(tonumber(element.attr["OffsetX"]), tonumber(element.attr["OffsetY"]), tonumber(element.attr["OffsetZ"]))
				data.colour = string.lower(element.attr["Color"])

				local extra = tonumber(string.sub(element.name, -2))
				config.extras[extra] = data
			end
		end
	end

	if config.version then
		error("A VCF version has already been specified")
	else
		config.version = 1
	end
end

local function GetExtra(xml)
	local lights = {}
	for _, element in ipairs(xml.kids) do
		if element.name == "Light" then
			local light = {}
			light.offset = vector3(tonumber(element.attr["OffsetX"]), tonumber(element.attr["OffsetY"]), tonumber(element.attr["OffsetZ"]))
			if not light.offset then
				error("Failed to get offset for extra light")
			end

			light.direction = tonumber(element.attr["Direction"])
			if not light.direction then
				error("Failed to get direction for extra light")
			else
				light.direction = glm.rad(light.direction)
			end

			light.colour = element.attr["Colour"]
			if not light.colour then
				error("Failed to get colour for extra light")
			end

			table.insert(lights, light)
		end
	end
	return lights
end

local function GetExtras(config, xml)
	for _, element in ipairs(xml.kids) do
		if element.name == "Extra" then
			local extra = tonumber(element.attr["Number"])
			config.extras[extra] = GetExtra(element)
		end
	end

	if config.version then
		error("A VCF version has already been specified")
	else
		config.version = 2
	end
end

local function GetSounds(config, xml)
	for _, element in ipairs(xml.kids) do
		if element.name == "MainHorn" then
			config.sounds.mainHorn = { audioString = element.attr["AudioString"] }
		elseif element.name == "SrnTone1" then
			config.sounds.srnTone1 = { audioString = element.attr["AudioString"] }
		elseif element.name == "SrnTone2" then
			config.sounds.srnTone2 = { audioString = element.attr["AudioString"] }
		elseif element.name == "SrnTone3" then
			config.sounds.srnTone3 = { audioString = element.attr["AudioString"] }
		elseif element.name == "SrnTone4" then
			config.sounds.srnTone4 = { audioString = element.attr["AudioString"] }
		end
	end
end

local function Split(s, delimiter)
    local result = {}
    for match in (s..delimiter):gmatch("(.-)"..delimiter) do
        table.insert(result, match);
    end
    return result
end

local function GetNumbersFromCSV(csv)
	local values = Split(csv, ",")

	local numbers = {}
	for _, v in ipairs(values) do
		local number = tonumber(v)
		if number then
			table.insert(numbers, number)
		end
	end

	return numbers
end

local function GetPattern(xml)
	local pattern = {}
	for _, element in ipairs(xml.el) do
		local section = {}
		section.Milliseconds = tonumber(element.attr["Duration"])
		section.Extras = GetNumbersFromCSV(element.attr["Extras"])
		pattern[#pattern + 1] = section
	end
	return pattern
end

local function GetPatterns(config, xml)
	for _, element in ipairs(xml.kids) do
		if element.name == "Primary" then
			config.pattern[`PRIMARY`] = GetPattern(element)
		elseif element.name == "Secondary" then
			config.pattern[`SECONDARY`] = GetPattern(element)
		elseif element.name == "Warning" then
			config.pattern[`WARNING`] = GetPattern(element)
		end
	end
end

local function ValidateVehicleConfig(config)
	for patternName, pattern in pairs(config.pattern) do
		for _, section in ipairs(pattern) do
			if not section.Milliseconds then
				return false, string.format("Unable to convert milliseconds in custom pattern %s", patternName)
			end

			if not section.Extras then
				return false, string.format("Unable to convert extras in custom pattern %s", patternName)
			end

			for _, extra in ipairs(section.Extras) do
				if extra < 1 or extra > 12 then
					return false, string.format("Extra %d out of the range 1 to 12 in custom pattern %s", extra, patternName)
				end
			end
		end
	end

	local patterns = { `PRIMARY`, `SECONDARY`, `WARNING` }
	for _, name in ipairs(patterns) do
		local pattern = config.pattern[name] or Config.Pattern[name]
		for _, stage in ipairs(pattern) do
			for _, extra in ipairs(stage.Extras) do
				if not config.extras[extra] then
					return false, string.format("Pattern %s uses extra %d but this is not defined", GetPatternNameFromPattern(name), extra)
				end
			end
		end
	end

	if not config.sounds then
		return false, "Sounds section does not exist"
	end

	local sirens = { config.sounds.srnTone1.audioString, config.sounds.srnTone2.audioString, config.sounds.srnTone3.audioString, config.sounds.srnTone4.audioString }
	if #sirens ~= 4 then
		return false, "Unable to find SrnTone1 to SrnTone4"
	end

	for i = 1, #sirens do
		if string.match(sirens[i], "xsiren") then
			return false, "Sirens of type 'xsiren' unsupported"
		end
	end

	return true
end

function GetVehicleFromXML(file, fileName)
	local xml = SLAXML:dom(file, fileName)

    local config = {}
    config.extras = {}
	config.sounds = {}
	config.pattern = {}

	for _, element in ipairs(xml.root.el) do
		if element.name == "EOVERRIDE" then
			GetExtraOverride(config, element)
		elseif element.name == "EXTRAS" then
			GetExtras(config, element)
		elseif element.name == "SOUNDS" then
			GetSounds(config, element)
		elseif element.name == "PATTERNS" then
			GetPatterns(config, element)
		end
	end

	local isValid, error = ValidateVehicleConfig(config)
	if isValid then
		return config, false
	else
		return false, error
	end
end

SLAXML = {
	VERSION = "0.7",
	_call = {
		pi = function(target,content)
			print(string.format("<?%s %s?>",target,content))
		end,
		comment = function(content)
			print(string.format("<!-- %s -->",content))
		end,
		startElement = function(name,nsURI,nsPrefix)
			                 io.write("<")
			if nsPrefix then io.write(nsPrefix,":") end
			                 io.write(name)
			if nsURI    then io.write(" (ns='",nsURI,"')") end
			                 print(">")
		end,
		attribute = function(name,value,nsURI,nsPrefix)
			                 io.write('  ')
			if nsPrefix then io.write(nsPrefix,":") end
			                 io.write(name,'=',string.format('%q',value))
			if nsURI    then io.write(" (ns='",nsURI,"')") end
			                 io.write("\n")
		end,
		text = function(text)
			print(string.format("  text: %q",text))
		end,
		closeElement = function(name,nsURI,nsPrefix)
			print(string.format("</%s>",name))
		end,
	}
}

function SLAXML:parser(callbacks)
	return { _call=callbacks or self._call, parse=SLAXML.parse }
end

function SLAXML:parse(xml, fileName, options)
	if not options then options = { stripWhitespace=false } end

	local find, sub, gsub, char, push, pop, concat = string.find, string.sub, string.gsub, string.char, table.insert, table.remove, table.concat
	local first, last, match1, match2, match3, pos2, nsURI
	local unpack = unpack or table.unpack
	local pos = 1
	local state = "text"
	local textStart = 1
	local currentElement={}
	local currentAttributes={}
	local currentAttributeCt
	local nsStack = {}
	local anyElement = false

	local utf8markers = { {0x7FF,192}, {0xFFFF,224}, {0x1FFFFF,240} }
	local function utf8(decimal)
		if decimal<128 then return char(decimal) end
		local charbytes = {}
		for bytes,vals in ipairs(utf8markers) do
			if decimal<=vals[1] then
				for b=bytes+1,2,-1 do
					local mod = decimal%64
					decimal = (decimal-mod)/64
					charbytes[b] = char(128+mod)
				end
				charbytes[1] = char(vals[2]+decimal)
				return concat(charbytes)
			end
		end
	end
	local entityMap  = { ["lt"]="<", ["gt"]=">", ["amp"]="&", ["quot"]='"', ["apos"]="'" }
	local entitySwap = function(orig,n,s) return entityMap[s] or n=="#" and utf8(tonumber('0'..s)) or orig end  
	local function unescape(str) return gsub( str, '(&(#?)([%d%a]+);)', entitySwap ) end

	local function finishText()
		if first>textStart and self._call.text then
			local text = sub(xml,textStart,first-1)
			if options.stripWhitespace then
				text = gsub(text,'^%s+','')
				text = gsub(text,'%s+$','')
				if #text==0 then text=nil end
			end
			if text then self._call.text(unescape(text)) end
		end
	end

	local function findPI()
		first, last, match1, match2 = find( xml, '^<%?([:%a_][:%w_.-]*) ?(.-)%?>', pos )
		if first then
			finishText()
			if self._call.pi then self._call.pi(match1,match2) end
			pos = last+1
			textStart = pos
			return true
		end
	end

	local function findComment()
		first, last, match1 = find( xml, '^<!%-%-(.-)%-%->', pos )
		if first then
			finishText()
			if self._call.comment then self._call.comment(match1) end
			pos = last+1
			textStart = pos
			return true
		end
	end

	local function nsForPrefix(prefix)
		if prefix=='xml' then return 'http://www.w3.org/XML/1998/namespace' end -- http://www.w3.org/TR/xml-names/#ns-decl
		for i=#nsStack,1,-1 do if nsStack[i][prefix] then return nsStack[i][prefix] end end
		error(("Cannot find namespace for prefix %s"):format(prefix))
	end

	local function startElement()
		anyElement = true
		first, last, match1 = find( xml, '^<([%a_][%w_.-]*)', pos )
		if first then
			currentElement[2] = nil
			currentElement[3] = nil
			finishText()
			pos = last+1
			first,last,match2 = find(xml, '^:([%a_][%w_.-]*)', pos )
			if first then
				currentElement[1] = match2
				currentElement[3] = match1
				match1 = match2
				pos = last+1
			else
				currentElement[1] = match1
				for i=#nsStack,1,-1 do if nsStack[i]['!'] then currentElement[2] = nsStack[i]['!']; break end end
			end
			currentAttributeCt = 0
			push(nsStack,{})
			return true
		end
	end

	local function findAttribute()
		first, last, match1 = find( xml, '^%s+([:%a_][:%w_.-]*)%s*=%s*', pos )
		if first then
			pos2 = last+1
			first, last, match2 = find( xml, '^"([^<"]*)"', pos2 )
			if first then
				pos = last+1
				match2 = unescape(match2)
			else
				first, last, match2 = find( xml, "^'([^<']*)'", pos2 )
				if first then
					pos = last+1
					match2 = unescape(match2)
				end
			end
		end
		if match1 and match2 then
			local currentAttribute = {match1,match2}
			local prefix,name = string.match(match1,'^([^:]+):([^:]+)$')
			if prefix then
				if prefix=='xmlns' then
					nsStack[#nsStack][name] = match2
				else
					currentAttribute[1] = name
					currentAttribute[4] = prefix
				end
			else
				if match1=='xmlns' then
					nsStack[#nsStack]['!'] = match2
					currentElement[2]      = match2
				end
			end
			currentAttributeCt = currentAttributeCt + 1
			currentAttributes[currentAttributeCt] = currentAttribute
			return true
		end
	end

	local function findCDATA()
		first, last, match1 = find( xml, '^<!%[CDATA%[(.-)%]%]>', pos )
		if first then
			finishText()
			if self._call.text then self._call.text(match1) end
			pos = last+1
			textStart = pos
			return true
		end
	end

	local function closeElement()
		first, last, match1 = find( xml, '^%s*(/?)>', pos )
		if first then
			state = "text"
			pos = last+1
			textStart = pos

			if currentElement[3] then currentElement[2] = nsForPrefix(currentElement[3])    end
			if self._call.startElement then self._call.startElement(unpack(currentElement)) end
			if self._call.attribute then
				for i=1,currentAttributeCt do
					if currentAttributes[i][4] then currentAttributes[i][3] = nsForPrefix(currentAttributes[i][4]) end
					self._call.attribute(unpack(currentAttributes[i]))
				end
			end

			if match1=="/" then
				pop(nsStack)
				if self._call.closeElement then self._call.closeElement(unpack(currentElement)) end
			end
			return true
		end
	end

	local function findElementClose()
		first, last, match1, match2 = find( xml, '^</([%a_][%w_.-]*)%s*>', pos )
		if first then
			nsURI = nil
			for i=#nsStack,1,-1 do if nsStack[i]['!'] then nsURI = nsStack[i]['!']; break end end
		else
			first, last, match2, match1 = find( xml, '^</([%a_][%w_.-]*):([%a_][%w_.-]*)%s*>', pos )
			if first then nsURI = nsForPrefix(match2) end
		end
		if first then
			finishText()
			if self._call.closeElement then self._call.closeElement(match1,nsURI) end
			pos = last+1
			textStart = pos
			pop(nsStack)
			return true
		end
	end

	while pos<#xml do
		if state=="text" then
			if not (findPI() or findComment() or findCDATA() or findElementClose()) then		
				if startElement() then
					state = "attributes"
				else
					first, last = find( xml, '^[^<]+', pos )
					pos = (first and last or pos) + 1
				end
			end
		elseif state=="attributes" then
			if not findAttribute() then
				if not closeElement() then
					print("Unable to load VCF for " .. fileName .. " (XML is broken)")
					break
				end
			end
		end
	end
end

function SLAXML:dom(xml, filename, opts)
	if not opts then opts={} end
	local rich = not opts.simple
	local push, pop = table.insert, table.remove
	local stack = {}
	local doc = { type="document", name="#doc", kids={} }
	local current = doc
	local builder = SLAXML:parser{
		startElement = function(name,nsURI)
			local el = { type="element", name=name, kids={}, el=rich and {} or nil, attr={}, nsURI=nsURI, parent=rich and current or nil }
			if current==doc then
				if doc.root then error(("Encountered element '%s' when the document already has a root '%s' element"):format(name,doc.root.name)) end
				doc.root = el
			end
			push(current.kids,el)
			if current.el then push(current.el,el) end
			current = el
			push(stack,el)
		end,
		attribute = function(name,value,nsURI)
			if not current or current.type~="element" then error(("Encountered an attribute %s=%s but I wasn't inside an element"):format(name,value)) end
			local attr = {type='attribute',name=name,nsURI=nsURI,value=value,parent=rich and current or nil}
			if rich then current.attr[name] = value end
			push(current.attr,attr)
		end,
		closeElement = function(name)
			if current.name~=name or current.type~="element" then error(("Received a close element notification for '%s' but was inside a '%s' %s"):format(name,current.name,current.type)) end
			pop(stack)
			current = stack[#stack]
		end,
		text = function(value)
			if current.type~='document' then
				if current.type~="element" then error(("Received a text notification '%s' but was inside a %s"):format(value,current.type)) end
				push(current.kids,{type='text',name='#text',value=value,parent=rich and current or nil})
			end
		end,
		comment = function(value)
			push(current.kids,{type='comment',name='#comment',value=value,parent=rich and current or nil})
		end,
		pi = function(name,value)
			push(current.kids,{type='pi',name=name,value=value,parent=rich and current or nil})
		end
	}
	builder:parse(xml, filename, opts)
	return doc
end
return SLAXML