----------------------------

--load window
uiWindow = UIWindow:create("selection", 20, 800 - 320 - 20, 620, 120)
scienceWindow = UIWindow:create("science", 140, 20, 650, 400)
warningWindow = UIWindow:create("warning", 800 - 250, 30, 230, 60)
buyWindow = UIWindow:create("buy", 20, 50, 100, 200)

local justClicked = false

function UILoad()
end

function UIUpdate()
    if love.keyboard.isDown('q') then
        if justClicked then
            scienceWindow:toggleOpen()
            buyWindow:toggleOpen()
        end
        justClicked = false
    else justClicked = true end
    isMouseOnWorld = true
    uiWindow:update()
    scienceWindow:update()
    warningWindow:update()
    buyWindow:update()

end

function UIDraw()
    --money

    uiWindow:draw()
    scienceWindow:draw()
    warningWindow:draw()
    buyWindow:draw()

    love.graphics.print('$: '..money, 10, 30)
    love.graphics.print('Credits: '..credits, 10, 10)
end