
local CARD = {}
CARD.name = "Reanimated Hand"
CARD.description = "" --displayed below the cards name
CARD.quality = CARD_COMMON -- card quality from 1-4. 1 is common, 4 is legendary
CARD.attack = 1 -- how much damage the card does
CARD.maxAttack = 1 -- default damage the card does
CARD.health = 1 -- how much health the card has
CARD.maxHealth = 1 -- the regular max health a card has
CARD.mana 	= 0 -- how much mana it takes to summon the card
CARD.defaultMana = 0 -- how much mana it normally takes to summon the card
CARD.attacks= 1 -- how many times the card can attack
CARD.maxAttacks	= 1 -- how many times the card can attack by default
CARD.type 	= "minion" -- For now, this is just minion and spell
CARD.classes= { "undead" } --This will be used for cards that are part of a group, like "demons", "beasts", etc.
--[[
	Effect:

]]--

function CARD:initialize() --called when the card is created, immediately after the internal call
end

function CARD:onPlay() -- called immediately after the card is played
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

function CARD:think()
end

CARDS:register( "card_zombie_hand", CARD, "card_minion_base" )
