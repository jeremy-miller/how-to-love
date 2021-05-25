io.stdout:setvbuf("no")  -- make print() immediately appear in Output, instead of waiting until process exits

function love.load()
  Object = require "classic"
  require "player"
  require "enemy"
  require "bullet"
  
  player = Player()
  enemy = Enemy()
  listOfBullets = {}
end

function love.update(dt)  -- dt = delta time (time passed between previous and current updates - ensure speed is the same on all computers)
  player:update(dt)
  enemy:update(dt)
  
  for i,v in ipairs(listOfBullets) do
    v:update(dt)
    v:checkCollision(enemy)
    if v.dead then
      table.remove(listOfBullets, i)
    end
  end
end

function love.draw()
  player:draw()
  enemy:draw()
  
  for i,v in ipairs(listOfBullets) do
    v:draw()
  end
end

function love.keypressed(key)
  player:keyPressed(key)
end
