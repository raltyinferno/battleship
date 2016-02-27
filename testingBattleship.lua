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

Board = require('board')

-- Objects for Testing
emptyBoard ={}
for i=1, 10 do
	emptyBoard[i]={}
	for j=1,10 do
		emptyBoard[i][j] = 0
	end
end

test1Board ={}
for i=2, 10 do
	test1Board[1] = {1,1,1,1,1,0,0,0,0,0}
	test1Board[i]={}
	for j=1,10 do
		test1Board[i][j] = 0
	end
end

-- Testing Battleship Class
TestBattleship = {}
	function TestBattleship:setUp()
		self.testBoard = Board:new_board()
	end

	function TestBattleship:testEmptyBoard()
		luaunit.assertEquals(self.testBoard,emptyBoard)
	end

	function TestBattleship:testPlaceShipFunction()
		Board.place_ship(self.testBoard,1,1,"carrier","vertical")
		luaunit.assertEquals(self.testBoard,test1Board)
	end
-- end of table TestBattleship



function main()
	os.exit( luaunit.LuaUnit.run() )
end

main()