--[[----------------------------------------
	LoadFiles( directory )
	Loads files from the specified directory.
--]]----------------------------------------

lovetoys = require("lua/modules/lovetoys/lovetoys")
lovetoys.initialize({
    globals = false,
    debug = false
})

camera = require( "lua/modules/hump/camera" )
gameState = require( "lua/modules/hump/gamestate" )
lume = require( "lua/modules/lume/lume" )

debugFont = love.graphics.newFont( 15 )
function loadFiles( dir )
	local objects = love.filesystem.getDirectoryItems( dir )
	local tbl = {}
	for i = 1,#objects do
		if love.filesystem.isDirectory( dir.."/"..objects[ i ] ) then
			tbl[ #tbl + 1 ] = dir.."/"..objects[ i ]
		else
			local name = dir.."/"..string.sub( objects[ i ], 0, string.len( objects[ i ] ) - 4 )
			require( name )
		end
	end

	for i = 1,#tbl do
		loadFiles( tbl[ i ] )
	end
end


function love.load()
    local sr,sg,sb = 46, 204, 113
    local r,g,b = 0,102,200

    local dr, dg, db = sr - r, sg - g, sb - b

	gameState.list = {}
	loadFiles( "lua/autorun" )
	loadFiles( "lua/cards" )
	loadFiles( "lua/boards" )
	gameState.registerEvents()
	gameState.switch( gameState.list.menu )
	love.math.setRandomSeed( os.time() )
end

--[[----------------------------------------
	Call our basic draw functions and call
	the draw hook.
--]]----------------------------------------

love.graphics.setDefaultFilter( "linear", "linear", 16 )
function love.draw()
end

--[[----------------------------------------
	Run these functions on tick.
--]]----------------------------------------
function love.update( dt )
	ents.cleanUp()
end

function love.mousepressed( x, y, button )
end

function love.mousereleased( x, y, button, istouch )
end

function love.wheelmoved(dx, dy)
end

function love.keypressed(key)
end
