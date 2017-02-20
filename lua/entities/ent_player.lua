
local ENT = {}

function ENT:initialize()

end

function ENT:setRespawnTime( t )
	self.respawnTime = love.timer.getTime() + t
end

function ENT:getRespawnTime()
	return self.respawnTime or 0
end

function ENT:getDisplayRespawnTime()
	return math.max( self:getRespawnTime() - love.timer.getTime(), 0 )
end

function ENT:shouldRespawn()
	return self:getRespawnTime() < love.timer.getTime()
end

local godTime = 1
function ENT:onTakeDamage( dmgInfo )
	if self:isGod() then
		dmgInfo:scaleDamage( 0 )
	else
		self:doFlashAnim( godTime, 0.05 )
		self:godMode( godTime )
	end
end

function ENT:godMode( dur )
	local t = love.timer.getTime()
	self.godTimer = t + dur
	self:setGod( true )
end

function ENT:setGod( b )
	self.god = b
end

function ENT:isGod()
	return self.god
end

function ENT:doFlashAnim( dur, ftime )
	local t = love.timer.getTime()
	self.flashDrawTime = ftime
	self.flashTime = t + ftime
	self.flashNum = math.floor( dur/ftime )
	self.curFlash = 0
	self.flashing = true
end

function ENT:onDeath()
	self:remove()
end


function ENT:think()

end

local lg = love.graphics
function ENT:draw()


end
ents.registerEntity( "ent_player", ENT )
