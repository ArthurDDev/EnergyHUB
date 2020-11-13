-------------------------------------------------------------------------------------

---------------------Window
love.window.setMode(800, 600)

---------------------Camera
--Set camera
cameraFile=require 'libraries/hump-master/camera'
cam=cameraFile()
--Set camera variables
camX=60*16/2
camY=60*16/2
camspeed=200

----------------------Libraries
--lunajson
local newdecoder = require 'libraries/lunajson.decoder'
local decode = newdecoder()
----------------------Configuration
--construction
file = assert(io.open("assets/Configuration/constructionConfig.json"))
local configContents = file:read("*all")
constructionConfig = decode(configContents)

----------------------Tools
--Renderer
local Renderer=require 'src/Tools/renderer'
renderer=Renderer:create()
--gameLoop
local GameLoop=require 'src/Tools/gameLoop'
gameLoop=GameLoop:create()


----------------------Objects
--World
world = require 'src/Objects/world'

--UI Window
UIWindow = require 'src/Objects/UI/UIWindow'
require 'src/Objects/UI/UI'

require 'src/Objects/menu'

function love.load() --------------------------------------------------Load

  ----------Camera
  --zoom
  cam:zoom(2)
  --filter
  love.graphics.setDefaultFilter( "nearest", "nearest", 0 )

  ----------World
  worldStart()

end

function love.update(dt) --------------------------------------------- Update
  if ingame==true then
  --world:update(dt)
    worldUpdate(dt)
    cam:lookAt(camX, camY)

  --------------------Camera
  --movement
    if love.keyboard.isDown('w') then
      camY=math.floor(camY-camspeed*dt)
    end
    if love.keyboard.isDown('s') then
      camY=math.floor(camY+camspeed*dt)
    end
    if love.keyboard.isDown('d') then
      camX=math.floor(camX+camspeed*dt)
    end
    if love.keyboard.isDown('a') then
      camX=math.floor(camX-camspeed*dt)
    end
  --clamp
    if camX < 0 then camX = 0 end
    if camX > 60*16 then camX = 60*16 end
    if camY < 0 then camY = 0 end
    if camY > 60*16 then camY = 60*16 end

  --------------------UIWindow
    UIUpdate()
  end

end

function love.draw() ------------------------------------------------- Draw
  if ingame==false then
    draw_menu()
  end

  if ingame==true then
    cam:attach()

    --Tudo colocado aqui será desenhado na camera

    --Renderer
      worldDraw()
      renderer:draw()

    cam:detach()

  --Tudo colocado aqui será desenhado em cima da camera

  --UI
    UIDraw()
  end

end
function turnos()
  money = money-expenses
end
