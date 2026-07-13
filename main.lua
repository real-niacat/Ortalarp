SMODS.ScreenShader {
    key = "mirror",
    path = "mirror.fs",
}

local function mirror_x(x)
    return love.graphics.getWidth() - x
end

local gxh = love.mouse.getX
function love.mouse.getX()
    return mirror_x(gxh())
end

local gph = love.mouse.getPosition
function love.mouse.getPosition()
    local x,y = gph()
    return mirror_x(x), y
end
last = ""
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