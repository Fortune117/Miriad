
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
	self.maxMana = 1
	self.mana = 1
end

function PANEL:onSizeChanged( oldw, oldh, w, h )

	self:setColumnWidth( w/self.maxSize )
	self:setRowHeight( h )
	self:arrangeGrid()

	local fSize = math.ceil( h*0.05 )
	self.manaFont = lg.newFont( "resources/fonts/Roboto-Regular.ttf", fSize )

	local fSize = math.ceil( h*0.08 )
	self.nameFont = lg.newFont( "resources/fonts/Roboto-Regular.ttf", fSize )

end

function PANEL:loadData( player, maxSize )

	self.maxMana = player.maxMana
	self.mana = player.mana
	self.name = player.name

	local hand = player.hand

	self.maxSize = maxSize

	local coldiv = math.max( #hand, 1 )
	self:setColumnWidth( self:getWidth()/coldiv )
	self:clearGrid()
	for i = 1,#hand do
		local h = self:getHeight()*0.65
		local w = h/math.sqrt( 2 )
		local card = gui.create( "mcardpreview" )
		card:setSize( w, h )
		card:flip()
		self:add( card )
	end
	self:arrangeGrid()

end

function PANEL:getBoard()
	return self:getParent():getBoard()
end


local manaBlue = { lume.rgba( 0xFF3f71ab ) }
local manaFadedBlue = { lume.rgba( 0xFF112642 ) }
local manaBlack = { lume.rgba( 0xff000000 ) }
local textWhite = { lume.rgba( 0xffEeEeEe ) }

function PANEL:drawMana( w, h )

	local size = h*0.04
	local gap = size*1.5
	local border = h*0.176
	local border2 = border/4

	lg.setFont( self.manaFont )

	local text = self.mana.."/"..self.maxMana
	local tw,th = lg.getFont():getWidth( text ), lg.getFont():getHeight( text )
	local tx, ty =  border/2 - tw/2, h - border2 - size - th/2

	lg.setColor( unpack( textWhite ) )
	lg.print( text, tx, ty )

	for i = 1,self.maxMana do
		lg.setColor( unpack( manaFadedBlue ) )
		lg.circle( "fill", border + size + ( size + gap )*(i-1), h - size - border2, size )
		lg.setColor( unpack( manaBlack ) )
		lg.circle( "line", border + size + ( size + gap )*(i-1), h - size - border2, size + 1/3 )
	end

	for i = 1,self.mana do
		lg.setColor( unpack( manaBlue ) )
		lg.circle( "fill", border + size + ( size + gap )*(i-1), h - size - border2, size )
		lg.setColor( unpack( manaBlack ) )
		lg.circle( "line", border + size + ( size + gap )*(i-1), h - size - border2, size + 1/3 )
	end

	lg.setFont( self.nameFont )

	local text = self.name
	local tw,th = lg.getFont():getWidth( text ), lg.getFont():getHeight( text )
	local tx, ty =  2, 2

	lg.setColor( unpack( textWhite ) )
	lg.print( text, tx, ty )

end

function PANEL:paint( w, h )

	lg.setColor( 60, 60, 60, 255 )
	lg.rectangle( "fill", 0, 0, w, h )
	lg.setColor( 0, 0, 0, 255 )
	lg.line( 0, h, w, h )

	self:drawMana( w, h )

end
gui.register( "mgamehandopp", PANEL, "grid" )
