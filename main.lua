-------------------------------------------------------------------------------------

---------------------Window
love.window.setMode(800, 600)
  
---------------------Camera
--Set camera
cameraFile=require 'libraries/hump-master/camera'
cam=cameraFile()
--Set camera variables
camX=0
camY=0
camspeed=200

build=false

----------------------Tools
--Renderer
local Renderer=require 'src/Tools/renderer'
renderer=Renderer:create()
--gameLoop
local GameLoop=require 'src/Tools/gameLoop'
gameLoop=GameLoop:create()

----------------------Objects
--World
require 'src/Objects/world'
--UI
require 'src/Objects/UI'


----------------------Windfield
--wf=require 'libraries/windfield-master/windfield'
--world=wf.newWorld(0, 0, false)

function love.load()

  ----------Camera
  --zoom
  cam:zoom(2)

  ----------World
  worldStart()

end

function love.update(dt)

  --world:update(dt)
  worldUpdate(dt)
  cam:lookAt(camX, camY)

  --------------------Camera
  if love.keyboard.isDown('w') then
    camY=camY-camspeed*dt
  end
  if love.keyboard.isDown('s') then
    camY=camY+camspeed*dt
  end
  if love.keyboard.isDown('d') then
    camX=camX+camspeed*dt
  end
  if love.keyboard.isDown('a') then
    camX=camX-camspeed*dt
  end

end

function love.draw()

  cam:attach()

    --Renderer
    worldDraw()
    renderer:draw()

  cam:detach()

  --UI
  UIDraw()

end
