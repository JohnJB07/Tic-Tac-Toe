-- LIBRARIES
local push = require 'push' -- Push library 

-- Game values
local WINDOW_HEIGHT, WINDOW_WIDTH = love.window.getMode()
local game_width, game_height = 432, 243
local turn = 0
local game_start = false

-- Player vars
local board = {
    player_one, player_two = false, false, -- Game state deciding who's turn is it
    player_one_win, player_two_win, tie = false, false, false, -- Whoever wins
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
    ["top_left"] = 'empty', ["top"] = 'empty', ["top_right"] = 'empty',
    ["left"] = 'empty', ["middle"] = 'empty', ["right"] = 'empty',
    ["bottom_left"] = 'empty', ["bottom"] = 'empty', ["bottom_right"] = 'empty'
    }
function love.load()
    -- Window
    love.graphics.setDefaultFilter('nearest', 'nearest') -- Makes the text not blurry (fixed a little bit)
    push:setupScreen(game_width, game_height, WINDOW_WIDTH, WINDOW_HEIGHT / 2, {
        fullscreen = false,
        vsync = true,
        resizable = false
    })
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
    if key == 'r' then
        board["top_left"] = 'empty'
        board["top"] = 'empty'
        board["top_right"] = 'empty'
        board["left"] = 'empty'
        board["middle"] = 'empty'
        board["right"] = 'empty'
        board["bottom_left"] = 'empty'
        board["bottom"] = 'empty'
        board["bottom_right"] = 'empty'
        player_one_win = false
        player_two_win = false
        tie = false
    end

    --[[
    
    TODO: Add player input
    
    ]]
    if game_start and player_one_win ~= true and player_two_win ~= true then
        -- TOP LEFT SQUARE
        if key == 'kp7' and board["top_left"] == 'empty' then
            if player_one == true then
                board["top_left"] = 'x'
            elseif player_two == true then
                board["top_left"] = 'o'
            end
            turn = turn + 1
        end

        -- TOP SQUARE
        if key == 'kp8'and board["top"] == 'empty' then
            if player_one == true then
                board["top"] = 'x'
            elseif player_two == true then
                board["top"] = 'o'
            end
            turn = turn + 1
        end
        
        -- TOP RIGHT SQUARE
        if key == 'kp9' and board["top_right"] == 'empty' then
            if player_one == true then
                board["top_right"] = 'x'
            elseif player_two == true then
                board["top_right"] = 'o'
            end
            turn = turn + 1
        end

        -- LEFT SQUARE
        if key == 'kp4' and board["left"] == 'empty'  then
            if player_one == true then
                board["left"] = 'x'
            elseif player_two == true then
                board["left"] = 'o'
            end
            turn = turn + 1
        end

        -- MIDDLE SQUARE
        if key == 'kp5' and board["middle"] == 'empty' then
            if player_one == true  then
                board["middle"] = 'x'
            elseif player_two == true then
                board["middle"] = 'o'
            end
            turn = turn + 1
        end

        -- RIGHT SQUARE
        if key == 'kp6' and board["right"] == 'empty' then
            if player_one == true  then
                board["right"] = 'x'
            elseif player_two == true then
                board["right"] = 'o'
            end
            turn = turn + 1
        end

        -- BOTTOM LEFT SQUARE
        if key == 'kp1' and board["bottom_left"] == 'empty' then
            if player_one == true then
                board["bottom_left"] = 'x'
            elseif player_two == true then
                board["bottom_left"] = 'o'
            end
            turn = turn + 1
        end

        -- BOTTOM SQUARE
        if key == 'kp2' and board["bottom"] == 'empty' then
            if player_one == true then
                board["bottom"] = 'x'
            elseif player_two == true then
                board["bottom"] = 'o'
            end
            turn = turn + 1
        end

        -- BOTTOM RIGHT SQUARE
        if key == 'kp3' and board["bottom_right"] == 'empty' then
            if player_one == true  then
                board["bottom_right"] = 'x'
            elseif player_two == true then
                board["bottom_right"] = 'o'
            end
            turn = turn + 1
        end
    end
end

-- CHECK IF PLAYER HAS WON
function love.update(dt)
    -- PLAYER ONE CHECK
    if board["top_left"] == 'x' and board["top"] == 'x' and board["top_right"] == 'x' then
        player_one_win = true
    elseif board["left"] == 'x' and board["middle"] == 'x' and board["right"] == 'x' then
        player_one_win = true
    elseif board["bottom_left"] == 'x' and board["bottom"] == 'x' and board["bottom_right"] == 'x' then
        player_one_win = true
    elseif board["top_left"] == 'x' and board["left"] == 'x' and board["bottom_left"] == 'x' then
        player_one_win = true
    elseif board["top"] == 'x' and board["middle"] == 'x' and board["bottom"] == 'x' then
        player_one_win = true
    elseif board["top_right"] == 'x' and board["right"] == 'x' and board["bottom_right"] == 'x' then
        player_one_win = true
    elseif board["top_left"] == 'x' and board["middle"] == 'x' and board["bottom_right"] == 'x' then
        player_one_win = true
    elseif board["top_right"] == 'x' and board["middle"] == 'x' and board["bottom_left"] == 'x' then
        player_one_win = true
    end

    -- PLAYER TWO CHECK
    if board["top_left"] == 'o' and board["top"] == 'o' and board["top_right"] == 'o' then
        player_two_win = true
    elseif board["left"] == 'o' and board["middle"] == 'o' and board["right"] == 'o' then
        player_two_win = true
    elseif board["bottom_left"] == 'o' and board["bottom"] == 'o' and board["bottom_right"] == 'o' then
        player_two_win = true
    elseif board["top_left"] == 'o' and board["left"] == 'o' and board["bottom_left"] == 'o' then
        player_two_win = true
    elseif board["top"] == 'o' and board["middle"] == 'o' and board["bottom"] == 'o' then
        player_two_win = true
    elseif board["top_right"] == 'o' and board["right"] == 'o' and board["bottom_right"] == 'o' then
        player_two_win = true
    elseif board["top_left"] == 'o' and board["middle"] == 'o' and board["bottom_right"] == 'o' then
        player_two_win = true
    elseif board["top_right"] == 'o' and board["middle"] == 'o' and board["bottom_left"] == 'o' then
        player_two_win = true
    end
    if turn == 9 and player_one_win ~= true and player_two_win ~= true then
        tie = true
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
        -- Table representation

        -- TOP
        love.graphics.print(board["top_left"], 120, 60)
        love.graphics.print(board["top"], 190, 60)
        love.graphics.print(board["top_right"], 260, 60)

        -- MIDDLE
        love.graphics.print(board["left"], 120, 120)
        love.graphics.print(board["middle"], 190, 120)
        love.graphics.print(board["right"], 260, 120)

        -- BOTTOM
        love.graphics.print(board["bottom_left"], 120, 180)
        love.graphics.print(board["bottom"], 190, 180)
        love.graphics.print(board["bottom_right"], 260, 180)


        -- Drawing stuff
        love.graphics.printf('Press "esc" or "x" to exit or "r" to restart.', 0, 0, game_width/2, 'left')
        if turn == 0 then
            love.graphics.printf('Player one turn', 0, 30, game_width/2, 'left')
        end

        if turn > 0 then
            -- Classic Text Debugging
            love.graphics.printf("Turn: ", 0, 45, game_width/2, 'left')
            love.graphics.printf(turn, 35, 45, game_width/2, 'left')
            if player_one == true then
                love.graphics.printf('Player two turn', 0, 30, game_width/2, 'left')
            elseif player_two == true then
                love.graphics.printf('Player one turn', 0, 30, game_width/2, 'left')
            end
        end
        
        -- In the case of player one or two winning OR a tie
        if player_one_win == true then
            love.graphics.print("PLAYER ONE WIN!", 170, 30)
        elseif player_two_win == true then
            love.graphics.print("PLAYER TWO WIN!", 190, 30)
        elseif tie == true then
            love.graphics.print("TIE!", 190, 30)
        end
    end

    push:finish()
end
