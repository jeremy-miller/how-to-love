 function love.load()
  player = {
    x = 100,
    y = 100,
    size = 25,
    image = love.graphics.newImage("face.png")
  }

  coins = {}

  for i=1,25 do
    table.insert(coins,
      {
        x = love.math.random(50, 650),
        y = love.math.random(50, 450),
        size = 10,
        image = love.graphics.newImage("dollar.png")
      }
    )
  end
  
  score = 0
  
  shakeDuration = 0
  shakeWait = 0
  shakeOffset = {x = 0, y = 0}
end

function love.update(dt)
  if love.keyboard.isDown("left") then
    player.x = player.x - 200 * dt
  elseif love.keyboard.isDown("right") then
    player.x = player.x + 200 * dt
  end

  if love.keyboard.isDown("up") then
    player.y = player.y - 200 * dt
  elseif love.keyboard.isDown("down") then
    player.y = player.y + 200 * dt
  end
  
  for i=#coins,1,-1 do
    if checkCollision(player, coins[i]) then
      table.remove(coins, i)
      player.size = player.size + 1
      score = score + 1
      shakeDuration = 0.3
    end
  end
  
  if shakeDuration > 0 then
    shakeDuration = shakeDuration - dt
    if shakeWait > 0 then
      shakeWait = shakeWait - dt
    else
      shakeOffset.x = love.math.random(-5,5)
      shakeOffset.y = love.math.random(-5,5)
      shakeWait = 0.05
    end
  end
end

function love.draw()
  love.graphics.push()
    if shakeDuration > 0 then
      love.graphics.translate(love.math.random(-5,5), love.math.random(-5,5))
    end
  
    -- move "camera" so player is in top-left corner (-player.x, -player.y), then move the player to the center of the camera (400, 300)
    love.graphics.translate(-player.x + 400, -player.y + 300)
    love.graphics.circle("line", player.x, player.y, player.size)
    love.graphics.draw(player.image, player.x, player.y,
      0, 1, 1, player.image:getWidth()/2, player.image:getHeight()/2)
    for i,v in ipairs(coins) do
      love.graphics.circle("line", v.x, v.y, v.size)
      love.graphics.draw(v.image, v.x, v.y,
        0, 1, 1, v.image:getWidth()/2, v.image:getHeight()/2)
    end
  love.graphics.pop()
  love.graphics.print("Score: " .. score, 10, 10)
end

function checkCollision(p1, p2)
  local distance = math.sqrt((p1.x - p2.x)^2 + (p1.y - p2.y)^2)
  return distance < p1.size + p2.size
end
