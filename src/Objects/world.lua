----------------------------------------------------
--require 'src/Tools/animation'
----------------Controll
--money
money = 1100000
nextcredits = 0
credits = 0
research = 0
expenses=0
moneyperround = 70000
--timer
energy = 0
energyr = 0
population = 5000000
---------------Tiless
size = {}
size.x = 60
size.y = 60

tilemap = {}
tilemap.size = size
tilemap.cells = {}

----------------Construction
selected = 0

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
sprites[5].image = love.graphics.newImage("assets/Sprites/Usinas/Turbina.png") --Load Sprites

sprites[6]={}
sprites[6].image = love.graphics.newImage("assets/Sprites/Usinas/Nuclear.png") --Load Sprites

isMouseOnWorld = true

function worldStart()

  energyr = population * 2.241

  load_animation()
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
      tilemap.cells[i][j].type = "lake"
      tilemap.cells[i][j].filled = false
      tilemap.cells[i][j].construction = 0
      tilemap.cells[i][j].sprite = 2
      tilemap.cells[i][j].father = {}
      tilemap.cells[i][j].father["X"] = -1
      tilemap.cells[i][j].father["Y"] = -1
      tilemap.cells[i][j].energy = 0
      tilemap.cells[i][j].credits = 0
      tilemap.cells[i][j].maintence = 0
      tilemap.cells[i][j].active = false

      local r, g, b, a = imagedata:getPixel(i, j)

      if r == 0 then
        tilemap.cells[i][j].sprite = 1
        tilemap.cells[i][j].type = "land"
      elseif r == 1 then
        tilemap.cells[i][j].type = "river"
      end
    end
  end

  UILoad()

end

function worldUpdate(dt)
  energy = 0
  nextcredits = 0
  expenses = 0
  for i = 0, 59 do
    for j = 0, 59 do
      if tilemap.cells[i][j].active == true then
        energy = energy + tilemap.cells[i][j].energy
        nextcredits = nextcredits + tilemap.cells[i][j].credits
        if tilemap.cells[i][j].maintence ~= 0 then expenses = expenses + tilemap.cells[i][j].maintence end
      end
    end
  end

  for key, animation in pairs(animations) do
    update_animation(animation, dt)
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

  if love.mouse.isDown(1) and isMouseOnWorld and selected ~= 0 then
    local proceed = true

    local width = constructionConfig[""..selected]["size"]["width"]
    local height = constructionConfig[""..selected]["size"]["height"]

    local offsetX = constructionConfig[""..selected]["offset"]["X"]
    local offsetY = constructionConfig[""..selected]["offset"]["Y"]

    for i = 0, width - 1 do
      for j = 0, height - 1 do
        if tilemap.cells[mouseX - offsetX + 1 + i][mouseY - offsetX + 1 + j].filled == true then  proceed = false end
        if tilemap.cells[mouseX - offsetX + 1 + i][mouseY - offsetX + 1 + j].type ~= constructionConfig[""..selected]["place"] then proceed = false end
      end
    end

    if tilemap.cells[mouseX][mouseY].filled == false then

      if proceed == true then
      
        if constructionConfig[""..selected]["cost"] > money then proceed = false
        else money = money - constructionConfig[""..selected]["cost"] end

        if proceed == true then
          tilemap.cells[mouseX - offsetX + 1][mouseY - offsetY + 1].construction = selected
          tilemap.cells[mouseX - offsetX + 1][mouseY - offsetY + 1].active = true
          tilemap.cells[mouseX - offsetX + 1][mouseY - offsetY + 1].energy = constructionConfig[''..selected]['energy']
          tilemap.cells[mouseX - offsetX + 1][mouseY - offsetY + 1].credits = constructionConfig[''..selected]['credits']
          tilemap.cells[mouseX - offsetX + 1][mouseY - offsetY + 1].maintence = constructionConfig[''..selected]['maintence']

          for i = 0, width - 1 do
            for j = 0, height - 1 do
              tilemap.cells[mouseX - offsetX + 1 + i][mouseY - offsetY + 1 + j].filled = true
              tilemap.cells[mouseX - offsetX + 1 + i][mouseY - offsetY + 1 + j].father["X"] = mouseX - offsetX + 1
              tilemap.cells[mouseX - offsetX + 1 + i][mouseY - offsetY + 1 + j].father["Y"] = mouseY - offsetY + 1
            end
          end
        end
      end
    end
  end

  --deactivate
  if love.mouse.isDown(2) and tilemap.cells[mouseX][mouseY].father["X"] ~= -1 then
    tilemap.cells[tilemap.cells[mouseX][mouseY].father["X"]][tilemap.cells[mouseX][mouseY].father["Y"]].active = false
  elseif tilemap.cells[mouseX][mouseY].father["X"] ~= -1 and love.mouse.isDown(1) then
    tilemap.cells[tilemap.cells[mouseX][mouseY].father["X"]][tilemap.cells[mouseX][mouseY].father["Y"]].active = true
  end

  --information

  if isMouseOnWorld then
    if tilemap.cells[mouseX][mouseY].father["X"] ~= -1 then
      local cellConstruction
      local cellActive = true
      if tilemap.cells[mouseX][mouseY].father["X"] ~= -1 then
        cellConstruction = tilemap.cells[tilemap.cells[mouseX][mouseY].father["X"]][tilemap.cells[mouseX][mouseY].father["Y"]].construction
        cellActive = tilemap.cells[tilemap.cells[mouseX][mouseY].father["X"]][tilemap.cells[mouseX][mouseY].father["Y"]].active
      end

      if cellConstruction ~= 0 and cellActive == true then showInformation(
        "Produz "..constructionConfig[""..cellConstruction]["energy"].." MWh"..
        "\nProduz "..constructionConfig[""..cellConstruction]["credits"].." Creditos de carbono"..
        "\nCusta "..constructionConfig[""..cellConstruction]["maintence"].." De manutenção"
        )
      else
        showInformation("Usina Desativada! \n \nprecione o botão esquerdo \ndo mouse para ativar")
      end
    else
      informationWindow:toggleOpen("close")
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
        --update_animation(sprites[construction].animation, dt)
        draw_animation(sprites[construction], i*16, j*16)
      end
    end
  end
  --Selection
  mouseX = math.floor((love.mouse.getX()/2 + camX - 200)/16)
  mouseY = math.floor((love.mouse.getY()/2 + camY - 150)/16)
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
  grid3 = anim8.newGrid(48+16, 48, sprites[3].image:getWidth(), sprites[3].image:getHeight())
  grid4 = anim8.newGrid(48, 48, sprites[4].image:getWidth(), sprites[4].image:getHeight())
  grid5 = anim8.newGrid(64, 106, sprites[5].image:getWidth(), sprites[5].image:getHeight())
  grid6 = anim8.newGrid(32, 32, sprites[6].image:getWidth(), sprites[6].image:getHeight())

  sprites[1].animation = anim8.newAnimation(grid1(1, '1-2'), 0.3)
  sprites[2].animation = anim8.newAnimation(grid2(1, '1-2'), 0.3)
  sprites[3].animation = anim8.newAnimation(grid3(1, '1-2'), 0.3)
  sprites[4].animation = anim8.newAnimation(grid4(1, '1-10'), 0.3)
  sprites[5].animation = anim8.newAnimation(grid5('1-5', 1), 0.3)
  sprites[6].animation = anim8.newAnimation(grid6(1, '1-2'), 0.3)

  sprites[1].animation2 = anim8.newAnimation(grid1(1, '1-1'), 0.3)
  sprites[2].animation2 = anim8.newAnimation(grid2(1, '1-1'), 0.3)
  sprites[3].animation2 = anim8.newAnimation(grid3(1, '1-1'), 0.3)
  sprites[4].animation2 = anim8.newAnimation(grid4(1, '1-1'), 0.3)
  sprites[5].animation2 = anim8.newAnimation(grid5('1-1', 1), 0.3)
  sprites[6].animation2 = anim8.newAnimation(grid6(1, '1-1'), 0.3)

  animations={}
  table.insert(animations, sprites[1].animation)
  table.insert(animations, sprites[2].animation)
  table.insert(animations, sprites[3].animation)
  table.insert(animations, sprites[4].animation)
  table.insert(animations, sprites[5].animation)
  table.insert(animations, sprites[6].animation)

  table.insert(animations, sprites[1].animation2)
  table.insert(animations, sprites[2].animation2)
  table.insert(animations, sprites[3].animation2)
  table.insert(animations, sprites[4].animation2)
  table.insert(animations, sprites[5].animation2)
  table.insert(animations, sprites[6].animation2)
end

function update_animation(animation, dt)
  animation:update(dt)
end

function draw_animation(sprite, x, y)
  sprite.animation:draw(sprite.image, x, y)
end
