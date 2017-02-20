
local BOARD = {}
BOARD.name = "Base Board"


function BOARD:initializeInternal() --callled when the card is created
end 

function BOARD:initialize() --called when the card is created, immediately after the internal call
end 

function BOARD:onPlay() -- called when a card is played
end 

function BOARD:onDeath() -- called when a card dies
end 

function BOARD:onCardDrawn() -- called when the card is drawn
end 

function BOARD:onTurnStart() -- called when a turn starts and this card is in the hand
end 

function BOARD:onTurnEnd() -- called when a turn ends and this card is in the hand
end 

function BOARD:onAttack() -- called when a card attacks another
end 

function BOARD:onDefend() -- called when a card is attacked by another
end 

function BOARD:onKill() -- called when a card kills another
end 

function BOARD:onKilled() -- called when a card kills another
end 

function BOARD:onCardDeath() -- called whenever a card in play dies
end 

function BOARD:thinkInternal()
end

function BOARD:think()
end 

CARDS:registerBoard( "board_base", BOARD )