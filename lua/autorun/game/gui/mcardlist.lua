
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

	self.grid = gui.create( "grid", self )
	self.grid:setPos( border, border )
	self.grid:setSize( w - border*2, h - border*2 )

	function self.grid:paint( w, h )
		lg.setColor( 60, 60, 60, 255 )
		lg.rectangle( "fill", 0, 0, self:getWidth(), self:getHeight() )
	end 

	self:loadCardsToGrid()

end 

function PANEL:getCardList()
	return self.cardList
end  

function PANEL:loadCardsToGrid()
	local list = self:getCardList()
	for k,v in pairs( list ) do 
		local button = gui.create( "button" )
		button:setText( v.name )
		self.grid:add( button )
	end 	
end 


function PANEL:paint()
	lg.setColor( 35, 35, 35, 255 )
	lg.rectangle( "fill", 0, 0, self:getWidth(), self:getHeight() )
end
gui.register( "mcardlist", PANEL, "panel" )