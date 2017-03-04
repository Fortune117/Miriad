
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

	self:setClampDrawing( false )

	self.field1 = gui.create( "grid", self )
	self.field2 = gui.create( "grid", self )

	self.field1.paint = function() end
	self.field2.paint = function() end

	self.phead = gui.create( "mplayerhead", self )
	self.phead2 = gui.create( "mplayerhead", self )

	self.maxFieldSize = 7

end

function PANEL:onSizeChanged( oldw, oldh, w, h )

	local pSize = h/7

	self.field1:setPos( 0, h/2 )
	self.field1:setSize( w, h/2 )

	self.phead:setPos( ( w - pSize )/2, h - pSize/2 )
	self.phead:setSize( pSize, pSize )

	self.field1:setColumnWidth( w/self.maxFieldSize )
	self.field1:setRowHeight( h/2 )

	self.field2:setPos( 0, 0 )
	self.field2:setSize( w, h/2 )

	self.phead2:setPos( ( w - pSize )/2, -pSize/2 )
	self.phead2:setSize( pSize, pSize )

	self.field2:setColumnWidth( w/self.maxFieldSize )
	self.field2:setRowHeight( h/2 )

end

function PANEL:loadData( board )

	self.phead:setPlayer( board:getActivePlayer() )
	self.phead2:setPlayer( board:getInactivePlayer() )

	self.field1:clearGrid()
	self.field2:clearGrid()

	self.maxFieldSize = board.maxFieldSize

	local h = self:getHeight()/2.3
	local activeField = board:getActiveField()
	for i = 1,#activeField do

		local card = gui.create( "mcardpreview" )
		card:setSize( h/math.sqrt( 2 ), h )
		card:setCardData( activeField[ i ] )

		--[[
		Okay, so this is pretty confusing.
		fieldCards[ k ] is referencing the card UI object actually on the field.
		which means we need to use getCardData()
		but it directly interacts with the cards in the inactive field
		lets gooo
		]]
		function card.doClick()

			local fieldCards = self.field1:getGridObjects()

			for k = 1,#fieldCards do
				if fieldCards[ k ]:isSelected() then
					fieldCards[ k ]:setSelected( false )
					return
				end
			end

			if activeField[ i ]:canAttack() then

				card:setSelected( not card:isSelected() )

			end

		end

		self.field1:add( card )

	end

	local inactiveField = board:getInactiveField()
	for i = 1,#inactiveField do

		local card = gui.create( "mcardpreview" )
		card:setSize( h/math.sqrt( 2 ), h )
		card:setCardData( inactiveField[ i ] )

		function card.doClick()

			local fieldCards = self.field1:getGridObjects()
			local attacker = nil
			for k = 1,#fieldCards do
				if fieldCards[ k ]:isSelected() then
					fieldCards[ k ]:setSelected( false )
					attacker = fieldCards[ k ]:getCardData()
				end
			end

			if attacker then
				inactiveField[ i ]:takeDamage( attacker, true )
				attacker:setAttacks( attacker:getAttacks() - 1 )
			end

		end

		self.field2:add( card )

	end

	function self.phead2.doClick()
		local fieldCards = self.field1:getGridObjects()
		local attacker = nil
		for k = 1,#fieldCards do
			if fieldCards[ k ]:isSelected() then
				fieldCards[ k ]:setSelected( false )
				attacker = fieldCards[ k ]:getCardData()
			end
		end

		if attacker then
			board:dealPlayerDamage( self.phead2:getPlayer(), attacker )
			attacker:setAttacks( attacker:getAttacks() - 1 )
		end
	end

end

function PANEL:paint( w, h )
	lg.setColor( 55, 55, 55, 255 )
	lg.rectangle( "fill", 0, 0, w, h )
	lg.setColor( 0, 0, 0, 255 )
	lg.line( 0, h/2, w, h/2 )
end
gui.register( "mgamefield", PANEL, "base" )
