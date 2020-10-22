----------------------------------------------------

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

function worldStart()

  ----------------Tiles
  --tileset
  tilesetImage = love.graphics.newImage('assets/Sprites/Tilesets/TileSet.png')
  tileset = newTileSet(tilesetImage, 16, 25)

  --initialize tiles
  local imagedata = love.image.newImageData('assets/Sprites/map.png')

  for i = 0, tilemap.size.x - 1 do
    tilemap.cells[i] = {} 
    for j = 0, tilemap.size.y - 1 do
      tilemap.cells[i][j] = {}
      tilemap.cells[i][j].type = "water"
      tilemap.cells[i][j].filled = false
      tilemap.cells[i][j].construction = "nil"
      tilemap.cells[i][j].sprite = 2

      local r = imagedata:getPixel(i, j)
      
      if r == 0 then
        tilemap.cells[i][j].sprite = 1
        tilemap.cells[i][j].type = "land"
      end
    end
  end

  print(constructionConfig["usine"]["id"])

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
  
  if mouseX > -1 and mouseX < tilemap.size.x and mouseY > -1 and mouseY < tilemap.size.y then
    if tilemap.cells[mouseX][mouseY].filled == true then
      --print("Position: "..mouseX.." : "..mouseY.." -- Cell:  "..tilemap.cells[mouseX][mouseY].type.." : ".."True".." : "..tilemap.cells[mouseX][mouseY].construction)
    else
      --print("Position: "..mouseX.." : "..mouseY.." -- Cell:  "..tilemap.cells[mouseX][mouseY].type.." : ".."False".." : "..tilemap.cells[mouseX][mouseY].construction)
    end
  else
    --print("No tile selected!")
  end

  if love.mouse.isDown(1) then
    tilemap.cells[mouseX][mouseY].construction = "usine"
    tilemap.cells[mouseX][mouseY].filled = true
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
      if tilemap.cells[i][j].construction ~= "nil" then
        love.graphics.rectangle("fill", i*16, j*16, 64, 64, 2, 2)
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