
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


function Board.place_ship(board, x, y, ship_type, orientation)
	local length = nil
	local shipNumber = nil
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
					board[i][y] = shipNumber
				end
			else 
				error()
			end
		elseif orientation == "vertical" then
			if y + length - 1 <= 10 then
				for i = y, length do
					board[x][i] = shipNumber
				end
			else 
				error()
			end
		else
			error()
		end
	else
		error()
	end

end


return Board