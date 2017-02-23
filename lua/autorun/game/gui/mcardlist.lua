
--[[--
 ▄▀▀█▄▄   ▄▀▀█▄▄▄▄  ▄▀▀▀▀▄  ▄▀▀▄ ▀▀▄  ▄▀▀▄ ▀▄  ▄▀▄▄▄▄
█ ▄▀   █ ▐  ▄▀   ▐ █ █   ▐ █   ▀▄ ▄▀ █  █ █ █ █ █    ▌
▐ █    █   █▄▄▄▄▄     ▀▄   ▐     █   ▐  █  ▀█ ▐ █
  █    █   █    ▌  ▀▄   █        █     █   █    █
 ▄▀▄▄▄▄▀  ▄▀▄▄▄▄    █▀▀▀       ▄▀    ▄▀   █    ▄▀▄▄▄▄▀
█     ▐   █    ▐    ▐          █     █    ▐   █     ▐
▐         ▐                    ▐     ▐        ▐
--]]--

local lg = love.graphics
local lm = love.mouse
local PANEL = {}

local border = 10
local numCards = 8 -- number of cards per page. make sure this is even or it's gonna fucken freak :(
function PANEL:initialize()

	local list = CARDS:getCards()


	local filter = { "card_minion_base", "card_spell_base" }
	self.cardList = lume.filter( list, 
					function( card )
						local found = lume.find( filter, card:getClass() ) or false 
						return not found 
					end,
					true )

	--self.cardList = lume.sort( self.cardList, "mana" )

	local w, h = love.graphics.getDimensions()

	self:setSize( w, h )

	local gw, gh =  w, h
	self.grid = gui.create( "grid", self )
	self.grid:setPos( 0, 0 )
	self.grid:setSize( gw, gh )
	self.grid:setColumnWidth( gw/(numCards/2) )
	self.grid:setRowHeight( gh/2 )
	self.grid:setXGap( 0 )
	self.grid:setYGap( 0 )

	self.grid.paint = self.paint 

	local bw = (gw - self:getCardWidth()*4)/(numCards) - 2
	self.next = gui.create( "button", self.grid )
	self.next:setSize( bw, gh )
	self.next:setPos( gw - bw, 0 )
	self.next:setText( ">" )
	self.next:setTextColor( 255, 255, 255, 255 )
	function self.next:doClick()
		local p = self:getParent():getParent()
		p:setPage( p:getPage() + 1 )
	end 
	function self.next:paint()
	end

	self.prev = gui.create( "button", self.grid )
	self.prev:setSize( bw, gh )
	self.prev:setPos( 0, 0 )
	self.prev:setText( "<" )
	self.prev:setTextColor( 255, 255, 255, 255 )
	function self.prev:doClick()
		local p = self:getParent():getParent()
		p:setPage( p:getPage() - 1 )
	end 
	function self.prev:paint()
	end

	self:setPage( 1 )

end

function PANEL:getCardList()
	return self.cardList
end

function PANEL:getCardWidth()
	return self.grid:getWidth()/5
end

function PANEL:getCardHeight()
	return self:getCardWidth()*math.sqrt( 2 )
end

function PANEL:setPage( n )
	local m = math.ceil( lume.count( self:getCardList() )/numCards )
	local newPage = lume.clamp( n, 1, m )
	if newPage ~= self.page then 
		self.page = newPage
		self:loadCardsToGrid( self.page )
	end 
end 

function PANEL:getPage()
	return self.page 
end 

local clear = false 
function PANEL:loadCardsToGrid( page )
	self.grid:clearGrid()
	local list = self:getCardList()
	local startNumber = numCards*(page-1)
	local count = 1
	for k,v in pairs( list ) do
		if count > startNumber and count <= numCards*page then  
			local preview = gui.create( "mcardpreview" )
			preview:setText( v.name )
			preview:setSize( self:getCardWidth(), self:getCardHeight() )
			preview:setCardData( v )
			self.grid:add( preview )
		end 
		count = count + 1
	end
end

function PANEL:paint( w, h )
	lg.setColor( 35, 35, 35, 255 )
	lg.rectangle( "fill", 0, 0, w, h )
end
gui.register( "mcardlist", PANEL, "panel" )
