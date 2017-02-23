
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

function CARD:canPlay() -- returns true or false to determine if the card can be played
end 

function CARD:play() -- plays the card into the field
end 

function CARD:onPlay() -- called immediately after the card is played
end 

function CARD:destroy() -- called to remove the card from play
end 

function CARD:onDeath() -- called when the card is removed from play
end 

function CARD:onDrawnFromDeck() -- called when the card is drawn from the deck
end 

function CARD:drawFromDeck() -- draws the card from the deck
end 

function CARD:onCardDrawn() -- called when a card is drawn
end 

function CARD:onTurnStartFromHand() -- called when a turn starts and this card is in the hand
end 

function CARD:onTurnEndFromHand() -- called when a turn ends and this card is in the hand
end 

function CARD:onTurnStart() -- called when a turn stars and this card is in play
end 

function CARD:onTurnEnd() -- called when a turn ends and this card is in play
end 

function CARD:onAttack() -- called when this card attacks another
end 

function CARD:onDefend() -- called when this card is attacked by another
end 

function CARD:onKill() -- called when this card kills another
end 

function CARD:onKilled() -- called when a card kills this card
end 

function CARD:onCardDeath() -- called whenever a card in play dies
end 

function CARD:onCardPlayed() -- called when a card is played
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

CARDS:register( "card_minion_base", CARD )