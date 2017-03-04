
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
	self.hand  = gui.create( "mgamehand", self )
	self.opphand  = gui.create( "mgamehandopp", self )
	self.field = gui.create( "mgamefield", self )
	self.endturn = gui.create( "mendturn", self.field )
end

function PANEL:onSizeChanged( oldw, oldh, w, h )

	local fieldH = h*0.4
	local handSize = (h - fieldH)/2

	self.opphand:setSize( w, handSize )
	self.opphand:setPos( 0, 0 )

	self.field:setSize( w, fieldH )
	self.field:setPos( 0, handSize )

	self.hand:setSize( w, handSize )
	self.hand:setPos( 0, fieldH + handSize )

	local bw = w*0.05
	local bh = h*0.05
	self.endturn:setSize( bw, bh )
	self.endturn:setPos( w - bw, fieldH/2 - bh/2 )

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

	self.field:loadData( board )
	self.hand:loadData( board:getActivePlayer(), board.maxHandSize )
	self.opphand:loadData( board:getInactivePlayer(), board.maxHandSize )

end

function PANEL:paint( w, h )

	lg.setColor( 35, 35, 35, 255 )
	lg.rectangle( "fill", 0, 0, w, h )

end

gui.register( "mgameboard", PANEL, "base" )
