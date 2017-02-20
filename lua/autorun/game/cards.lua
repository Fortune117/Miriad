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


local cache = {}
function CARDS:register( name, card, base )

	base = base or false 
	local cbase = self.index[ base ]
	if not cbase and base then 
		cache[ name ] = { cdata = card, cbase = base }
	elseif cbase then
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
	self.decks.index[ name ] = { valid = true }
end 

function CARDS:getDeck( name )
	return self.decks.index[ name ] or { valid = false }
end 

function CARDS:isValidDeck( deck )
	return deck.valid 
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
	for i = 1,#deck do 
		local deckSlot = deck[ i ]
		if deckSlot.name == cardName then 
			if deckSlot.count >= self.maxCopiesInDeck then 
				return false 
			end 
		end 
	end 
	return true 

end 

function CARDS:addToDeck( deckName, cardName )

	local deck = self:getDeck( name )
	for i = 1,#deck do 
		local deckSlot = deck[ i ]
		if deckSlot.name == cardName then 
			deckSlot.count = deckSlot.count + 1 
			return
		end 
	end 
	table.insert( deck, { name = cardName, count = 1 } )

end

function CARDS:removeFromDeck( deckName, cardName )

	local deck = self:getDeck( name )
	for i = 1,#deck do 
		local deckSlot = deck[ i ]
		if deckSlot.name == cardName then 
			deckSlot.count = deckSlot.count - 1 
			if deckSlot.count <= 0 then 
				table.remove( deck, i )
			end 
			return
		end 
	end

end 

local boardCache = {}
function CARDS:registerBoard( name, board, base )

	base = base or false 
	local bbase = self.board.index[ base ]
	if not bbase and base then 
		boardCache[ name ] = { bdata = board, bbase = base }
	elseif bbase then
		local bdata = setmetatable( board, { __index = bbase } )
		self.board.index[ name ] = cdata
	else 
		self.board.index[ name ] = card
	end 
 
	for k,v in pairs( boardCache ) do
		if v.bbase == name then 
			CARDS:registerBord( k, v.bdata, name )
			boardCache[ k ] = nil
		end 
	end 

end

function CARDS:setActiveBoard( name )
	self.board.activeBoard = self:getBoard( name )
end 