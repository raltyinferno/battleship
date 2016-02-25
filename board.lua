
local Board = {}

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

    	-- Set Grid Lines
    	love.graphics.setColor(255, 255, 255)
		for i = 0, 10 do
			love.graphics.line(0, i * cellsize, cellsize * 10, i * cellsize)
			love.graphics.line(i * cellsize, 0, i * cellsize, 10 * cellsize)
		end

		-- Set Ship Colors
		for i = 1, 10 do
			for j = 1, 10 do
				love.graphics.print(playerBoard[i][j], i * cellsize - (cellsize/2)-5,
													   j * cellsize - (cellsize/2)-5)
			end
		end
	love.graphics.setCanvas()

	return canvas
end


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
			if x + length - 1 <= 10 then
				for i = x, length do
					if board[i][y] ~= 0 then
						collision = true
					end
				end
				if not collision then
					for i = x, length do
						board[i][y] = shipNumber
					end
				end
			else 
				collision = true
				error()
			end
		elseif orientation == "vertical" then
			if y + length - 1 <= 10 then
				for j = y, length do
					if board[x][j] ~= 0 then
						collision = true
					end
				end
				for j = y, length do
					board[x][j] = shipNumber
				end
			else 
				collision = true
				error()
			end
		else
			collision = true
			error()
		end
	else
		collision = true
		error()
	end
	return nil
end


return Board