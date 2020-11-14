local UIWindow = {}

local windowConfig = require 'src/Objects/UI/windowConfig'

--Create Button

function newButton(text, image, imageX, imageY, fn, width, height, x, y, price, sPrice, unlocked, bought)
    return {
        text = text,
        image = image or nil,
        imageX = imageX or nil,
        imageY = imageY or nil,
        fn = fn or nil,
        width = width,
        height = height,
        x = x,
        y = y,
        price = price or nil,
        sPrice = sPrice or nil,
        unlocked = unlocked or nil,
        bought = bought or nil,

        now = false,
        last = true,
        hot = false
    }
end

--Create Window

function UIWindow:create(type, windowX, windowY, windowWidth, windowHeight)
    local uiWindow = {}

    local buttons = {}

    local open = false
    if type == "selection" then open = true end

    if type == "selection" then
        for i = 1, 6 do
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
    else
        if type == "science" then
            for i = 1, 6 do
                table.insert(buttons,newButton(
                    windowConfig.scienceTree[i].text,
                    windowConfig.scienceTree[i].image,
                    windowConfig.scienceTree[i].imageX,
                    windowConfig.scienceTree[i].imageY,
                    windowConfig.scienceTree[i].fn,
                    windowConfig.scienceTree[i].width,
                    windowConfig.scienceTree[i].height,
                    windowConfig.scienceTree[i].x + windowX,
                    windowConfig.scienceTree[i].y + windowY,
                    windowConfig.scienceTree[i].price,
                    windowConfig.scienceTree[i].sPrice,
                    windowConfig.scienceTree[i].unlocked,
                    windowConfig.scienceTree[i].bought
                ))
            end
        end
    end

    function uiWindow:update()

        if open == true then
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
                    if type == "science" then
                        if buttons[i].unlocked == true and buttons[i].bought ~= true then
                            if money >= buttons[i].price then
                                buttons[i].fn(buttons[i])
                                if i == 4 or i == 5 then buttons[6].unlocked = true end
                            end
                        end
                    else
                        if type == "selection" then
                            if scienceWindow:getButton(i).bought then buttons[i].fn() end
                        end
                    end
                end
            end
        end
    end

    function uiWindow:draw()

        if open == true then
            love.graphics.setColor({.458*2, .297*2, .129*2, .7})
            love.graphics.rectangle("fill", windowX, windowY, windowWidth, windowHeight, 5, 5, 10)

            love.graphics.setColor({.458, .297, .129, 1})
            love.graphics.rectangle("line", windowX, windowY, windowWidth, windowHeight, 5, 5, 10)

            for i, button in ipairs(buttons) do


                local color = {.458*2, .297*2, .129*2, 1}
                if buttons[i].hot then color = {.458, .297, .129, 1} end
                if type == "science" then
                    if buttons[i].hot then color = {.458*2.5, .297*2.5, .129*2.5, 1} end
                    if buttons[i].bought == true then color = {.458*3, .297*3, .129*3, 1} end
                    if buttons[i].unlocked ~= true then color = {.458, .297, .129, 1} end
                else
                    if type == "selection" then
                        if buttons[i].hot  == true then color = {.458*2.5, .297*2.5, .129*2.5, 1} end
                        if scienceWindow:getButton(i).bought ~= true then color = {.458, .297, .129, 1} end
                    end
                end

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

    end

    function uiWindow:toggleOpen()
        if open == true then open = false
        else open = true end
    end

    function uiWindow:getButton(n)
        return buttons[n]
    end

    return uiWindow
end

return UIWindow