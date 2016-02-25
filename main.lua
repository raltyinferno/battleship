-- main.lua
-- CS 372 Software Construction Spring 2016
-- KDS & LS
-- February 26, 2016

-- love .

function drawBoard()
	canvas = love.graphics.newCanvas(100,100)

	love.graphics.setCanvas(canvas)
		for i = 0, 10, 1 do
			love.graphics.line(0, i * 10, 10 * 10, i * 10)
			love.graphics.line(i * 10, 0, i * 10, 10 * 10)
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
	grid  = drawBoard()
end



function love.draw(dt)
    love.graphics.print("Hello World",0,0)
    love.graphics.rectangle("fill",20,20,10,10)

    love.graphics.draw(grid, 400,300)
end

