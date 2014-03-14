jeu = {}

function jeu:init()
 
  self.fond = love.graphics.newImage("texture/fond.png")
  self.j1   = love.graphics.newImage("texture/j1.png")
  self.j2   = love.graphics.newImage("texture/j2.png")
  self.imgBall = love.graphics.newImage("texture/ball.png")
  self.bump = love.audio.newSource("sfx/bump.wav", "static")
  self.point = love.audio.newSource("sfx/point.wav", "static")
  
  self.lightWorld = love.light.newWorld()
  self.lightWorld.setAmbientColor(100,100, 100)
  
 -- self.light1 = self.lightWorld.newLight(1280/2, 0, 255, 255, 255, 300)
--  self.light2 = self.lightWorld.newLight(1280/2, 600, 255, 255, 255, 300)
  
  self.perso1 = {
                  x = 75 ,
                  y = 250
                }
  self.perso2 = {
                  x = 1280-75 ,
                  y = 250
                }
  self.ball = {
                x = 1280/2,
                y= 300,
                dx = 300,
                dy = 0,
                oldx = 1280/2,
                oldy = 300,
                light = self.lightWorld.newLight(0, 0, 255, 0, 0, 100)
              }
   self.ball.light.setGlowStrength(10)

end


function jeu:enter()
  
end


function jeu:draw()

  self.lightWorld.update()
  
  love.graphics.draw(self.fond, 0, 0)

  self.lightWorld.drawShadow()
  
  love.graphics.draw(self.j1, self.perso1.x-self.j1:getWidth()/2 , self.perso1.y-self.j1:getHeight()/2 )
  love.graphics.draw(self.j2, self.perso2.x-self.j2:getWidth()/2 , self.perso2.y-self.j2:getHeight()/2 )
  love.graphics.draw(self.imgBall, self.ball.x-self.imgBall:getWidth()/2 , self.ball.y-self.imgBall:getHeight()/2 )
  
  self.lightWorld.drawShine()
  --love.postshader.draw("bloom")
end


function jeu:update(dt)
  self.ball.x = self.ball.x + self.ball.dx * dt
  self.ball.y = self.ball.y + self.ball.dy * dt
  
  self.perso1.y = love.mouse.getY()
  self.perso2.y = love.mouse.getY()
  
  if self.ball.y > 600 - self.imgBall:getHeight()/2 then  -- rebond bas
    self.ball.dy = -self.ball.dy
    self.ball.y = 600 - self.imgBall:getHeight()/2
    self.bump:play()
  elseif self.ball.y < 0 + self.imgBall:getHeight()/2 then -- rebond ahut
    self.ball.dy = -self.ball.dy
    self.ball.y = 0 + self.imgBall:getHeight()/2
    self.bump:play()
  end
  
  if self.ball.x > 1280 - self.imgBall:getWidth()/2 then -- rebond droite
    self.point:play()
    self.ball.x = 1280 - self.imgBall:getWidth()/2
    self.ball.dx = -self.ball.dx
  elseif self.ball.x < 0 + self.imgBall:getWidth()/2 then -- rebond gauche
    self.point:play()
    self.ball.x = 0 + self.imgBall:getWidth()/2
    self.ball.dx = -self.ball.dx
  end
  
  if  self.ball.x - self.imgBall:getWidth() /2 < self.perso1.x + self.j1:getWidth() /2   -- rebond j1
  and self.ball.y + self.imgBall:getHeight()/2 > self.perso1.y - self.j1:getHeight()/2
  and self.ball.y - self.imgBall:getHeight()/2 < self.perso1.y+self.j1:getHeight()/2
  and self.ball.oldx - self.imgBall:getWidth() /2 >= self.perso1.x + self.j1:getWidth() /2 then
    
    self.ball.x = self.perso1.x + self.j1:getWidth()/2 + self.imgBall:getWidth()/2
    self.ball.dx = -self.ball.dx +  75
    self.ball.dy =  self.ball.dy + (self.ball.y - self.perso1.y ) * 5
    self.ball.light.setColor(255, 0, 0)
    self.bump:play()
  end
  
    if  self.ball.x + self.imgBall:getWidth() /2 > self.perso2.x - self.j2:getWidth() /2    -- rebond j2
  and self.ball.y + self.imgBall:getHeight()/2 > self.perso2.y - self.j2:getHeight()/2
  and self.ball.y - self.imgBall:getHeight()/2 < self.perso2.y+self.j2:getHeight()/2
  and self.ball.oldx + self.imgBall:getWidth() /2 <= self.perso2.x - self.j2:getWidth() /2 then
    
    self.ball.x = self.perso2.x - self.j2:getWidth()/2 - self.imgBall:getWidth()/2
    self.ball.dx = -self.ball.dx -  75
    self.ball.dy =  self.ball.dy + (self.ball.y - self.perso2.y ) * 5
    self.bump:play()
    self.ball.light.setColor(0, 0, 255)
  end
  
  self.ball.light.setPosition(self.ball.x,self.ball.y)
  
  self.ball.oldx , self.ball.oldy = self.ball.x , self.ball.y
  

end

function jeu:mousepressed(Sx, Sy, button)

end


function jeu:keypressed(key)

end