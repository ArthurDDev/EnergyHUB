--function load_menu()
  font=love.graphics.newFont(32.5)

  button_height = 64

  ingame=false

  local
  function newButton(text, fn)
    return {text=text, fn=fn, now=false, last=false}
  end

  buttons={}

  table.insert(buttons, newButton(
        "Start Game",
        function()
          ingame=true
        end))
  table.insert(buttons, newButton(
        "Settings",
        function()
          print("going to settings")
        end))
  table.insert(buttons, newButton(
        "Exit",
        function()
          love.event.quit(0)
        end))
--end

function draw_menu()
  local ww=love.graphics.getWidth()
  local wh=love.graphics.getHeight()

  local button_width=ww/3
  local margin=60

  local total_height=(button_height+margin)*#buttons
  local cursor_y=0

  for i, button in ipairs(buttons) do
    button.last=button.now

    local bx=ww/2-button_width/2
    local by=wh/2-total_height/2+cursor_y

    local color={0.4, 0.4, 0.5, 1}
    local mx, my = love.mouse.getPosition()
    local hot=mx>bx and mx<bx+button_width and my>by and my<by+button_height

    if hot then
      color={0.8, 0.8, 0.9, 1}
    end

    button.now=love.mouse.isDown(1)
    if button.now and not button.last and hot then
      button.fn()
    end

    love.graphics.setColor(unpack(color))
    love.graphics.rectangle("fill", ww/2-button_width/2, wh/2-total_height/2+cursor_y, button_width, button_height)
    cursor_y=cursor_y+button_height+margin

    love.graphics.setColor(0, 0, 0, 1)

    local textW=font:getWidth(button.text)
    local textH=font:getHeight(button.text)

    love.graphics.print(button.text, font, ww/2-textW/2, by+textH/2)
  end
end
