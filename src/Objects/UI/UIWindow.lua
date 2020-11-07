local UIWindow = {}

local windowConfig = require 'src/Objects/UI/windowConfig'

--Create Button

function newButton(text, image, imageX, imageY, fn, width, height, x, y)
    return {
        text = text,
        image = image,
        imageX = imageX,
        imageY = imageY,
        fn = fn,
        width = width,
        height = height,
        x = x,
        y = y,

        now = false,
        last = true,
        hot = false
    }
end

--Create Window

function UIWindow:create(windowX, windowY, windowWidth, windowHeight)
    local uiWindow = {}

    local buttons = {}

    for i = 1, 3 do
        table.insert(buttons,newButton(
            windowConfig.constructionSelection[i].text,
            windowConfig.constructionSelection[i].image,
            windowConfig.constructionSelection[i].imageX,
            windowConfig.constructionSelection[i].imageY,
            windowConfig.constructionSelection[i].fn,
            windowConfig.constructionSelection[i].width,
            windowConfig.constructionSelection[i].height,
            windowConfig.constructionSelection[i].x + windowX,
            windowConfig.constructionSelection[i].y + windowY
        ))
    end

    function uiWindow:update()

        local mx = love.mouse.getX()
        local my = love.mouse.getY()

        if mx > windowX and mx < windowX+windowWidth and my > windowY and my < windowY+windowHeight then
            isMouseOnWorld = false
        end

        for i, button in ipairs(buttons) do
            buttons[i].hot = mx > buttons[i].x and mx < buttons[i].x+buttons[i].width and
                my > buttons[i].y and my < buttons[i].y+buttons[i].height

            if buttons[i].hot then
                if love.mouse.isDown(1) then
                    if not buttons[i].last then
                        buttons[i].now = true
                        buttons[i].last = true
                    else
                        buttons[i].now = false
                    end
                else
                    buttons[i].last = false
                    buttons[i].now = false
                end
            end

            if buttons[i].now then
                buttons[i].fn()
            end
        end
    end

    function uiWindow:draw()

        love.graphics.setColor({.458*2, .297*2, .129*2, .7})
        love.graphics.rectangle("fill", windowX, windowY, windowWidth, windowHeight, 5, 5, 10)

        love.graphics.setColor({.458, .297, .129, 1})
        love.graphics.rectangle("line", windowX, windowY, windowWidth, windowHeight, 5, 5, 10)

        for i, button in ipairs(buttons) do

            local color = {.458*2, .297*2, .129*2, 1}
            if buttons[i].hot then color = {.458, .297, .129, 1} end

            love.graphics.setColor(color)

            love.graphics.rectangle(
                "fill",
                buttons[i].x,
                buttons[i].y,
                buttons[i].width,
                buttons[i].height
            )

            love.graphics.setColor({1, 1, 1, 1})
            if buttons[i].image ~= 0 then
                love.graphics.draw(buttons[i].image, buttons[i].x + buttons[i].imageX, buttons[i].y + buttons[i].imageY)
            end

            love.graphics.setColor({0, 0, 0, 1})
            love.graphics.print(
                buttons[i].text,
                buttons[i].x,
                buttons[i].y
            )

            love.graphics.setColor({1, 1, 1, 1})
        end

        love.graphics.setColor({1, 1, 1, 1})

    end

    return uiWindow
end

return UIWindow