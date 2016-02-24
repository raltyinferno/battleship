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

TestBattleship = {}

	function TestBattleship:testEmptyBoard()
		luaunit.assertEquals(0,0)
	end
-- end of table TestBattleship



function main()
	os.exit( luaunit.LuaUnit.run() )
end

main()