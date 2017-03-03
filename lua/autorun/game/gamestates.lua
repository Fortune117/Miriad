
gameState.list.menu = {}
local menu = gameState.list.menu
function menu:init()
	self.ui = {}
end

function menu:enter( prev )

	local w,h = love.graphics.getDimensions()
	self.ui.mainpage = gui.create( "mpanel" )
	local page = self.ui.mainpage
	page:setPos( 0, 0 )
	page:setSize( w, h )

	-- local bw, bh = 200, 50
	-- local deckButton = gui.create( "button", page2 )
	-- deckButton:setPos( (w - bw)/2, (h - bh)/2 )
	-- deckButton:setSize( bw, bh )
	-- deckButton:setText( "Deck Builder" )
	-- deckButton:setParent( page )
	-- function deckButton:doClick()
	-- 	gameState.switch( gameState.list.decks )
	-- end

	local deck1 = CARDS:createDeck( "deck1" )
	CARDS:addToDeck( "deck1", "card_adept" )
	CARDS:addToDeck( "deck1", "card_imp" )
	CARDS:addToDeck( "deck1", "card_lelemental" )
	CARDS:addToDeck( "deck1", "card_zombie" )
	CARDS:addToDeck( "deck1", "card_beserker" )
	CARDS:addToDeck( "deck1", "card_putpocket" )

	local deck2 = CARDS:createDeck( "deck2" )
	CARDS:addToDeck( "deck2", "card_adept" )
	CARDS:addToDeck( "deck2", "card_imp" )
	CARDS:addToDeck( "deck2", "card_lelemental" )
	CARDS:addToDeck( "deck2", "card_zombie" )
	CARDS:addToDeck( "deck2", "card_beserker" )
	CARDS:addToDeck( "deck2", "card_putpocket" )

	local player1 =
	{
		name = "Fortune",
		hp = 30,
		mana = 1,
		maxMana = 1,
		deck = deck1,
		hand = {}
	}
	local player2 =
	{
		name = "DeSync",
		hp = 30,
		mana = 0,
		maxMana = 0,
		deck = deck2,
		hand = {}
	}
	local bw, bh = 200, 50
	local startButton = gui.create( "button", page2 )
	startButton:setPos( (w - bw)/2, (h - bh)/2 )
	startButton:setSize( bw, bh )
	startButton:setText( "Test Game" )
	startButton:setParent( page )
	function startButton:doClick()
		gameState.switch( gameState.list.board, player1, player2 )
	end

end

function menu:leave()
	for k,v in pairs( self.ui ) do
		v:remove()
	end
end

function menu:update( dt )
	gui.update()
end

function menu:draw()
	local t = love.timer.getTime()
	hook.call( "paint", t )
	gui.draw( t )
end

function menu:focus()
end

function menu:keypressed()
end

function menu:keyreleased()
end

function menu:mousepressed( x, y, button )
	gui.buttonCheck( x, y, button )
end

function menu:mousereleased( x, y, button, istouch )
	gui.buttonReleased( x, y, button, istouch )
end

function menu:wheelmoved(dx, dy)
	gui.wheelMoved( dx, dy )
end

function menu:quit()
end

gameState.list.decks = {}

local decks = gameState.list.decks
function decks:init()
	self.ui = {}
end

function decks:enter( prev )

	local w,h = love.graphics.getDimensions()
	self.ui.cardlist = gui.create( "mcardlist" )
	local cardlist = self.ui.cardlist
	cardlist:setPos( 0, 0 )
	cardlist:setSize( w, h )

end

function decks:leave()
	for k,v in pairs( self.ui ) do
		v:remove()
	end
end

function decks:update( dt )
	gui.update()
end

function decks:draw()
	local t = love.timer.getTime()
	hook.call( "paint", t )
	gui.draw( t )
end

function decks:focus()
end

function decks:keypressed( key )
	if key == "right" then
		self.ui.cardlist.next:doClick()
	elseif key == "left" then
		self.ui.cardlist.prev:doClick()
	end
end

function decks:keyreleased()
end

function decks:mousepressed( x, y, button )
	gui.buttonCheck( x, y, button )
end

function decks:mousereleased( x, y, button, istouch )
	gui.buttonReleased( x, y, button, istouch )
end

function decks:wheelmoved(dx, dy)
	gui.wheelMoved( dx, dy )
end

function decks:quit()
end


gameState.list.game = {}

gameState.list.paused = {}
