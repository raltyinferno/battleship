-- main.lua
-- CS 372 Software Construction Spring 2016
-- KDS & LS
-- February 26, 2016

-- love .

--constants
SCREEN_WIDTH = 800
SCREEN_HEIGHT = 600

Board = require('board')
local ship_err = false
local mouse_x = nil
local mouse_y = nil

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

----------
--placing
----------
local function handle_P1_PLACING_UP()
	
end

local function handle_P1_PLACING_DRAW()
	
end

local function handle_P2_PLACING_UP()
	
end

local function handle_P2_PLACING_DRAW()
	
end
-----------
--shooting
-----------
local function handle_P1_SHOOTING_UP()
	
end

local function handle_P1_SHOOTING_DRAW()
	
end

local function handle_P2_SHOOTING_UP()
	
end

local function handle_P2_SHOOTING_DRAW()
	
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

 update_handlers = {}
 
 draw_handlers = {}

function love.load(arg)
	player1board = Board.new_board()
	player2board = Board.new_board()
	
	player1target = Board.new_board()
	player2target = Board.new_board()
	
	grid  = Board.drawBoard(50, player1board)
	
	if pcall(Board.place_ship(player1board,1,6,"carrier","vertical")) then
	else
		ship_err = true
	end
	
end

function love.update(dt)

--Debuging stuff
	mouse_x, mouse_y = love.mouse.getPosition()
end

function love.draw(dt)

--Debuging stuff
    love.graphics.draw(grid, 10,10)
	love.graphics.print("Mouse x: " .. mouse_x .. " Mouse y " .. mouse_y, 50, 550)
	if ship_err then
		love.graphics.print("error placing ship, try again",600,550)
	end

end

function love.mousereleased(x, y, button, istouch)
	if button == 1 then
		
	end
end







