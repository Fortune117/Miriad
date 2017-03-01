gameState.list.board = {}

local board = gameState.list.board
function board:init()
	self.ui = {}
end

function board:enter( prev, player1, player2 )
    self:loadBoard( "board_base", player1, player2 )
end

function board:leave()
end

function board:update( dt )
	gui.update()
    local gameBoard = self:getBoard()
    gameBoard:thinkInternal( dt )
    gameBoard:think()
end

function board:draw()
	local t = love.timer.getTime()
	hook.call( "paint", t )
	gui.draw( t )
end

function board:focus()
end

function board:keypressed()
end

function board:keyreleased()
end

function board:mousepressed( x, y, button )
	gui.buttonCheck( x, y, button )
end

function board:mousereleased( x, y, button, istouch )
	gui.buttonReleased( x, y, button, istouch )
end

function board:wheelmoved(dx, dy)
	gui.wheelMoved( dx, dy )
end

function board:quit()
end

function board:setBoard( board )
    self.board = board
end

function board:getBoard()
    return self.board
end

function board:loadBoard( boardname, player1, player2 )
    self:setBoard( CARDS:getBoard( boardname ) )
    local gameBoard = self:getBoard()
    gameBoard:initializeInternal()
    gameBoard:initialize()
    gameBoard:setPlayers( player1, player2 )
    gameBoard:setUp()
end
