----------------------------

--load window
uiWindow = UIWindow:create("selection", 20, 800 - 320 - 20, 620, 120)
scienceWindow = UIWindow:create("science", 100, 20, 650, 400)

local justClicked = false

function UILoad()
end

function UIUpdate()
    if love.keyboard.isDown('q') then
        if justClicked then
            scienceWindow:toggleOpen()
        end
        justClicked = false
    else justClicked = true end
    isMouseOnWorld = true
    uiWindow:update()
    scienceWindow:update()

end

function UIDraw()
    --money

    uiWindow:draw()
    scienceWindow:draw()

    love.graphics.print('$: '..money, 10, 30)
    love.graphics.print('Credits: '..credits, 10, 10)
    love.graphics.print(energy..'/'..energyr, 10, 50)
end
