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
  tileset = newTileSet(tilesetImage, 16, 16)

  --initialize tiles
  local imagedata = love.image.newImageData('assets/Sprites/map.png')

  for i = 0, tilemap.size.x - 1 do
    tilemap.cells[i] = {} 
    for j = 0, tilemap.size.y - 1 do
      tilemap.cells[i][j] = {}
      tilemap.cells[i][j].type = "land"
      
      local r = imagedata:getPixel(i, j)
      
      if r == 0 then
        tilemap.cells[i][j].sprite = 1
      else
        tilemap.cells[i][j].sprite = 2
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

end

function worldDraw()

  ------------TileSet
  for i = 0, tilemap.size.x - 1 do
    for j = 0, tilemap.size.y - 1 do
      love.graphics.draw(tileset.spriteSheet, tileset.quads[tilemap.cells[i][j].sprite], i*16, j*16)
    end
  end

end

------------------Other functions

function newTileSet(image, width, height) --create tileset
  local tileSet = {}
  tileSet.spriteSheet = image;
  tileSet.quads = {};

  for y = 0, image:getHeight() - height, height do
      for x = 0, image:getWidth() - width, width do
        print("go")
          table.insert(tileSet.quads, love.graphics.newQuad(x, y, width, height, image:getDimensions()))
      end
  end

  return tileSet
end