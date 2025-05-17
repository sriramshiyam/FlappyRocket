triangles = {}

function triangles:load()
    self.list = {}
    self.offset = 0
    local x1 = canvas_width + 1000
    for i = 1, 5 do
        local y1 = love.math.random(canvas_height / 2 - love.math.random(0, 300), canvas_height / 2)
        table.insert(self.list, { { x1 = x1, y1 = y1, x2 = x1 - 900, y2 = y1 - 2000, x3 = x1 + 900, y3 = y1 - 2000 },
            { x1 = x1, y1 = y1 + 300, x2 = x1 - 900, y2 = y1 + 2000, x3 = x1 + 900, y3 = y1 + 2000 } })
        x1 = x1 + 1000
    end
end

function triangles:update(dt)
    for i = #self.list, 1, -1 do
        local triangle1 = self.list[i][1]
        local triangle2 = self.list[i][2]
        if triangle1.x3 < 0 then
            table.remove(self.list, i)
            local x1 = self.list[#self.list][1].x1 + 1000
            local y1 = love.math.random(
                self.list[#self.list][1].y1 + (((love.math.random(0, 1) == 0 and 1) or -1) * love.math.random(0, 300)),
                self.list[#self.list][1].y1)
            table.insert(self.list, { { x1 = x1, y1 = y1, x2 = x1 - 900, y2 = y1 - 2000, x3 = x1 + 900, y3 = y1 - 2000 },
                { x1 = x1, y1 = y1 + 300, x2 = x1 - 900, y2 = y1 + 2000, x3 = x1 + 900, y3 = y1 + 2000 } })
        else
            triangle1.x1 = triangle1.x1 - 600 * dt
            triangle1.x2 = triangle1.x2 - 600 * dt
            triangle1.x3 = triangle1.x3 - 600 * dt
            triangle2.x1 = triangle2.x1 - 600 * dt
            triangle2.x2 = triangle2.x2 - 600 * dt
            triangle2.x3 = triangle2.x3 - 600 * dt
            triangle1.y1 = triangle1.y1 + self.offset * dt * 3
            triangle1.y2 = triangle1.y2 + self.offset * dt * 3
            triangle1.y3 = triangle1.y3 + self.offset * dt * 3
            triangle2.y1 = triangle2.y1 + self.offset * dt * 3
            triangle2.y2 = triangle2.y2 + self.offset * dt * 3
            triangle2.y3 = triangle2.y3 + self.offset * dt * 3
        end
    end
end

function triangles:draw()
    for i = 1, #self.list do
        local triangle1 = self.list[i][1]
        local triangle2 = self.list[i][2]
        love.graphics.polygon("fill", triangle1.x1, triangle1.y1, triangle1.x2, triangle1.y2, triangle1.x3, triangle1.y3)
        love.graphics.polygon("fill", triangle2.x1, triangle2.y1, triangle2.x2, triangle2.y2, triangle2.x3, triangle2.y3)
    end
end
