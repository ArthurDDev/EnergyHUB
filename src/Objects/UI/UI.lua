----------------------------

--load window
uiWindow = UIWindow:create("selection", 20, 800 - 320 - 20, 620, 120)
scienceWindow = UIWindow:create("science", 140, 20, 650, 400)
warningWindow = UIWindow:create("warning", 800 - 250, 30, 230, 60)
buyWindow = UIWindow:create("buy", 20, 100, 100, 200)
informationWindow = UIWindow:create("information", 0, 0, 200, 100)

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
    informationWindow:update()

end

function UIDraw()
    --money

    uiWindow:draw()
    scienceWindow:draw()
    warningWindow:draw()
    buyWindow:draw()
    informationWindow:draw()

    love.graphics.print('$: '..money, 10, 30)
    love.graphics.print('Credits: '..credits, 10, 10)
    love.graphics.print((energy/1000)..'/'..energyr/1000, 10, 70)
    love.graphics.print('Research Credits: '..research, 10, 50)
end


function showWarning(text)
    warningWindow:toggleOpen("open")
    warningWindow:setText(text)
end
function showInformation(text)
    informationWindow:toggleOpen("open")
    informationWindow:setText(text)
end
