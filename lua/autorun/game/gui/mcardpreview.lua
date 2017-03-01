
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
	self:setCardData( CARDS:getCard( "card_minion_base" ) )
	self:setClampDrawing( false )
	self:scaleElements( self:getSize() )
	self.flipped = false -- this 'turns' the card over so that it shows the back.
end

function PANEL:doClick()
end

function PANEL:setCardData( card )
	self.cardData = card
end

function PANEL:getCardData( card )
	return self.cardData
end

function PANEL:getHealth()
	return self:getCardData():getHealth()
end

function PANEL:getManaCost()
	return self:getCardData():getManaCost()
end

function PANEL:getAttack()
	return self:getCardData():getAttack()
end

function PANEL:getAttacks()
	return self:getCardData():getAttacks()
end

function PANEL:getQuality()
	return self:getCardData():getQuality()
end

function PANEL:getQualityColor()
	local q = self:getQuality()
	return CARDS:getQualityColor( q )
end

function PANEL:getDescription()
	return self:getCardData():getDescription()
end

function PANEL:getType()
	return self:getCardData():getType()
end

function PANEL:getClasses()
	return self:getCardData():getClasses()
end

function PANEL:isClass( class )
	return self:getClasses()[ class ]
end

function PANEL:getName()
	return self:getCardData():getName()
end

function PANEL:onSizeChanged( oldw, oldh, w, h )
	self:scaleElements( w, h )
end

function PANEL:flip()
	self.flipped = not self.flipped
end

local backgroundColor = { lume.rgba( 0xff40404f ) }
function PANEL:drawBackGround( w, h )
	lg.setColor( 0, 0, 0, 255 )
	lg.rectangle( "fill", -2, -2, w+4, h+4 )
	lg.setColor( unpack( backgroundColor ) )
	lg.rectangle( "fill", 0, 0, w, h )
end

function PANEL:drawCardBack( w, h )

	lg.setColor( 0, 0, 0, 255 )
	lg.rectangle( "fill", -2, -2, w+4, h+4 )
	lg.setColor( unpack( backgroundColor ) )
	lg.rectangle( "fill", 0, 0, w, h )

end

local manaSizeMult = 0.085 -- we use this to determine the size of the 'stat bubbles'
local statSizeMult = 0.085 -- we use this to determine the size of the 'stat bubbles'
local nameBarSizeMult = 0.09 -- we use this to determine the size of the 'stat bubbles'
local qualityBubbleSizeMult = 0.025 -- we use this to determine the size of the 'stat bubbles'
local descSizeMult = 0.05 -- we use this to determine the size of the 'stat bubbles'
local textWhite = { lume.rgba( 0xffEeEeEe ) }
local textBlack = { lume.rgba( 0xff000000 ) }

function PANEL:scaleElements( w, h )

	self.manaBubbleSize = h*manaSizeMult
	self.statBubbleSize = h*statSizeMult
	self.nameBarSize = h*nameBarSizeMult
	self.qualityBubbleSize = h*qualityBubbleSizeMult

	local fSize = math.ceil( self.statBubbleSize*1.5 )
	self.manaFont = lg.newFont( "resources/fonts/Roboto-Regular.ttf", fSize )

	local fSize = math.ceil( self.statBubbleSize*1.3 )
	self.statFont = lg.newFont( "resources/fonts/Roboto-Regular.ttf", fSize )

	local fSize = math.max( 1, math.floor( self.nameBarSize*0.78 ) )
	self.nameFont = lg.newFont( "resources/fonts/Amiko-Regular.ttf", fSize )
	self.nameHighlightFont = lg.newFont( "resources/fonts/Amiko-Regular.ttf", fSize )

	local fSize = math.max( 1, math.floor( h*descSizeMult ) )
	self.descFont = lg.newFont( "resources/fonts/Roboto-Regular.ttf", fSize )

end

local manaBlue = { lume.rgba( 0xFF3f71ab ) }
local manaBlack = { lume.rgba( 0xff000000 ) }
local manaBorder = 2

function PANEL:drawMana( w, h )

	local size = self.manaBubbleSize

	local x = manaBorder + size/2
	local y = manaBorder + size/2

	lg.setColor( unpack( manaBlue ) )
	lg.circle( "fill", x, y, size, 75 )
	lg.setColor( unpack( manaBlack ) )
	lg.circle( "line", x, y, size, 75 )
	lg.circle( "line", x, y, size+(1/3), 75 )

	lg.setFont( self.manaFont )

	local text = self:getManaCost()
	local tw,th = lg.getFont():getWidth( text ), lg.getFont():getHeight( text )

	local tx, ty =  x - tw/2, y - th/2
	lg.setColor( unpack( textBlack ) )
	lg.print( text, tx + 1, ty + 1 )
	lg.setColor( unpack( textWhite ) )
	lg.print( text, tx, ty )

end

local nameBar = { lume.rgba( 0xFF737387 ) }
local nameBarShadow = { lume.rgba( 0xef000000 ) }
function PANEL:drawName( w, h )

	local barW = w*1
	local barH = self.nameBarSize

	local x = ( w - barW )/2
	local y = (5*h)/9 - barH/2

	local size = self.qualityBubbleSize
	local qx, qy = w/2, y + barH
	local c = self:getQualityColor()

	lg.setColor( unpack( c ) )
	lg.circle( "fill", qx, qy, size, 75 )

	lg.setColor( unpack( c ) )
	lg.circle( "line", qx, qy, size, 75 )
	lg.setColor( unpack( manaBlack ) )
	lg.circle( "line", qx, qy, size+(1/3), 75 )
----------------------------------------------------------------
	lg.setColor( unpack( nameBarShadow ) )
	lg.rectangle( "fill", x - 1, y - 1, barW + 2, barH + 2 )

	lg.setColor( unpack( nameBar ) )
	lg.rectangle( "fill", x, y, barW, barH )


	local text = self:getName()
	local tw,th = self.nameFont:getWidth( text ), self.nameFont:getHeight( text )

	local tx, ty = ( w - tw)/2, (5*h)/9 - th/2

	lg.setFont( self.nameHighlightFont )

	lg.setColor( unpack( textBlack ) )
	lg.print( text, tx+1, ty + 1 )


	lg.setFont( self.nameFont )

	lg.setColor( unpack( textWhite ) )
	lg.print( text, tx, ty )


end

function PANEL:drawDescription( w, h )

	local x = w/2
	local y = h - h/4

	lg.setFont( self.descFont )

	local numChars = math.floor( w/lg.getFont():getWidth( "A" ) )

	local text = self:getDescription()

	local width, wrappedText = lg.getFont():getWrap( text, w - 4 )

	local avgTextH = lg.getFont():getHeight( "A" ) + 1

	lg.setColor( unpack( textWhite ) )
	for i = 1,#wrappedText do

		local str = wrappedText[ i ]
		local tw, th = lg.getFont():getWidth( str ), lg.getFont():getHeight( str )

		local ty = y - avgTextH*( #wrappedText/2 - i + 1 ) - th/2

		local tx = ( w - tw )/2

		lg.setColor( unpack( textBlack ) )
		lg.print( str, tx + 1, ty + 1 )

		lg.setColor( unpack( textWhite ) )
		lg.print( str, tx, ty )

	end

end

local healthRed = { lume.rgba( 0xFFff4e50 ) }
local damageYellow = { lume.rgba( 0xFFe6a02a ) }
local statBorder = 2
function PANEL:drawStats( w, h )

	local size = self.statBubbleSize

	local x = statBorder + size/2
	local y = h - size/2 - statBorder

	lg.setColor( unpack( damageYellow ) )
	lg.circle( "fill", x, y, size, 100 )
	lg.setColor( unpack( manaBlack ) )
	lg.circle( "line", x, y, size, 75 )
	lg.circle( "line", x, y, size+(1/3), 75 )

	lg.setFont( self.statFont )

	local text = self:getAttack()
	local tw,th = lg.getFont():getWidth( text ), lg.getFont():getHeight( text )
	local tx, ty =  x - tw/2, y - th/2

	lg.setColor( unpack( textBlack ) )
	lg.print( text, tx + 1, ty + 1 )

	lg.setColor( unpack( textWhite ) )
	lg.print( text, tx, ty )

	local x = w - size/2 - statBorder
	local y = h - size/2 - statBorder

	lg.setColor( unpack( healthRed ) )
	lg.circle( "fill", x, y, size, 100 )
	lg.setColor( unpack( manaBlack ) )
	lg.circle( "line", x, y, size, 75 )
	lg.circle( "line", x, y, size+(1/3), 75 )

	lg.setFont( self.statFont )

	local text = self:getHealth()
	local tw,th = lg.getFont():getWidth( text ), lg.getFont():getHeight( text )
	local tx, ty =  x - tw/2, y - th/2

	lg.setColor( unpack( textBlack ) )
	lg.print( text, tx + 1, ty + 1 )

	lg.setColor( unpack( textWhite ) )
	lg.print( text, tx, ty )

end

function PANEL:paint( w, h )
	if self.flipped then
		self:drawCardBack( w, h )
	else
		self:drawBackGround( w, h )
		self:drawMana( w, h )
		if self:getType() == "minion" then
			self:drawStats( w, h )
		end
		self:drawName( w, h )
		self:drawDescription( w, h )
	end
end

function PANEL:paintOver()
end

gui.register( "mcardpreview", PANEL, "button" )
