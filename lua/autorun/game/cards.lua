CARDS = {}
CARDS.index = {}
CARDS.deck = {}
CARDS.deck.index = {}
CARDS.deck.maxCopiesInDeck = 2
CARDS.deck.maxDeckSize = 30
CARDS.board = {}
CARDS.board.index = {}
CARDS.board.maxMinions = 8
CARDS.board.activeBoard = nil

CARD_COMMON = 1
CARD_RARE = 2
CARD_EPIC = 3
CARD_LEGENDARY = 4

CARDS.qualityColors =
{
	[ CARD_COMMON ] = { 200, 200, 200, 255 },
	[ CARD_RARE ] = { 100, 115, 250, 255 },
	[ CARD_EPIC ] = { lume.rgba( 0xff8e30b0 ) },
	[ CARD_LEGENDARY ] = { 178, 120, 25, 255 }
}

local cache = {}
function CARDS:register( name, card, base )

	card.__class = name

	base = base or false
	local cbase = self.index[ base ]
	if not cbase and base then
		cache[ name ] = { cdata = card, cbase = base }
	elseif cbase then
		card.__baseClass = cbase
		local cdata = setmetatable( card, { __index = cbase } )
		self.index[ name ] = cdata
	else
		self.index[ name ] = card
	end

	for k,v in pairs( cache ) do
		if v.cbase == name then
			CARDS:register( k, v.cdata, name )
			cache[ k ] = nil
		end
	end

end

function CARDS:getCards()
	return self.index
end

function CARDS:getCard( name )
	return self.index[ name ]
end

function CARDS:createDeck( name )
	self.deck.index[ name ] = { valid = true }
	return self:getDeck( name )
end

function CARDS:getDeck( name )
	return self.deck.index[ name ] or { valid = false }
end

function CARDS:isValidDeck( deck )
	return deck.valid
end

function CARDS:numCardsInDeck( cardName, deck )
	local count = 0 
	for i = 1,#deck do 
		if deck[ i ].class == cardName then 
			count = count + 1
		end 
	end 
	return count 
end 

function CARDS:canUseDeck( deckName )

	local deck = self:getDeck( deckName )
	if #deck >= self.maxDeckSize then
		return true
	else
		return "Deck is to small to be able to play."
	end

end

function CARDS:canAddToDeck( deckName, cardName )

	local deck = self:getDeck( name )
	if #deck >= self.maxDeckSize then return false end
	if self:numCardsInDeck( cardName ) > self.maxCopiesInDeck then return false end 
	return true

end

function CARDS:addToDeck( deckName, cardName )

	local deck = self:getDeck( deckName )
	table.insert( deck, table.copy( self:getCard( cardName ) ) )

end

function CARDS:removeFromDeck( deckName, cardName )

	local deck = self:getDeck( deckName )
	for i = 1,#deck do 
		if deck[ i ].class == cardName then 
			table.remove( deck, i )
		end 
	end 

end

function CARDS:getQualityColor( q )
	return self.qualityColors[ q ] or { 230, 230, 230, 255 }
end

function CARDS:getBoard( name )
	return self.board.index[ name ]
end

local boardCache = {}
function CARDS:registerBoard( name, board, base )

	base = base or false
	local bbase = self.board.index[ base ]
	if not bbase and base then
		boardCache[ name ] = { bdata = board, bbase = base }
	elseif bbase then
		local bdata = setmetatable( board, { __index = bbase } )
		self.board.index[ name ] = bdata
	else
		self.board.index[ name ] = board
	end

	for k,v in pairs( boardCache ) do
		if v.bbase == name then
			CARDS:registerBord( k, v.bdata, name )
			boardCache[ k ] = nil
		end
	end

end
