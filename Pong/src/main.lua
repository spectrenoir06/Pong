Gamestate = require "class/Gamestate"
Camera    = require "class/Camera"
Timer     = require "class/Timer"
require "class/light"
require "class/postshader"



require "gamestate/jeu"

function love.load()
  
  Gamestate.registerEvents()
     Gamestate.switch(jeu)

end
