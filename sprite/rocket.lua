rocket = {}

function rocket:load()
    self.texture = love.graphics.newImage("res/image/rocket.png")
    self.square_texture = love.graphics.newImage("res/image/square.png")
    self.rotation = 90
    self.y_velocity = 0
    self.position = { x = canvas_width / 3, y = canvas_height / 2 - 50 }
    self.smokes = {}
    self.smoke_timer = 0.15
    self.offset = 0
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

    local cross_product = vector1.x * vector2.y - vector2.x * vector1.y
    self.offset = -500 * cross_product
    self:update_smokes(dt)
end

function rocket:update_smokes(dt)
    for i = #self.smokes, 1, -1 do
        local smoke = self.smokes[i]
        smoke.x = smoke.x + smoke.speed.x * dt
        smoke.y = smoke.y + smoke.speed.y * dt + self.offset * dt * 3

        if smoke.x < -50 then
            table.remove(self.smokes, i)
        end
    end

    self.smoke_timer = self.smoke_timer - dt

    if self.smoke_timer < 0 then
        self.smoke_timer = 0.15
        local smoke = {
            x = self.position.x,
            y = self.position.y,
            rotation = math.random(0, 360),
            size = math.random(7, 22),
            speed = {}
        }

        if math.random(0, 1) == 0 then
            smoke.speed.x = -math.random(400, 450)
        else
            smoke.speed.x = -math.random(500, 550)
        end

        if math.random(0, 1) == 0 then
            smoke.speed.y = math.random(20, 25)
        else
            smoke.speed.y = math.random(30, 35)
        end

        smoke.speed.y = smoke.speed.y * ((math.random(0, 1) == 0 and -1) or 1)

        table.insert(self.smokes, smoke)
    end
end

function rocket:draw()
    self:draw_smokes()
    love.graphics.draw(self.texture, self.position.x, self.position.y, self.rotation * math.pi / 180, 1, 1,
        self.texture:getWidth() / 2, self.texture:getHeight() * 0.9)
end

function rocket:draw_smokes()
    love.graphics.setColor(0.67, 0.67, 0.67, 1)
    for i = 1, #self.smokes do
        local smoke = self.smokes[i]
        love.graphics.draw(self.square_texture, smoke.x, smoke.y, smoke.rotation * math.pi / 180,
            smoke.size, smoke.size)
    end
    love.graphics.setColor(1, 1, 1, 1)
end
