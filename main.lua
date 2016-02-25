-- main.lua
-- CS 372 Software Construction Spring 2016
-- KDS & LS
-- February 26, 2016

-- love .

Board = require('board')
local ship_err = false
local mouse_x = nil
local mouse_y = nil

--states
local P1_PLACING = 1
local P2_PLACING = 2
local P1_TURN = 3
local P2_TURN = 4

local function handle_P1_PLACING()


end
-- Configuration
function love.conf(t)
	t.title = "Battleship"
	t.version = "LOVE 0.10.1 (Super Toast)"
	t.window.width = 800
	t.window.height = 600

	-- For Windows debugging
	t.console = true
end

function love.load(arg)
	player1board = Board.new_board()
	if pcall(Board.place_ship(player1board,1,6,"carrier","vertical")) then
	else
		ship_err = true
	end
	grid  = Board.drawBoard(50, player1board)
end

-- Board.place_ship(board, x, y, ship_type, orientation)
function love.update(dt)
	mouse_x, mouse_y = love.mouse.getPosition()
end

function love.draw(dt)
    --love.graphics.print("Hello World",0,0)
    --love.graphics.rectangle("fill",20,20,10,10)
    --love.graphics.print(player1board[1][1], 750,550)

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







