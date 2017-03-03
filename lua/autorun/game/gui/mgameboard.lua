
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
	self.field = gui.create( "mgamefield" )
	self.hand  = gui.create( "mgamehand" )
end 

function PANEL:onSizeChanged( oldw, oldh, w, h )

	local fieldH = h*0.75
	self.field:setSize( w, fieldH )
	self.field:setPos( 0, 0 )

	self.hand:setSize( w, h - fieldH )
	self.hand:setPos( 0, fieldH )

end

function PANEL:getBoard()
	return self.board 
end 

function PANEL:loadBoard( board )

	self.board = board 
	board:setUI( self )
	self:updateBoard( board )

end 

function PANEL:updateBoard( board )

	self.field:loadData( board.field )
	self.hand:loadData( board:getActiveHand(), board.maxHandSize )

end 

function PANEL:paint( w, h )
	lg.setColor( 35, 35, 35, 255 )
	lg.rectangle( "fill", 0, 0, w, h )
end

gui.register( "mgameboard", PANEL, "base" )