
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

function PANEL:drawBackGround( w, h )
	lg.setColor( 100, 100, 100, 255 )
	lg.rectangle( "fill", 0, 0, w, h )
	lg.setColor( 160, 160, 160, 255 )
	lg.rectangle( "line", 1, 1, w-2, h-2 )
end


local manaSizeMult = 0.12 -- we use this to determine the size of the 'stat bubbles'
local statSizeMult = 0.12 -- we use this to determine the size of the 'stat bubbles'
local nameBarSizeMult = 0.09 -- we use this to determine the size of the 'stat bubbles'
local descSizeMult = 0.05 -- we use this to determine the size of the 'stat bubbles'
local textWhite = { lume.rgba(0xFFE5E5E5) }

function PANEL:scaleElements( w, h )

	self.manaBubbleSize = w*manaSizeMult
	self.statBubbleSize = w*statSizeMult
	self.nameBarSize = h*nameBarSizeMult

	local fSize = math.floor( self.statBubbleSize*1.5 )
	self.manaFont = lg.newFont( fSize )

	local fSize = math.floor( self.statBubbleSize*1.3 )
	self.statFont = lg.newFont( fSize )

	local fSize = math.max( 1, math.floor( self.nameBarSize*0.8 ) )
	self.nameFont = lg.newFont( fSize )

	local fSize = math.max( 1, math.floor( h*descSizeMult ) )
	self.descFont = lg.newFont( fSize )

end

local manaBlue = { lume.rgba(0xFF3f71ab) }
local manaBlack = { lume.rgba(0xe5191919) }
local manaBorder = 2

function PANEL:drawMana( w, h )

	local size = self.manaBubbleSize

	local x = manaBorder + size/2
	local y = manaBorder + size/2

	lg.setColor( unpack( manaBlue ) )
	lg.circle( "fill", x, y, size, 100 )
	lg.setColor( unpack( manaBlack ) )
	lg.circle( "line", x, y, size, 100 )

	lg.setFont( self.manaFont )

	local text = self:getManaCost()
	local tw,th = lg.getFont():getWidth( text ), lg.getFont():getHeight( text )
	lg.setColor( unpack( textWhite ) )
	lg.print( text, x - tw/2, y - th/2 )

end

local nameBar = { lume.rgba(0xFF8c8c8c) }
local nameBarShadow = { lume.rgba(0x96000000) }
function PANEL:drawName( w, h )

	local barW = w*1.05
	local barH = self.nameBarSize

	local x = ( w - barW )/2
	local y = (5*h)/9 - barH/2

	lg.setColor( unpack( nameBarShadow ) )
	lg.rectangle( "fill", 0, y + 2, w, barH )

	lg.setColor( unpack( nameBar ) )
	lg.rectangle( "fill", x, y, barW, barH )


	lg.setFont( self.nameFont )

	local text = self:getName()
	local tw,th = lg.getFont():getWidth( text ), lg.getFont():getHeight( text )
	lg.setColor( unpack( textWhite ) )
	lg.print( text, w/2 - tw/2, (5*h)/9 - th/2  )

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
		lg.print( str, tx, ty )

	end


end

local healthRed = { lume.rgba(0xFFff4e50) }
local damageYellow = { lume.rgba(0xFFe6a02a) }
local statBorder = 2
function PANEL:drawStats( w, h )

	local size = self.statBubbleSize

	local x = statBorder + size/2
	local y = h - size/2

	lg.setColor( unpack( damageYellow ) )
	lg.circle( "fill", x, y, size, 100 )
	lg.setColor( unpack( manaBlack ) )
	lg.circle( "line", x, y, size, 100 )

	lg.setFont( self.statFont )

	local text = self:getAttack()
	local tw,th = lg.getFont():getWidth( text ), lg.getFont():getHeight( text )
	lg.setColor( unpack( textWhite ) )
	lg.print( text, x - tw/2, y - th/2 )

	local x = w - size/2 - statBorder
	local y = h - size/2 - statBorder

	lg.setColor( unpack( healthRed ) )
	lg.circle( "fill", x, y, size, 100 )
	lg.setColor( unpack( manaBlack ) )
	lg.circle( "line", x, y, size, 100 )

	lg.setFont( self.statFont )

	local text = self:getHealth()
	local tw,th = lg.getFont():getWidth( text ), lg.getFont():getHeight( text )
	lg.setColor( unpack( textWhite ) )
	lg.print( text, x - tw/2, y - th/2 )

end

function PANEL:paint( w, h )
	self:drawBackGround( w, h )
	self:drawMana( w, h )
	self:drawStats( w, h )
	self:drawName( w, h )
	self:drawDescription( w, h )
end

function PANEL:paintOver()
end

gui.register( "mcardpreview", PANEL, "button" )
