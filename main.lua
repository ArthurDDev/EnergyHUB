function love.load()
  love.window.setMode(800, 600)
  cameraFile=require 'libraries/hump/camera'
  cam=cameraFile()

  camX=love.graphics.getWidth()/2
  camY=love.graphics.getHeight()/2
  camspeed=200

  build=false
  --local Renderer=require 'renderer'
  --renderer=Renderer:create()
  require 'player'

  wf=require 'libraries/windfield/windfield'
  world=wf.newWorld(0, 0, false)
  world:setQueryDebugDrawing(true)
  world:addCollisionClass('Build')
  ex=world:newRectangleCollider(100, 100, 200, 200, {collision_class='Build'})

end

function love.update(dt)
  world:update(dt)
  playerUpdate(dt)
  cam:lookAt(camX, camY)

  if love.keyboard.isDown('up') then
    camY=camY-camspeed*dt
  end
  if love.keyboard.isDown('down') then
    camY=camY+camspeed*dt
  end
  if love.keyboard.isDown('right') then
    camX=camX+camspeed*dt
  end
  if love.keyboard.isDown('left') then
    camX=camX-camspeed*dt
  end

  if love.mouse.isDown(1) then
    colliders=world:queryRectangleArea(love.mouse.getX(), love.mouse.getY(), 20, 20, {'Build'})
    if #colliders>0 then
      build=true
    end
  end
end

function love.draw()
  --renderer:draw()
  playerDraw()
  if yay==true then
    love.graphics.print('YAY')
  end
  cam:attach()
    world:draw()
    love.graphics.rectangle('fill', 0, 0, 100, 100)
  cam:detach()
end
