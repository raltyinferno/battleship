-- main.lua
-- CS 372 Software Construction Spring 2016
-- KDS & LS
-- February 26, 2016

-- love .

Board = require('board')

function drawBoard(cellsize, playerBoard)
	canvas = love.graphics.newCanvas(cellsize * 10,cellsize * 10)

	love.graphics.setCanvas(canvas)
		-- Background color
		love.graphics.setColor(0, 0, 255)
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
				love.graphics.print(playerBoard[i][j], i * cellsize - (cellsize/2),
													   j * cellsize - (cellsize/2))
			end
		end
	love.graphics.setCanvas()

	return canvas
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
	Board.place_ship(player1board,1,1,"carrier","vertical")
	grid  = drawBoard(50, player1board)
end

-- Board.place_ship(board, x, y, ship_type, orientation)

function love.draw(dt)
    --love.graphics.print("Hello World",0,0)
    --love.graphics.rectangle("fill",20,20,10,10)
    --love.graphics.print(player1board[1][1], 750,550)

    love.graphics.draw(grid, 10,10)

end

function love.mousereleased(x, y, button, istouch)
	if button == 1 then
		
	end
end







