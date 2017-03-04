
local CARD 	= {}
CARD.name 	= "Base Minion Thingo" -- the display name for the card
CARD.description = "" --displayed below the cards name
CARD.quality = 1 -- card quality from 1-4. 1 is common, 4 is legendary
CARD.maxAttack = 1 -- default damage the card does
CARD.attack = 1 -- how much damage the card does
CARD.health = 1 -- how much health the card has
CARD.maxHealth = 1 -- the regular max health a card has
CARD.mana 		= 1 -- how much mana it takes to summon the card
CARD.defaultMana = 1 -- how much mana it normally takes to summon the card
CARD.attacks	= 1 -- how many times the card can attack
CARD.maxAttacks	= 1 -- how many times the card can attack by default
CARD.type 	= "minion" -- For now, this is just minion and spell
CARD.classes= {} --This will be used for cards that are part of a group, like "demons", "beasts", etc.

function CARD:initializeInternal() --callled when the card is created
	self:setInPlay( false )
end

function CARD:initialize() --called when the card is created, immediately after the internal call
end

function CARD:canPlay() -- returns true or false to determine if the card can be played
	local board = self:getBoard()
	local field = board:getActiveField()
	if #field >= board:getMaxFieldSize() then
		return false
	end
	if board:getMana( self:getOwner() )< self.mana then
		return false
	end
	return true
end

function CARD:onPlay() -- called immediately after the card is played
end

function CARD:onBurned()
end

function CARD:onDestroyed()
end

function CARD:destroy() -- called to remove the card from play, doesn't trigger death rattles. e.g. burning from overdraw
	self:onDestroyed()
end

function CARD:canDie()
	return self:isInPlay()
end

function CARD:die()
	local board = self:getBoard()
	board:removeCardFromField( self )
	self:onDeath()
end

function CARD:onDeath() -- called when the card is removed from play
end

function CARD:onDrawnFromDeck() -- called when the card is drawn from the deck
end

function CARD:drawFromDeck() -- draws the card from the deck
end

function CARD:onCardDrawn( card ) -- called when a card is drawn
end

function CARD:onTurnStartFromHand() -- called when a turn starts and this card is in the hand
end

function CARD:onTurnEndFromHand() -- called when a turn ends and this card is in the hand
end

function CARD:onTurnStart() -- called when a turn stars and this card is in play
end

function CARD:onTurnEnd() -- called when a turn ends and this card is in play
end

function CARD:onAttack( target, damage ) -- called when this card attacks another
end

function CARD:onDamagePlayer( player, damage )
end

function CARD:onDefend( attacker, damage ) -- called when this card is attacked by another
end

function CARD:onKill( target ) -- called when this card kills another
end

function CARD:onKilled( attacker ) -- called when a card kills this card
end

function CARD:onCardDeath( card ) -- called whenever a card in play dies
end

function CARD:onCardPlayed( card ) -- called when a card is played
end

function CARD:setInPlay( b )
	self.inPlay = b
end

function CARD:isInPlay()
	return self.inPlay
end

function CARD:thinkInternal()
end

function CARD:think()
end

function CARD:setBoard( board )
	self.board = board
end

function CARD:getBoard()
	return self.board
end

function CARD:setOwner( ply )
	self.owner = ply
end

function CARD:getOwner()
	return self.owner
end

function CARD:getClass() -- this returns a string
	return self.__class
end

function CARD:getBaseClass() --this returns another class object
	return self.__baseClass
end

function CARD:setManaCost( n )
	self.mana = n
end

function CARD:getManaCost()
	return self.mana
end

function CARD:getDefaultManaCost()
	return self.defaultMana
end

function CARD:setHealth( n )
	self.health = n
	if self.health <= 0 then
		if self:canDie() then
			self:die()
		end
	end
end

function CARD:getHealth()
	return self.health
end

function CARD:getMaxHealth()
	return self.maxHealth
end

function CARD:setAttack( n )
	self.attack = n
end

function CARD:getAttack()
	return self.attack
end

function CARD:getMaxAttack()
	return self.maxAttack
end

function CARD:setAttacks( n )
	self.attacks = n
end

function CARD:getAttacks()
	return self.attacks
end

function CARD:getMaxAttacks()
	return self.maxAttacks
end

function CARD:canAttack()
	return self.attacks > 0
end

function CARD:onTakeDamage( attacker, damage )
end

function CARD:takeDamage( attacker, reflect, damage ) -- attacker is the card affecting our health
	reflect = reflect or false
	damage = damage or attacker:getAttack()
	self.health = self.health - damage
	if attacker.type == "minion" and reflect then
		attacker:onAttack( self, damage )
		self:onDefend( attacker, damage )
		attacker:takeDamage( self, false )
	end
	self:onTakeDamage( attacker, damage )
	if self.health <= 0 then
		if self:canDie() then
			attacker:onKill( self, damage )
			self:onKilled( attacker, damage )
			self:die()
		end
	end
end

function CARD:getQuality()
	return self.quality
end

function CARD:getDescription()
	return self.description
end

function CARD:getType()
	return self.type
end

function CARD:getClasses()
	return self.classes
end

function CARD:isClass( class )
	return self:getClasses()[ class ]
end

function CARD:getName()
	return self.name
end

function CARD:setPlayer( player )
	self.player = player
end

function CARD:getPlayer()
	return self.player
end

CARDS:register( "card_minion_base", CARD )
