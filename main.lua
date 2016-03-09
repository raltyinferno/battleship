-- main.lua
-- CS 372 Software Construction Spring 2016
-- KDS & LS
-- February 26, 2016

-- open the folder "/battleship/" in Love application
-- love .

Board = require('board')

--constants
SCREEN_WIDTH = 800
SCREEN_HEIGHT = 600
CELLSIZE = 40

SHIPTYPE = {"carrier", "battleship", "submarine", "destroyer", "patrol"}
SHIPDIRECTION  = {"horizontal", "vertical"}

--flags n' stuff
local ship_err = false
local mouse_x = nil
local mouse_y = nil
local sub_message = ""
local state = nil
local p1_ships_placed = 0
local p2_ships_placed = 0
local selected_grid_x = 0
local selected_grid_y = 0
local active_board_x = nil
local active_board_y = nil
local shipNumber = 1
local shipDirection = 1
local car_placed = false
local bat_placed = false
local sub_placed = false
local des_placed = false
local pat_placed = false
local placing = false
local once = true


--states
local START = 1
local P1_PLACING = 2
local P2_PLACING = 3
local P1_TURN = 4
local P2_TURN = 5
local P1_PICKING = 6
local P2_PICKING = 7
local SWAP_P1 = 8
local SWAP_P2 = 9

-----------------
--state handlers
-----------------
--split between functions for the love draw, and love update functions

local function handle_START()
	player1board = Board.new_board()
	player2board = Board.new_board()
	
	player1board.x = SCREEN_WIDTH/2-(10*CELLSIZE/2)
	player1board.y = 10
	
	player2board.x = SCREEN_WIDTH/2-(10*CELLSIZE/2)
	player2board.y = 10
	
	player1target = Board.new_board()
	player2target = Board.new_board()

	player1_board_grid  = Board.drawBoard(CELLSIZE, player1board)
	player1_target_grid  = Board.drawBoard(CELLSIZE, player2board)
	
	player2_board_grid  = Board.drawBoard(CELLSIZE, player1target)
	player2_target_grid  = Board.drawBoard(CELLSIZE, player2target)
	state = P1_PLACING
end

----------
--Update
----------
local function handle_P1_PLACING_UP()
	if once then
		local car_placed = false
		local bat_placed = false
		local sub_placed = false
		local des_placed = false
		local pat_placed = false
		once = false
	end
	sub_message = "PLAYER 1 PLACE YOUR SHIPS"
	active_board_x = player1board.x
	active_board_y = player1board.y
	player1_board_grid  = Board.drawBoard(CELLSIZE, player1board)
end

local function handle_P2_PLACING_UP()
	if once then
		local car_placed = false
		local bat_placed = false
		local sub_placed = false
		local des_placed = false
		local pat_placed = false
		once = false
	end
	sub_message = "PLAYER 2 PLACE YOUR SHIPS"
	active_board_x = player2board.x
	active_board_y = player2board.y
	player2_board_grid  = Board.drawBoard(CELLSIZE, player1target)
end

local function handle_P1_PICKING_UP()

end

local function handle_P2_PICKING_UP()

end

local function handle_P1_TURN_UP()
	player1_board_grid  = Board.drawBoard(CELLSIZE, player1board)
	player1_target_grid  = Board.drawBoard(CELLSIZE, player2board)
end

local function handle_P2_TURN_UP()
	player2_board_grid  = Board.drawBoard(CELLSIZE, player1target)
	player2_target_grid  = Board.drawBoard(CELLSIZE, player2target)
end

--------
--Draw
--------
local function handle_P1_PLACING_DRAW()
	love.graphics.draw(player1_board_grid, player1board.x,player1board.y)
	love.graphics.rectangle("fill", 700, 10, 90, 50)
end

local function handle_P2_PLACING_DRAW()
	love.graphics.draw(player2_board_grid, player2board.x,player2board.y)
	love.graphics.rectangle("fill", 700, 10, 90, 50)
end

local function handle_P1_PICKING_DRAW()

end

local function handle_P2_PICKING_DRAW()

end

local function handle_P1_TURN_DRAW()
	
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
					[P1_PICKING] = handle_P1_PICKING_UP,
					[P1_TURN]    = handle_P1_TURN_UP,
					[P2_PLACING] = handle_P2_PLACING_UP,
					[P2_PICKING] = handle_P2_PICKING_UP,
					[P2_TURN]    = handle_P2_TURN_UP}
 
 draw_handlers = {[START] = handle_START,
				  [P1_PLACING] = handle_P1_PLACING_DRAW,
				  [P1_PICKING] = handle_P1_PICKING_DRAW,
				  [P1_TURN]    = handle_P1_TURN_DRAW,
				  [P2_PLACING] = handle_P2_PLACING_DRAW,
				  [P2_PICKING] = handle_P2_PICKING_DRAW,
				  [P2_TURN]    = handle_P2_TURN_DRAW}
				
function love.load(arg)
	state = START
end

function love.mousepressed(x,y,button,istouch)
	if state == P1_PLACING then
		if button == 1 then
			selected_grid_x, selected_grid_y =Board.find_grid_click(active_board_x,active_board_y,x,y,CELLSIZE)
			if Board.find_button_click(x,y,700,10,90,50) then --debugging
				once = true
				state = P2_PLACING				
			end
		end
		if selected_grid_x and placing then		
			if Board.place_ship(player1board,selected_grid_x,selected_grid_y,SHIPTYPE[shipNumber],SHIPDIRECTION[shipDirection])then--debuging
				ship_err = true
			else --ship placing was successful
				placing = false
				if shipNumber == 1 then
					car_placed = true
				elseif shipNumber == 2 then
					bat_placed = true
				elseif shipNumber == 3 then
					sub_placed = true
				elseif shipNumber == 4 then
					des_placed = true
				else
					pat_placed = true
				end
			end
		end
	elseif state == P2_PLACING then
		if button == 1 then
			selected_grid_x, selected_grid_y =Board.find_grid_click(active_board_x,active_board_y,x,y,CELLSIZE)
			if Board.find_button_click(x,y,700,10,90,50) then --debugging
				once = true
				state = P1_PLACING
			end
		end	
		if selected_grid_x and placing then		
			if Board.place_ship(player2board,selected_grid_x,selected_grid_y,SHIPTYPE[shipNumber],SHIPDIRECTION[shipDirection])then--debuging
				ship_err = true
			else --ship placing was successful
				placing = false
				if shipNumber == 1 then
					car_placed = true
				elseif shipNumber == 2 then
					bat_placed = true
				elseif shipNumber == 3 then
					sub_placed = true
				elseif shipNumber == 4 then
					des_placed = true
				else
					pat_placed = true
				end
			end
		end
	elseif state == P1_TURN then
		if button == 1 then
			selected_grid_x, selected_grid_y =Board.find_grid_click(active_board_x,active_board_y,x,y,CELLSIZE)
		end		
	elseif state == P2_TURN then
		if button == 1 then
			selected_grid_x, selected_grid_y =Board.find_grid_click(active_board_x,active_board_y,x,y,CELLSIZE)
		end		
	
	end
end

function love.keypressed(key)
	if state == P1_PLACING then
		if key == '1'  and not car_placed and not placing then
			shipNumber = 1
			placing = true
		elseif key == '2' and not bat_placed and not placing then
			shipNumber = 2
			placing = true
		elseif key == '3' and not sub_placed and not placing then
			shipNumber = 3
			placing = true
		elseif key == '4' and not des_placed and not placing then
			shipNumber = 4
			placing = true
		elseif key == '5' and not pat_placed and not placing then
			shipNumber = 5
			placing = true
		elseif key == 'space' then
			if shipDirection == 1 then
				shipDirection = 2
			else
				shipDirection = 1
			end
		end
	elseif state == P2_PLACING then
		if key == '1'  and not car_placed and not placing then
			shipNumber = 1
			placing = true
		elseif key == '2' and not bat_placed and not placing then
			shipNumber = 2
			placing = true
		elseif key == '3' and not sub_placed and not placing then
			shipNumber = 3
			placing = true
		elseif key == '4' and not des_placed and not placing then
			shipNumber = 4
			placing = true
		elseif key == '5' and not pat_placed and not placing then
			shipNumber = 5
			placing = true
		elseif key == 'space' then
			if shipDirection == 1 then
				shipDirection = 2
			else
				shipDirection = 1
			end
		end
	end
		
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
	love.graphics.print("Mouse x: " .. mouse_x .. " Mouse y " .. mouse_y, 50, 550)
	love.graphics.print("Grid x: " .. selected_grid_x .. " Grid y " .. selected_grid_y, 450, 550)
	if ship_err then
		love.graphics.print("error placing ship, try again",600,570)
	end
love.graphics.print("Ship (Num Keys #1-5)", 3,5)
	love.graphics.print("#" .. shipNumber .. " - " .. SHIPTYPE[shipNumber], 3,20)
	love.graphics.print("Direction: (Space Key)", 3, 35)
	love.graphics.print(SHIPDIRECTION[shipDirection], 3, 50)
	
end










