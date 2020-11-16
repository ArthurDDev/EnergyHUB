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

local justClicked = false

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

  if love.keyboard.isDown('t') then
    if justClicked then
      if energy >= energyr then
        turnos()
      end
    end
    justClicked = false
  else justClicked = true end

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
    if camX < 200 then camX = 200 end
    if camX > 60*16 - 200 then camX = 60*16 - 200 end
    if camY < 150 then camY = 150 end
    if camY > 60*16 - 150 then camY = 60*16 - 150 end

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
  money = money + moneyperround
  money = money-expenses
  population = population + population * 0.008
  energyr = population * 2.241

  credits = credits + nextcredits

end
