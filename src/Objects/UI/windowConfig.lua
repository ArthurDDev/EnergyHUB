local table = {

    constructionSelection = {
        {
            text = "Solar",
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
            text = "aaaaaaaa",
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
            text = "bbbbbbbb",
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
        close = false
    }

}

return table