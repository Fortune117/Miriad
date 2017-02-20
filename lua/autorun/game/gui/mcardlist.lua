
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

local border = 20
function PANEL:initialize()

	self.cardList = CARDS:getCards()

	local w, h = love.graphics.getDimensions()

	self:setSize( w, h )

	local gw, gh =  w - border*2, h - border*2
	self.grid = gui.create( "grid", self )
	self.grid:setPos( border, border )
	self.grid:setSize( gw, gh )
	self.grid:setColumnWidth( gw/3 )
	self.grid:setRowHeight( gh/2 )
	self.grid:setXGap( 5 )


	self:loadCardsToGrid()

end

function PANEL:getCardList()
	return self.cardList
end

function PANEL:getCardWidth()
	return self.grid:getWidth()/5
end

function PANEL:getCardHeight()
	return self:getCardWidth()*1.5
end

function PANEL:loadCardsToGrid()
	local list = self:getCardList()
	for k,v in pairs( list ) do
		local button = gui.create( "button" )
		button:setText( v.name )
		button:setSize( self:getCardWidth(), self:getCardHeight() )
		self.grid:add( button )
	end
end


function PANEL:paint()
	lg.setColor( 35, 35, 35, 255 )
	lg.rectangle( "fill", 0, 0, self:getWidth(), self:getHeight() )
end
gui.register( "mcardlist", PANEL, "panel" )
