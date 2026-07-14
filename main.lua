SMODS.ScreenShader {
    key = "mirror",
    path = "mirror.fs",
}

local function mirror_x(x)
    return love.graphics.getWidth() - x
end

local gxh = love.mouse.getX; function love.mouse.getX() return love.graphics.getWidth() - gxh() end

--[[
local gxh = love.mouse.getX
function love.mouse.getX()
    return mirror_x(gxh())
end
]]

local gph = love.mouse.getPosition
function love.mouse.getPosition()
    local x,y = gph()
    return mirror_x(x), y
end

local ldh = love.graphics.draw
function love.graphics.draw(...)
    local args = {...}
    if args[1].typeOf and args[1]:typeOf("Text") then
        local first_number = nil
        for i,v in pairs(args) do
            if not first_number and type(v) == "number" then
                first_number = i
            end
        end
        if first_number then
            args[first_number+3] = (args[first_number+3] or 1) * -1
            local width = args[1].getWidth and args[1]:getWidth() or 0
            args[first_number+5] = args[first_number+5] or 0
            args[first_number+5] = args[first_number+5] + width
        end
    end
    return ldh(unpack(args))
end

local lph = love.graphics.print
function love.graphics.print(...)
    local args = {...}
    args[1] = string.reverse(args[1])
    return lph(unpack(args))
end

local function traverse_table(t, match, call, stop)
    if not (t and type(t) == "table") then
        return
    end
    local to_search = { t }
    local seen = {}

    stop = stop or function() end

    for _, entry in ipairs(to_search) do
        for k, v in pairs(entry) do
            if type(v) == "table" and (not seen[v]) and (not stop(v)) then
                table.insert(to_search, v)
                seen[v] = true
            elseif match(v) then
                local r = call(v)
                if r then
                    entry[k] = r
                end
            end
        end
    end
end

local dtin = DynaText.init
function DynaText:init(config)
    local cfg = SMODS.shallow_copy(config)
    local function is_string(v) return type(v) == "string" end
    local function is_obj(v) return getmetatable(v) end
    -- traverse_table(cfg.string, is_string, string.reverse, is_obj)
    -- traverse_table(cfg.strings, is_string, string.reverse, is_obj)
    if type(cfg.string) == "string" then
        cfg.string = string.reverse(cfg.string)
    end

    return dtin(self, cfg)
end

-- local function calc_offset(index, dyna)
--     local center = dyna.T.x + (dyna.T.w / 2)
--     local char_pos = dyna.T.x + (dyna.scale * index)
--     local off = center - char_pos
--     return off
-- end

---@param letter DynaTextLetter
function Ortalarp_text_effect(dyna, index, letter)
    -- if not dyna.larped then

    -- end
end