
local CARD 	= {}
CARD.name 	= "Base Minion Thingo" -- the display name for the card
CARD.description = "" --displayed below the cards name
CARD.quality = 1 -- card quality from 1-4. 1 is common, 4 is legendary
CARD.attack = 1 -- how much damage the card does
CARD.health = 1 -- how much health the card has
CARD.mana 	= 1 -- how much mana it takes to summon the card
CARD.attacks= 1 -- how many times the card can attack
CARD.type 	= "minion" -- For now, this is just minion and spell
CARD.classes= {} --This will be used for cards that are part of a group, like "demons", "beasts", etc.

function CARD:initializeInternal() --callled when the card is created
end 

function CARD:initialize() --called when the card is created, immediately after the internal call
end 

function CARD:canPlay( board ) -- returns true or false to determine if the card can be played
end 

function CARD:onPlay( board ) -- called immediately after the card is played
end 

function CARD:onDestroyed()
end 

function CARD:destroy( board ) -- called to remove the card from play, doesn't trigger death rattles. e.g. burning from overdraw
	self:onDestroyed( board )
end 

function CARD:onDeath( board ) -- called when the card is removed from play
end 

function CARD:onDrawnFromDeck( board ) -- called when the card is drawn from the deck
end 

function CARD:drawFromDeck( board ) -- draws the card from the deck
end 

function CARD:onCardDrawn( card, board ) -- called when a card is drawn
end 

function CARD:onTurnStartFromHand( board ) -- called when a turn starts and this card is in the hand
end 

function CARD:onTurnEndFromHand( board ) -- called when a turn ends and this card is in the hand
end 

function CARD:onTurnStart( board ) -- called when a turn stars and this card is in play
end 

function CARD:onTurnEnd( board ) -- called when a turn ends and this card is in play
end 

function CARD:onAttack( target, board ) -- called when this card attacks another
end 

function CARD:onDefend( attacker, board ) -- called when this card is attacked by another
end 

function CARD:onKill( target, board ) -- called when this card kills another
end 

function CARD:onKilled( attacker, board ) -- called when a card kills this card
end 

function CARD:onCardDeath( card, board ) -- called whenever a card in play dies
end 

function CARD:onCardPlayed( card, board ) -- called when a card is played
end 

function CARD:inPlay()
end 

function CARD:thinkInternal()
end

function CARD:think()
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

function CARD:setHealth( n )
	self.health = n 
end 

function CARD:getHealth()
	return self.health 
end 

function CARD:setAttack( n )
	self.attack = n 
end 

function CARD:getAttack()
	return self.attack
end 

function CARD:setAttacks( n )
	self.attacks = n 
end 

function CARD:getAttacks()
	return self.attacks 
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