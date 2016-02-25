-- testingBattleship.lua
-- CS 372 Software Construction Spring 2016
-- KDS & LS
-- February 26, 2016

-- lua testingBattleship.lua -v


-- LuaUnit scans all variables that start with test or Test. 
-- If they are functions, or if they are tables that contain 
-- functions that start with test or Test, they are run as part of the test suite.

-- When tests are defined in tables, you can optionally define two special functions,
-- setUp() and tearDown(), which will be executed respectively before and after every test.
luaunit = require('luaunit')

emptyBoard ={}
for i=1, 10 do
	emptyBoard[i]={}
	for j=1,10 do
		emptyBoard[i][j] = 0
	end
end

Board = {}
function Board.new_board()
	local blank_board = {}
	for i=1, 10 do
		blank_board[i] = {}
		for j=1,10 do
			blank_board[i][j] = 1
		end
	end
	return blank_board
end

TestBattleship = {}

	function TestBattleship:testEmptyBoard()
		luaunit.assertEquals(self.testBoard,emptyBoard)
	end
	
	function TestBattleship:setUp()
		self.testBoard = Board:new_board()
	end
	
-- end of table TestBattleship



function main()
	os.exit( luaunit.LuaUnit.run() )
end

main()