local table = {

    constructionSelection = {
        {
            text = "Termoeletrica",
            fn = function() selected = 1 end,
            width = 80,
            height = 80,
            x = 20,
            y = 20,
            clickable = true,
            background = true,
            image = sprites[1].image,
            imageX = 20,
            imageY = 20
        },
        {
            text = "Biomassa",
            fn = function() selected = 2 end,
            width = 80,
            height = 80,
            x = 120,
            y = 20,
            clickable = true,
            background = true,
            image = sprites[2].image,
            imageX = 20,
            imageY = 20
        },
        {
            text = "Hidroeletrica",
            fn = function() selected = 3 end,
            width = 80,
            height = 80,
            x = 220,
            y = 20,
            clickable = true,
            background = true,
            image = sprites[3].image,
            imageX = 20,
            imageY = 20
        },
        {
            text = "Solar",
            fn = function() selected = 4 end,
            width = 80,
            height = 80,
            x = 320,
            y = 20,
            clickable = true,
            background = true,
            image = sprites[4].image,
            imageX = 20,
            imageY = 20
        },
        {
            text = "Eolica",
            fn = function() selected = 5 end,
            width = 80,
            height = 80,
            x = 420,
            y = 20,
            clickable = true,
            background = true,
            image = sprites[5].image,
            imageX = 20,
            imageY = 20
        },
        {
            text = "Nuclear",
            fn = function() selected = 6 end,
            width = 80,
            height = 80,
            x = 520,
            y = 20,
            clickable = true,
            background = true,
            image = sprites[6].image,
            imageX = 20,
            imageY = 20
        }
    },
    scienceTree = {
        {
            text = "Termoeletrica",
            fn = function(buttons) end,
            width = 80,
            height = 80,
            x = 20,
            y = 20,
            clickable = true,
            background = true,
            image = sprites[1].image,
            imageX = 20,
            imageY = 20,

            price = 0,
            sPrice = 0,
            unlocked = true,
            bought = true
        },
        {
            text = "Biomassa",
            fn = function(buttons) end,
            width = 80,
            height = 80,
            x = 20,
            y = 120,
            clickable = true,
            background = true,
            image = sprites[2].image,
            imageX = 20,
            imageY = 20,

            price = 0,
            sPrice = 0,
            unlocked = true,
            bought = true
        },
        {
            text = "Hidroeletrica",
            fn = function(buttons) end,
            width = 80,
            height = 80,
            x = 20,
            y = 220,
            clickable = true,
            background = true,
            image = sprites[3].image,
            imageX = 20,
            imageY = 20,

            price = 0,
            sPrice = 0,
            unlocked = true,
            bought = true
        },
        {
            text = "Solar",
            fn = function(buttons)
                buttons.bought = true
                money = money - buttons.price
            end,
            width = 80,
            height = 80,
            x = 160,
            y = 20,
            clickable = true,
            background = true,
            image = sprites[4].image,
            imageX = 20,
            imageY = 20,

            price = 2,
            sPrice = 5,
            unlocked = true,
            bought = false
        },
        {
            text = "Eolica",
            fn = function(buttons)
                buttons.bought = true
                money = money - buttons.price
            end,
            width = 80,
            height = 80,
            x = 160,
            y = 120,
            clickable = true,
            background = true,
            image = sprites[5].image,
            imageX = 20,
            imageY = 20,

            price = 2,
            sPrice = 5,
            unlocked = true,
            bought = false
        },
        {
            text = "Nuclear",
            fn = function(buttons)
                buttons.bought = true
                money = money - buttons.price
            end,
            width = 80,
            height = 80,
            x = 300,
            y = 20,
            clickable = true,
            background = true,
            image = sprites[6].image,
            imageX = 20,
            imageY = 20,

            price = 10,
            sPrice = 30,
            unlocked = false,
            bought = false
        }
    },
    buy = {
        {
            text = "Comprar \ncreditos de \npesquisa",
            fn = function()
                research = research + 1
                credits = credits - 1000
            end,
            width = 60,
            height = 60,
            x = 20,
            y = 20,
            clickable = true,
            background = true,
            image = nil,
            imageX = nil,
            imageY = nil
        },
        {
            text = "Comprar \ndinheiro",
            fn = function()
                money = money + 10
                credits = credits - 1000
            end,
            width = 60,
            height = 60,
            x = 20,
            y = 100,
            clickable = true,
            background = true,
            image = nil,
            imageX = nil,
            imageY = nil
        }
    },
    warnings = {
        {
            text = "",
            fn = function()  end,
            width = 0,
            height = 0,
            x = 5,
            y = 5,
            clickable = true,
            background = true,
            image = nil,
            imageX = nil,
            imageY = nil
        },
        {
            text = "ok",
            fn = function() warningWindow:toggleOpen("close") end,
            width = 50,
            height = 20,
            x = 170,
            y = 35,
            clickable = true,
            background = true,
            image = nil,
            imageX = nil,
            imageY = nil
        }
    },
    information = {
        {
            text = "",
            fn = function()  end,
            width = 0,
            height = 0,
            x = 5,
            y = 5,
            clickable = true,
            background = true,
            image = nil,
            imageX = nil,
            imageY = nil
        }
    }

}

return table