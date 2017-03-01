
local BOARD = {}
BOARD.name = "Base Board"
BOARD.desc = "not much tbh"
BOARD.maxHandSize = 9 -- max number of cards you can have in your hand
BOARD.startHandSize = 5 -- how many cards you start off with
BOARD.player2BonusCards = 1 -- how many extra cards should player 2 get when the game starts.
BOARD.maxFieldSize = 7 -- max number of minions on the board


function BOARD:initializeInternal() --callled when the board is created
	self.players =
	{
		[1] = {},
		[2] = {}
	}
	self.field =
	{
		[1] = {}, -- player 1 field
		[2] = {}  -- player 2 field
	}
	self:setTurn( 1 )
end

function BOARD:initialize() --called when the board is created, immediately after the internal call
end

function BOARD:onPlay() -- called when a card is played
end

function BOARD:onDeath() -- called when a card dies
end

function BOARD:onCardDrawn() -- called when the card is drawn
end

function BOARD:onTurnStart() -- called when a turn starts
end

function BOARD:onTurnEnd() -- called when a turn ends
end

function BOARD:onAttack() -- called when a card attacks another
end

function BOARD:onDefend() -- called when a card is attacked by another
end

function BOARD:onKill() -- called when a card kills another
end

function BOARD:onKilled() -- called when a card kills another
end

function BOARD:onCardDeath() -- called whenever a card in play dies
end

function BOARD:thinkInternal( dt )
end

function BOARD:think( dt )
end

function BOARD:getName()
	return self.name
end

function BOARD:getDescription()
	return self.desc
end

function BOARD:setTurn( n ) -- please only use this to set it to 1 or 2... it will actually break a lot of stuff :(
	self.turn = n
end

function BOARD:getTurn()
	return self.turn
end

function BOARD:getNextTurn() -- get the opposite turns number
	return lume.pingpong( self:getTurn() - 1 ) + 1  -- maths magic. should flip between 1 and 2
end

-- returns the data for the player who is currently having their turn
function BOARD:getActivePlayer()
	return self:getPlayers()[ self:getTurn() ]
end

function BOARD:getInactivePlayer()
	return self:getPlayer()[ self:getNextTurn() ]
end

-- returns the board data for the player currently having their turn
function BOARD:getActiveField()
	return self.field[ self:getTurn() ]
end

function BOARD:getInactiveField()
	return self.field[ self:getNextTurn() ]
end

-- these are for use with custom boards.
function BOARD:onTurnEnd( player )
end

function BOARD:onTurnStart( player )
end

-- note that this will call functions regardless of which turn just ened, will have to account for that in the card code.
function BOARD:endTurn()

	local plys = self:getPlayers()
	for i = 1,#plys do

		local plyNumber = i
		local ply = plys[ plyNumber ]

		local field = self:getActiveField()
		for k = 1,#field do
			field[ k ]:onTurnEnd( self )
		end

		for k = 1,#ply.hand do
			ply.hand[ k ]:onTurnEndFromHand( self )
		end

	end

	self:onTurnEnd( self:getActivePlayer() )

	self:setTurn( self:getNextTurn() )

	self:startTurn()

end

function BOARD:startTurn()

	local plys = self:getPlayers()
	for i = 1,#plys do

		local plyNumber = i
		local ply = plys[ plyNumber ]

		local field = self:getActiveField()
		for k = 1,#field do
			field[ k ]:onTurnStart( self )
		end

		for k = 1,#ply.hand do
			ply.hand[ k ]:onTurnStartFromHand( self )
		end

	end

	self:onTurnStart( self:getActivePlayer() )

end

function BOARD:setUp() -- called after players are loaded and should be called only once.
	local plys = self:getPlayers()
	for i = 1,#plys do
		local plyNumber = i
		local ply = plys[ plyNumber ]
		ply.deck = lume.shuffle( ply.deck )
		local drawCount = self.maxHandSize + ( i == #plys and self.player2BonusCards or 0 )
		for n = 1,drawCount do
			self:drawCard( ply )
		end
	end
end

--[[
player structure
	name = string
	hp = 30
	deck = {}
	hand = {}
]]
function BOARD:setPlayers( player1, player2 )

	player1.id = 1
	player2.id = 2
	self.players[ 1 ] = player1
	self.players[ 2 ] = player2

end

function BOARD:getPlayers()
	return self.players
end

function BOARD:addToDeck( player, card )
end

function BOARD:removeFromDeck( player, id )
end

function BOARD:getDeck( player )
	return self:getPlayers()[ player.id ].deck
end

function BOARD:onCardBurned( player, card )
end

function BOARD:burnCard( player, card )
	card:onBurned( player, board )
	self:onCardBurned( player, card )
	card:destroy( self )
end

function BOARD:onCardDrawn( player, card )
end

function BOARD:drawCard( player, card )

	local deck = self:getDeck( player )
	local hand = self:getHand( player )
	local card = card or lume.last( deck )

	local len = #hand
	if #hand >= self.maxHandSize then
		self:burnCard( player, card )
	else
		self:onCardDrawn( player, card )
		card:onDrawnFromDeck( self )
		self:addToHand( player, card )
	end

end

function BOARD:addToHand( player, card ) -- if we're just adding a card, we only need its data not its ID
	table.insert( player.hand, card )
end

function BOARD:removeFromHand( player, id ) -- if we're removing a card however, we need its id.
	table.remove( player.hand, id )
end

function BOARD:getHand( player )
	return self:getPlayers()[ player.id ].hand
end

function BOARD:getMaxFieldSize()
	return self.maxFieldSize
end

function BOARD:getAllMinions()

	local tbl = {}
	local field = self:getActiveField()
	for k = 1,#field do
		tbl[ #tbl + 1 ] = field[ k ]
	end

	local field = self:getInactiveField()
	for k = 1,#field do
		tbl[ #tbl + 1 ] = field[ k ]
	end

	return tbl

end

function BOARD:canPlayCard( card, player ) -- we call this before we call playCard, not during (better practice)
	return card:canPlay( self )
end

function BOARD:playCard( card, slot, player )

	local pid = player.id
	local field = self:getField( pid )
	slot = slot or #field + 1

	field[ slot ] = table.copy( card )

	field[ slot ]:onPlay( self )

	local minions = self:getAllMinions()
	for i = 1,#minions do
		minions[ i ]:onCardPlayed( field[ slot ], self )
	end

end

CARDS:registerBoard( "board_base", BOARD )
