
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

function PANEL:initialize()
	self.maxSize = 9
end

function PANEL:onSizeChanged( oldw, oldh, w, h )
	self:setColumnWidth( w/self.maxSize )
	self:setRowHeight( h )
	self:arrangeGrid()
end 

function PANEL:loadData( hand, maxSize )
	self.maxSize = maxSize 
	self:setColumnWidth( self:getWidth()/self.maxSize )
	self:clearGrid()
	for i = 1,#hand do 
		local w = self:getWidth()/10
		local h = w*math.sqrt( 2 ) 
		local card = gui.create( "mcardpreview" )
		card:setSize( w, h )
		card:setCardData( hand[ i ] )
		self:add( card )
	end 
	self:arrangeGrid()
end 

function PANEL:paint( w, h )
	lg.setColor( 35, 35, 35, 255 )
	lg.rectangle( "fill", 0, 0, w, h )
end
gui.register( "mgamehand", PANEL, "grid" )