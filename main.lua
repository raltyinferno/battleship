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
MINICELLSIZE = 15

SHIPTYPE = {"carrier", "battleship", "submarine", "destroyer", "patrol"}
SHIPDIRECTION  = {"horizontal", "vertical"}

--flags n' stuff
local ship_err = false
local mouse_x = nil
local mouse_y = nil
local sub_message = ""
local state = nil
local p1_ships_placed = {false, false, false, false, false}
local p2_ships_placed = {false, false, false, false, false}
local selected_grid_x = 0
local selected_grid_y = 0
local active_board_x = nil
local active_board_y = nil
local shipNumber = 1
local shipDirection = 1


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
	
	player1board.x = SCREEN_WIDTH/2 - (10*CELLSIZE/2)
	player1board.y = 10
	
	player2board.x = SCREEN_WIDTH/2 - (10*CELLSIZE/2)
	player2board.y = 10
	
	player1target = Board.new_board()
	player2target = Board.new_board()

	player1target.x = SCREEN_WIDTH - (10*MINICELLSIZE) - 10
	player1target.y = SCREEN_HEIGHT/3

	player2target.x = SCREEN_WIDTH - (10*MINICELLSIZE) - 10
	player2target.y = SCREEN_HEIGHT/3

	player1_board_grid  = Board.drawBoard(CELLSIZE, player1board)
	player1_target_grid  = Board.drawBoard(CELLSIZE, player2target)
	
	player2_board_grid  = Board.drawBoard(CELLSIZE, player2board)
	player2_target_grid  = Board.drawBoard(CELLSIZE, player1target)
	state = P1_PLACING
end

----------
--Update
----------
local function handle_P1_PLACING_UP()
	sub_message = "PLAYER 1 PLACE YOUR SHIPS"
	active_board_x = player1board.x
	active_board_y = player1board.y
	--player1_board_grid  = Board.drawBoard(CELLSIZE, player1board)
end

local function handle_P2_PLACING_UP()
	sub_message = "PLAYER 2 PLACE YOUR SHIPS"
	active_board_x = player2board.x
	active_board_y = player2board.y
	
	--player2_board_grid  = Board.drawBoard(CELLSIZE, player1target)
	player2_board_grid  = Board.drawBoard(CELLSIZE, player2board)
end

local function handle_P1_PICKING_UP()

end

local function handle_P2_PICKING_UP()

end

local function handle_P1_TURN_UP()
	sub_message = "PLAYER 1 FIRE AT YOUR ENEMY"
	player1_board_grid  = Board.drawBoard(MINICELLSIZE, player1board)
	player1_target_grid  = Board.drawBoard(CELLSIZE, player1target)
end

local function handle_P2_TURN_UP()
	sub_message = "PLAYER 2 FIRE AT YOUR ENEMY"
	player2_board_grid  = Board.drawBoard(MINICELLSIZE, player2board)
	player2_target_grid  = Board.drawBoard(CELLSIZE, player2target)
end

--------
--Draw
--------
local function handle_P1_PLACING_DRAW()
	love.graphics.draw(player1_board_grid, player1board.x,player1board.y)
	love.graphics.rectangle("fill", 700, 10, 90, 50)

	love.graphics.print("Direction: (Space Key)", 3, 5)
	love.graphics.print({{0,255,0},SHIPDIRECTION[shipDirection]}, 3, 20)
	love.graphics.print("Ship (Num Keys #1-5)", 3,35)
	local printShip = {}
	for index, value in ipairs(p1_ships_placed) do
		if index == shipNumber and value == false then
			printShip[#printShip +1] = {0,255,0} --green
		elseif value == false then
			printShip[#printShip +1] = {255,255,255} --white
		else
			printShip[#printShip +1] = {128,128,128} --grey
		end
		printShip[#printShip +1] = "#" .. index .. " - " .. SHIPTYPE[index] .. "\n"
	end
	love.graphics.print(printShip, 3,50)
end

local function handle_P2_PLACING_DRAW()
	love.graphics.draw(player2_board_grid, player2board.x,player2board.y)
	love.graphics.rectangle("fill", 700, 10, 90, 50)

	love.graphics.print("Direction: (Space Key)", 3, 5)
	love.graphics.print({{0,255,0},SHIPDIRECTION[shipDirection]}, 3, 20)
	love.graphics.print("Ship (Num Keys #1-5)", 3,35)
	local printShip = {}
	for index, value in ipairs(p2_ships_placed) do
		if index == shipNumber and value == false then
			printShip[#printShip +1] = {0,255,0} --green
		elseif value == false then
			printShip[#printShip +1] = {255,255,255} --white
		else
			printShip[#printShip +1] = {128,128,128} --grey
		end
		printShip[#printShip +1] = "#" .. index .. " - " .. SHIPTYPE[index] .. "\n"
	end
	love.graphics.print(printShip, 3,50)
end

local function handle_P1_PICKING_DRAW()

end

local function handle_P2_PICKING_DRAW()

end

local function handle_P1_TURN_DRAW()
	love.graphics.draw(player1_target_grid, player1board.x, player1board.y)
	love.graphics.draw(player1_board_grid, player1target.x, player1target.y)
end

local function handle_P2_TURN_DRAW()
	love.graphics.draw(player2_target_grid, player2board.x, player2board.y)
	love.graphics.draw(player2_board_grid, player2target.x, player2target.y)
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
			-- if Board.find_button_click(x,y,700,10,90,50) then --debugging
			-- 	state = P2_PLACING
			-- end
		end
		if selected_grid_x and p1_ships_placed[shipNumber] == false then		
			if Board.place_ship(player1board,selected_grid_x,selected_grid_y,SHIPTYPE[shipNumber],SHIPDIRECTION[shipDirection])then--debuging
				ship_err = true
			else --ship placing was successful
				ship_err = false
				p1_ships_placed[shipNumber] = true
			end
		end
		if p1_ships_placed[1] and p1_ships_placed[2] and p1_ships_placed[3]
			                  and p1_ships_placed[4] and p1_ships_placed[5] then
			shipNumber = 1
			shipDirection = 1
			state = P2_PLACING
		end

	elseif state == P2_PLACING then
		if button == 1 then
			selected_grid_x, selected_grid_y =Board.find_grid_click(active_board_x,active_board_y,x,y,CELLSIZE)
			-- if Board.find_button_click(x,y,700,10,90,50) then --debugging
			-- 	state = P1_PLACING
			-- end
		end	
		if selected_grid_x and p2_ships_placed[shipNumber] == false then		
			if Board.place_ship(player2board,selected_grid_x,selected_grid_y,SHIPTYPE[shipNumber],SHIPDIRECTION[shipDirection])then--debuging
				ship_err = true
			else --ship placing was successful
				ship_err = false
				p2_ships_placed[shipNumber] = true
			end
		end
		if p2_ships_placed[1] and p2_ships_placed[2] and p2_ships_placed[3]
			                  and p2_ships_placed[4] and p2_ships_placed[5] then
			state = P1_TURN
		end

	elseif state == P1_TURN then
		if button == 1 then
			selected_grid_x, selected_grid_y = Board.find_grid_click(active_board_x,active_board_y,x,y,CELLSIZE)
			
			ship_err, hit = Board.fire_at_ship(player1target,player2board,selected_grid_x,selected_grid_y)
			if not ship_err and not hit then
				state = P2_TURN
			end
		end	
		

	elseif state == P2_TURN then
		if button == 1 then
			selected_grid_x, selected_grid_y = Board.find_grid_click(active_board_x,active_board_y,x,y,CELLSIZE)

			ship_err, hit = Board.fire_at_ship(player2target,player1board,selected_grid_x,selected_grid_y)
			if not ship_err and not hit then
				state = P1_TURN
			end

		end		
	end
end

function love.keypressed(key)
	if state == P1_PLACING or state == P2_PLACING then
		if key == '1'  then
			shipNumber = 1
		elseif key == '2' then
			shipNumber = 2
		elseif key == '3' then
			shipNumber = 3
		elseif key == '4'  then
			shipNumber = 4
		elseif key == '5' then
			shipNumber = 5
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
	if ship_err and (state == P1_PLACING or state == P2_PLACING) then
		love.graphics.print("error placing ship, try again",600,570)
	end
end










