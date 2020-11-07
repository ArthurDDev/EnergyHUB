----------------------------------------------------
--require 'src/Tools/animation'
----------------Controll
--money
money = 0
credits = 0
--timer
mTimer = 0
mTargetTimer = 30
moneyAdd = 50

---------------Tiles
size = {}
size.x = 60
size.y = 60

tilemap = {}
tilemap.size = size
tilemap.cells = {}

----------------Construction
selected = 1

sprites={}

sprites[1]={}
sprites[1].image = love.graphics.newImage("assets/Sprites/Usinas/Termoeletrica.png") --Load Sprites

sprites[2]={}
sprites[2].image = love.graphics.newImage("assets/Sprites/Usinas/Biomassa.png") --Load Sprites

sprites[3]={}
sprites[3].image = love.graphics.newImage("assets/Sprites/Usinas/Hidrelétrica (1).png") --Load Sprites

sprites[4]={}
sprites[4].image = love.graphics.newImage("assets/Sprites/Usinas/Solar01.png") --Load Sprites

sprites[5]={}
sprites[5].image = love.graphics.newImage("assets/Sprites/Usinas/Hidrelétrica (1).png") --Load Sprites

sprites[6]={}
sprites[6].image = love.graphics.newImage("assets/Sprites/Usinas/Nuclear.png") --Load Sprites

isMouseOnWorld = true

function worldStart()

  ----------------Tiles
  --tileset
  tilesetImage = love.graphics.newImage('assets/Sprites/Tilesets/TileSet.png')
  tileset = newTileSet(tilesetImage, 16, 25)

  --initialize tiles
  local imagedata = love.image.newImageData('assets/Sprites/map.png')

  --------------World
  for i = 0, tilemap.size.x - 1 do
    tilemap.cells[i] = {}
    for j = 0, tilemap.size.y - 1 do
      tilemap.cells[i][j] = {}
      tilemap.cells[i][j].type = "water"
      tilemap.cells[i][j].filled = true
      tilemap.cells[i][j].construction = 0
      tilemap.cells[i][j].sprite = 2
      tilemap.cells[i][j].father = {}
      tilemap.cells[i][j].father["X"] = nil
      tilemap.cells[i][j].father["Y"] = nil

      local r = imagedata:getPixel(i, j)

      if r == 0 then
        tilemap.cells[i][j].sprite = 1
        tilemap.cells[i][j].type = "land"
        tilemap.cells[i][j].filled = false
      end
    end
  end

end

function worldUpdate(dt)
  -------------Money
  if mTimer < mTargetTimer then
    mTimer = mTimer + dt*10
  else
    mTimer = 0
    money = money + moneyAdd
  end

  --------------Build
  mouseX = math.floor((love.mouse.getX()/2 + camX - 200)/16)
  mouseY = math.floor((love.mouse.getY()/2 + camY - 150)/16)

  --Debug
  if mouseX > -1 and mouseX < tilemap.size.x and mouseY > -1 and mouseY < tilemap.size.y then
    if tilemap.cells[mouseX][mouseY].filled == true then
      print("Position: "..mouseX.." : "..mouseY.." -- Cell:  "..tilemap.cells[mouseX][mouseY].type.." : ".."True".." : "..tilemap.cells[mouseX][mouseY].construction)
    else
      print("Position: "..mouseX.." : "..mouseY.." -- Cell:  "..tilemap.cells[mouseX][mouseY].type.." : ".."False".." : "..tilemap.cells[mouseX][mouseY].construction)
    end
  else
    print("No tile selected!")
  end

  if love.mouse.isDown(1) and isMouseOnWorld then
    local proceed = true

    local width = constructionConfig[""..selected]["size"]["width"]
    local height = constructionConfig[""..selected]["size"]["height"]

    local offsetX = constructionConfig[""..selected]["offset"]["X"]
    local offsetY = constructionConfig[""..selected]["offset"]["Y"]

    for i = 0, width - 1 do
      for j = 0, height - 1 do
        if tilemap.cells[mouseX - offsetX + 1 + i][mouseY - offsetX + 1 + j].filled == true then  proceed = false end
      end
    end

    if tilemap.cells[mouseX][mouseY].filled == false then
      if proceed == true then
        tilemap.cells[mouseX - offsetX + 1][mouseY - offsetY + 1].construction = selected

        for i = 0, width - 1 do
          for j = 0, height - 1 do
            tilemap.cells[mouseX - offsetX + 1 + i][mouseY - offsetX + 1 + j].filled = true
            tilemap.cells[mouseX - offsetX + 1 + i][mouseY - offsetX + 1 + j].father["X"] = mouseX - offsetX + 1
            tilemap.cells[mouseX - offsetX + 1 + i][mouseY - offsetX + 1 + j].father["Y"] = mouseX - offsetY + 1
          end
        end
      end
    end
  end

end

function worldDraw()

  ------------TileSet
  for i = 0, tilemap.size.x - 1 do
    for j = 0, tilemap.size.y - 1 do
      love.graphics.draw(tileset.spriteSheet, tileset.quads[tilemap.cells[i][j].sprite], i*16, j*16)
    end
  end

  -------------Build
  --Buildings
  for i = 0, tilemap.size.x - 1 do
    for j = 0, tilemap.size.y - 1 do
      local construction = tilemap.cells[i][j].construction
      if construction ~= 0 then
        --love.graphics.draw(sprites[construction].image, i*16, j*16)
        --load_animation()
        --update_animation(sprites[construction], dt)
        draw_animation(sprites[construction], i*16, j*16)
      end
    end
  end
  --Selection
  if mouseX > -1 and mouseX < tilemap.size.x and mouseY > -1 and mouseY < tilemap.size.y then
    love.graphics.rectangle("line", mouseX*16, mouseY*16, 16, 16, 2, 2)
  end

end

------------------Other functions

function newTileSet(image, width, height) --create tileset
  local tileSet = {}
  tileSet.spriteSheet = image;
  tileSet.quads = {};

  for y = 0, image:getHeight() - height, height do
      for x = 0, image:getWidth() - width, width do
        table.insert(tileSet.quads, love.graphics.newQuad(x + 1 + 2*x/height, y, width, height, image:getDimensions()))
      end
  end

  return tileSet
end

anim8 = require 'libraries/anim8-master/anim8'

function load_animation()
  grid1 = anim8.newGrid(32, 32, sprites[1].image:getWidth(), sprites[1].image:getHeight())
  grid2 = anim8.newGrid(112, 64, sprites[2].image:getWidth(), sprites[2].image:getHeight())
  grid3 = anim8.newGrid(48, 48, sprites[3].image:getWidth(), sprites[3].image:getHeight())
  grid4 = anim8.newGrid(48, 48, sprites[4].image:getWidth(), sprites[4].image:getHeight())
  grid5 = anim8.newGrid(48, 48, sprites[3].image:getWidth(), sprites[3].image:getHeight())
  grid6 = anim8.newGrid(32, 32, sprites[6].image:getWidth(), sprites[6].image:getHeight())

  sprites[1].animation = anim8.newAnimation(grid1(1, '1-2'), 0.3)
  sprites[2].animation = anim8.newAnimation(grid2(1, '1-2'), 0.3)
  sprites[3].animation = anim8.newAnimation(grid3(1, '1-2'), 0.3)
  sprites[4].animation = anim8.newAnimation(grid4(1, '1-10'), 0.3)
  sprites[5].animation = anim8.newAnimation(grid5(1, '1-2'), 0.3)
  sprites[6].animation = anim8.newAnimation(grid6(1, '1-2'), 0.3)
end

function update_animation(sprite, dt)
  sprite.animation:update(dt)
end

function draw_animation(sprite, x, y)
  sprite.animation:draw(sprite.image, x, y)
end
