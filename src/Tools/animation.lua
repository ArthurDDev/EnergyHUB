require 'src/Objects/world.lua'
anim8 = require 'libraries/anim8-master/anim8.lua'

function load_animation()
  grid1 = anim8.newGrid(48, 48, sprites[1].image:getWidth(), sprites[1].image:getHeight())
  grid2 = anim8.newGrid(32, 32, sprites[2].image:getWidth(), sprites[2].image:getHeight())
  grid3 = anim8.newGrid(32, 32, sprites[3].image:getWidth(), sprites[3].image:getHeight())

  sprites[1].animation = anim8.newAnimation(grid1(1, '1-10'), 0.3)
  sprites[2].animation = anim8.newAnimation(grid2(1, '1-2'), 0.3)
  sprites[3].animation = anim8.newAnimation(grid3(1, '1-2'), 0.3)
end

function update_animation(sprite)
  sprite.animation:update(dt)
end

function draw_animation(sprite, x, y)
  sprite.animation:draw(sprite.image, x, y)
end
