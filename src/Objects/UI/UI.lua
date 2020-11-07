----------------------------

--load window
uiWindow = UIWindow:create(20, 800 - 320 - 20, 320, 120)

function UIUpdate()

    isMouseOnWorld = true
    uiWindow:update()

end

function UIDraw()
    --money

    uiWindow:draw()

    love.graphics.print('$: '..money, 10, 30)
    love.graphics.print('Credits: '..credits, 10, 10)
end