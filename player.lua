money=0
cCredits=0
timer=0

function playerUpdate(dt)
  if timer<30 then
    timer=timer+dt
  elseif timer>30 then
    timer=0
    money=money+100
  end
end

function playerDraw()
  love.graphics.printf('$'..money, 0, 50, love.graphics.getWidth()/2, 'center')
  --love.graphics.print(timer)
end
