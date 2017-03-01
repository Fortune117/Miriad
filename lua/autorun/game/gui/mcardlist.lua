
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

	
	local cardArray = {}
	for k,v in pairs( self.cardList ) do 
		cardArray[ #cardArray + 1 ] = v 
	end 

	self.cardList = lume.sort( cardArray, "mana" )

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
		local newPage = p:getPage() + 1
		p:setPage( newPage )
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
		local newPage = p:getPage() - 1
		p:setPage( newPage )
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
	if m == 1 then -- i hate if statements. and people. they made me do this :(
		self.next:setText( "" )
		self.prev:setText( "" )
	elseif newPage == m then 
		self.next:setText( "" )
		self.prev:setText( "<" )
	elseif newPage == 1 then 
		self.next:setText( ">" )
		self.prev:setText( "" )
	end 
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
	local master = self 
	self.grid:clearGrid()
	local list = self:getCardList()
	local startNumber = numCards*(page-1)
	for i = 1,#list do
		if i > startNumber then
			if i <= numCards*page then 
				local card = list[ i ]
				local preview = gui.create( "mcardpreview" )
				preview:setText( card.name )
				preview:setSize( self:getCardWidth(), self:getCardHeight() )
				preview:setCardData( card )
				function preview:doClick() 
					master:onCardClicked( self )
				end 
				self.grid:add( preview )
			end 
		end 
	end
end

function PANEL:onCardClicked( cardPanel ) -- called whena card on the preview panel is clicked

end

function PANEL:paint( w, h )
	lg.setColor( 65, 65, 65, 255 )
	lg.rectangle( "fill", 0, 0, w, h )
end
gui.register( "mcardlist", PANEL, "panel" )
