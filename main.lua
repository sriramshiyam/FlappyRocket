require "sprite.rocket"

canvas_width = 1920
canvas_height = 1080

local canvas
canvas_offset_x = 0
canvas_offset_y = 0
scale = 1

function love.load()
    love.window.setTitle("Flappy Rocket")
    love.window.setMode(800, 600, { resizable = true })
    love.window.maximize()
    love.graphics.setDefaultFilter("nearest", "nearest")
    canvas = love.graphics.newCanvas(canvas_width, canvas_height)
    rocket:load()
end

function love.update(dt)
    rocket:update(dt)
end

function love.draw()
    love.graphics.setCanvas(canvas)
    love.graphics.clear(0.17, 0.17, 0.17)
    rocket:draw()
    love.graphics.setCanvas()
    love.graphics.clear()
    love.graphics.draw(canvas, canvas_offset_x, canvas_offset_y, 0, scale, scale)
end

function love.resize(window_width, window_height)
    scale = math.min(window_width / canvas_width, window_height / canvas_height)
    canvas_offset_x = (window_width - canvas_width * scale) / 2
    canvas_offset_y = (window_height - canvas_height * scale) / 2
end
