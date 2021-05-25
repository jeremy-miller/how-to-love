function love.load()
  Object = require "classic"
  
  require "entity"
  require "player"
  require "wall"
  require "box"
  
  player = Player(100, 100)
  wall = Wall(200, 100)
  box = Box(400, 150)
  
  objects = {}
  table.insert(objects, player)
  table.insert(objects, wall)
  table.insert(objects, box)
end

function love.update(dt)
  for i,v in ipairs(objects) do
    v:update(dt)
  end
  
  local loop = true
  local limit = 0
  
  while loop do
    loop = false
    limit = limit + 1
    
    if limit > 100 then
      break
    end
    
    for i=1,#objects-1 do  -- don't need to check for collisions with the final object
      for j=i+1,#objects do  -- make sure we don't check for collisions with itself
        local collision = objects[i]:resolveCollision(objects[j])
        if collision then
          loop = true
        end
      end
    end
  end
end

function love.draw()
  for i,v in ipairs(objects) do
    v:draw()
  end
end
