rocket = {}

function rocket:load()
    self.texture = love.graphics.newImage("res/image/rocket.png")
    self.rotation = 90
    self.y_velocity = 0
end

function rocket:update(dt)
    local vector1 = { x = 0, y = 1 }
    local vector2 = { x = math.cos(self.rotation * math.pi / 180), y = math.sin(self.rotation * math.pi / 180) }

    local dot_product = vector1.x * vector2.x + vector1.y * vector2.y

    if love.keyboard.isDown("space") then
        self.y_velocity = -1
    else
        self.y_velocity = 1
    end

    self.rotation = self.rotation + self.y_velocity * 150 * dot_product * dt
end

function rocket:draw()
    love.graphics.draw(self.texture, canvas_width / 3, canvas_height / 2 - 50, self.rotation * math.pi / 180, 1, 1,
        self.texture:getWidth() / 2, self.texture:getHeight() * 0.9)
end
