-- main.lua
-- CS 372 Software Construction Spring 2016
-- KDS & LS
-- February 26, 2016

-- love .
Board = require('board')

--constants
SCREEN_WIDTH = 800
SCREEN_HEIGHT = 600

--flags n' stuff
local ship_err = false
local mouse_x = nil
local mouse_y = nil
local sub_message = ""
local state = nil
local p1_ships_placed = 0
local p2_ships_placed = 0

--states
local START = 1
local P1_PLACING = 2
local P2_PLACING = 3
local P1_TURN = 4
local P2_TURN = 5

-----------------
--state handlers
-----------------
--split between functions for the love draw, and love update functions

local function handle_START()
	state = P1_PLACING
end
----------
--placing
----------
local function handle_P1_PLACING_UP()
	sub_message = "PLAYER 1 PLACE YOUR SHIPS"
end

local function handle_P1_PLACING_DRAW()
	love.graphics.draw(player1_board_grid, SCREEN_WIDTH/2-250,10)
end

local function handle_P2_PLACING_UP()
	
end

local function handle_P2_PLACING_DRAW()
	
end
-----------
--TURN
-----------
local function handle_P1_TURN_UP()
	
end

local function handle_P1_TURN_DRAW()
	
end

local function handle_P2_TURN_UP()
	
end

local function handle_P2_TURN_DRAW()
	
end

-- Configuration
function love.conf(t)
	t.title = "Battleship"
	t.version = "LOVE 0.10.1 (Super Toast)"
	t.window.width = SCREEN_WIDTH
	t.window.height = SCREEN_HEIGHT

	-- For Windows debugging
	t.console = true
end

 update_handlers = {[START] = handle_START,
					[P1_PLACING] = handle_P1_PLACING_UP,
					[P1_TURN] = handle_P1_TURN_UP,
					[P2_PLACING] = handle_P2_PLACING_UP,
					[P2_TURN] = handle_P2_TURN_UP}
 
 draw_handlers = {[START] = handle_START,
					[P1_PLACING] = handle_P1_PLACING_DRAW,
					[P1_TURN] = handle_P1_TURN_DRAW,
					[P2_PLACING] = handle_P2_PLACING_DRAW,
					[P2_TURN] = handle_P2_TURN_DRAW}

function love.load(arg)
	player1board = Board.new_board()
	player2board = Board.new_board()
	
	player1target = Board.new_board()
	player2target = Board.new_board()
	
	player1_board_grid  = Board.drawBoard(50, player1board)
	player1_target_grid  = Board.drawBoard(50, player2board)
	
	player2_board_grid  = Board.drawBoard(50, player1target)
	player2_target_grid  = Board.drawBoard(50, player2target)
	
	state = START

	-- if pcall(Board.place_ship(player1board,1,6,"carrier","vertical")) then
	-- else
		-- ship_err = true
	-- end
	
end

function love.update(dt)

	update_handlers[state]()

--Debuging stuff
	mouse_x, mouse_y = love.mouse.getPosition()
end

function love.draw(dt)

	draw_handlers[state]()
	love.graphics.printf(sub_message,SCREEN_WIDTH/2-100,SCREEN_HEIGHT-80, 200, 'center')
	
	
--Debuging stuff
    --love.graphics.draw(grid, 10,10)
	love.graphics.print("Mouse x: " .. mouse_x .. " Mouse y " .. mouse_y, 50, 550)
	if ship_err then
		love.graphics.print("error placing ship, try again",600,550)
	end

end

function love.mousereleased(x, y, button, istouch)
	if button == 1 then
		
	end
end







