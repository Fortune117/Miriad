
local CARD = {}
CARD.name = "Base Minion Thingo"
CARD.attack = 1
CARD.health = 1
CARD.mana 	= 1
CARD.type 	= "minion"


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

function CARD:thinkInternal()
end

function CARD:think()
end 

CARDS:register( "card_minion_base", CARD )