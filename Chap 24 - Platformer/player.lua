Player = Entity:extend()

function Player:new(x, y)
  Player.super.new(self, x, y, "player.png")
  self.strength = 10
  self.canJump = false
end

function Player:update(dt)
  Player.super.update(self, dt)
  
  if love.keyboard.isDown("left") then
    self.x = self.x - 200 * dt
  elseif love.keyboard.isDown("right") then
    self.x = self.x + 200 * dt
  end
  
  -- only allow jumping if you're on the ground
  if self.last.y ~= self.y then
    self.canJump = false
  end
end

function Player:jump()
  if self.canJump then
    self.gravity = -300
    self.canJump = false
  end
end

function Player:collide(e, direction)
  Player.super.collide(self, e, direction)
  if direction == "bottom" then
    self.canJump = true
  end
end
