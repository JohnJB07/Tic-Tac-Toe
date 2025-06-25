-- LIBRARIES
local push = require 'push' -- Push library 

-- Game values
local WINDOW_HEIGHT, WINDOW_WIDTH = love.window.getMode()
local game_width, game_height = 432, 243
local turn = 0
local num = ''
local game_start = false

function love.load()
    -- Window
    love.graphics.setDefaultFilter('nearest', 'nearest') -- Makes the text not blurry (fixed a little bit)
    push:setupScreen(game_width, game_height, WINDOW_WIDTH, WINDOW_HEIGHT / 2, {
        fullscreen = false,
        vsync = true,
        resizable = false
    })

    -- Player vars
    
    board = {
        player_one, player_two = false, false, -- Game state deciding who's turn is it
        player_one_win, player_two_win = false, false, -- Whoever wins
        --[[
        Explanation: A 3x3 Grid will be used for determining player input for the X and the O which will house the state of:
            empty - the player CAN place their shape there
            occupied - the player CAN'T place their shape there 

            See example below:
                hashtag - empty
                X - player one
                O - player two              KEYPAD VISUAL:
                        X # X                   7 8 9

                        # X O                   4 5 6
                                
                        # # O                   1 2 3
        ]]
        [0] = 'empty', [1] = 'empty', [2] = 'empty',
        [3] = 'empty', [4] = 'empty', [5] = 'empty',
        [6] = 'empty', [7] = 'empty', [8] = 'empty'
    }
end


function love.keypressed(key)
    if turn % 2 == 0 then
        player_one, player_two = true, false
    elseif turn % 2 == 1 then
        player_one, player_two = false, true 
    end

    --[[

    NOTE: lazy route but i'll change once im knowledgeable enough
    Key pressed used the keypad for user inputs using modulo operator to check who's turn is it 
    (somehow dont get why the modulo operator makes player one act on turn 2 but it works ig?)

    ]]
    if key == 'escape' or key == 'x' then
        love.event.quit()
    end
    if key == 'return' then
        game_start = true
    end
    if key == 'kp7' and game_start then
        num = 'top left'
        turn = turn + 1
    end
    if key == 'kp8' and game_start then
        num = 'top'
        turn = turn + 1
    end
    if key == 'kp9' and game_start then
        num = 'top right'
        turn = turn + 1
    end
    if key == 'kp4' and game_start then
        num = 'left'
        turn = turn + 1
    end
    if key == 'kp5' and game_start then
        num = 'middle'
        turn = turn + 1
    end
    if key == 'kp6' and game_start then
        num = 'right'
        turn = turn + 1
    end
    if key == 'kp1' and game_start then
        num = 'bottom left'
        turn = turn + 1
    end
    if key == 'kp2' and game_start then
        num = 'bottom'
        turn = turn + 1
    end
    if key == 'kp3' and game_start then
        num = 'bottom right'
        turn = turn + 1
    end
end

function love.draw()
    push:start()

    -- BG color
    love.graphics.clear(45/225, 50/225, 20/255, 1)

    -- Game state text
    if not game_start then
        love.graphics.print('Press "ENTER" To start', game_width/2 - 70, game_height/2)
    else
        -- Drawing stuff
        love.graphics.printf('Press "esc" or "x" to exit.', 0, 0, game_width/2, 'left')
        if turn == 0 then
            love.graphics.printf('Player one turn', 0, 30, game_width/2, 'left')
        end

        if turn > 0 and turn < 10 then
            -- Classic Text Debugging
            love.graphics.printf("Turn: ", 0, 45, game_width/2, 'left')
            love.graphics.printf(turn, 35, 45, game_width/2, 'left')
            love.graphics.printf(num, 0, game_height/2 - 6, game_width/2, 'center')
            if player_one == true then
                love.graphics.printf('Player two turn', 0, 30, game_width/2, 'left')
            elseif player_two == true then
                love.graphics.printf('Player one turn', 0, 30, game_width/2, 'left')
            end
        end
        
        -- In the case of player one or two winning OR a tie
        if player_one_win == true then
            love.graphics.printf("PLAYER ONE WIN!", 100, game_width/2 - 100, game_width/2, 'center')
        elseif player_two_win == true then
            love.graphics.printf("PLAYER TWO WIN!", 100, game_width/2 - 100, game_width/2, 'center')
        elseif turn > 9 then
            love.graphics.printf("TIE!", 100, game_width/2 - 100, game_width/2, 'center')
        end
    end

    push:finish()
end
