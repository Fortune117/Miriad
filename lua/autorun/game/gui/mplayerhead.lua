
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
	self:setTextColor( 255, 255, 255, 255 )
end

function PANEL:setPlayer( player )
	self.player = player
	self:setText( player.hp )
end

function PANEL:getPlayer()
	return self.player
end

function PANEL:paint( w, h )
	lg.setColor( 55, 55, 55, 255 )
	lg.circle( "fill", w/2, h/2, w )
	lg.setColor( 0, 0, 0, 255 )
	lg.circle( "line", w/2, h/2, w )
end
gui.register( "mplayerhead", PANEL, "button" )
