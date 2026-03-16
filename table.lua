local engine = select(2,...)

local table_wipe = wipe
local next = next
local type = type
local table_remove = table.remove


local function table_getKeyByValue(tbl,value)
	for k,v in next,tbl do
		if v == value then
			return k
		end
	end
end

local function table_removeByValue(tbl,value)
	local key = table_getKeyByValue(tbl,value)
	if not key then return end

	if type(key) == "number" and table_remove(tbl,key) then
		return true
	end

	if tbl[key] then
		tbl[key] = nil
		return true
	end
end

local table_del,table_new
do
	local cache = setmetatable({},{__mode = "k"})

	table_new = function()
		local n,t = #cache
		if n == 0 then
			t = {}
		else
			t,cache[n] = cache[n]
		end

		return t
	end

	table_del = function(t)
		table_wipe(t)
		cache[#cache+1] = t	
	end
end

local function table_copy(tbl,deep)
	local result = table_new()
	for k,v in pairs(tbl) do
		if deep and type(v) == "table" then
			result[k] = copy(v,deep)
		else
			result[k] = v
		end
	end

	return result
end

engine.table = setmetatable({
	getKeyByValue = table_getKeyByValue,
	removeByValue = table_removeByValue,
	new = table_new,
	del = table_del,
	copy = table_copy,
	wipe = table_wipe,
},{__index = table})