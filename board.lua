-- board.lua
-- CS 372 Software Construction Spring 2016
-- KDS & LS
-- February 26, 2016

local Board = {}

local boardColor = 	{ {0,150,200}, --ocean
					  {0,201,50}, --ship 1
					  {201,151,0}, --ship 2
					  {201,0,50}, --ship 3
					  {50,0,201}, --ship 4
					  {151,0,201} --ship 5
					}

function Board.new_board()
	local blank_board = {}
	for i=1, 10 do
		blank_board[i] = {}
		for j=1,10 do
			blank_board[i][j] = 0
		end
	end
	return blank_board
end

function Board.drawBoard(cellsize, playerBoard)
	canvas = love.graphics.newCanvas(cellsize * 10,cellsize * 10)

	love.graphics.setCanvas(canvas)
		-- Background color
		love.graphics.setColor(0, 150, 200)
    	love.graphics.rectangle('fill', 0, 0, cellsize * 10, cellsize * 10)

		-- Set Ship Colors/values
		for i = 1, 10 do
			for j = 1, 10 do
				love.graphics.setColor(boardColor[(playerBoard[i][j]+1)])
				love.graphics.rectangle('fill', (i-1) * cellsize, (j-1) * cellsize, cellsize, cellsize)

				love.graphics.setColor(255, 255, 255)
				love.graphics.print(playerBoard[i][j], i * cellsize - (cellsize/2)-5,
													   j * cellsize - (cellsize/2)-5)
			end								--the -5 is to center the number in the cell
		end

		-- Set Grid Lines
    	love.graphics.setColor(255, 255, 255)
		for i = 0, 10 do
			love.graphics.line(0, i * cellsize, cellsize * 10, i * cellsize)
			love.graphics.line(i * cellsize, 0, i * cellsize, 10 * cellsize)
		end

	love.graphics.setCanvas()

	return canvas
end

--returns true if there was an error placing
function Board.place_ship(board, x, y, ship_type, orientation) 
	local length = nil
	local shipNumber = nil
	local collision = false
	if ship_type == "carrier" then
		length = 5
		shipNumber = 1
	elseif ship_type == "battleship" then
		length = 4
		shipNumber = 2
	elseif ship_type == "submarine" then
		length = 3
		shipNumber = 3
	elseif ship_type == "destroyer" then
		length = 3
		shipNumber = 4
	elseif ship_type == "patrol" then
		length = 2
		shipNumber = 5
	else
		error()
	end

	if x >= 1 and y >= 1 and x <= 10 and y <= 10 then
		if orientation == "horizontal" then
			if (x + length - 1) <= 10 then
				for i = x, length+x-1 do
					if board[i][y] ~= 0 then
						collision = true
						return collision
					end
				end
				if not collision then
					for i = x, x+length-1 do
						board[i][y] = shipNumber
					end
				end
			else 
				collision = true
			end
		elseif orientation == "vertical" then
			if (y + length - 1) <= 10 then
				for j = y, length+y-1 do
					if board[x][j] ~= 0 then
						collision = true
						return collision
					end
				end
				for j = y, y+length-1 do
					board[x][j] = shipNumber
				end
			else 
				collision = true
			end
		else
			collision = true
		end
	else
		collision = true
	end
	return collision
end

function Board.find_grid_click(x,y,mouse_x,mouse_y,cellsize) --param 1 and 2 are position of board
	for i=0,9 do
		for j=0,9 do
			if mouse_x >= i*cellsize+x and mouse_x <= (i+1)*cellsize+x then
				if mouse_y >= j*cellsize+y and mouse_y <= (j+1)*cellsize+y then
					return i+1,j+1
				elseif mouse_y < y or mouse_y > 10*cellsize+y then
					return 0,0
				end
			elseif mouse_x < x or mouse_x > 10*cellsize+x then
				return 0,0
			end
			
		end
	end
end

function Board.find_button_click(mouse_x,mouse_y,button_x, button_y,width,height) --returns true if mouse is within button
	if mouse_x >= button_x and mouse_x <= button_x+width then
		if mouse_y >= button_y and mouse_y <= button_y+height then
			return true
		else
			return false
		end
	else 
		return false
	end
end


return Board